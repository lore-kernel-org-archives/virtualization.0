From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/12] VMCI: device driver implementaton.
Date: Mon, 29 Oct 2012 19:21:43 -0700
Message-ID: <20121030022143.GD1920@kroah.com>
References: <20121030005923.17788.21797.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121030010409.17788.6745.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121030010409.17788.6745.stgit@promb-2n-dhcp175.eng.vmware.com>
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

On Mon, Oct 29, 2012 at 06:04:15PM -0700, George Zhang wrote:
> +/*
> + * vmci_get_context_id() - Gets the current context ID.
> + *
> + * Returns the current context ID.  Note that since this is accessed only
> + * from code running in the host, this always returns the host context ID.
> + */
> +u32 vmci_get_context_id(void)
> +{
> +	if (vmci_guest_code_active()) {
> +		return vmci_get_vm_context_id();
> +	} else if (vmci_host_code_active()) {
> +		return VMCI_HOST_CONTEXT_ID;
> +	} else {
> +		return VMCI_INVALID_ID;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(vmci_get_context_id);

checkpatch didn't complain about too many { } here?

> +/*
> + * vmci_version() - Returns the version of the driver.
> + *
> + * Returns the version of the VMCI driver.
> + */
> +u32 vmci_version(void)
> +{
> +	return VMCI_VERSION;
> +}
> +EXPORT_SYMBOL_GPL(vmci_version);

Why is this needed?  Why would a kernel driver ever care about this?

thanks,

greg k-h
