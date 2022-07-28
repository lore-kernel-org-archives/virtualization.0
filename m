Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E010AC04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 06:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A9574174A;
	Thu, 28 Jul 2022 06:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A9574174A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CpkXJAak
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFx8lzrxp0hF; Thu, 28 Jul 2022 06:57:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 56D7B4172A;
	Thu, 28 Jul 2022 06:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56D7B4172A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A19EC0035;
	Thu, 28 Jul 2022 06:57:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 702BBC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 428784174A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:57:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 428784174A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8DxmlWdfkhe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:57:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDA464172A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDA464172A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658991440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aNrvDX5jD4bbxr/ZoGZ9aTRGHV2eCpOGLNsGcDL70rk=;
 b=CpkXJAakNcITCduGTPu6YCoXVbdoxjGX2XAVLOF2fv9pHJBdOqwWCy48HPvE6hxe5XIRRf
 aCGgyfOWlqCeY/z+yGiQcbdVpp08h1NvdIB4c+TKaG5R4mbSBIMm/Q9HW2gX1sdzSrC7Ak
 PIQzsZUz4ioRagWkaTS+JmzPk4E413o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-X16BA4XpOb2GRFmyX_zV3Q-1; Thu, 28 Jul 2022 02:57:17 -0400
X-MC-Unique: X16BA4XpOb2GRFmyX_zV3Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 s18-20020a2e2c12000000b0025e124e10c5so133388ljs.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 23:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aNrvDX5jD4bbxr/ZoGZ9aTRGHV2eCpOGLNsGcDL70rk=;
 b=C8gzq99BojIQtIEmu27/FblZmoknYorDKCESpDHdRE8EvTOm1r6NRx6h9mkhtn2RCC
 MyPjK1YCs/YBGA8tGNA1DKwrSgHVFNUPIBua1iHAhgi3qhs6wxJwLGeTSL7WhJ6mGoYA
 emAkZ704p8yGCQRaAJm4HUTMpc+cL0VjEV0NfGpwvJ8zh2eAZZ9GjRoJKnw9wxdiSZJl
 GSPKl/1cl/ZMwZiN+JnhXILjWEgbIbZz1VeERA5BiphuED1dL4cEiTZIjpThdj7NmhL1
 VnprA3KyIYAXqM7cpttRV0JHVyY7pAA2alvnwoutM2XtlwJ0erUP6sw6qfborkPrJOCO
 hx9w==
X-Gm-Message-State: AJIora+6lJMgvdalczykwX0/SasJlz41CyQ5kzbYwczB5pAn8kNTFVjM
 z11Q84p4STEZhWzyzrrpC0n0lINsQBwpqqMfpWJpDbu7mOm1i4JuAfLFZ27EqrcQ0EPpK+kaEW4
 fn5+MJjmUOBPrPUz2XhsZwE2ZRY3itQIB1o0kj4oiZN1DgYDFJI6pX35Jlw==
X-Received: by 2002:a2e:83c4:0:b0:25d:ea2c:5bc2 with SMTP id
 s4-20020a2e83c4000000b0025dea2c5bc2mr8244228ljh.251.1658991435692; 
 Wed, 27 Jul 2022 23:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vdsjbwQyA+nyZuEq4P7rLEB919gZUApUoDGS+e1G5Z0SAXUGDmRrGD5xjFrpBeBQGT+SvcePA5Q4Wd296jaP4=
X-Received: by 2002:a2e:83c4:0:b0:25d:ea2c:5bc2 with SMTP id
 s4-20020a2e83c4000000b0025dea2c5bc2mr8244223ljh.251.1658991435500; Wed, 27
 Jul 2022 23:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <DM8PR12MB5400AB08EE51E6BF05EEBDE2AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWc0M4O8Rr2jR4L_myPd_VmxkYjHTnwdxQFAf3N_hZw_3g@mail.gmail.com>
 <DM8PR12MB540033DA1293BA23E29148EAAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWfOS9nCBNeborhTdOXAnmZX9XwRF=2E0aphuHbqr352CA@mail.gmail.com>
 <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWczrvaaookrQE5=6mTABS-VmJKF6iY+aO3ZD8OB4FumRA@mail.gmail.com>
 <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEtDu9D2ovmWkKEuxqg5POqvMgYNK1_MHWCGMYOG7_t7Qg@mail.gmail.com>
 <DM8PR12MB5400DBF0BFFF104940BB4A45AB969@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CACGkMEv6AfPsgSBr6P4NqhG=EoXdHhXmAVAZpzWtSkdcJ-Bbxw@mail.gmail.com>
 <20220728024712-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220728024712-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 14:57:04 +0800
Message-ID: <CACGkMEs-n5NVFOs8qO+0nmWTgAnMrS05+0t_c4wJekc05p0jYQ@mail.gmail.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>,
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

On Thu, Jul 28, 2022 at 2:48 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jul 28, 2022 at 01:51:37PM +0800, Jason Wang wrote:
> > On Thu, Jul 28, 2022 at 1:39 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Thursday, July 28, 2022 5:09 AM
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Michael S. Tsirkin <mst@redhat.com>;
> > > > virtualization@lists.linux-foundation.org
> > > > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > > >
> > > > On Wed, Jul 27, 2022 at 2:52 PM Eli Cohen <elic@nvidia.com> wrote:
> > > > >
> > > > > I found out that the reason why I could not enforce the mtu stems from the fact that I did not configure max mtu for the net device
> > > > (e.g. through libvirt <mtu size="9000"/>).
> > > > > Libvirt does not allow this configuration for vdpa devices and probably for a reason. The vdpa backend driver has the freedom to do
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
> > > > > I worked around this limitation by unconditionally setting VIRTIO_NET_F_MTU in the host features. As said, it only indicates that
> > > > we should read the actual limitation for the device.
> > > > >
> > > > > If this makes sense I can send a patch to fix this.
> > > >
> > > > I wonder whether it's worth to bother:
> > > >
> > > > 1) mgmt (above libvirt) should have the knowledge to prepare the correct XML
> > > > 2) it's not specific to MTU, we had other features work like, for
> > > > example, the multiqueue?
> > > >
> > >
> > >
> > > Currently libvirt does not recognize setting the mtu through XML for vdpa device. So you mean the fix should go to libvirt?
> >
> > Probably.
> >
> > > Furthermore, even if libvirt supports MTU configuration for a vdpa device, the actual value provided will be ignored and the limitation will be taken from what the vdpa device published in its virtio_net_config structure. That makes the XML configuration binary.
> >
> > Yes, we suffer from a similar issue for "queues=". I think we should
> > fix qemu by failing the initialization if the value provided by cli
> > doesn't match what is read from config space.
> >
> > E.g when mtu=9000 was set by cli but the actual mtu is 1500.
> >
> > Thanks
>
>
> Jason most features are passthrough now, no?
> Why do you want to make this one special?

I don't want to make anything special, but I couldn't find a better approach.

MTU is not the only thing. It applies to all the other features whose
default value is false (MQ, RSS, etc).

Thanks

>
>
>
> > >
> > > > Thanks
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
