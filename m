From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/12] VMCI: queue pairs implementation.
Date: Tue, 8 Jan 2013 16:15:39 -0800
Message-ID: <20130109001539.GA24989@kroah.com>
References: <20130108234751.2698.66606.stgit@promb-2n-dhcp175.eng.vmware.com>
	<20130108235444.2698.24076.stgit@promb-2n-dhcp175.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130108235444.2698.24076.stgit@promb-2n-dhcp175.eng.vmware.com>
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

On Tue, Jan 08, 2013 at 03:54:54PM -0800, George Zhang wrote:
> VMCI queue pairs allow for bi-directional ordered communication between host and guests.

You should wrap your commit lines at 72 characters, like git asks you to :)

> +/* Guest device port I/O. */
> +struct PPNSet {
> +	u64 num_produce_pages;
> +	u64 num_consume_pages;
> +	u32 *produce_ppns;
> +	u32 *consume_ppns;
> +	bool initialized;
> +};

I know this is a private structure to the driver, so it's not that big
of a deal at all, but the naming for this is a bit odd (mixed case.)

Not a show stopper at all, but if you had run checkpatch.pl on it, it
would have warned you about this.

thanks,

greg k-h
