Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8ACC6FA99
	for <virtualization@archiver.kernel.org>; Sun, 12 Mar 2023 06:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D76C181B14;
	Sun, 12 Mar 2023 06:48:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D76C181B14
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P+uEDJKd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRq5e-JexuSW; Sun, 12 Mar 2023 06:48:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5285081A5F;
	Sun, 12 Mar 2023 06:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5285081A5F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25090C0071;
	Sun, 12 Mar 2023 06:48:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4151CC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E835410A7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:48:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E835410A7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P+uEDJKd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uYnWzodqo6Yc
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:48:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4DE4410A0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4DE4410A0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678603685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/MGBMB8V+RyMvX5Yg8Jpm8tdqEc5z5gytWcPVLlptK0=;
 b=P+uEDJKdPsAn8RWIECSDVv4X67GfqmI2oFRJUYJg+De0fsiPokB20dseQ+znb04j3dvKbL
 z6X+0GxcIcOk2RGtfxGzGoKOK8i43/qgZXU8FIMSJzJCCYfk9/Oa6CnOy+0gb6LlLZSljm
 +fFf/M2uRDqFtuz7UG1+IABBT0me6aI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-g0vWj_VGPSyjR0xcpB_xZg-1; Sun, 12 Mar 2023 01:48:04 -0500
X-MC-Unique: g0vWj_VGPSyjR0xcpB_xZg-1
Received: by mail-wm1-f72.google.com with SMTP id
 az12-20020a05600c600c00b003e8910ec2fdso3172303wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678603683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MGBMB8V+RyMvX5Yg8Jpm8tdqEc5z5gytWcPVLlptK0=;
 b=2SOgHDLJXr71pss2ahvpkt7/UMKFWCU18D08XmhY/Z2s/ltnqpEmF4/07XCbXDkgIx
 8kAquy2lGqBtR1iBiU8yAdLTcpP0bovMFdAnSegXUEd9rVrHuuJa5st/hA8YT+CWc7U5
 dBuTMgbvl/d/AuM7dPCJDuh79CXBEFsimiGgtlmooO9W/8thP5P1Ks2pjGV1G1MM05zk
 DCmq1pkGgMgX3j/MaqMnBtShbl5Ai33y9sN50fhiYq82AW4mv9xjoYmMEZN2P6FyZa9z
 7aSN2NoguLtZ2j5HUGRjPsF4i21pNPw4rgVAcR3zW82ESxbyEFxuvjPgVA8oco6TvRsn
 eLBw==
X-Gm-Message-State: AO0yUKXS1Nx3P7dJzs449TAmAwHuXg4VKbzN8bk9euFge7hmKVbW+M2+
 kY3aTlTON1vO9S1YJ3Z3z0e8iT2DdUHkKbl6GkkPqZ3xigDp3cX+zSVGY6BoQrtIX8UtTi8Szj+
 c2jxP9CoTwQl4dZSFa4Z9fIBfqVHItMuplhFEhlww+Q==
X-Received: by 2002:a05:600c:548e:b0:3eb:2708:86ca with SMTP id
 iv14-20020a05600c548e00b003eb270886camr7661079wmb.28.1678603683271; 
 Sat, 11 Mar 2023 22:48:03 -0800 (PST)
X-Google-Smtp-Source: AK7set8uyFMuQBoVusVSQX+GO75f9FSj5c5dvx6BVxihm5DSxXQAxeIy/vI/V/Z6b/PRWsDUaL2tLQ==
X-Received: by 2002:a05:600c:548e:b0:3eb:2708:86ca with SMTP id
 iv14-20020a05600c548e00b003eb270886camr7661068wmb.28.1678603682974; 
 Sat, 11 Mar 2023 22:48:02 -0800 (PST)
Received: from redhat.com ([2.52.29.35]) by smtp.gmail.com with ESMTPSA id
 x26-20020a1c7c1a000000b003eae73ee4a1sm4705358wmc.17.2023.03.11.22.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Mar 2023 22:48:02 -0800 (PST)
