Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742FEC4708E
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 06:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7032440360;
	Thu, 29 Dec 2022 06:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7032440360
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tlbYeDp0ScB2; Thu, 29 Dec 2022 06:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F2F6A4031F;
	Thu, 29 Dec 2022 06:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2F6A4031F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AACA2C0033;
	Thu, 29 Dec 2022 06:14:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5113BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 06:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1742F40335
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 06:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1742F40335
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZlGc7YOxKei
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 06:14:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A5EC4031F
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A5EC4031F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 06:14:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0VYK6Tb2_1672294446; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VYK6Tb2_1672294446) by smtp.aliyun-inc.com;
 Thu, 29 Dec 2022 14:14:07 +0800
Message-ID: <1672294402.0733626-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
Date: Thu, 29 Dec 2022 14:13:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
 <1672216298.4455094-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuADspVzge5Q8JdEQssjGg911CaT1u_NQ9s7i-7UMwkhg@mail.gmail.com>
 <1672279792.8628097-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsET7fKxuKu7NckZX5N8fs+AqZ-adwKFNixJRNNn09GRQ@mail.gmail.com>
 <1672285288.3368185-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtp7ee_Tv21SZXh+a5Y6TsT31SUABECbOwRk=Hk3xRcWw@mail.gmail.com>
In-Reply-To: <CACGkMEtp7ee_Tv21SZXh+a5Y6TsT31SUABECbOwRk=Hk3xRcWw@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, edumazet@google.com, kuba@kernel.org,
 maxime.coquelin@redhat.com, pabeni@redhat.com, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 29 Dec 2022 12:08:23 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Dec 29, 2022 at 11:49 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Thu, 29 Dec 2022 11:22:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Thu, Dec 29, 2022 at 10:10 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > On Wed, 28 Dec 2022 19:41:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > On Wed, Dec 28, 2022 at 4:34 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > >
> > > > > > On Tue, 27 Dec 2022 01:58:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > On Tue, Dec 27, 2022 at 12:33:53PM +0800, Jason Wang wrote:
> > > > > > > > On Tue, Dec 27, 2022 at 10:25 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, 26 Dec 2022 15:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > > We used to busy waiting on the cvq command this tends to be
> > > > > > > > > > problematic since:
> > > > > > > > > >
> > > > > > > > > > 1) CPU could wait for ever on a buggy/malicous device
> > > > > > > > > > 2) There's no wait to terminate the process that triggers the cvq
> > > > > > > > > >    command
> > > > > > > > > >
> > > > > > > > > > So this patch switch to use virtqueue_wait_for_used() to sleep with a
> > > > > > > > > > timeout (1s) instead of busy polling for the cvq command forever. This
> > > > > > > > >
> > > > > > > > > I don't think that a fixed 1S is a good choice.
> > > > > > > >
> > > > > > > > Well, it could be tweaked to be a little bit longer.
> > > > > > > >
> > > > > > > > One way, as discussed, is to let the device advertise a timeout then
> > > > > > > > the driver can validate if it's valid and use that timeout. But it
> > > > > > > > needs extension to the spec.
> > > > > > >
> > > > > > > Controlling timeout from device is a good idea, e.g. hardware devices
> > > > > > > would benefit from a shorter timeout, hypervisor devices from a longer
> > > > > > > timeout or no timeout.
> > > > > >
> > > > > > Yes. That is good.
> > > > > >
> > > > > > Before introducing this feature, I personally like to use "wait", rather than
> > > > > > define a timeout.
> > > > >
> > > > > Note that the driver still needs to validate what device advertises to
> > > > > avoid infinite wait.
> > > >
> > > > Sorry, I didn't understand what you mean.
> > >
> > > I meant the interface needs to carefully designed to
> > >
> > > 1) avoid device to advertise a infinite (or very long) timeout
> > > 2) driver need to have its own max timeout regardless what device advertises
> >
> >
> > I see.
> >
> > As far as I know, different operations will take different time.
> > For example, the queues are initialized one by one when performing
> > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET commands. If the number of queues is large, then
> > this time will be very long.
>
> I see. This is the case even for the software backends.
>
> >
> > So we should set different timeouts for different commands.
>
> Probably but it would result in a very complex interface, the device
> can just choose to advertise the maximum timeout of all the commands
> in this case. As discussed, I think we can start a very long timeout.
> Is 1 minutes sufficient in this case?


For now, 1 minutes are safe.

Thanks.

