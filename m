Return-Path: <SRS0=GUxp=ED=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC5C388F7
	for <virtualization@archiver.kernel.org>; Wed, 28 Oct 2020 18:01:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7D0247F9
	for <virtualization@archiver.kernel.org>; Wed, 28 Oct 2020 18:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqH/JArj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7D0247F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 822498598B;
	Wed, 28 Oct 2020 18:01:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k0vemgKonH9D; Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B211886BC1;
	Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BDB9C0859;
	Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DB7AC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2308786BC1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 18:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QwJfRchLEdKM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 18:01:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2B40C8598B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 18:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603908079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Nk2LjAqH68iPpRMmd15ZYH8jce4ByIolJyVBRLfJOQ=;
 b=gqH/JArjHAOtNxrZDd0KeDgGida6k8cN8zNPiZ/PWkK6p589Xe0dUC5AebTIvvsdII5mEQ
 jSOKVu9zzRT2hZBiG8EHkM+3TcATYF8LwlNl40UOcaaIVGu9bhAEPdTqoQVDhNwDNdcPHX
 4GYf83j2SAqcvWED/l5NX1BCpczF3Dk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-FTBxzHMfNAit5yGLg8ElLg-1; Wed, 28 Oct 2020 14:01:17 -0400
X-MC-Unique: FTBxzHMfNAit5yGLg8ElLg-1
Received: by mail-wr1-f72.google.com with SMTP id w1so147003wrr.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 11:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5Nk2LjAqH68iPpRMmd15ZYH8jce4ByIolJyVBRLfJOQ=;
 b=jPbazgCqakL3rDmHXKJIgaylqiAXb9e4TK3l2gMFBWniTqxY0EVoVpTd9pYb85P32H
 5WX5hLvth0nOk1RynwqqZgXXXJB3dPWroQjhoyaH7VYKlWokP7Ae3u9w7fiWuR/pZdM6
 djQUVVN8f/BZCEXGc4vL4xZcqzXE4fKPic7rYAide55VcJ86D4Jri/J7NwLsNuOezNta
 0JLp/tNKXYL8gfu1cz60H45gIYfpykd4hYL6PIjFx3YMMIe17RnGaCZmvxw9Bf3kNBI4
 CESNNP8OAkrls7lypNfBXR6+c4rn/eXyW93QZxJ6pWzZNpsKRoM1kVHIFgCDJ+yTycNT
 QAFA==
X-Gm-Message-State: AOAM53070rP76lM9BHzNw0MN9kzMoeKIl04bDwRIHA1JpjzBQpQv4i/K
 v9U1xR3q7Eu5jhcl4bAR1STg8lKyEsKg1cD1/gT8APAjZT0P0hf+T3Nx14yNJ4k+I05QmcnTNcw
 PYchmXQAkvohNwtoXZdN9iTrFxNJNuaiirbKtA6+Ivw==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr525238wrn.257.1603908076672;
 Wed, 28 Oct 2020 11:01:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS4a2Tb6jVLditxSIK/2tiQlDfblWIHCJN1cagQ8Ey8zoitAc/WOhLkPDuLKeb4iVg6mXqJg==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr525205wrn.257.1603908076449;
 Wed, 28 Oct 2020 11:01:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id a17sm440271wra.29.2020.10.28.11.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 11:01:15 -0700 (PDT)
Date: Wed, 28 Oct 2020 14:01:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20201028135103-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
 <20200222140408-mutt-send-email-mst@kernel.org>
 <20200224171657.GB7278@lst.de>
 <691d8c8e-665c-b05f-383f-78377fcf6741@amazon.com>
MIME-Version: 1.0
In-Reply-To: <691d8c8e-665c-b05f-383f-78377fcf6741@amazon.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On Wed, Oct 28, 2020 at 03:24:03PM +0100, Alexander Graf wrote:
> On 24.02.20 18:16, Christoph Hellwig wrote:
> > On Sat, Feb 22, 2020 at 02:07:58PM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> > > > AFAIU you have a positive attitude towards the idea, that
> > > > !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio'
> > > > should be scrapped.
> > > > 
> > > > I would like to accomplish that without adverse effects to virtio-ccw
> > > > (because caring for virtio-ccw is a part of job description).
> > > > 
> > > > Regards,
> > > > Halil
> > > 
> > > It is possible, in theory. IIRC the main challenge is that DMA API
> > > has overhead of indirect function calls even when all it
> > > does it return back the PA without changes.
> > 
> > That overhead is gone now, the DMA direct calls are direct calls these
> > days.
> 
> Michael, would that mitigate your concerns to just always use the DMA API?
> If not, wouldn't it make sense to benchmark and pinpoint Christoph to paths
> that do slow things down, so we can finally move virtio into a world where
> it doesn't bypass the kernel DMA infrastructure.
> 
> 
> Alex


There's no specific concern really. One can in theory move the code
handling !VIRTIO_F_ACCESS_PLATFORM such that instead of having a branch
in virtio code, you instead override platform DMA API and then use DMA
API unconditionally.

The gain from that will probably be marginal, but maybe I'm wrong.
Let's see the patches.

We still need to do the override when !VIRTIO_F_ACCESS_PLATFORM,
according to spec. Encrypted hypervisors still need to set
VIRTIO_F_ACCESS_PLATFORM.


Is VIRTIO_F_ACCESS_PLATFORM a good default? Need to support
legacy guests does not allow that at the qemu level, we
need to be conservative there. But yes, if you have a very
modern guest then it might be a good idea to just always
enable VIRTIO_F_ACCESS_PLATFORM. I say might since unfortunately
most people only use VIRTIO_F_ACCESS_PLATFORM with
vIOMMU, using it without VIRTIO_F_ACCESS_PLATFORM is supported
but is a path less well trodden. Benchmarking that,
fixing issues that surface if any would be imho effort
well spent, and would be a prerequisite to making it
a default in a production system.


> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
