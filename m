Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65A4C433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:14:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659ED206D8
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659ED206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 388F2859D9;
	Mon, 18 Jan 2021 15:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id slpcDi6wqofb; Mon, 18 Jan 2021 15:14:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E46CC851AA;
	Mon, 18 Jan 2021 15:14:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE352C1786;
	Mon, 18 Jan 2021 15:14:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BEDBC013A;
 Mon, 18 Jan 2021 15:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4C4B12001E;
 Mon, 18 Jan 2021 15:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1346CHN43Avj; Mon, 18 Jan 2021 15:14:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by silver.osuosl.org (Postfix) with ESMTPS id 0AD5C2001C;
 Mon, 18 Jan 2021 15:14:33 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id 19so18911408qkm.8;
 Mon, 18 Jan 2021 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8/QgAqc0aRwKS3j1sw2jdEshnvLA6NQrB2MHBO445ps=;
 b=OUW4fmwJMB3DlPjCqHB4ucAnBizINKGQ12AtxdzV3oB+3hP2fbkuv7APF3wIwz7gxB
 eLzm0xZ72V4Ik+o0FJ1nGNVDTa0IdK8zErtabD5BxcdFoDUfYzMYU9FNFoiXehK4bFfY
 o66vD4IUoz0JL7mFUJHX0nJNZAox9hH62vtj7O/MRiMbimGSAa0PJFb6nz22YYGt44vs
 +ZH0BmrZRSd+y378d6AI4WH1Gj4IeTReIMC+ZGsx4nFs5fjMxC8/o1/dSIhZnB2zVQ+k
 roAXFRXrZ7834DS2oaP5u/AxxsvrK27zPRWheQYHoQefLNV/cqwUp/Dq5gLaM3Au0cDT
 qQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=8/QgAqc0aRwKS3j1sw2jdEshnvLA6NQrB2MHBO445ps=;
 b=qtEVHfWNvTiC0gZKhcAnnD+LBxHeZwSk2ZWzfy+JcxvvqqFDGjusl4Jmj4kThIxgYQ
 aLpZPlbNt2WId7iIDBuvfqAwqk7CFBqVlEXt4Y3UrzGJ7qFwRbdC0Gcnx70it/91Nt+I
 JrJEGWhablvBI5mU18nvOiweGRY6xp2QzetGmbkpKZ9KA2M6xLyxMH0pPqyPBUsnQAVa
 zc80SEirpAcANf1FMFyTlVA65pGnsZ0jgfPFOeXhVxipKAG7cBSgsFjoaBgmpv4OLpSF
 wH0Bm7glgoDtpQFsgYLK0KXwRY48aig3hwWNQHFSDa3okU5sqVQKS2FW1xdnXGyz+Dkt
 0rGw==
X-Gm-Message-State: AOAM530f7H3ZibhyeAnWSxIFdP4TZKDuCRzWXKOOPxlFzQsq/zfgCWf0
 hfTorg+uvravu6SCOLABes4=
X-Google-Smtp-Source: ABdhPJzMTKjmpH2iOukLV0Kxa2DXEPChKiYHkmNYSdAGutYV5YUYETku4jkS1p49oIw5G9DUl099YQ==
X-Received: by 2002:a05:620a:63c:: with SMTP id 28mr105003qkv.26.1610982871901; 
 Mon, 18 Jan 2021 07:14:31 -0800 (PST)
Received: from fedora
 (209-6-208-110.s8556.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com.
 [209.6.208.110])
 by smtp.gmail.com with ESMTPSA id 133sm10893311qkd.94.2021.01.18.07.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 07:14:31 -0800 (PST)
Date: Mon, 18 Jan 2021 10:14:28 -0500
From: Konrad Rzeszutek Wilk <konrad@darnok.org>
To: Martin Radev <martin.b.radev@gmail.com>
Subject: Re: [PATCH] swiotlb: Validate bounce size in the sync/unmap path
Message-ID: <20210118151428.GA72213@fedora>
References: <X/27MSbfDGCY9WZu@martin> <20210113113017.GA28106@lst.de>
 <YAV0uhfkimXn1izW@martin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YAV0uhfkimXn1izW@martin>
Cc: thomas.lendacky@amd.com, file@sect.tu-berlin.de,
 robert.buhren@sect.tu-berlin.de, kvm@vger.kernel.org, konrad.wilk@oracle.com,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 mathias.morbitzer@aisec.fraunhofer.de, Christoph Hellwig <hch@lst.de>,
 kirill.shutemov@linux.intel.com
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

On Mon, Jan 18, 2021 at 12:44:58PM +0100, Martin Radev wrote:
> On Wed, Jan 13, 2021 at 12:30:17PM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 12, 2021 at 04:07:29PM +0100, Martin Radev wrote:
> > > The size of the buffer being bounced is not checked if it happens
> > > to be larger than the size of the mapped buffer. Because the size
> > > can be controlled by a device, as it's the case with virtio devices,
> > > this can lead to memory corruption.
> > > 
> > 
> > I'm really worried about all these hodge podge hacks for not trusted
> > hypervisors in the I/O stack.  Instead of trying to harden protocols
> > that are fundamentally not designed for this, how about instead coming
> > up with a new paravirtualized I/O interface that is specifically
> > designed for use with an untrusted hypervisor from the start?
> 
> Your comment makes sense but then that would require the cooperation
> of these vendors and the cloud providers to agree on something meaningful.
> I am also not sure whether the end result would be better than hardening
> this interface to catch corruption. There is already some validation in
> unmap path anyway.
> 
> Another possibility is to move this hardening to the common virtio code,
> but I think the code may become more complicated there since it would
> require tracking both the dma_addr and length for each descriptor.

Christoph,

I've been wrestling with the same thing - this is specific to busted
drivers. And in reality you could do the same thing with a hardware
virtio device (see example in http://thunderclap.io/) - where the
mitigation is 'enable the IOMMU to do its job.'.

AMD SEV documents speak about utilizing IOMMU to do this (AMD SEV-SNP)..
and while that is great in the future, SEV without IOMMU is now here.

Doing a full circle here, this issue can be exploited with virtio
but you could say do that with real hardware too if you hacked the
firmware, so if you say used Intel SR-IOV NIC that was compromised
on an AMD SEV machine, and plumbed in the guest - the IOMMU inside
of the guest would be SWIOTLB code. Last line of defense against
bad firmware to say.

As such I am leaning towards taking this code, but I am worried
about the performance hit .. but perhaps I shouldn't as if you
are using SWIOTLB=force already you are kind of taking a
performance hit?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
