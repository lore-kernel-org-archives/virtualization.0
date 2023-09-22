Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112D9CD4F2B
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 07:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8127560FBD;
	Fri, 22 Sep 2023 07:52:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8127560FBD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=y9aiHqpV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CHM9LzgypiTg; Fri, 22 Sep 2023 07:52:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EA9860E3B;
	Fri, 22 Sep 2023 07:52:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0EA9860E3B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E79BBC0039;
	Fri, 22 Sep 2023 07:52:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43293C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:52:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1707183C90
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:52:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1707183C90
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=y9aiHqpV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ydcvnEkeEXHD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:52:27 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19D2383C70
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:52:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19D2383C70
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-404314388ceso20612055e9.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695369145; x=1695973945;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hcD2WxWIK5nogl0nPGxwYMClWdYAi/+TaekySrDVVbY=;
 b=y9aiHqpVGAaYRTYDAKoG0vM/gDwbQG6MpQXKswD0LiDGz0PyfQV8ADNqNZv7Dfahhb
 LTF+IRHeS5IGb7Ii0XAajUP8gCK2I+GBX5jj2kXo8K24BuAOQqNkQl6XZz/TPIZJHEgJ
 r2sqZSvIwQ4V2pzYu4BkWXfhbtY1Ujps5xvmyYmuwyr1isYB9ow39JMMawD+I8t46xV0
 5hnxMz0ygLnMIb7WWcQxnndBvok54s3xmQN4q3VpHL5zHtqxjo0JQ6xq7o8rWWZ6rhcE
 R+c5F8T2SARU1OkxB6EeBDes2lzK0mDSCUeTKSL9RspJ1ppkZ6Ounr3A5y0NVmutbL6J
 Qpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695369145; x=1695973945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcD2WxWIK5nogl0nPGxwYMClWdYAi/+TaekySrDVVbY=;
 b=F2ZjaCXZWNcjr8HI0cIi5ExEAk/On+CduVGqlS6ZSn3/lMHaAuidPVUVopIlMRZ6yK
 r2Pvoqx7f/UIftuKOYA6SqDFh02Klm5ws4CUHRmevUPtSCFYN7w6JdDUwBMrQ9OtAFVR
 1bVGcwt5AC0Gc+csLOllCiqtcba5cSWhbVj3lwALiNATE3o2EUnBUZyCCnatJQHUp5bM
 aV+II5HkagJAs1rYL8vW/HOn1HmT4FpsQiHTOxcXYfHHPmTSl9sqQACLyx1L47rojrAh
 58DY7oJh9eRzUVnJCKdsASK7OZyajZvmMLA+7IJL15YkwtHApMC+CuEzRUUgkQKxj/yU
 JVew==
X-Gm-Message-State: AOJu0YyG23aRGevqfwp70Dhn+bzNk1WNDYZBliKovsxqmXZxo9kcZVLi
 APiIjADMIqzh66hSCcfLzc3Y3g==
X-Google-Smtp-Source: AGHT+IH50+JuT0hNWVHhO8l5lBOC4otqoUC+uD8KQFJh7d5H2c8inCy3MrjHonCe1JbAgZ2NZbenow==
X-Received: by 2002:a05:600c:c5:b0:3fe:2f31:8bf7 with SMTP id
 u5-20020a05600c00c500b003fe2f318bf7mr6796220wmm.26.1695369145016; 
 Fri, 22 Sep 2023 00:52:25 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a5d4642000000b00317e77106dbsm3731065wrs.48.2023.09.22.00.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:52:24 -0700 (PDT)
Date: Fri, 22 Sep 2023 08:52:30 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922075230.GA1361815@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d513178-bab9-0522-87f5-1a058bb8121d@arm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>
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

On Tue, Sep 19, 2023 at 09:28:08AM +0100, Robin Murphy wrote:
> On 2023-09-19 09:15, Jean-Philippe Brucker wrote:
> > On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index 17dcd826f5c2..3649586f0e5c 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > > >    	int ret;
> > > >    	unsigned long flags;
> > > > +	/*
> > > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > > +	 */
> > > > +	if (!viommu)
> > > > +		return 0;
> > > 
> > > Minor nit: I'd be inclined to make that check explicitly in the places where
> > > it definitely is expected, rather than allowing *any* sync to silently do
> > > nothing if called incorrectly. Plus then they could use
> > > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > > with a NULL viommu without viommu_map_pages() blowing up first...)
> > 
> > They're not strictly equivalent: this check works around a temporary issue
> > with the IOMMU core, which calls map/unmap before the domain is finalized.
> > Once we merge domain_alloc() and finalize(), then this check disappears,
> > but we still need to test nr_endpoints in map/unmap to handle detached
> > domains (and we still need to fix the synchronization of nr_endpoints
> > against attach/detach). That's why I preferred doing this on viommu and
> > keeping it in one place.
> 
> Fair enough - it just seems to me that in both cases it's a detached domain,
> so its previous history of whether it's ever been otherwise or not shouldn't
> matter. Even once viommu is initialised, does it really make sense to send
> sync commands for a mapping on a detached domain where we haven't actually
> sent any map/unmap commands?

If no requests were added by map/unmap, then viommu_sync_req() is
essentially a nop because virtio doesn't use sync commands (and
virtqueue_kick() only kicks the host when the queue's not empty, if I
remember correctly). It still does a bit of work so is less efficient than
a preliminary check on nr_endpoints, but it feels nicer to streamline the
case where the domain is attached, since map/unmap on detached domains
happens rarely, if ever.

Either is fine by me. An extra test won't make much difference performance
wise, and I guess will look less confusing. Niklas, do you mind resending
the version with nr_endpoints check (and updated commit messages)?

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
