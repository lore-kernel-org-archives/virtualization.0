Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105701EB497
	for <virtualization@lists.linux.dev>; Wed,  7 Aug 2024 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037690; cv=none; b=mXWDa9TWXPrxEbOEqymnEa4zPwf4Iqi5Azs3gdIYLmVv5YUyu4G4BvN3ic8nGNQNWNED4kbIfxXOOUntC68icgekCGlYmtnkaGOy9pmsgZL1XSbB3hoG29Fk76In7hHrUnnef0ZlKhsPiFAxhBHC7HX72HtlhWTKsAKIJbEcDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037690; c=relaxed/simple;
	bh=q9NcHt6yfC3iP9uRtNhtgIABvg+G9gkTnkkFm1hOZlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NvL+f0bmHLR9aM6zr+0MCGz4sExyRkK/pDKBnUUEDkSnN0xsw2nJmqfFDBmhm1Q6ruTbhdVZ9jFMhJ5wPCapwQM8OtmmiwrVzny+ZiTNR5HaWxXSYVpl+b4CKQ/X8S6uMndNq/jtNmf3hE4pvninmvSAKbqtD4mv9fTFG5UcLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhmyVjCV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhmyVjCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723037688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSUqX+IG7mupB/XOn4TRmU85G6PcmHt69UDnYVwYRo8=;
	b=VhmyVjCVj1WGBXGn56/3GO/bpRezhxHdFJTYD/83aYIglOCp2x3V1fcyn6crEU5MhDYcRJ
	Hy7gAeD1fnW6FeQhnp4Hjx7OPic3liH9lAws54X9MQSpym21O3PggWATg5dMLMMDaOjNks
	k1XZzWwOQxrBbE3G1GkKJoWsvegqZqI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-JrHL1cA8P_S6ngz2VfVqQA-1; Wed, 07 Aug 2024 09:34:44 -0400
X-MC-Unique: JrHL1cA8P_S6ngz2VfVqQA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef23d3650fso17980131fa.2
        for <virtualization@lists.linux.dev>; Wed, 07 Aug 2024 06:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723037683; x=1723642483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSUqX+IG7mupB/XOn4TRmU85G6PcmHt69UDnYVwYRo8=;
        b=P8qul6V9TbuKbSZ4sgocCdr2kdOzTyZxah/NhcjUOQ4qtOmALo6Ra7dqjCOiMv57LF
         iZZ5t3VVGTa92g1ZBRr/GwpPhxPaxkyWrZaimrz3lTryIYES4qIBC4JXKZXJLOlZqd8L
         UnqoR0ctWA71ZFTzsbm4dQGKLlYxrCtjGEozYyBbBC8WPwKw7Gn1hu9727xrPCw7X0cM
         oxgVnMm/ZJiB0vwFysrRLEuJtTbpHGdG1Zma8+AjOY22Nr8WX/ERkG8FtZJ508i0ibcZ
         rWcZjkGSpkT8aFBpwcArzhoyiByk+K2f5N+wrV3uHcT/AxaC5o1bN3GEi7vPmkeYOi8G
         eDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdKg7HWP8SpnwEnJWjGyJ6fPUQJcIsDjN44/Pfbat8SJOSsBfnDlSJ1rgDKrV+mpAZcBd+r6F+rznj/MJXYEnNvzwZuRGmwRz+dkvCZZw=
X-Gm-Message-State: AOJu0YxPy1xPouJlB7Xhy8cV5g3z1X09Ihcjaa6tZ69+xTP4cmL8h0Dd
	/4F06t45jQdp1ujQ/XYv9buShSsvv74rlipcP8o7izhyhdvcp+ta9NQHyP6VDCTn17JyX2sILMR
	j8sVaBSUluDAOQhobgna0j0o7nLz1J18UwpTd2RpiSovEktRyLVsPQjlUfmm93E6T
X-Received: by 2002:a2e:8609:0:b0:2ef:2c4b:b799 with SMTP id 38308e7fff4ca-2f15aabccc8mr133927521fa.28.1723037682765;
        Wed, 07 Aug 2024 06:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1kLJOf5OmR6kChfxdY0La3W7+UVEX3evrbMrawtVKvFb7dXch4A6sXrabkqBnUM9UXYidjQ==
X-Received: by 2002:a2e:8609:0:b0:2ef:2c4b:b799 with SMTP id 38308e7fff4ca-2f15aabccc8mr133927051fa.28.1723037681669;
        Wed, 07 Aug 2024 06:34:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:efe1:812e:e83a:2c34:ce60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059714d5sm29324685e9.13.2024.08.07.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:34:41 -0700 (PDT)
Date: Wed, 7 Aug 2024 09:34:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev,
	axboe@kernel.dk, kvm@vger.kernel.org, linux-block@vger.kernel.org,
	oren@nvidia.com