Date: Sun, 12 Mar 2023 01:47:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
Message-ID: <20230312014705-mutt-send-email-mst@kernel.org>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310030624-mutt-send-email-mst@kernel.org>
 <fb824fb0-1704-daeb-eb02-fdcfe1686902@nvidia.com>
 <20230311140528-mutt-send-email-mst@kernel.org>
 <4da4a05e-4b0f-2c1e-8b58-ade2c620c868@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <4da4a05e-4b0f-2c1e-8b58-ade2c620c868@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Sat, Mar 11, 2023 at 05:19:43PM -0500, Feng Liu wrote:
> 
> 
> On 2023-03-11 p.m.2:06, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Mar 10, 2023 at 08:21:31AM -0500, Feng Liu wrote:
> > > 
> > > 
> > > On 2023-03-10 a.m.3:06, Michael S. Tsirkin wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Fri, Mar 10, 2023 at 07:34:25AM +0200, Feng Liu wrote:
> > > > > This patch series performs a clean up of the code in virtio_ring and
> > > > > virtio_pci, modifying it to conform with the Linux kernel coding style
> > > > > guidance [1]. The modifications ensure the code easy to read and
> > > > > understand. This small series does few short cleanups in the code.
> > > > > 
> > > > > Patch-1 Allow non power of 2 sizes for virtqueues
> > > > > Patch-2 Avoid using inline for small functions.
> > > > > Patch-3 Use const to annotate read-only pointer params.
> > > > > 
> > > > > [1]
> > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv6.2-rc3%2Fprocess%2Fcoding-style.html%23the-inline-disease&data=05%7C01%7Cfeliu%40nvidia.com%7C6cd34740c4674c1892f608db2263b300%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638141583834629671%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=IA0QCCKjHnYiEk2vPlZ5WjlXs1CMXDphyyqTYnbqQqo%3D&reserved=0
> > > > > 
> > > > > All of the patches have been verified based on the kernel code
> > > > > commit 44889ba56cbb ("Merge tag 'net-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> > > > 
> > > > verified how?
> > > > 
> > > Hi Michael
> > > 1. Applied the patches on lastest kernel source(44889ba56cbb), compile and
> > > install the kernel, and use iperf to test traffic
> > > 2. To validate this change, we tested various virtqueue sizes for packed
> > > rings, including 128, 256, 512, 100, 200, 500, and 1000, with
> > > CONFIG_PAGE_POISONING enabled, and test by iperf& ping -f and all tests
> > > passed successfully.
> > 
> > Given split ring does not support non power of 2 how exactly
> > did you configure non power of 2?
> > 
> 
> Hi, Michael
> We can implement the test by modifying qemu; 1. force the
> VIRTIO_F_RING_PACKED feature bit to be set, 2. set
> VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE and VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE to the
> value of non power_of_2, 3. remove the check of is_power_of virtqueue, then
> qemu can create the required virtual device (non power_2 size , packed
> virtqueue device) ;In this way, any length and packed ring test can be
> performed;
> remove the modified code, I can test split vq, and can see that the size of
> power_of_2 can load the driver normally, and the size of non power_of_2 will
> give an warning and fail to load the driver

Sounds like a plan but what exactly did you do previously?
You indicated you tested non powers of 2.

> > > 
> > > > > Feng Liu (3):
> > > > >     virtio_pci_modern: Allow non power of 2 sizes for virtqueues
> > > > >     virtio_ring: Avoid using inline for small functions
> > > > >     virtio_ring: Use const to annotate read-only pointer params
> > > > > 
> > > > >    drivers/virtio/virtio_pci_modern.c |  5 ----
> > > > >    drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
> > > > >    include/linux/virtio.h             | 14 ++++-----
> > > > >    3 files changed, 31 insertions(+), 36 deletions(-)
> > > > > 
> > > > > --
> > > > > 2.34.1
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
