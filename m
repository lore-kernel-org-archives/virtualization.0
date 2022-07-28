Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659E6C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 02:09:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D86EF60EC4;
	Thu, 28 Jul 2022 02:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D86EF60EC4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JJe7jzTJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkmez4jZnmFO; Thu, 28 Jul 2022 02:09:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5896160B89;
	Thu, 28 Jul 2022 02:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5896160B89
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5926C0033;
	Thu, 28 Jul 2022 02:09:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6D8AC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EBBA40462
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EBBA40462
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JJe7jzTJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hK-eQx2t-UpF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:09:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EC02403A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EC02403A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 02:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658974165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7jRuDrTmH3agxFY8Ekj+s9BX5EBpFkAN7QSMXI3yWE=;
 b=JJe7jzTJRfKaIbnuENNzjNA/59gEeXNPpCbAecrZpmGG5Lc3nEXKtgo8Rd93Tp/CeE/x7s
 cGJ0F3zGHUSO/BlGMBeLjdxhbuXs0JWu+2adtEBczjhZvnVUHx/15+sviJ03q851S00X0q
 pzEkdPSbf2jAIjS/BFh6lOsD/zkn1aM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-Yl2kVS5sOnu70AF1GSP68Q-1; Wed, 27 Jul 2022 22:09:24 -0400
X-MC-Unique: Yl2kVS5sOnu70AF1GSP68Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 k7-20020a05651239c700b0048a9f539070so201137lfu.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 19:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u7jRuDrTmH3agxFY8Ekj+s9BX5EBpFkAN7QSMXI3yWE=;
 b=QKN2akhXmjBFWuSHy+nDO+e0Z2xk1pSCIVJh4beuDUs8p1HGItRL23UP3KaW9aY0PD
 vPC5TRE/H40befI3pj2VRissOm/zvZZkhCIzj71rfr1WaD/wM3YM7RJCvv0tIyZ2vqjc
 GRoj0UwP0X/iL8f28kB/1zRmfeAB6thy40HosU4bekrCIw+g/tjZsCV86ODdYuxt/5sx
 HUJNB/kQ9S7m1e2tFZacAh6SkhiHrkxFRg4d8LHd9GO4oAMbw0BvTiDGowbrNdFw1rO0
 FYfL/T/kvVai1Jx4JDiJoG9ChM6EekPZQKH/Ur7q859ngOHdGHSBtKqStZwCHljWS7oT
 +//w==
X-Gm-Message-State: AJIora/9q+O6/20Uktk+Szqbk/SlJC+YQbKKaUE2SeQYpYx0y3MzLk9Y
 NL0YcSX0zs8WhiRBVqiB9ID2kH3+II3qWVdBykZIiIPdyMlcldAQ/bIb691U/GPGEm/Ba/rgGYB
 /IDq4ibGc92Y1uGZZ14H+97MXuUA9Hpm7aqHUqeUFlqw69X5BdgXGiF0tPA==
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr8806845lfu.442.1658974162565; 
 Wed, 27 Jul 2022 19:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vpB5y4VhaBCtJzRBm3skgldLoQB36AcdyI82c7M8u2GB49Q1Aadf2AjC4B1mXKIan3lma8uZweiHeMKDMVm8k=
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id
 w13-20020a0565120b0d00b004815cb4cf1emr8806839lfu.442.1658974162177; Wed, 27
 Jul 2022 19:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <DM8PR12MB5400869D5921E28CE2DC7263AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220719093841-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400F967A710B1151AD5132CAB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <DM8PR12MB5400AB08EE51E6BF05EEBDE2AB8F9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWc0M4O8Rr2jR4L_myPd_VmxkYjHTnwdxQFAf3N_hZw_3g@mail.gmail.com>
 <DM8PR12MB540033DA1293BA23E29148EAAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWfOS9nCBNeborhTdOXAnmZX9XwRF=2E0aphuHbqr352CA@mail.gmail.com>
 <DM8PR12MB54005AB1DE4617493645D2CBAB8E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWczrvaaookrQE5=6mTABS-VmJKF6iY+aO3ZD8OB4FumRA@mail.gmail.com>
 <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB54001D7DFB29EF048CCD04CCAB979@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 10:09:11 +0800
Message-ID: <CACGkMEtDu9D2ovmWkKEuxqg5POqvMgYNK1_MHWCGMYOG7_t7Qg@mail.gmail.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Jul 27, 2022 at 2:52 PM Eli Cohen <elic@nvidia.com> wrote:
>
> I found out that the reason why I could not enforce the mtu stems from the fact that I did not configure max mtu for the net device (e.g. through libvirt <mtu size="9000"/>).
> Libvirt does not allow this configuration for vdpa devices and probably for a reason. The vdpa backend driver has the freedom to do it using its copy of virtio_net_config.
>
> The code in qemu that is responsible to allow to consider the device MTU restriction is here:
>
> static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> {
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VirtIONet *n = VIRTIO_NET(dev);
>     NetClientState *nc;
>     int i;
>
>     if (n->net_conf.mtu) {
>         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
>     }
>
> The above code can be interpreted as follows:
> if the command line arguments of qemu indicates that mtu should be limited, then we would read this mtu limitation from the device (that actual value is ignored).
>
> I worked around this limitation by unconditionally setting VIRTIO_NET_F_MTU in the host features. As said, it only indicates that we should read the actual limitation for the device.
>
> If this makes sense I can send a patch to fix this.

I wonder whether it's worth to bother:

1) mgmt (above libvirt) should have the knowledge to prepare the correct XML
2) it's not specific to MTU, we had other features work like, for
example, the multiqueue?

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
