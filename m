From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/12] VMCI: context implementation.
Date: Mon, 29 Oct 2012 19:07:52 -0700
Message-ID: <20121030020752.GA1920@kroah.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030010333.17788.94988.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030010333.17788.94988.stgit@promb-2n-dhcp175.eng.vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: George Zhang <georgezhang@vmware.com>
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2012 at 06:03:42PM -0700, George Zhang wrote:
> VMCI Context code maintains state for vmci and allows the driver to communicate with multiple VMs.
> 

Very minor nit, wrap your changelog comments at 72 columns or at the
least, 80.  Didn't checkpatch complain about that?

> +/*
> + * vmci_context_id_to_host_vmid() - Map CID to HostID
> + * @context_id: Context ID of VMCI context.
> + * @host_vmid:  Host VM ID data
> + * @host_vmid_len:      Length of Host VM ID Data.
> + *
> + * Maps a context ID to the host specific (process/world) ID
> + * of the VM/VMX.  This function is not used on Linux systems
> + * and should be ignored.
> + */
> +int vmci_context_id_to_host_vmid(u32 context_id,
> +				 void *host_vmid, size_t host_vmid_len)
> +{
> +	return VMCI_ERROR_UNAVAILABLE;
> +}
> +EXPORT_SYMBOL_GPL(vmci_context_id_to_host_vmid);

Why even have this function if it doesn't do anything?


thanks,

greg k-h
