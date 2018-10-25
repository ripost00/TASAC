package nzero.admin.egovframework.cmmn.model;
import java.math.BigDecimal;
import java.util.*;



@SuppressWarnings("serial")
public class SimpleData extends SimpleDataProtocol
{
    public SimpleData(String name) {
        this.name = name;
    }

    public SimpleData() {
    }

    @SuppressWarnings("unchecked")
	public SimpleData(Map m) {
        super(m);
    }

    @SuppressWarnings("unchecked")
	public void set(Object key, Object value)
    {
        super.put(key, value);
    }

    @SuppressWarnings("unchecked")
	public void setString(Object key, String value) {
        super.put(key, value);
    }

    @SuppressWarnings("unchecked")
	public void setInt(Object key, int value)
    {
        Integer integer = new Integer(value);
        super.put(key, integer);
    }

    @SuppressWarnings("unchecked")
	public void setDouble(Object key, double value)
    {
        Double dou = new Double(value);
        super.put(key, dou);
    }

    @SuppressWarnings("unchecked")
	public void setFloat(Object key, float value)
    {
        Float flo = new Float(value);
        super.put(key, flo);
    }

    @SuppressWarnings("unchecked")
	public void setLong(Object key, long value)
    {
        Long lon = new Long(value);
        super.put(key, lon);
    }

    @SuppressWarnings("unchecked")
	public void setShort(Object key, short value)
    {
        Short shor = new Short(value);
        super.put(key, shor);
    }

    @SuppressWarnings("unchecked")
	public void setBoolean(Object key, boolean value)
    {
        Boolean bool = new Boolean(value);
        super.put(key, bool);
    }

    @SuppressWarnings("unchecked")
	public void setBigDecimal(Object key, BigDecimal value)
    {
        super.put(key, value);
    }

    public Object get(Object key)
    {
        Object o = super.get(key);
        if(o == null)
        {
            if(nullToInitialize)
                return "";
            else
                return null;
        } else
        {
            return o;
        }
    }

    public String getString(Object key) {
        Object o = super.get(key);
        if(o == null) {
            if(nullToInitialize)
                return "";
            else
                return null;
        } else {
            return o.toString();
        }
    }

