package modelo;

public class Cliente {

    private int idCliente;
    private int idNegocio;
    private String tipoDocumento;
    private String numeroDocumento;
    private String razonSocialNombre;
    private String direccion;
    private String email;
    private String telefono;

    public Cliente() {
    }

    public Cliente(int idCliente, int idNegocio, String tipoDocumento, String numeroDocumento,
                   String razonSocialNombre, String direccion, String email, String telefono) {
        this.idCliente = idCliente;
        this.idNegocio = idNegocio;
        this.tipoDocumento = tipoDocumento;
        this.numeroDocumento = numeroDocumento;
        this.razonSocialNombre = razonSocialNombre;
        this.direccion = direccion;
        this.email = email;
        this.telefono = telefono;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdNegocio() {
        return idNegocio;
    }

    public void setIdNegocio(int idNegocio) {
        this.idNegocio = idNegocio;
    }

    public String getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getNumeroDocumento() {
        return numeroDocumento;
    }

    public void setNumeroDocumento(String numeroDocumento) {
        this.numeroDocumento = numeroDocumento;
    }

    public String getRazonSocialNombre() {
        return razonSocialNombre;
    }

    public void setRazonSocialNombre(String razonSocialNombre) {
        this.razonSocialNombre = razonSocialNombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
}