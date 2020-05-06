From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Date: Wed, 6 May 2020 05:46:59 -0400
Message-ID: <20200506054619-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506102123.739f1233@carbon>
 <3ecb558b-5281-2497-db3c-6aae7d7f882b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3ecb558b-5281-2497-db3c-6aae7d7f882b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Jubran, Samih" <sameehj@amazon.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 06, 2020 at 04:34:36PM +0800, Jason Wang wrote:
> 
> On 2020/5/6 下午4:21, Jesper Dangaard Brouer wrote:
> > On Wed,  6 May 2020 14:16:32 +0800
> > Jason Wang <jasowang@redhat.com> wrote:
> > 
> > > We tried to reserve space for vnet header before
> > > xdp.data_hard_start. But this is useless since the packet could be
> > > modified by XDP which may invalidate the information stored in the
> > > header and
> > IMHO above statements are wrong. XDP cannot access memory before
> > xdp.data_hard_start. Thus, it is safe to store a vnet headers before
> > xdp.data_hard_start. (The sfc driver also use this "before" area).
> 
> 
> The problem is if we place vnet header before data_hard_start, virtio-net
> will fail any header adjustment.
> 
> Or do you mean to copy vnet header before data_hard_start before processing
> XDP?
> 
> 
> > 
> > > there's no way for XDP to know the existence of the vnet header currently.
> > It is true that XDP is unaware of this area, which is the way it
> > should be.  Currently the area will survive after calling BPF/XDP.
> > After your change it will be overwritten in xdp_frame cases.
> > 
> > 
> > > So let's just not reserve space for vnet header in this case.
> > I think this is a wrong approach!
> > 
> > We are working on supporting GRO multi-buffer for XDP.  The vnet header
> > contains GRO information (see pahole below sign).
> 
> 
> Another note is that since we need reserve room for skb_shared_info, GRO for
> XDP may probably lead more frag list.
> 
> 
> >   It is currently not
> > used in the XDP case, but we will be working towards using it.
> 
> 
> Good to know that, but I think it can only work when the packet is not
> modified by XDP?
> 
> 
> > There
> > are a lot of unanswered questions on how this will be implemented.
> > Thus, I cannot layout how we are going to leverage this info yet, but
> > your patch are killing this info, which IHMO is going in the wrong
> > direction.
> 
> 
> I can copy vnet header ahead of data_hard_start, does it work for you?
> 
> Thanks

That's likely to be somewhat expensive.


> 
> > 
> > 
> > > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >   drivers/net/virtio_net.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 11f722460513..98dd75b665a5 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -684,8 +684,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
> > >   			page = xdp_page;
> > >   		}
> > > -		xdp.data_hard_start = buf + VIRTNET_RX_PAD + vi->hdr_len;
> > > -		xdp.data = xdp.data_hard_start + xdp_headroom;
> > > +		xdp.data_hard_start = buf + VIRTNET_RX_PAD;
> > > +		xdp.data = xdp.data_hard_start + xdp_headroom + vi->hdr_len;
> > >   		xdp.data_end = xdp.data + len;
> > >   		xdp.data_meta = xdp.data;
> > >   		xdp.rxq = &rq->xdp_rxq;
> > > @@ -845,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
> > >   		 * the descriptor on if we get an XDP_TX return code.
> > >   		 */
> > >   		data = page_address(xdp_page) + offset;
> > > -		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
> > > +		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM;
> > >   		xdp.data = data + vi->hdr_len;
> > >   		xdp.data_end = xdp.data + (len - vi->hdr_len);
> > >   		xdp.data_meta = xdp.data;
> > 
> > 
