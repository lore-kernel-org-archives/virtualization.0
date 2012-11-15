From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/12] VMCI: datagram implementation.
Date: Thu, 15 Nov 2012 15:47:14 -0800
Message-ID: <20121115234714.GA8005@kroah.com>
References: <20121107183624.9658.78903.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20121107184116.9658.20579.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20121107184116.9658.20579.stgit@promb-2n-dhcp175.eng.vmware.com>
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

On Wed, Nov 07, 2012 at 10:41:26AM -0800, George Zhang wrote:
> +/*
> + * Create a datagram entry given a handle pointer.
> + */
> +static int dg_create_handle(u32 resource_id,
> +			    u32 flags,
> +			    u32 priv_flags,
> +			    vmci_datagram_recv_cb recv_cb,
> +			    void *client_data, struct vmci_handle *out_handle)
> +{
> +	int result;
> +	u32 context_id;
> +	struct vmci_handle handle;
> +	struct datagram_entry *entry;
> +
> +	BUG_ON(!recv_cb);
> +	BUG_ON(!out_handle);
> +	BUG_ON(priv_flags & ~VMCI_PRIVILEGE_ALL_FLAGS);

Given that this is a static function, there's no need for these
"asserts", right?  Please send a follow-on patch removing all BUG_ON()
calls from these files, it's not acceptable to crash a user's box from a
driver that is handling parameters _you_ are feeding it.

thanks,

greg k-h
