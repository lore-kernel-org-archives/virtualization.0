Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B555C4332F
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 03:13:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5FF610CB
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 03:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0A5FF610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C067280F88;
	Mon, 13 Sep 2021 03:13:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FwtaqwYTucgB; Mon, 13 Sep 2021 03:13:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D893B80F8A;
	Mon, 13 Sep 2021 03:13:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A476AC0011;
	Mon, 13 Sep 2021 03:13:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91E70C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 03:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B31280F8A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 03:13:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dUiknkKCMlk3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 03:13:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCC7E80F88
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 03:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631502806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ynfqwpH3KzIeA0uiKbDJ8EYG2NA2NQ/Pqq4R6pwUis=;
 b=FLKyGAc5K9V3RBs8Zvqn8rR4KRSc5yEon8OzaQjRHQVSIimaDSZ6xx35bmIkgO/YKXAw3y
 n1g1wsmWxbOyPXr+b669mxyyPtTphe4icPpucrWBpceSkl5Obh73UlJO2HlDxAn6+3LwTA
 nxA75L7Q5CFxo5auUOsPI2VWxGzL1Yc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-XvEYaMCJMUaigp7eUk1hIg-1; Sun, 12 Sep 2021 23:13:25 -0400
X-MC-Unique: XvEYaMCJMUaigp7eUk1hIg-1
Received: by mail-lj1-f198.google.com with SMTP id
 v25-20020a2e9919000000b001bc160ab064so3506452lji.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 20:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7ynfqwpH3KzIeA0uiKbDJ8EYG2NA2NQ/Pqq4R6pwUis=;
 b=wQpY+dT4KdJ9GUd9j5QnGEJLNXDkNzddm/3rLJEVms3A+4g74dq3p7hLwZMQbGJJY6
 LihjFzIyU+IcmGfjO9XPGOiAkuXVd56iXuFvz2SCNNvWSM+6UTTZoL2bb1cUs918qNEH
 ZoYfwXDCuy8MSvsgLz8DDmrRnBscTIq/OY0VZ0hH3WMZkyD7CWbCLO6PlIrYqoI/Eykq
 TitnUUqOafzrI9jLUWloDkF7unZl6FvAissgOnjN8n1GJMfVjqPMqgJTnElpLzvibJ9L
 EzOnQAv9tOWoK3y4Y9Cu4pn4HfjmT/yaotKBm4NO48yfRkmd3n00dPDfQ3fGg+5FT/gx
 52mQ==
X-Gm-Message-State: AOAM5323oRZbHO7sMA3sjnnF/Wn0uXOzyGUbLCK6a6u1rMCaJYjdPeMh
 Gepx/7wiENfgA268VQJzNepCa7BUv69FTJjJjyi0DhEov3hZJ7hPBu7QDoT4EiyUffvDDTxNuhs
 /zVBBvwuA8yrtOEIt4xlgVDhgyGX6i8sqEahRClPNuhMXLztAeMKgDD5H/Q==
X-Received: by 2002:a05:6512:110b:: with SMTP id
 l11mr7284209lfg.199.1631502803431; 
 Sun, 12 Sep 2021 20:13:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWY3irfNvlKroa2NGZGKMmbuG1Hy7Q+Q0B/7zCg1JFPEhXMMAXZPcrIOwol7AlQdOQ7HyObdOu36j70R/Mbgg=
X-Received: by 2002:a05:6512:110b:: with SMTP id
 l11mr7284195lfg.199.1631502803161; 
 Sun, 12 Sep 2021 20:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
 <20210909080157.GA17383@L-PF27918B-1352.localdomain>
 <CACGkMEsnp7-axbZWuB_w7ZkSWKa0Y+Ej-Kq0QSfO2-DNN=ShVA@mail.gmail.com>
 <20210909095726.GA17469@L-PF27918B-1352.localdomain>
 <CACGkMEvy-DWjAD636+YshY5VUE_mDQo0JBxEw7uBp5rExMj2_w@mail.gmail.com>
 <20210910073231.GA17715@L-PF27918B-1352.localdomain>
 <CACLfguWeXwWJ9yd18vHbYicOk5=eMZJ0X=m86EKjmgHu35NdVA@mail.gmail.com>
 <20210910092013.GA17783@L-PF27918B-1352.localdomain>
 <CACLfguXFDra77Nqiv+ArUEOzTf9rzi0gLK4_r0ofCfJHSO056Q@mail.gmail.com>
 <CACGkMEte0iEpDh4dT6Bgd6Be2O3BwpOsehP14A8kLeqTdqBQ9A@mail.gmail.com>
 <20210913025920.GB17820@L-PF27918B-1352.localdomain>
