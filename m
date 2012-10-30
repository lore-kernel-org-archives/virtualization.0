From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/12] VMCI: device driver implementaton.
Date: Mon, 29 Oct 2012 19:23:47 -0700
Message-ID: <20121030022347.GE1920@kroah.com>
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
> +static int __init vmci_core_init(void)
> +{
> +	int result;
> +
> +	result = vmci_ctx_init();
> +	if (result < VMCI_SUCCESS) {
> +		pr_err("Failed to initialize VMCIContext (result=%d).\n",
> +			result);

If you are going to use pr_* functions, it's usually a good idea to
define pr_fmt in a consistant way so that it shows up the same across
all of your .c files.  See other drivers for examples of how to do this
properly.

> +		return -EINVAL;
> +	}
> +
> +	result = vmci_datagram_init();
> +	if (result < VMCI_SUCCESS) {
> +		pr_err("Failed to initialize VMCIDatagram (result=%d).\n",
> +			result);
> +		return -EINVAL;
> +	}
> +
> +	result = vmci_event_init();
> +	if (result < VMCI_SUCCESS) {
> +		pr_err("Failed to initialize VMCIEvent (result=%d).\n", result);
> +		return -EINVAL;
> +	}

You don't free and unwind things properly if things go wrong here, why
not?

> +
> +	return 0;
> +}
> +
> +static void __exit vmci_core_exit(void)
> +{
> +	vmci_event_exit();
> +}
> +
> +static int __init vmci_drv_init(void)
> +{
> +	int error;
> +
> +	error = vmci_core_init();
> +	if (error)
> +		return error;
> +
> +	if (!vmci_disable_guest) {
> +		error = vmci_guest_init();
> +		if (error) {
> +			pr_warn("Failed to initialize guest personality (err=%d).\n",
> +				error);
> +		} else {
> +			vmci_guest_personality_initialized = true;
> +			pr_info("Guest personality initialized and is %s\n",
> +				vmci_guest_code_active() ?
> +				"active" : "inactive");
> +		}
> +	}
> +
> +	if (!vmci_disable_host) {
> +		error = vmci_host_init();
> +		if (error) {
> +			pr_warn("Unable to initialize host personality (err=%d).\n",
> +				error);
> +		} else {
> +			vmci_host_personality_initialized = true;
> +			pr_info("Initialized host personality\n");
> +		}
> +	}
> +
> +	if (!vmci_guest_personality_initialized &&
> +	    !vmci_host_personality_initialized) {
> +		vmci_core_exit();
> +		return -ENODEV;
> +	}
> +
> +	pr_debug("Module is initialized\n");

Really?  You need this message still?

> +	return 0;
> +}
> +module_init(vmci_drv_init);
> +
> +static void __exit vmci_drv_exit(void)
> +{
> +	if (vmci_guest_personality_initialized)
> +		vmci_guest_exit();
> +
> +	if (vmci_host_personality_initialized)
> +		vmci_host_exit();
> +
> +	vmci_core_exit();
> +	pr_debug("Module is unloaded\n");

Same here, is this really needed?

thanks,

greg k-h
