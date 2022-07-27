Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ED1C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 15:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9D5C4061D;
	Wed, 27 Jul 2022 15:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9D5C4061D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HJ862lkH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80hfUGL9VXBN; Wed, 27 Jul 2022 15:44:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 55F5B40608;
	Wed, 27 Jul 2022 15:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55F5B40608
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05CF5C0035;
	Wed, 27 Jul 2022 15:44:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69574C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3664A82730
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3664A82730
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HJ862lkH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mcF5--9iYKlk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:44:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56CAF82726
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56CAF82726
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658936650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xjoftw+lPi/Jdd4dOQv7y6H1hb7jKnp8oUGe5twN9uw=;
 b=HJ862lkHK20V3q+PPtljcVCeayurhxdQ3i63fKRMGGiXGhCPlikEMDyQLmX4RkNmPSOPU1
 wgJD3cMRZ1nl39wIlIhHDoT3bFlPQdNqvSR7xazeQE0Fw8wVRqu0LADOIhhV5B025iyWwM
 h93OxkF1Yx62XjvGtJh937e99b5XVbw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-Z-AQfQ-BMLClCu8fQK96qQ-1; Wed, 27 Jul 2022 11:44:06 -0400
X-MC-Unique: Z-AQfQ-BMLClCu8fQK96qQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 sd24-20020a1709076e1800b0072b582293c2so5168635ejc.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 08:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Xjoftw+lPi/Jdd4dOQv7y6H1hb7jKnp8oUGe5twN9uw=;
 b=4kW7sLD/vNRiFasUNjldjP2VuXezM6bgg6tuM6S7NXQdsP/lXi1g/G9379+J0bh28f
 pRd1Epf8Mh05NB/q0/dkVBz/itCAXWjNc0WLEiNjeoU826zhaTsU6eL52FkHQdP6laS8
 +v6mbHLqgGrOsnZwVEZOzXSU+o4TmQppKv2sYLapiaaeeIIk5muYx6/g/t5uwraMDs9Y
 eLnesCcB8/GmcIgiS4iSAxIo3T/zNbH75eJ2jAsk9hn4edQShiuoDfC82F4ywwjT/fP9
 t1Jxg6FdmHdFvP6G3/CIhMuUCxlACMqZ4nG45JQLqdXuwIIoaRnEKIBKr6Psg5H7dqEz
 w2SA==
X-Gm-Message-State: AJIora8zRzYQUjeTyiQjVkevx7JoGEcoEB9sgmvXcWvQZ8Hl5cnwzKS1
 rvHn+sAXHpHfi2dNBgsuL3vlZhi72g2uo85V/RPiJc3RIA0FAbDlMByWDIjHTRqckdjrW0CjaxY
 V6H4PCO8mXoiRBAF/bn/VNz+2Cwf7MSB1wC03mtsapw==
X-Received: by 2002:a17:907:9810:b0:72f:36e5:266c with SMTP id
 ji16-20020a170907981000b0072f36e5266cmr17963168ejc.105.1658936645139; 
 Wed, 27 Jul 2022 08:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFZGQD3a281tjE4wzKhXvbtnkIpRIqZTMJS8oOccdgxgUCZ2E8X7qMw1LXWcjb+xYUX+5jGg==
X-Received: by 2002:a17:907:9810:b0:72f:36e5:266c with SMTP id
 ji16-20020a170907981000b0072f36e5266cmr17963152ejc.105.1658936644855; 
 Wed, 27 Jul 2022 08:44:04 -0700 (PDT)
Received: from redhat.com ([2.52.132.243]) by smtp.gmail.com with ESMTPSA id
 g16-20020a50ee10000000b0043cc58ca84dsm796262eds.39.2022.07.27.08.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 08:44:04 -0700 (PDT)
