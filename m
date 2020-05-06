From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: performance bug in virtio net xdp
Date: Wed, 6 May 2020 10:37:57 +0200
Message-ID: <20200506103757.4bc78b3a@carbon>
References: <20200506035704-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200506035704-mutt-send-email-mst@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Eugenio Perez Martin <eperezma@redhat.com>, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 6 May 2020 04:08:27 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> So for mergeable bufs, we use ewma machinery to guess the correct buffer
> size. If we don't guess correctly, XDP has to do aggressive copies.
> 
> Problem is, xdp paths do not update the ewma at all, except
> sometimes with XDP_PASS. So whatever we happen to have
> before we attach XDP, will mostly stay around.
> 
> The fix is probably to update ewma unconditionally.

I personally find the code hard to follow, and (I admit) that it took
me some time to understand this code path (so I might still be wrong).

In patch[1] I tried to explain (my understanding):

  In receive_mergeable() the frame size is more dynamic. There are two
  basic cases: (1) buffer size is based on a exponentially weighted
  moving average (see DECLARE_EWMA) of packet length. Or (2) in case
  virtnet_get_headroom() have any headroom then buffer size is
  PAGE_SIZE. The ctx pointer is this time used for encoding two values;
  the buffer len "truesize" and headroom. In case (1) if the rx buffer
  size is underestimated, the packet will have been split over more
  buffers (num_buf info in virtio_net_hdr_mrg_rxbuf placed in top of
  buffer area). If that happens the XDP path does a xdp_linearize_page
  operation.


The EWMA code is not used when headroom is defined, which e.g. gets
enabled when running XDP.


[1] https://lore.kernel.org/netdev/158824572816.2172139.1358700000273697123.stgit@firesoul/
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