>
> Thanks
>
> >
> > Thanks.
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > Some of the DPUs are very
> > > > > > > > > lazy for cvq handle.
> > > > > > > >
> > > > > > > > Such design needs to be revisited, cvq (control path) should have a
> > > > > > > > better priority or QOS than datapath.
> > > > > > >
> > > > > > > Spec says nothing about this, so driver can't assume this either.
> > > > > > >
> > > > > > > > > In particular, we will also directly break the device.
> > > > > > > >
> > > > > > > > It's kind of hardening for malicious devices.
> > > > > > >
> > > > > > > ATM no amount of hardening can prevent a malicious hypervisor from
> > > > > > > blocking the guest. Recovering when a hardware device is broken would be
> > > > > > > nice but I think if we do bother then we should try harder to recover,
> > > > > > > such as by driving device reset.
> > > > > > >
> > > > > > >
> > > > > > > Also, does your patch break surprise removal? There's no callback
> > > > > > > in this case ATM.
> > > > > > >
> > > > > > > > >
> > > > > > > > > I think it is necessary to add a Virtio-Net parameter to allow users to define
> > > > > > > > > this timeout by themselves. Although I don't think this is a good way.
> > > > > > > >
> > > > > > > > Very hard and unfriendly to the end users.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > > gives the scheduler a breath and can let the process can respond to
> > > > > > > > > > asignal. If the device doesn't respond in the timeout, break the
> > > > > > > > > > device.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > > Changes since V1:
> > > > > > > > > > - break the device when timeout
> > > > > > > > > > - get buffer manually since the virtio core check more_used() instead
> > > > > > > > > > ---
> > > > > > > > > >  drivers/net/virtio_net.c | 24 ++++++++++++++++--------
> > > > > > > > > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > > > index efd9dd55828b..6a2ea64cfcb5 100644
> > > > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > > > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> > > > > > > > > >       vi->rx_mode_work_enabled = false;
> > > > > > > > > >       spin_unlock_bh(&vi->rx_mode_lock);
> > > > > > > > > >
> > > > > > > > > > +     virtqueue_wake_up(vi->cvq);
> > > > > > > > > >       flush_work(&vi->rx_mode_work);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > > > >       return !oom;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > > > > > > > > +{
> > > > > > > > > > +     virtqueue_wake_up(cvq);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static void skb_recv_done(struct virtqueue *rvq)
> > > > > > > > > >  {
> > > > > > > > > >       struct virtnet_info *vi = rvq->vdev->priv;
> > > > > > > > > > @@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> > > > > > > > > >       return err;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static int virtnet_close(struct net_device *dev);
> > > > > > > > > > +
> > > > > > > > > >  /*
> > > > > > > > > >   * Send command via the control virtqueue and check status.  Commands
> > > > > > > > > >   * supported by the hypervisor, as indicated by feature bits, should
> > > > > > > > > > @@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > > > > > > >       if (unlikely(!virtqueue_kick(vi->cvq)))
> > > > > > > > > >               return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > > > >
> > > > > > > > > > -     /* Spin for a response, the kick causes an ioport write, trapping
> > > > > > > > > > -      * into the hypervisor, so the request should be handled immediately.
> > > > > > > > > > -      */
> > > > > > > > > > -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > > > > > > -            !virtqueue_is_broken(vi->cvq))
> > > > > > > > > > -             cpu_relax();
> > > > > > > > > > +     if (virtqueue_wait_for_used(vi->cvq)) {
> > > > > > > > > > +             virtqueue_get_buf(vi->cvq, &tmp);
> > > > > > > > > > +             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > > > > +     }
> > > > > > > > > >
> > > > > > > > > > -     return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > > > > > > +     netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
> > > > > > > > > > +     virtio_break_device(vi->vdev);
> > > > > > > > > > +     return VIRTIO_NET_ERR;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > > > > > > > > > @@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > > > > > > >
> > > > > > > > > >       /* Parameters for control virtqueue, if any */
> > > > > > > > > >       if (vi->has_cvq) {
> > > > > > > > > > -             callbacks[total_vqs - 1] = NULL;
> > > > > > > > > > +             callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > > > > > > >               names[total_vqs - 1] = "control";
> > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.25.1
> > > > > > > > > >
> > > > > > > > > > _______________________________________________
> > > > > > > > > > Virtualization mailing list
> > > > > > > > > > Virtualization@lists.linux-foundation.org
> > > > > > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
