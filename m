From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 11/12] VMCI: host side driver implementation.
Date: Thu, 15 Nov 2012 16:03:31 -0800
Message-ID: <20121116000331.GA13149@kroah.com>
References: <20121107183624.9658.78903.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121107184249.9658.53806.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121107184249.9658.53806.stgit@promb-2n-dhcp175.eng.vmware.com>
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

On Wed, Nov 07, 2012 at 10:42:53AM -0800, George Zhang wrote:
> +/*
> + * Sets up a given context for notify to work.  Calls drv_map_bool_ptr()
> + * which maps the notify boolean in user VA in kernel space.
> + */
> +static int vmci_host_setup_notify(struct vmci_ctx *context,
> +				  unsigned long uva)
> +{
> +	struct page *page;
> +	int retval;
> +
> +	if (context->notify_page) {
> +		pr_devel("%s: Notify mechanism is already set up.\n", __func__);
> +		return VMCI_ERROR_DUPLICATE_ENTRY;
> +	}
> +
> +	if (!access_ok(VERIFY_WRITE, (void __user *)uva, sizeof(bool)))
> +		return VMCI_ERROR_GENERIC;

This line causes sparse to complain.  The odds that userspace knows what
gcc is using for "bool" is pretty low.

Please fix.

thanks,

greg k-h