In-Reply-To: <20210913025920.GB17820@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Sep 2021 11:13:12 +0800
Message-ID: <CACGkMEuDg8cOVT75gaMS5ZV7h2+U3ivrcO6Y-nDjZXFGi8o-Qw@mail.gmail.com>
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in
 vdpa_config_ops
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Cindy Lu <lulu@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Sep 13, 2021 at 10:59 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Mon, Sep 13, 2021 at 09:43:40AM +0800, Jason Wang wrote:
> > On Fri, Sep 10, 2021 at 11:11 PM Cindy Lu <lulu@redhat.com> wrote:
> > >
> > > On Fri, Sep 10, 2021 at 5:20 PM Wu Zongyong
> > > <wuzongyong@linux.alibaba.com> wrote:
> > > >
> > > > On Fri, Sep 10, 2021 at 04:25:18PM +0800, Cindy Lu wrote:
> > > > > ,
> > > > >
> > > > > On Fri, Sep 10, 2021 at 3:33 PM Wu Zongyong
> > > > > <wuzongyong@linux.alibaba.com> wrote:
> > > > > >
> > > > > > On Fri, Sep 10, 2021 at 09:45:53AM +0800, Jason Wang wrote:
> > > > > > > On Thu, Sep 9, 2021 at 5:57 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Sep 09, 2021 at 05:28:26PM +0800, Jason Wang wrote:
> > > > > > > > > On Thu, Sep 9, 2021 at 4:02 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Sep 09, 2021 at 10:55:03AM +0800, Jason Wang wrote:
> > > > > > > > > > > On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > This new callback is used to indicate whether the vring size can be
> > > > > > > > > > > > change or not. It is useful when we have a legacy virtio pci device as
> > > > > > > > > > > > the vdpa device for there is no way to negotiate the vring num by the
> > > > > > > > > > > > specification.
> > > > > > > > > > >
> > > > > > > > > > > So I'm not sure it's worth bothering. E.g what if we just fail
> > > > > > > > > > > VHOST_SET_VRING_NUM it the value doesn't match what hardware has?
> > > > > > > > > > >
> > > > > > > > > > > Thanks
> > > > > > > > > > >
> > > > > > > > > > I think we should not call VHOST_SET_VRING_NUM in that case.
> > > > > > > > > >
> > > > > > > > > > If the hardware reports that the virtqueue size cannot be changed, we
> > > > > > > > > > should call VHOST_GET_VRING_NUM to get the static virtqueue size
> > > > > > > > > > firstly, then allocate the same size memory for the virtqueues and write
> > > > > > > > > > the address to hardware finally.
> > > > > > > > > >
> > > > > > > > > > For QEMU, we will ignore the properties rx/tx_queue_size and just get it
> > > > > > > > > > from the hardware if this new callback return true.
> > > > > > > > >
> > > > > > > > > This will break live migration. My understanding is that we can
> > > > > > > > > advertise those capability/limitation via the netlink management
> > > > > > > > > protocol then management layer can choose to use the correct queue
> > > > > > > > > size.
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > I agree, it is a good idea.
> > > > > > > > BTW, can we also advertise mac address of network device? I found the
> > > > > > > > mac address generated by libvirt or qemu will break the network datapath
> > > > > > > > down if I don't specify the right mac explicitly in the XML or qemu
> > > > > > > > commandline.
> > > > > > >
> > > > > > > We never saw this before, AFAIK when vhost-vdpa is used, currently
> > > > > > > qemu will probably ignore the mac address set via command line since
> > > > > > > the config space is read from the device instead of qemu itself?
> > > > > > >
> > > > > >
> > > > > > I saw the code below in qemu:
> > > > > >
> > > > > > static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > > > > {
> > > > > >     ...
> > > > > >     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > > > >         struct virtio_net_config netcfg = {};
> > > > > >         memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > > > >         vhost_net_set_config(get_vhost_net(nc->peer),
> > > > > >             (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);
> > > > > >     }
> > > > > >     ...
> > > > > > }
> > > > > >
> > > > > > This write the mac address set via cmdline into vdpa device config, and
> > > > > > then guest will read it back.
> > > > > > If I remove these codes, it behaves like you said.
> > > > > >
> > > > > >
> > > > > Hi Zongyong
> > > > > I think this code only works while qemu get an all 0 mac address from
> > > > > hardware , you can get more information from the function
> > > > > virtio_net_get_config.
> > > >
> > > > It depends how vdpa_config_ops->set_config implements.
> > > > For mlx5, callback set_config do nothing. But for virtio-pci, callback
> > > > set_config will write the config register of the vdpa device, so qemu
> > > > will write the mac set via cmdline to hardware and the mac guest read
> > > > it back is the value writted by qemu just now.
> > > >
> > > So here comes a question, which MAC address has higher priority ?
> > > the MAC address in hardware or the MAC address from the cmdline?
> > > If both of these two MAC addresses exist, which should we use?
> > > I have checked the spec, not sure if the bit VIRTIO_NET_F_MAC is the right one?
> >
> > I think so, if VIRTIO_NET_F_MAC is set, qemu can override the mac otherwise not.
> >
> The spec says:
> "driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it. If the driver
> negotiates the VIRTIO_NET_F_MAC feature, the driver MUST set the physical address
> of the NIC to mac. Otherwise, it SHOULD use a locally-administered MAC address."
>
> To my understanding, I guess you mean qemu CANNOT override the mac
> device provides actually?