Date: Wed, 27 Jul 2022 11:44:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
Message-ID: <20220727114228-mutt-send-email-mst@kernel.org>
References: <CAJaqyWc0M4O8Rr2jR4L_myPd_VmxkYjHTnwdxQFAf3N_hZw_3g@mail.gmail.com>
 <DM8PR12MB540033DA1293BA23E29148EAAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWfOS9nCBNeborhTdOXAnmZX9XwRF=2E0aphuHbqr352CA@mail.gmail.com>
 <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWczrvaaookrQE5=6mTABS-VmJKF6iY+aO3ZD8OB4FumRA@mail.gmail.com>
 <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220727032334-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400E307D34E8B0C5D224813AB979@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220727053311-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400AE8A41758321E0348764AB979@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400AE8A41758321E0348764AB979@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Wed, Jul 27, 2022 at 10:16:19AM +0000, Eli Cohen wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, July 27, 2022 12:35 PM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Jason Wang <jasowang@redhat.com>;
> > virtualization@lists.linux-foundation.org
> > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > 
> > On Wed, Jul 27, 2022 at 09:04:47AM +0000, Eli Cohen wrote:
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, July 27, 2022 10:25 AM
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Jason Wang <jasowang@redhat.com>;
> > > > virtualization@lists.linux-foundation.org
> > > > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > > >
> > > > On Wed, Jul 27, 2022 at 06:51:56AM +0000, Eli Cohen wrote:
> > > > > I found out that the reason why I could not enforce the mtu stems from the fact that I did not configure max mtu for the net
> > device
> > > > (e.g. through libvirt <mtu size="9000"/>).
> > > > > Libvirt does not allow this configuration for vdpa devices and probably for a reason. The vdpa backend driver has the freedom
> > to do
> > > > it using its copy of virtio_net_config.
> > > > >
> > > > > The code in qemu that is responsible to allow to consider the device MTU restriction is here:
> > > > >
> > > > > static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > > > {
> > > > >     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > > > >     VirtIONet *n = VIRTIO_NET(dev);
> > > > >     NetClientState *nc;
> > > > >     int i;
> > > > >
> > > > >     if (n->net_conf.mtu) {
> > > > >         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> > > > >     }
> > > > >
> > > > > The above code can be interpreted as follows:
> > > > > if the command line arguments of qemu indicates that mtu should be limited, then we would read this mtu limitation from the
> > > > device (that actual value is ignored).
> > > > >
> > > > > I worked around this limitation by unconditionally setting VIRTIO_NET_F_MTU in the host features. As said, it only indicates
> > that
> > > > we should read the actual limitation for the device.
> > > > >
> > > > > If this makes sense I can send a patch to fix this.
> > > >
> > > > Well it will then either have to be for vdpa only, or have
> > > > compat machinery to avoid breaking migration.
> > > >
> > >
> > > How about this one:
> > >
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 1067e72b3975..e464e4645c79 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -3188,6 +3188,7 @@ static void virtio_net_guest_notifier_mask(VirtIODevice *vdev, int idx,
> > >  static void virtio_net_set_config_size(VirtIONet *n, uint64_t host_features)
> > >  {
> > >      virtio_add_feature(&host_features, VIRTIO_NET_F_MAC);
> > > +    virtio_add_feature(&host_features, VIRTIO_NET_F_MTU);
> > >
> > >      n->config_size = virtio_feature_get_config_size(feature_sizes,
> > >                                                      host_features);
> > 
> > Seems to increase config size unconditionally?
> 
> Right but you pay for reading two more bytes. Is that such a high price to pay?


That's not a performance question. The issue compatibility, size
should not change for a given machine type.


> > 
> > > @@ -3512,6 +3513,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > >
> > >     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > >          struct virtio_net_config netcfg = {};
> > > +        n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> > >          memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
> > >          vhost_net_set_config(get_vhost_net(nc->peer),
> > >              (uint8_t *)&netcfg, 0, ETH_ALEN, VHOST_SET_CONFIG_TYPE_MASTER);
> > 
> > And the point is vdpa does not support migration anyway ATM, right?
> > 
> 
> I don't see how this can affect vdpa live migration. Am I missing something?

config size affects things like pci BAR size. This must not change
during migration.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
