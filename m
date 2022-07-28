Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5126C04A68
	for <virtualization@archiver.kernel.org>; Thu, 28 Jul 2022 05:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B9804179E;
	Thu, 28 Jul 2022 05:51:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B9804179E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RA1Bz2gg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0wbDwe8z5Y1y; Thu, 28 Jul 2022 05:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BCB041704;
	Thu, 28 Jul 2022 05:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5BCB041704
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D849C0033;
	Thu, 28 Jul 2022 05:51:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA8E2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77F7B60BFF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:51:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77F7B60BFF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RA1Bz2gg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BY826Gvmz0gG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:51:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8117360ABB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8117360ABB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jul 2022 05:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658987513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3p+5YoHErrWZsylgsT25kVJ1/LRXBSCOr+pq6In3vE=;
 b=RA1Bz2ggq/AxT8nacTopRV5A/GU0iyOmEVnb4VdXIKpvL3qXZKbNCJT71ykwL39VyaoC2M
 Lvw5yOVOrqoxV4NK4atkVrVShLQRy1ZUdMZU3d3sEb8EkKQGzOtAT7g0y4f9dq+zhEnwaA
 Na7NKF57AGNM+1gn/DfuXyM1DblJpws=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-A0lmfW91PJehKIK56bretQ-1; Thu, 28 Jul 2022 01:51:50 -0400
X-MC-Unique: A0lmfW91PJehKIK56bretQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 c15-20020ac244af000000b0048a8421d969so330289lfm.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 22:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z3p+5YoHErrWZsylgsT25kVJ1/LRXBSCOr+pq6In3vE=;
 b=rEABHRmqbrsjyVghMP7Qgff9JL08mfdKXW3IE0xhODoXf82o7NmgXHyMwr6qdEi7vv
 8ycHRnjMpHQKg569ReCvp3TnDJI9OANWReB0Dk+V4GGgzTZQFJVPnAqvunTzuW2xauyV
 JlRAvu+PHaE7H3ebRRrEPAZirVWIzFVLtXyNMiyooKIeD5IMWt5yregarbLSrD8FUTGp
 /SIK7C/353Odv4gXvEhu2NMOeheYHnGg5lfHyQS/wLUMg0YjmCOTL3b2Wjd2mr+q7CvA
 F5T345n2fw1xMRMP9DHbKNfIDM/dvtfuEydKQWk69AYcY+tRnHttW3qdIdlbyhstG1Wy
 kbaQ==
X-Gm-Message-State: AJIora+L/9DIFMcyVdym2EkLQbIw9PKq/PeIWSy8YnmMpIWu1S2YX7aQ
 kr75+Yjl1jXQ2myE796TBGzAIHx+uGBw9UOFqkW5Uaz6m7iG5Ssu8h91luV/beHa+m/oXp3cYTA
 QfSPShuQFOBtV/QqE/y4CEWAmS6tVR4Awk7o41RIovGYvunVe23PMJ0IlgQ==
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr8851664lfa.124.1658987509148; 
 Wed, 27 Jul 2022 22:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1txUOkXryg1lzI7tBfRmKQs3G8/BxqE7jBH5umVM1ezcD7IXHDnb1Ai9RjwKMsE5sot+EEkwqfG+wIHW57Ll7o=
X-Received: by 2002:a05:6512:3f0e:b0:48a:5edd:99b2 with SMTP id
 y14-20020a0565123f0e00b0048a5edd99b2mr8851658lfa.124.1658987508825; Wed, 27
 Jul 2022 22:51:48 -0700 (PDT)
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
 <CACGkMEtDu9D2ovmWkKEuxqg5POqvMgYNK1_MHWCGMYOG7_t7Qg@mail.gmail.com>
 <DM8PR12MB5400DBF0BFFF104940BB4A45AB969@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400DBF0BFFF104940BB4A45AB969@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Jul 2022 13:51:37 +0800
Message-ID: <CACGkMEv6AfPsgSBr6P4NqhG=EoXdHhXmAVAZpzWtSkdcJ-Bbxw@mail.gmail.com>
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

On Thu, Jul 28, 2022 at 1:39 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, July 28, 2022 5:09 AM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Eugenio Perez Martin <eperezma@redhat.com>; qemu-devel@nongnu.org; Michael S. Tsirkin <mst@redhat.com>;
> > virtualization@lists.linux-foundation.org
> > Subject: Re: VIRTIO_NET_F_MTU not negotiated
> >
> > On Wed, Jul 27, 2022 at 2:52 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
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
> > I wonder whether it's worth to bother:
> >
> > 1) mgmt (above libvirt) should have the knowledge to prepare the correct XML
> > 2) it's not specific to MTU, we had other features work like, for
> > example, the multiqueue?
> >
>
>
> Currently libvirt does not recognize setting the mtu through XML for vdpa device. So you mean the fix should go to libvirt?

Probably.

> Furthermore, even if libvirt supports MTU configuration for a vdpa device, the actual value provided will be ignored and the limitation will be taken from what the vdpa device published in its virtio_net_config structure. That makes the XML configuration binary.

Yes, we suffer from a similar issue for "queues=". I think we should
fix qemu by failing the initialization if the value provided by cli
doesn't match what is read from config space.

E.g when mtu=9000 was set by cli but the actual mtu is 1500.

Thanks

>
> > Thanks
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
