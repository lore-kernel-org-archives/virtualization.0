From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: performance bug in virtio net xdp
Date: Wed, 6 May 2020 07:57:10 -0400
Message-ID: <20200506075226-mutt-send-email-mst@kernel.org>
References: <20200506035704-mutt-send-email-mst@kernel.org>
 <20200506103757.4bc78b3a@carbon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200506103757.4bc78b3a@carbon>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Eugenio Perez Martin <eperezma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 06, 2020 at 10:37:57AM +0200, Jesper Dangaard Brouer wrote:
> On Wed, 6 May 2020 04:08:27 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > So for mergeable bufs, we use ewma machinery to guess the correct buffer
> > size. If we don't guess correctly, XDP has to do aggressive copies.
> > 
> > Problem is, xdp paths do not update the ewma at all, except
> > sometimes with XDP_PASS. So whatever we happen to have
> > before we attach XDP, will mostly stay around.
> > 
> > The fix is probably to update ewma unconditionally.
> 
> I personally find the code hard to follow, and (I admit) that it took
> me some time to understand this code path (so I might still be wrong).
> 
> In patch[1] I tried to explain (my understanding):
> 
>   In receive_mergeable() the frame size is more dynamic. There are two
>   basic cases: (1) buffer size is based on a exponentially weighted
>   moving average (see DECLARE_EWMA) of packet length. Or (2) in case
>   virtnet_get_headroom() have any headroom then buffer size is
>   PAGE_SIZE. The ctx pointer is this time used for encoding two values;
>   the buffer len "truesize" and headroom. In case (1) if the rx buffer
>   size is underestimated, the packet will have been split over more
>   buffers (num_buf info in virtio_net_hdr_mrg_rxbuf placed in top of
>   buffer area). If that happens the XDP path does a xdp_linearize_page
>   operation.
> 
> 
> The EWMA code is not used when headroom is defined, which e.g. gets
> enabled when running XDP.
> 
> 
> [1] https://lore.kernel.org/netdev/158824572816.2172139.1358700000273697123.stgit@firesoul/

You are right.
So I guess the problem is just inconsistency?

When XDP program returns XDP_PASS, and it all fits in one page,
then we trigger
	        ewma_pkt_len_add(&rq->mrg_avg_pkt_len, head_skb->len);

if it does not trigger XDP_PASS, or does not fit in one page,
then we don't.

Given XDP does not use ewma for sizing, let's not update the average
either.


> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