Seems not, if VIRTIO_NET_F_MAC is not negotiated, mac is not valid in
the config space:

"The mac address field always exists (though is only valid if
VIRTIO_NET_F_MAC is set)"

So I think the right approach:

- if mac is not specified in the cli, Qemu doesn't need to override the mac
- if mac is specified in the cli and VIRTIO_NET_F_MAC is supported,
Qemu can override the mac
- if mac is specified in the cli and VIRTIO_NET_F_MAC is not
supported, we need fail the launching

Note that we're working on extending the netlink management API to set
mac address during vDPA instance provisioning. Management layer can
then get the correct mac address and set it via cli. AFAIK, Cindy's
patch is a workaround when netlink doesn't support mac address.

Thanks

> > Thanks
> >
> > > if yes, I will post a patch in qemu and add check for this bit before
> > > we set the mac to hardware
> > > https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html
> > >
> > > Thanks
> > > cindy
> > > > > > > Thanks
> > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > What do you think?
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
> > > > > > > > > > > >  drivers/virtio/virtio_vdpa.c |  5 ++++-
> > > > > > > > > > > >  include/linux/vdpa.h         |  4 ++++
> > > > > > > > > > > >  include/uapi/linux/vhost.h   |  2 ++
> > > > > > > > > > > >  4 files changed, 29 insertions(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > > > > > > > > index 9479f7f79217..2204d27d1e5d 100644
> > > > > > > > > > > > --- a/drivers/vhost/vdpa.c
> > > > > > > > > > > > +++ b/drivers/vhost/vdpa.c
> > > > > > > > > > > > @@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> > > > > > > > > > > >         return 0;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
> > > > > > > > > > > > +                                                 u32 __user *argp)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +       struct vdpa_device *vdpa = v->vdpa;
> > > > > > > > > > > > +       const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > > > > > > > +       bool unchangeable = false;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > > > > > > > > +               unchangeable = ops->get_vq_num_unchangeable(vdpa);
> > > > > > > > > > > > +
> > > > > > > > > > > > +       if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
> > > > > > > > > > > > +               return -EFAULT;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> > > > > > > > > > > >                                    void __user *argp)
> > > > > > > > > > > >  {
> > > > > > > > > > > > @@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> > > > > > > > > > > >         case VHOST_VDPA_GET_IOVA_RANGE:
> > > > > > > > > > > >                 r = vhost_vdpa_get_iova_range(v, argp);
> > > > > > > > > > > >                 break;
> > > > > > > > > > > > +       case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
> > > > > > > > > > > > +               r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
> > > > > > > > > > > > +               break;
> > > > > > > > > > > >         default:
> > > > > > > > > > > >                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
> > > > > > > > > > > >                 if (r == -ENOIOCTLCMD)
> > > > > > > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > > > index 72eaef2caeb1..afb47465307a 100644
> > > > > > > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > > > > > > @@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > > > > > >         struct vdpa_vq_state state = {0};
> > > > > > > > > > > >         unsigned long flags;
> > > > > > > > > > > >         u32 align, num;
> > > > > > > > > > > > +       bool may_reduce_num = true;
> > > > > > > > > > > >         int err;
> > > > > > > > > > > >
> > > > > > > > > > > >         if (!name)
> > > > > > > > > > > > @@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > > > > > > > > > >
> > > > > > > > > > > >         /* Create the vring */
> > > > > > > > > > > >         align = ops->get_vq_align(vdpa);
> > > > > > > > > > > > +       if (ops->get_vq_num_unchangeable)
> > > > > > > > > > > > +               may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
> > > > > > > > > > > >         vq = vring_create_virtqueue(index, num, align, vdev,
> > > > > > > > > > > > -                                   true, true, ctx,
> > > > > > > > > > > > +                                   true, may_reduce_num, ctx,
> > > > > > > > > > > >                                     virtio_vdpa_notify, callback, name);
> > > > > > > > > > > >         if (!vq) {
> > > > > > > > > > > >                 err = -ENOMEM;
> > > > > > > > > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > > > > > > > > index 35648c11e312..f809b7ada00d 100644
> > > > > > > > > > > > --- a/include/linux/vdpa.h
> > > > > > > > > > > > +++ b/include/linux/vdpa.h
> > > > > > > > > > > > @@ -195,6 +195,9 @@ struct vdpa_iova_range {
> > > > > > > > > > > >   *                             @vdev: vdpa device
> > > > > > > > > > > >   *                             Returns the iova range supported by
> > > > > > > > > > > >   *                             the device.
> > > > > > > > > > > > + * @get_vq_num_unchangeable    Check if size of virtqueue is unchangeable (optional)
> > > > > > > > > > > > + *                             @vdev: vdpa device
> > > > > > > > > > > > + *                             Returns boolean: unchangeable (true) or not (false)
> > > > > > > > > > > >   * @set_map:                   Set device memory mapping (optional)
> > > > > > > > > > > >   *                             Needed for device that using device
> > > > > > > > > > > >   *                             specific DMA translation (on-chip IOMMU)
> > > > > > > > > > > > @@ -262,6 +265,7 @@ struct vdpa_config_ops {
> > > > > > > > > > > >                            const void *buf, unsigned int len);
> > > > > > > > > > > >         u32 (*get_generation)(struct vdpa_device *vdev);
> > > > > > > > > > > >         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> > > > > > > > > > > > +       bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
> > > > > > > > > > > >
> > > > > > > > > > > >         /* DMA ops */
> > > > > > > > > > > >         int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > > > > > > > > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > > > > > > > > > > index c998860d7bbc..184f1f7f8498 100644
> > > > > > > > > > > > --- a/include/uapi/linux/vhost.h
> > > > > > > > > > > > +++ b/include/uapi/linux/vhost.h
> > > > > > > > > > > > @@ -150,4 +150,6 @@
> > > > > > > > > > > >  /* Get the valid iova range */
> > > > > > > > > > > >  #define VHOST_VDPA_GET_IOVA_RANGE      _IOR(VHOST_VIRTIO, 0x78, \
> > > > > > > > > > > >                                              struct vhost_vdpa_iova_range)
> > > > > > > > > > > > +/* Check if the vring size can be change */
> > > > > > > > > > > > +#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
> > > > > > > > > > > >  #endif
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.31.1
> > > > > > > > > > > >
> > > > > > > > > >
> > > > > > > >
> > > > > >
> > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