    @SuppressWarnings("unchecked")
	public int getInt(Object key)
    {
        Object o = super.get(key);
        if(o == null)
            if(nullToInitialize)
            {
                return 0;
            } else
            {
            	System.out.println("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
                throw new RuntimeException("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
            }
        Class classType = o.getClass();
        if(classType == java.lang.Integer.class)
            return ((Integer)o).intValue();
        if(classType == java.lang.Short.class)
            return ((Short)o).shortValue();
        if(classType == java.lang.String.class)
        {
            try
            {
                return Integer.parseInt(o.toString());
            }
            catch(Exception e)
            {
            	System.out.println("Key(" + key + ")" + " Type(int) does not match : It's type is not int.");
            }
            throw new RuntimeException("Value Type(int) does not match : It's type is not int.");
        } else
        {
        	System.out.println("Key(" + key + ")" + " Type(int) does not match : It's type is not int.");
            throw new RuntimeException("Value Type(int) does not match : It's type is not int.");
        }
    }

    @SuppressWarnings("unchecked")
	public double getDouble(Object key)
    {
        Object o = super.get(key);
        if(o == null)
            if(nullToInitialize)
            {
                return 0.0D;
            } else
            {
                System.out.println("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
                throw new RuntimeException("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
            }
        Class classType = o.getClass();
        if(classType == java.lang.Double.class)
            return ((Double)o).doubleValue();
        if(classType == java.lang.Float.class)
            return (double)((Float)o).floatValue();
        if(classType == java.lang.String.class || classType == java.math.BigDecimal.class)
        {
            try
            {
                return Double.parseDouble(o.toString());
            }
            catch(Exception e)
            {
                System.out.println("Key(" + key + ")" + " Type(double) does not match : It's type is not double.");
            }
            throw new RuntimeException("Value Type(double) does not match : It's type is not double.");
        } else
        {
            System.out.println("Key(" + key + ")" + " Type(double) does not match : It's type is not double.");
            throw new RuntimeException("Value Type(double) does not match : It's type is not double.");
        }
    }

    @SuppressWarnings("unchecked")
	public float getFloat(Object key)
    {
        Object o = super.get(key);
        if(o == null)
            if(nullToInitialize)
            {
                return 0.0F;
            } else
            {
                System.out.println("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
                throw new RuntimeException("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
            }
        Class classType = o.getClass();
        if(classType == java.lang.Float.class)
            return ((Float)o).floatValue();
        if(classType == java.lang.String.class || classType == java.math.BigDecimal.class)
        {
            try
            {
                return Float.parseFloat(o.toString());
            }
            catch(Exception e)
            {
                System.out.println("Key(" + key + ")" + " Type(float) does not match : It's type is not float.");
            }
            throw new RuntimeException("Value Type(float) does not match : It's type is not float.");
        } else
        {
            System.out.println("Key(" + key + ")" + " Type(float) does not match : It's type is not float.");
            throw new RuntimeException("Value Type(float) does not match : It's type is not float.");
        }
    }

    @SuppressWarnings("unchecked")
	public long getLong(Object key)
    {
        Object o = super.get(key);
        if(o == null)
            if(nullToInitialize)
            {
                return 0L;
            } else
            {
                System.out.println("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
                throw new RuntimeException("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
            }
        Class classType = o.getClass();
        if(classType == java.lang.Long.class)
            return ((Long)o).longValue();
        if(classType == java.lang.Integer.class)
            return (long)((Integer)o).intValue();
        if(classType == java.lang.Short.class)
            return (long)((Short)o).shortValue();
        if(classType == java.lang.String.class)
        {
            try
            {
                return Long.parseLong(o.toString());
            }
            catch(Exception e)
            {
                System.out.println("Key(" + key + ")" + " Type(long) does not match : It's type is not long.");
            }
            throw new RuntimeException("Value Type(long) does not match : It's type is not long.");
        } else
        {
            System.out.println("Key(" + key + ")" + " Type(long) does not match : It's type is not long.");
            throw new RuntimeException("Value Type(long) does not match : It's type is not long.");
        }
    }

    @SuppressWarnings("unchecked")
	public short getShort(Object key)
    {
        Object o = super.get(key);
        if(o == null)
            if(nullToInitialize)
            {
                return 0;
            } else
            {
                System.out.println("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
                throw new RuntimeException("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
            }
        Class classType = o.getClass();
        if(classType == java.lang.Short.class)
            return ((Short)o).shortValue();
        if(classType == java.lang.String.class)
        {
            try
            {
                return Short.parseShort(o.toString());
            }
            catch(Exception e)
            {
                System.out.println("Key(" + key + ")" + " Type(short) does not match : It's type is not short.");
            }
            throw new RuntimeException("Value Type(short) does not match : It's type is not short.");
        } else
        {
            System.out.println("Key(" + key + ")" + " Type(short) does not match : It's type is not short.");
            throw new RuntimeException("Value Type(short) does not match : It's type is not short.");
        }
    }

    public boolean getBoolean(Object key)
    {
        Object o = super.get(key);
        if(o == null)
            if(nullToInitialize)
            {
                return false;
            } else
            {
            	System.out.println("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
                throw new RuntimeException("Key(" + key + ") does not exist in " + name + " SData or Key(" + key + ")'s value is null.");
            }
        if(o.getClass().isInstance(new Boolean(true)))
            return ((Boolean)o).booleanValue();
        if(o.getClass().isInstance(new String()))
        {
            try
            {
                return Boolean.valueOf(o.toString()).booleanValue();
            }
            catch(Exception e)
            {
            	System.out.println("Key(" + key + ")" + " Type(boolean) does not match : It's type is not boolean.");
            }
            throw new RuntimeException("Value Type(boolean) does not match : It's type is not boolean.");
        } else
        {
        	System.out.println("Key(" + key + ")" + " Type(boolean) does not match : It's type is not boolean.");
            throw new RuntimeException("Value Type(boolean) does not match : It's type is not boolean.");
        }
    }

    @SuppressWarnings("unchecked")
	public String toString() {
        int max = super.size() - 1;
        StringBuffer buf = new StringBuffer();
        Set keySet = super.keySet();
        Iterator keys = keySet.iterator();
        buf.append("\t-----------------[SimpleData]------------------");
        buf.append("\n\t\t   KEY\t\t|\t  VALUE");
        buf.append("\n\t-------------------------------------------------");
        for(int i = 0; i <= max; i++){
            Object o = keys.next();
            if(o == null){
                buf.append("");
            } else {
                String str = o.toString();
                if(str.length() < 6)
                    buf.append("\n\t  " + o + "\t\t\t|    " + getString(o));
                else
                if(str.length() < 14)
                    buf.append("\n\t  " + o + "\t\t|    " + getString(o));
                else
                if(str.length() < 22)
                    buf.append("\n\t  " + o + "\t|    " + getString(o));
                else
                    buf.append("\n\t  " + o + "|    " + getString(o));
            }
        }

        buf.append("\n\t-------------------------------------------------");
        return buf.toString();
    }
}