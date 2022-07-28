Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C48C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 06:46:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80EEC417E3;
	Thu, 28 Jul 2022 06:46:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80EEC417E3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iyHTiDYL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2qb4zKPGLw6b; Thu, 28 Jul 2022 06:46:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EB84415DF;
	Thu, 28 Jul 2022 06:46:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EB84415DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 644F4C0035;
	Thu, 28 Jul 2022 06:46:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7D06C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 813444167B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 813444167B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zgnl-dDEC2hZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:46:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3400C415DF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3400C415DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658990792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VVlg4ZDriIr9yuhH+5AZkqioVyHgUvTYzgVgHD7Vooc=;
 b=iyHTiDYL+W3+Jjl3EPAxDqursSbamESFBwCBK+Mf64lzjFuIQc80z/CirYlIM0bJbUyTZh
 dHhpUsWyKDkjKkfG9Q+5L16UwPob22t2rIF9aAfhPrt4eNlkcj/Y2oRNj+Mipt/vDQgCKl
 x+FaUdK6OUpVZYFcSKzHPAb/gMMWeY8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-5TQa1Mb7MyWEgaMxZWWLOg-1; Thu, 28 Jul 2022 02:46:31 -0400
X-MC-Unique: 5TQa1Mb7MyWEgaMxZWWLOg-1
Received: by mail-wm1-f72.google.com with SMTP id
 i184-20020a1c3bc1000000b003a026f48333so552518wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 23:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=VVlg4ZDriIr9yuhH+5AZkqioVyHgUvTYzgVgHD7Vooc=;
 b=Kv0GxhB4kk+c608m1cvZcIFB79B+GCQ4eSjkqTxTohd9M8J7+iDXoOzhbCE806nqpH
 aJEyyR/1/9D5sA3lqyMaJJMBJXJYwFmqNvnksLox8sJbKZ9IkrTdTuZQsowWbJmB4r0C
 5gg46vAl3muMh7chtrLLQUU+60r03K9e8se8WXohfdwXN7mR7Xhhwq8T3FVsmAEa5xXw
 fIZVOBaI9GyoPADu3zDRcCRAbVBDRUfJXdXHqvHWInkRb9nnp8sBgE5bnRLgdSLvXc4k
 aFVburu5z41Q61sNCwIksrDrZpzcg4O0QhqUsKfDXSkjxGJABFSs2lOkbIoq6bkkEr3S
 gmNA==
X-Gm-Message-State: AJIora/Owj+0R8ojGN1yO5muiBH2OvebzKCln2kVPRlg7mr1vLPpwuTR
 2I1hLMs39lWDP8sgLSCW3YWvCnHJDuxDWzquF3XHbXabiLM1qcJrge06+v6m3XmAypiXNmGNWgf
 IETsZ8X2q4Mp/+vSMQSWwt394mb9KBxQSxnYZpxCxQg==
X-Received: by 2002:a7b:c3d4:0:b0:3a3:ce7:7894 with SMTP id
 t20-20020a7bc3d4000000b003a30ce77894mr5479720wmj.134.1658990790284; 
 Wed, 27 Jul 2022 23:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1umYkl91s09bq48tXOKYt8gpsMeqKv8QU/I6YvWaUcJ/Vx0RJ4Y0ujyN1l+orJ7RczikeRhjw==
X-Received: by 2002:a7b:c3d4:0:b0:3a3:ce7:7894 with SMTP id
 t20-20020a7bc3d4000000b003a30ce77894mr5479696wmj.134.1658990789752; 
 Wed, 27 Jul 2022 23:46:29 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 d10-20020adfe84a000000b0021e4982270asm73798wrn.13.2022.07.27.23.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 23:46:29 -0700 (PDT)
Date: Thu, 28 Jul 2022 02:46:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
Message-ID: <20220728024257-mutt-send-email-mst@kernel.org>
References: <CAJaqyWfOS9nCBNeborhTdOXAnmZX9XwRF=2E0aphuHbqr352CA@mail.gmail.com>
 <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWczrvaaookrQE5=6mTABS-VmJKF6iY+aO3ZD8OB4FumRA@mail.gmail.com>
 <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220727032334-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400E307D34E8B0C5D224813AB979@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220727053311-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400AE8A41758321E0348764AB979@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220727114228-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400E23C3E7DA97E034F02BEAB969@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400E23C3E7DA97E034F02BEAB969@DM8PR12MB5400.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Thu, Jul 28, 2022 at 05:51:32AM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, July 27, 2022 6:44 PM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org
> > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > 
> > On Wed, Jul 27, 2022 at 10:16:19AM +0000, Eli Cohen wrote:
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, July 27, 2022 12:35 PM
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Jason Wang <jasowang@redhat.com>;
> > > > virtualization@lists.linux-foundation.org
> > > > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > > >
> > > > On Wed, Jul 27, 2022 at 09:04:47AM +0000, Eli Cohen wrote:
> > > > > > -----Original Message-----
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, July 27, 2022 10:25 AM
> > > > > > To: Eli Cohen <elic@nvidia.com>
> > > > > > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Jason Wang <jasowang@redhat.com>;
> > > > > > virtualization@lists.linux-foundation.org
> > > > > > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > > > > >
> > > > > > On Wed, Jul 27, 2022 at 06:51:56AM +0000, Eli Cohen wrote:
> > > > > > > I found out that the reason why I could not enforce the mtu stems from the fact that I did not configure max mtu for the net
> > > > device
> > > > > > (e.g. through libvirt <mtu size="9000"/>).
> > > > > > > Libvirt does not allow this configuration for vdpa devices and probably for a reason. The vdpa backend driver has the
> > freedom
> > > > to do
> > > > > > it using its copy of virtio_net_config.
> > > > > > >
> > > > > > > The code in qemu that is responsible to allow to consider the device MTU restriction is here:
> > > > > > >
> > > > > > > static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > > > > > {
> > > > > > >     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > > > > > >     VirtIONet *n = VIRTIO_NET(dev);
> > > > > > >     NetClientState *nc;
> > > > > > >     int i;
> > > > > > >
> > > > > > >     if (n->net_conf.mtu) {
> > > > > > >         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> > > > > > >     }
> > > > > > >
> > > > > > > The above code can be interpreted as follows:
> > > > > > > if the command line arguments of qemu indicates that mtu should be limited, then we would read this mtu limitation from
> > the
> > > > > > device (that actual value is ignored).
> > > > > > >
> > > > > > > I worked around this limitation by unconditionally setting VIRTIO_NET_F_MTU in the host features. As said, it only indicates
> > > > that
> > > > > > we should read the actual limitation for the device.
> > > > > > >
> > > > > > > If this makes sense I can send a patch to fix this.
> > > > > >
> > > > > > Well it will then either have to be for vdpa only, or have
> > > > > > compat machinery to avoid breaking migration.
> > > > > >
> > > > >
> > > > > How about this one:
> > > > >
> > > > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > > > index 1067e72b3975..e464e4645c79 100644
> > > > > --- a/hw/net/virtio-net.c
> > > > > +++ b/hw/net/virtio-net.c
> > > > > @@ -3188,6 +3188,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
> > > > >  static void virtio_net_set_config_size(VirtIONet *n, uint64_t host_features)
> > > > >  {
> > > > >      virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
> > > > > +    virtio_add_feature(&host_features, VIRTIO_NET_F_MTU);
> > > > >
> > > > >      n->config_size = virtio_feature_get_config_size(feature_sizes,
> > > > >                                                      host_features);
> > > >
> > > > Seems to increase config size unconditionally?
> > >
> > > Right but you pay for reading two more bytes. Is that such a high price to pay?
> > 
> > 
> > That's not a performance question. The issue compatibility, size
> > should not change for a given machine type.
> > 
> 
> Did you mean it should not change for virtio_net pci devices?

yes

> Can't management controlling the live migration process take care of this?

Management does what it always did which is set flags consistently.
If we tweak them with virtio_add_feature it can do nothing.

> > 
> > > >
> > > > > @@ -3512,6 +3513,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > > >
> > > > >     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > > >          struct virtio_net_config netcfg = {};
> > > > > +        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> > > > >          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > > > >          vhost_net_set_config(get_vhost_net(nc->peer),
> > > > >              (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);
> > > >
> > > > And the point is vdpa does not support migration anyway ATM, right?
> > > >
> > >
> > > I don't see how this can affect vdpa live migration. Am I missing something?
> > 
> > config size affects things like pci BAR size. This must not change
> > during migration.
> > 
> 
> Why should this change during live migration?

Simply put features need to match on both ends.

> > --
> > MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
