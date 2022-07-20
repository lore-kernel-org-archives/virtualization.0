Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3723C43334
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 10:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3361182B1B;
	Wed, 20 Jul 2022 10:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3361182B1B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BSnf9R2w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvzUi8jak64F; Wed, 20 Jul 2022 10:15:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 904CB82A8F;
	Wed, 20 Jul 2022 10:15:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 904CB82A8F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5196DC0033;
	Wed, 20 Jul 2022 10:15:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24A90C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 10:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBDD5400AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 10:15:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EBDD5400AB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BSnf9R2w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VdhC3VU08jkZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 10:15:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0FD3240139
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FD3240139
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658312103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJ4WxB5dhNPjJqdquaqhoN2af1xdb+vZcxaA/Fw3OBA=;
 b=BSnf9R2wg1RBCQeplNqltmHaN+sCk3hdfDr/yl6H2pqQ/o9mMUiik1F4JCQoxsAD8uZg+m
 MSJRzi13EYXc3Z2o12eLJ0IPgF1cELO0nkwpKS/t9Bay4fVCYF5JBI0E+HphJGHH6ecp6a
 ieIwSYi1tsR3Z8bwisR0nRms6WCAky8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-SIIcsPJBOCa3U3YqhKNHMw-1; Wed, 20 Jul 2022 06:14:57 -0400
X-MC-Unique: SIIcsPJBOCa3U3YqhKNHMw-1
Received: by mail-wm1-f71.google.com with SMTP id
 z20-20020a1c4c14000000b003a3020da654so568983wmf.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tJ4WxB5dhNPjJqdquaqhoN2af1xdb+vZcxaA/Fw3OBA=;
 b=cGweST9sjbc4PSN11pdpLT39uNa3rRQQicxzZQitNMs/8gsbYHDmLfv+6EHWjP+8Fu
 VTCNF8tVoVa40Dq3DC5ggKTTa9jURFgbxU+JxpK/tC3gnbWHnWAdPahNg4S8cuNUxqBn
 zOZZaKJ98CaPBcuymOEm1UUiaSZ0q4OTLyHPPD1dAs/MQlABmwhSpCg5k+v4CxR7veGn
 SvQ+bMw3YMMHjNo1XI2aekcsazEN43a6XtvW1DivdrzWR4nAjPzbQZvW2WBWGxlEBp/6
 NNdXcDtB/8C2zXoo156KmXb2dFK/LAA3+qBIHAuHgzBKnHURbHcZvRpfSmXW4paWAm6d
 6SuQ==
X-Gm-Message-State: AJIora/gs1DXxn8kjgRyEr+BOYcwHWG8U25hsRKFv+uQdl0Qhp3/RaeZ
 PSpwi9ucckbRCCIGtNvuxE2ilgyHU6mLmcujfteRsrNJXdo9TljI3NSaIVXOnMYOd9FsrOt+bUY
 3GFbYWr3sbcOnCF64gUqvkWALRaBxjgwK7SCtuaPq0Q==
X-Received: by 2002:a05:600c:3ca4:b0:3a0:1825:2e29 with SMTP id
 bg36-20020a05600c3ca400b003a018252e29mr3068713wmb.11.1658312095746; 
 Wed, 20 Jul 2022 03:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v7HZj3Cip5DcdGD1mDjgvfsIqZb7FufD4VMADg77+C0ZheZVhYft3D8SfCrlGFyALQ9lZTFQ==
X-Received: by 2002:a05:600c:3ca4:b0:3a0:1825:2e29 with SMTP id
 bg36-20020a05600c3ca400b003a018252e29mr3068694wmb.11.1658312095490; 
 Wed, 20 Jul 2022 03:14:55 -0700 (PDT)
Received: from redhat.com ([2.55.25.63]) by smtp.gmail.com with ESMTPSA id
 m9-20020adfe0c9000000b0021e40f9f47csm3373270wri.5.2022.07.20.03.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jul 2022 03:14:55 -0700 (PDT)
Date: Wed, 20 Jul 2022 06:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
Message-ID: <20220720061432-mutt-send-email-mst@kernel.org>
References: <DM8PR12MB5400869D5921E28CE2DC7263AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220719093841-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400F967A710B1151AD5132CAB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB5400AB08EE51E6BF05EEBDE2AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWc0M4O8Rr2jR4L_myPd_VmxkYjHTnwdxQFAf3N_hZw_3g@mail.gmail.com>
 <DM8PR12MB540033DA1293BA23E29148EAAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWfOS9nCBNeborhTdOXAnmZX9XwRF=2E0aphuHbqr352CA@mail.gmail.com>
 <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
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

