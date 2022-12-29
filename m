Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E73CC4332F
	for <virtualization@archiver.kernel.org>; Thu, 29 Dec 2022 02:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB0D84011D;
	Thu, 29 Dec 2022 02:06:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB0D84011D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyjT-WbOi7ke; Thu, 29 Dec 2022 02:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5182340122;
	Thu, 29 Dec 2022 02:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5182340122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E072C0032;
	Thu, 29 Dec 2022 02:06:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 770E0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 02:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F67B60C29
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 02:06:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F67B60C29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5X7iPjGM4kaX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 02:06:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37A5B6066D
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37A5B6066D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Dec 2022 02:06:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0VYJPPK2_1672279570; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VYJPPK2_1672279570) by smtp.aliyun-inc.com;
 Thu, 29 Dec 2022 10:06:11 +0800
Message-ID: <1672279315.3435805-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
Date: Thu, 29 Dec 2022 10:01:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <1672216748.7057884-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtr7r25s6Tgsj=fcw3MD3ShLmuuVHvx0WVNiQHyV_G=zw@mail.gmail.com>
In-Reply-To: <CACGkMEtr7r25s6Tgsj=fcw3MD3ShLmuuVHvx0WVNiQHyV_G=zw@mail.gmail.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, kuba@kernel.org, maxime.coquelin@redhat.com,
 pabeni@redhat.com, davem@davemloft.net
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

On Wed, 28 Dec 2022 19:43:56 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Dec 28, 2022 at 4:40 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > On Tue, 27 Dec 2022 12:33:53 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > On Tue, Dec 27, 2022 at 10:25 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >
> > > > On Mon, 26 Dec 2022 15:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > We used to busy waiting on the cvq command this tends to be
> > > > > problematic since:
> > > > >
> > > > > 1) CPU could wait for ever on a buggy/malicous device
> > > > > 2) There's no wait to terminate the process that triggers the cvq
> > > > >    command
> > > > >
> > > > > So this patch switch to use virtqueue_wait_for_used() to sleep with a
> > > > > timeout (1s) instead of busy polling for the cvq command forever. This
> > > >
> > > > I don't think that a fixed 1S is a good choice.
> > >
> > > Well, it could be tweaked to be a little bit longer.
> > >
> > > One way, as discussed, is to let the device advertise a timeout then
> > > the driver can validate if it's valid and use that timeout. But it
> > > needs extension to the spec.
> > >
> > > > Some of the DPUs are very
> > > > lazy for cvq handle.
> > >
> > > Such design needs to be revisited, cvq (control path) should have a
> > > better priority or QOS than datapath.
> > >
> > > > In particular, we will also directly break the device.
> > >
> > > It's kind of hardening for malicious devices.
> >
> > Just based on timeout, it is judged that it is a malicious device. I think it is
> > too arbitrary.
>
> Drivers have very little information to make the decision. So it's
> really a balance.
>
> We can start with a very long timeout like 10 minutes. Otherwise a
> buggy/malicious device will block a lot of important things (reboot,
> modprobe) even if the scheduler is still functional.

Relatively speaking, starting from a 1min+ timeout, I think it is safe.

Thanks.



>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > >
> > > > I think it is necessary to add a Virtio-Net parameter to allow users to define
> > > > this timeout by themselves. Although I don't think this is a good way.
> > >
> > > Very hard and unfriendly to the end users.
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > > gives the scheduler a breath and can let the process can respond to
> > > > > asignal. If the device doesn't respond in the timeout, break the
> > > > > device.
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > > Changes since V1:
> > > > > - break the device when timeout
> > > > > - get buffer manually since the virtio core check more_used() instead
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 24 ++++++++++++++++--------
> > > > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index efd9dd55828b..6a2ea64cfcb5 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -405,6 +405,7 @@ static void disable_rx_mode_work(struct virtnet_info *vi)
> > > > >       vi->rx_mode_work_enabled = false;
> > > > >       spin_unlock_bh(&vi->rx_mode_lock);
> > > > >
> > > > > +     virtqueue_wake_up(vi->cvq);
> > > > >       flush_work(&vi->rx_mode_work);
> > > > >  }
> > > > >
> > > > > @@ -1497,6 +1498,11 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >       return !oom;
> > > > >  }
> > > > >
> > > > > +static void virtnet_cvq_done(struct virtqueue *cvq)
> > > > > +{
> > > > > +     virtqueue_wake_up(cvq);
> > > > > +}
> > > > > +
> > > > >  static void skb_recv_done(struct virtqueue *rvq)
> > > > >  {
> > > > >       struct virtnet_info *vi = rvq->vdev->priv;
> > > > > @@ -1984,6 +1990,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
> > > > >       return err;
> > > > >  }
> > > > >
> > > > > +static int virtnet_close(struct net_device *dev);
> > > > > +
> > > > >  /*
> > > > >   * Send command via the control virtqueue and check status.  Commands
> > > > >   * supported by the hypervisor, as indicated by feature bits, should
> > > > > @@ -2026,14 +2034,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
> > > > >       if (unlikely(!virtqueue_kick(vi->cvq)))
> > > > >               return vi->ctrl->status == VIRTIO_NET_OK;
> > > > >
> > > > > -     /* Spin for a response, the kick causes an ioport write, trapping
> > > > > -      * into the hypervisor, so the request should be handled immediately.
> > > > > -      */
> > > > > -     while (!virtqueue_get_buf(vi->cvq, &tmp) &&
> > > > > -            !virtqueue_is_broken(vi->cvq))
> > > > > -             cpu_relax();
> > > > > +     if (virtqueue_wait_for_used(vi->cvq)) {
> > > > > +             virtqueue_get_buf(vi->cvq, &tmp);
> > > > > +             return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > +     }
> > > > >
> > > > > -     return vi->ctrl->status == VIRTIO_NET_OK;
> > > > > +     netdev_err(vi->dev, "CVQ command timeout, break the virtio device.");
> > > > > +     virtio_break_device(vi->vdev);
> > > > > +     return VIRTIO_NET_ERR;
> > > > >  }
> > > > >
> > > > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > > > > @@ -3526,7 +3534,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> > > > >
> > > > >       /* Parameters for control virtqueue, if any */
> > > > >       if (vi->has_cvq) {
> > > > > -             callbacks[total_vqs - 1] = NULL;
> > > > > +             callbacks[total_vqs - 1] = virtnet_cvq_done;
> > > > >               names[total_vqs - 1] = "control";
> > > > >       }
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > > > _______________________________________________
> > > > > Virtualization mailing list
> > > > > Virtualization@lists.linux-foundation.org
> > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > >
> > >
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