Subject: Re: [PATCH 1/1] virtio_blk: implement init_hctx MQ operation
Message-ID: <20240807093322-mutt-send-email-mst@kernel.org>
References: <20240801111337-mutt-send-email-mst@kernel.org>
 <0888da3b-3283-405b-b1a8-a315e2623289@nvidia.com>
 <20240801112843-mutt-send-email-mst@kernel.org>
 <9400fb28-47c2-4629-af17-df2a95f2d3d8@nvidia.com>
 <20240801114205-mutt-send-email-mst@kernel.org>
 <6a8f0c72-ba77-42c3-8d85-6bb23a23f025@nvidia.com>
 <20240801175617.GA1133773@fedora.redhat.com>
 <a10e97ce-792a-410f-b68e-d00292987b3a@nvidia.com>
 <20240803083824-mutt-send-email-mst@kernel.org>
 <7022d183-f98e-40b4-b3cb-00eb43c1ff06@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7022d183-f98e-40b4-b3cb-00eb43c1ff06@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 03, 2024 at 08:54:45PM +0300, Max Gurtovoy wrote:
> 
> On 03/08/2024 15:39, Michael S. Tsirkin wrote:
> > On Sat, Aug 03, 2024 at 01:07:27AM +0300, Max Gurtovoy wrote:
> > > On 01/08/2024 20:56, Stefan Hajnoczi wrote:
> > > > On Thu, Aug 01, 2024 at 06:56:44PM +0300, Max Gurtovoy wrote:
> > > > > On 01/08/2024 18:43, Michael S. Tsirkin wrote:
> > > > > > On Thu, Aug 01, 2024 at 06:39:16PM +0300, Max Gurtovoy wrote:
> > > > > > > On 01/08/2024 18:29, Michael S. Tsirkin wrote:
> > > > > > > > On Thu, Aug 01, 2024 at 06:17:21PM +0300, Max Gurtovoy wrote:
> > > > > > > > > On 01/08/2024 18:13, Michael S. Tsirkin wrote:
> > > > > > > > > > On Thu, Aug 01, 2024 at 06:11:37PM +0300, Max Gurtovoy wrote:
> > > > > > > > > > > In this operation set the driver data of the hctx to point to the virtio
> > > > > > > > > > > block queue. By doing so, we can use this reference in the and reduce
> > > > > > > > > > in the .... ?
> > > > > > > > > sorry for the type.
> > > > > > > > > 
> > > > > > > > > should be :
> > > > > > > > > 
> > > > > > > > > "By doing so, we can use this reference and reduce the number of operations in the fast path."
> > > > > > > > ok. what kind of benefit do you see with this patch?
> > > > > > > As mentioned. This is a micro optimization that reduce the number of
> > > > > > > instructions/dereferences in the fast path.
> > > > > > By how much? How random code tweaks affect object code is unpredictable.
> > > > > > Pls show results of objdump to prove it does anything
> > > > > > useful.
> > > > > This is the way all modern block drivers such as NVMe PCI/RDMA/TCP use the
> > > > > driver_data.
> > > > > 
> > > > > These drivers don't have driver specific mechanisms to find the queue from
> > > > > the hctx->queue->queuedata like vblk driver has for some unknown reason.
> > > > > 
> > > > > It is pretty easy to review this patch and see its benefits, isn't it ?
> > > > > 
> > > > > It is not expected to provide extreme perf improvement.
> > > > > 
> > > > > It is introduced for aligning the driver to use common MQ mechanisms and
> > > > > reduce dereferences.
> > > > > 
> > > > > This is not "random code tweaks".
> > > > If you cannot observe a performance change, then adjusting the commit
> > > > description to explain this as a code cleanup to reduce dereferences and
> > > > local variables, improving code readability seems fine to me. I think
> > > > it's a nice cleanup when presented as such rather than a performance
> > > > optimization.
> > > > 
> > > > Stefan
> > > Sure. Please check the bellow adjustment:
> > > 
> > > virtio_blk: implement init_hctx MQ operation
> > > 
> > > Set the driver data of the hardware context (hctx) to point directly to
> > > the virtio block queue. This cleanup improves code readability, reduces
> > > the number of dereferences, and minimizes local variables in the fast
> > > path.
> > I'd drop the local variables part, it is not at all clear why is that
> > a win.
> 
> We can drop it:
> 
> virtio_blk: implement init_hctx MQ operation
> 
> Set the driver data of the hardware context (hctx) to point directly to
> the virtio block queue. This cleanup improves code readability and reduces
> the number of dereferences in the fast path.
> 


yep. also pls drop 1/1 from subject. Just [PATCH vX]

pls repost with these commit log tweaks, I will queue.
-- 
MST

