Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A9EC04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 09:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B70E8404BB;
	Wed, 27 Jul 2022 09:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B70E8404BB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PJ6YaLE3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WdrRx5_NE3Oy; Wed, 27 Jul 2022 09:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C8FB40494;
	Wed, 27 Jul 2022 09:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C8FB40494
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61F12C0035;
	Wed, 27 Jul 2022 09:35:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F653C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CDDF040494
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CDDF040494
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KgCmeEULpq5s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:35:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A23D4028D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A23D4028D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658914499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nTu5NFFijHvsfn7itaXXmAt2nr30kbr5pULqEuXHg0=;
 b=PJ6YaLE3xMDJg2wN4WHjsgNHm0j8HVsc8Nl8ZSiOTz1MA9VzZtFQgPVeHV2nD81BuH9AZL
 bN8ATrmiZnYUUftOJu76c7DF9mA6d20uvM5El+ky3Iocu3INSjQT9CONJyKXyeTCNB1quW
 pueLOegj1O1lV3cdU2SRaURjzbNzsJA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-TTKdeXQiMxSeyXNBrOq7yg-1; Wed, 27 Jul 2022 05:34:58 -0400
X-MC-Unique: TTKdeXQiMxSeyXNBrOq7yg-1
Received: by mail-wm1-f70.google.com with SMTP id
 c17-20020a7bc011000000b003a2bfaf8d3dso8855913wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 02:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=5nTu5NFFijHvsfn7itaXXmAt2nr30kbr5pULqEuXHg0=;
 b=k6junsR2GJcndJDX/UarLX/4FOvApri8EOqOwP/Xmag8gfT/kNTl/Z4aOd7Wb6DmnI
 0Ku5Z8/1wlabSpjcvFDYsqGc+9sQp77Qaslyo3lPP2IXQIG4RVZpOmM1saqhrCM8Opqp
 FV4+ruvihlwxSJus0Jl9B4yBOEftUNbfe0JlMkSaIRJ4WaRagWpADVapTiVDs7961riU
 slPke2KOMQ1cIuhJM2KKjznqk2VSVLEOJNiWYxzwZW6hedK/fZTKbwSTK5BaYTGznKtU
 DWvn2Y/vM9brC9v8NNfzj1WBveCuJ1Mt3Gy9sRb6DdMXkMUezMRCz8/j1w1DYNJIRmrk
 wqdQ==
X-Gm-Message-State: AJIora/d6sUpjy/wR21DQLnasz1m1JlTktlOLnh1xHEJ4J//FVCN4gfR
 2T+/9uarWM9eQ3+Y7qsP0aFY7r6FnyXot5UZ48XLx6d3mgsSXJvT7QALSUmNXpLTlPAt7KzN8du
 iyUCZRM5JOO1/vKKTn2eBmyZ7Cv2Oy48jIsF1zw2MKQ==
X-Received: by 2002:a5d:5885:0:b0:21d:ad15:30be with SMTP id
 n5-20020a5d5885000000b0021dad1530bemr13726258wrf.90.1658914497176; 
 Wed, 27 Jul 2022 02:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sFOFcPG8gkrtElQFk67gFvNjlebxA3/p1LPmwZVJyGoX9n6idQQnKHi+wCOjIDYpdRVi7/Ig==
X-Received: by 2002:a5d:5885:0:b0:21d:ad15:30be with SMTP id
 n5-20020a5d5885000000b0021dad1530bemr13726243wrf.90.1658914496786; 
 Wed, 27 Jul 2022 02:34:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7424:0:3d16:86dc:de54:5671])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a05600c0a0b00b003a319bd3278sm1985200wmp.40.2022.07.27.02.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 02:34:56 -0700 (PDT)
Date: Wed, 27 Jul 2022 05:34:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
Message-ID: <20220727053311-mutt-send-email-mst@kernel.org>
References: <DM8PR12MB5400F967A710B1151AD5132CAB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB5400AB08EE51E6BF05EEBDE2AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWc0M4O8Rr2jR4L_myPd_VmxkYjHTnwdxQFAf3N_hZw_3g@mail.gmail.com>
 <DM8PR12MB540033DA1293BA23E29148EAAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWfOS9nCBNeborhTdOXAnmZX9XwRF=2E0aphuHbqr352CA@mail.gmail.com>
 <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWczrvaaookrQE5=6mTABS-VmJKF6iY+aO3ZD8OB4FumRA@mail.gmail.com>
 <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220727032334-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400E307D34E8B0C5D224813AB979@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400E307D34E8B0C5D224813AB979@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Wed, Jul 27, 2022 at 09:04:47AM +0000, Eli Cohen wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, July 27, 2022 10:25 AM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org
> > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > 
> > On Wed, Jul 27, 2022 at 06:51:56AM +0000, Eli Cohen wrote:
> > > I found out that the reason why I could not enforce the mtu stems from the fact that I did not configure max mtu for the net device
> > (e.g. through libvirt <mtu size="9000"/>).
> > > Libvirt does not allow this configuration for vdpa devices and probably for a reason. The vdpa backend driver has the freedom to do
> > it using its copy of virtio_net_config.
> > >
> > > The code in qemu that is responsible to allow to consider the device MTU restriction is here:
> > >
> > > static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > {
> > >     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > >     VirtIONet *n = VIRTIO_NET(dev);
> > >     NetClientState *nc;
> > >     int i;
> > >
> > >     if (n->net_conf.mtu) {
> > >         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> > >     }
> > >
> > > The above code can be interpreted as follows:
> > > if the command line arguments of qemu indicates that mtu should be limited, then we would read this mtu limitation from the
> > device (that actual value is ignored).
> > >
> > > I worked around this limitation by unconditionally setting VIRTIO_NET_F_MTU in the host features. As said, it only indicates that
> > we should read the actual limitation for the device.
> > >
> > > If this makes sense I can send a patch to fix this.
> > 
> > Well it will then either have to be for vdpa only, or have
> > compat machinery to avoid breaking migration.
> > 
> 
> How about this one:
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 1067e72b3975..e464e4645c79 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3188,6 +3188,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
>  static void virtio_net_set_config_size(VirtIONet *n, uint64_t host_features)
>  {
>      virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
> +    virtio_add_feature(&host_features, VIRTIO_NET_F_MTU);
> 
>      n->config_size = virtio_feature_get_config_size(feature_sizes,
>                                                      host_features);

Seems to increase config size unconditionally?

> @@ -3512,6 +3513,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> 
>     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>          struct virtio_net_config netcfg = {};
> +        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
>          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
>          vhost_net_set_config(get_vhost_net(nc->peer),
>              (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);

And the point is vdpa does not support migration anyway ATM, right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