On Wed, Jul 20, 2022 at 08:17:29AM +0000, Eli Cohen wrote:
> > From: Eugenio Perez Martin <eperezma@redhat.com>
> > Sent: Wednesday, July 20, 2022 10:47 AM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; virtualization@lists.linux-foundation.org
> > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > 
> > On Wed, Jul 20, 2022 at 8:30 AM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Eugenio Perez Martin <eperezma@redhat.com>
> > > > Sent: Tuesday, July 19, 2022 5:51 PM
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; virtualization@lists.linux-foundation.org
> > > > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > > >
> > > > On Tue, Jul 19, 2022 at 4:02 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > > From: Eli Cohen
> > > > > > Sent: Tuesday, July 19, 2022 4:53 PM
> > > > > > To: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Cc: Jason Wang <jasowang@redhat.com>; Eugenio Perez Martin <eperezma@redhat.com>; virtualization@lists.linux-
> > > > foundation.org
> > > > > > Subject: RE: VIRTIO_NET_F_MTU not negotiated
> > > > > >
> > > > > > >
> > > > > > > On Tue, Jul 19, 2022 at 01:25:42PM +0000, Eli Cohen wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > mlx5_vdpa is offering VIRTIO_NET_F_MTU. However the driver (is it qemu
> > > > > > > > responsibility?) does not accept and it ends up not negotiated.
> > > > > > >
> > > > > > > qemu is responsible for passing features to driver.
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > I don't see how can the driver refuse to negotiate this. What if the hardware
> > > > > > > > has a limitation with respect to mtu?
> > > > > > >
> > > > > > > Then it can fail FEATURES_OK
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > I noticed this when I created the device with mtu of 1000. I expected the
> > > > > > > > netdev at the vm to have mtu of 1000 and any attempt to go beyond should fail
> > > > > > > > but that's not the case.
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > Comments?
> > > > > > >
> > > > > > >
> > > > > > > Any chance mtu is too small?
> > > > > > >
> > > > > >
> > > > > > MIN_MTU is 68 bytes and I was trying 1000. I tried also 1300 but same thing.
> > > > > >
> > > > > > >         if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
> > > > > > >                 int mtu = virtio_cread16(vdev,
> > > > > > >                                          offsetof(struct virtio_net_config,
> > > > > > >                                                   mtu));
> > > > > > >                 if (mtu < MIN_MTU)
> > > > > > >                         __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
> > > > > > >         }
> > > > > > >
> > > > > > > any chance it's on power or another BE system?
> > > > > > >
> > > > > >
> > > > > > No, it's x86_64.
> > > > > >
> > > > > > I will test also vdpa device running on the host.
> > > > >
> > > > > vdpa running on the host (using virtio_vdpa) behaves as expected.
> > > > > Is there a quick way to check if qemu fails to pass the information to the driver on the guest?
> > > > >
> > > >
> > > > Can you trace with "-trace 'vhost_vdpa_set_features' -trace
> > > > 'vhost_vdpa_set_features'"? They're parameters of qemu.
> > >
> > > I get this:
> > > vhost_vdpa_set_features dev: 0x5595ae9751a0 features: 0x3008b1803
> > >
> > > VIRTIO_NET_F_MTU is bit 3 and it seems to be off.
> > >
> > 
> > Sorry, I put trace on vhost_vdpa *_set_* features twice in my message.
> > 
> > Could you try tracing vhost_vdpa_get_features too? That way we know if
> > qemu offers it to the guest.
> > 
> 
> Sure.
> I get these two successive prints right as the VM starts booting:
> vhost_vdpa_get_features dev: 0x55c87e4651e0 features: 0x300cb182b
> vhost_vdpa_get_features dev: 0x55c87e4627a0 features: 0x300cb182b
> 
> Later on I get this:
> vhost_vdpa_set_features dev: 0x55c87e4651e0 features: 0x3008b1803
> 
> # qemu-system-x86_64 --version
> QEMU emulator version 7.0.0 (v7.0.0)
> Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers
> 
> 
> 
> > Thanks!
> 

so it's there but driver does not ack it.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
