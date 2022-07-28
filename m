Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEA1C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 06:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 035C3401BE;
	Thu, 28 Jul 2022 06:48:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 035C3401BE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DeY3qTD+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id inXknSzqcDcW; Thu, 28 Jul 2022 06:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22EDB4013A;
	Thu, 28 Jul 2022 06:48:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22EDB4013A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFBEFC0035;
	Thu, 28 Jul 2022 06:48:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E7F1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:48:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCBDA82D96
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCBDA82D96
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DeY3qTD+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DsHPWC7ak-C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0CD2A82D7C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0CD2A82D7C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 06:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658990885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wmpo3PbPPabv9CIdNU/BXkbr/pucVbSsZrbT/IOI5xc=;
 b=DeY3qTD+JzJKqoKSvYSIiwt18biTT94ip5RKkgJrgKvp6tWeWREBe/6hBmSvPr4N83F/UX
 ysc3jATtCawl6na7di6kc4VN6WwNskNRhSWlsrswN0AcMDovgwEEo/wEYWgihYO/6Xnwo8
 qapvzMVW+VVpZNhByvf1wslw9VqjXxA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-_vAVglhDNuOi0X17eZJnpA-1; Thu, 28 Jul 2022 02:48:04 -0400
X-MC-Unique: _vAVglhDNuOi0X17eZJnpA-1
Received: by mail-ed1-f71.google.com with SMTP id
 w5-20020a05640234c500b0043be08bb082so528607edc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 23:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=wmpo3PbPPabv9CIdNU/BXkbr/pucVbSsZrbT/IOI5xc=;
 b=fW7gxziQ8yk0ab8q4lXwGY2Q6z4k9QFy6+OaJkrtTuZXNRFfHsw0QnMDBKRncyt4iI
 l3LHgOoiLMgxVDYVfmQglm0heXBE2jogQWwyScShF1fZDf4SvabqVCkEV+CHA61COX3a
 TyVx8Ujt+FmEo3pQPlS16+rzUHXhchgbqOCZPso04NEMNVNOPeNQM6GF2Gf82bs/iwzH
 kAkKyurXBvdqLF8baQsFzz7jLkdkpY1QEqI/KG56U2z4G8B/J+VH8TdK5QlTtHOty1j2
 Jyiyf5LkONxZOYTHOP22G3rQrdVbq0GE8rNAgiY+H3f1UKvmC+4jXa3tUKcD2PM2A0RX
 11Tg==
X-Gm-Message-State: AJIora/CsSnjWSskkzWL3Zuq17KITUqFmkUqxcaxpjolQD7K53u40iQv
 5DusDHYVqVPl8zfOgfiZqDT2GY/+F77D0oz5sEZRge6nUJhq0jYlbauHoKDJKABQQxiOhCR3ko8
 7aYIqvF7n5G5ITeUk2oNbBGOHonEH7eJpkeVulaXr8A==
X-Received: by 2002:a05:6402:16:b0:43a:f435:5d07 with SMTP id
 d22-20020a056402001600b0043af4355d07mr26409665edu.420.1658990882919; 
 Wed, 27 Jul 2022 23:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s73AS/pDk0TIQ05tJcT+Txzqc8SnVF5s78SD/DtP/kY6hfGpBqTj85UFkKL3BDrKm2LnlXvw==
X-Received: by 2002:a05:6402:16:b0:43a:f435:5d07 with SMTP id
 d22-20020a056402001600b0043af4355d07mr26409646edu.420.1658990882566; 
 Wed, 27 Jul 2022 23:48:02 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 j21-20020a170906431500b0072af56103casm39000ejm.220.2022.07.27.23.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 23:48:02 -0700 (PDT)
Date: Thu, 28 Jul 2022 02:47:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: VIRTIO_NET_F_MTU not negotiated
Message-ID: <20220728024712-mutt-send-email-mst@kernel.org>
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
MIME-Version: 1.0
In-Reply-To: <CACGkMEv6AfPsgSBr6P4NqhG=EoXdHhXmAVAZpzWtSkdcJ-Bbxw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Thu, Jul 28, 2022 at 01:51:37PM +0800, Jason Wang wrote:
> On Thu, Jul 28, 2022 at 1:39 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Thursday, July 28, 2022 5:09 AM
> > > To: Eli Cohen <elic@nvidia.com>
> > > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Michael S. Tsirkin <mst@redhat.com>;
> > > virtualization@lists.linux-foundation.org
> > > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> > >
> > > On Wed, Jul 27, 2022 at 2:52 PM Eli Cohen <elic@nvidia.com> wrote:
> > > >
> > > > I found out that the reason why I could not enforce the mtu stems from the fact that I did not configure max mtu for the net device
> > > (e.g. through libvirt <mtu size="9000"/>).
> > > > Libvirt does not allow this configuration for vdpa devices and probably for a reason. The vdpa backend driver has the freedom to do
> > > it using its copy of virtio_net_config.
> > > >
> > > > The code in qemu that is responsible to allow to consider the device MTU restriction is here:
> > > >
> > > > static void virtio_net_device_realize(DeviceState *dev, Error **errp)
> > > > {
> > > >     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > > >     VirtIONet *n = VIRTIO_NET(dev);
> > > >     NetClientState *nc;
> > > >     int i;
> > > >
> > > >     if (n->net_conf.mtu) {
> > > >         n->host_features |= (1ULL << VIRTIO_NET_F_MTU);
> > > >     }
> > > >
> > > > The above code can be interpreted as follows:
> > > > if the command line arguments of qemu indicates that mtu should be limited, then we would read this mtu limitation from the
> > > device (that actual value is ignored).
> > > >
> > > > I worked around this limitation by unconditionally setting VIRTIO_NET_F_MTU in the host features. As said, it only indicates that
> > > we should read the actual limitation for the device.
> > > >
> > > > If this makes sense I can send a patch to fix this.
> > >
> > > I wonder whether it's worth to bother:
> > >
> > > 1) mgmt (above libvirt) should have the knowledge to prepare the correct XML
> > > 2) it's not specific to MTU, we had other features work like, for
> > > example, the multiqueue?
> > >
> >
> >
> > Currently libvirt does not recognize setting the mtu through XML for vdpa device. So you mean the fix should go to libvirt?
> 
> Probably.
> 
> > Furthermore, even if libvirt supports MTU configuration for a vdpa device, the actual value provided will be ignored and the limitation will be taken from what the vdpa device published in its virtio_net_config structure. That makes the XML configuration binary.
> 
> Yes, we suffer from a similar issue for "queues=". I think we should
> fix qemu by failing the initialization if the value provided by cli
> doesn't match what is read from config space.
> 
> E.g when mtu=9000 was set by cli but the actual mtu is 1500.
> 
> Thanks


Jason most features are passthrough now, no?
Why do you want to make this one special?



> >
> > > Thanks
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
