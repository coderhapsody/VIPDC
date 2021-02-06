using System;
using System.Dynamic;
using System.Linq;
using System.Reflection;

namespace VIPDC.Providers.Utilities
{
    public class StaticMemberDynamicObject : DynamicObject
    {
        private Type _type;
        public StaticMemberDynamicObject(Type type) { this._type = type; }

        // Handle static methods
        public override bool TryInvokeMember(InvokeMemberBinder binder, object[] args, out object result)
        {
            MethodInfo method = _type.GetMethod(binder.Name, BindingFlags.Static | BindingFlags.Public, null, new Type[] { }, new ParameterModifier[] { });
            if (method == null)
            {
                method = _type.GetMethods().Where(methodInfo => methodInfo.Name.Equals(binder.Name) && methodInfo.GetParameters().Length == args.Length).First();
                if (method == null)
                {
                    result = null;
                    return false;
                }
            }

            result = method.Invoke(null, args);
            return true;
        }
    }

    
}
