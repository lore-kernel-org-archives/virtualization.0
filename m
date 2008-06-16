From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] virtio_net: Fix skb->csum_start computation
	(2.6.24, 2.6.25)
Date: Mon, 16 Jun 2008 12:38:45 -0700
Message-ID: <20080616193845.GA3804@kroah.com>
References: <200806161441.41993.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806161441.41993.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: stable@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 16, 2008 at 02:41:41PM +1000, Rusty Russell wrote:
> From: Mark McLoughlin <markmc@redhat.com>
> 
> hdr->csum_start is the offset from the start of the ethernet
> header to the transport layer checksum field. skb->csum_start
> is the offset from skb->head.
> 
> skb_partial_csum_set() assumes that skb->data points to the
> ethernet header - i.e. it computes skb->csum_start by adding
> the headroom to hdr->csum_start.
> 
> Since eth_type_trans() skb_pull()s the ethernet header,
> skb_partial_csum_set() should be called before
> eth_type_trans().
> 
> (Without this patch, GSO packets from a guest to the world outside the
> host are corrupted).

Is this in Linus's tree already?  If so, what is the commit id.

If not, we need a good reason to be able to take it into the -stable
tree (note that 2.6.24 isn't being maintained anymore...)

thanks,

greg k-h
