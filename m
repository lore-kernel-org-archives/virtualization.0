From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: fix the XDP truesize
 calculation for mergeable buffers
Date: Wed, 6 May 2020 08:08:48 -0400
Message-ID: <20200506075807-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506061633.16327-2-jasowang@redhat.com>
 <20200506033259-mutt-send-email-mst@kernel.org>
 <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 06, 2020 at 04:21:15PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午3:37, Michael S. Tsirkin wrote:
> > On Wed, May 06, 2020 at 02:16:33PM +0800, Jason Wang wrote:
> > > We should not exclude headroom and tailroom when XDP is set. So this
> > > patch fixes this by initializing the truesize from PAGE_SIZE when XDP
> > > is set.
> > > 
> > > Cc: Jesper Dangaard Brouer<brouer@redhat.com>
> > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > Seems too aggressive, we do not use up the whole page for the size.
> > 
> > 
> > 
> 
> For XDP yes, we do:
> 
> static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
>                       struct ewma_pkt_len *avg_pkt_len,
>                       unsigned int room)
> {
>     const size_t hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
>     unsigned int len;
> 
>     if (room)
>         return PAGE_SIZE - room;
> 
> ...
> 
> Thanks

Hmm. But that's only for new buffers. Buffers that were outstanding
before xdp was attached don't use the whole page, do they?




Also, with TCP smallqueues blocking the queue like that might be a problem.
Could you try and check performance impact of this?
I looked at what other drivers do and I see they tend to copy the skb
in XDP_PASS case. ATM we don't normally - but should we?

-- 
MST
