From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v8 7/7] net: vhost: make busyloop_intr more
 accurate
Date: Mon, 1 Jun 2020 09:26:00 -0400
Message-ID: <20200601092522-mutt-send-email-mst@kernel.org>
References: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
 <1534680686-3108-8-git-send-email-xiangxia.m.yue@gmail.com>
 <f85bfa97-ab9c-2d51-2053-1fe6bb3d45bc@redhat.com>
 <8460e039-d58e-85df-cef9-c87933f46cc2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8460e039-d58e-85df-cef9-c87933f46cc2@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: xiangxia.m.yue@gmail.com, makita.toshiaki@lab.ntt.co.jp, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 21, 2018 at 08:47:35AM +0800, Jason Wang wrote:
> 
> 
> On 2018年08月21日 08:33, Jason Wang wrote:
> > 
> > 
> > On 2018年08月19日 20:11, xiangxia.m.yue@gmail.com wrote:
> > > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > 
> > > The patch uses vhost_has_work_pending() to check if
> > > the specified handler is scheduled, because in the most case,
> > > vhost_has_work() return true when other side handler is added
> > > to worker list. Use the vhost_has_work_pending() insead of
> > > vhost_has_work().
> > > 
> > > Topology:
> > > [Host] ->linux bridge -> tap vhost-net ->[Guest]
> > > 
> > > TCP_STREAM (netperf):
> > > * Without the patch:  38035.39 Mbps, 3.37 us mean latency
> > > * With the patch:     38409.44 Mbps, 3.34 us mean latency
> > 
> > The improvement is not obvious as last version. Do you imply there's
> > some recent changes of vhost that make it faster?
> > 
> 
> I misunderstood the numbers, please ignore this.
> 
> It shows less than 1% improvement. I'm not sure it's worth to do so. Can you
> try bi-directional pktgen to see if it has more obvious effect?
> 
> Thanks


Right, this kind of gain is in the noise. Try measuring CPU utilization?

> > Thanks
> > 
> > > 
> > > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > > ---
> > >   drivers/vhost/net.c | 9 ++++++---
> > >   1 file changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > index db63ae2..b6939ef 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -487,10 +487,8 @@ static void vhost_net_busy_poll(struct
> > > vhost_net *net,
> > >       endtime = busy_clock() + busyloop_timeout;
> > >         while (vhost_can_busy_poll(endtime)) {
> > > -        if (vhost_has_work(&net->dev)) {
> > > -            *busyloop_intr = true;
> > > +        if (vhost_has_work(&net->dev))
> > >               break;
> > > -        }
> > >             if ((sock_has_rx_data(sock) &&
> > >                !vhost_vq_avail_empty(&net->dev, rvq)) ||
> > > @@ -513,6 +511,11 @@ static void vhost_net_busy_poll(struct
> > > vhost_net *net,
> > >           !vhost_has_work_pending(&net->dev, VHOST_NET_VQ_RX))
> > >           vhost_net_enable_vq(net, rvq);
> > >   +    if (vhost_has_work_pending(&net->dev,
> > > +                   poll_rx ?
> > > +                   VHOST_NET_VQ_RX: VHOST_NET_VQ_TX))
> > > +        *busyloop_intr = true;
> > > +
> > >       mutex_unlock(&vq->mutex);
> > >   }
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
