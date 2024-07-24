Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1465695
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721822295; cv=none; b=pmno8YEgGDDsbn9LM5AL7IHtsuxBXZIACzqAEUY5s5/7deKWNGEOjUFbdKh/0iGinJRrlj6K56mLijxgl+obXHY/qdkYkUpesidUUW/6SNH391YUb2Q6TK70Uq8WKxRIjMnAi4fepsjwJjcsrMwpYFgRIOhVNMndtcv1Euxzicw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721822295; c=relaxed/simple;
	bh=pTtzIZvfksjXgHZbeHEGJbdmq/jxxyPYsmAsM9XJtMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQuAKk6+zUVuNT/xeWmRfpBLTSVxmy8FckIJjSFQb8mhwhsfoUnkjMmJjzvTxBHBvfIDG31b51Mdeg2Sq4zfa+tJUaVrNkMRztS3ai+QVztNYTNVZlCo3UCtJSHSBtpH0ggsEGLDBKyoGVR9liSanCCgig9MUWPcbBUkdSk2WBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ezrHJvOw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ezrHJvOw"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso170376966b.3
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721822291; x=1722427091; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=96LiP4EJKTbJ9zW7jWWaw9Mt26G4l1eFWQe0YZezUgo=;
        b=ezrHJvOw4+C4j+/sgk7oxFavU6TXroTha9dJJEiyx/not05D/AKqc9ldeDRgWSJGpY
         NLlmuAyx8GRL5C1AisrsF7WGiu9DK81th41X7sifm7Di8eXxIudD93f5ewE4pKeduZd6
         0KH1xZdQ7/Gl5VB7XP03oC844YwoLEOnZGe7dN29tsrM5S1P5HCevB3Xka60+4BN6Z5O
         vT+H+Hu9N7yT2lovZ9HhYoNra86xzdTkitDpwbKCCBmzHmPxDGdB0AdwWy9KKcZOJk/7
         4/OqcpJc73fdRiYCL/yANKpFKY9WY7W8pMDbdMo4zz1MnPvFjODnlVfuWIcKauiP2XaV
         TW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721822291; x=1722427091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96LiP4EJKTbJ9zW7jWWaw9Mt26G4l1eFWQe0YZezUgo=;
        b=t1XB+XRd4eqCs305gJEqP+0i3roCPdqdPLGe7E+QhbXK3EpjOzVLZr2Y1omnbqARAr
         1cpceV+FNZwsgV5BGTiJuv2GQnqk0t/V8TAQE/pQ6H1QkfaG1V8lPhKq/TeDQOgACicV
         JzJpii4lEFuzj1ThgzNy5KrOyMa3IPtVhqlzP5N3EJIZFlSZWsknu7HbxaMM622/zyF5
         C5sB6FnZEJnhVXjEk2sLm0hVGgVS/6LBRHfgvtA4bWoiD/U549RoQhbopjz9H0Mtn46R
         EJW94FembG0b25HNImiwwd/1U+J6s2jubEyRo5VjAbcVuo1DVJ1gN9cEG5/iY0UmrtLG
         ky8w==
X-Forwarded-Encrypted: i=1; AJvYcCWQFc8tDbjkRNga/bhP+oSE+yh+DkvJ1U+Fm61oN5RcSJdr3N8T2+9WXcEqSUbiS4NxbJJuOKJzdZHUgE9czooZSPGMy1yqBS51af5uA+8=
X-Gm-Message-State: AOJu0YyKVncx/c71hkgS7VmAlr+tiO9S1LRh2afsDd8Q+lYNpuU6K8PO
	takmBOXpZ57d2htuNwGBVyMFbIC3fAM7mifSdEx3tDZDkAYZeUj7y3wT25IyNc4=
X-Google-Smtp-Source: AGHT+IHvmNN4dfiaiUDQcItBMdEPOzv0avhX3W76e+XHKZ1xVDZEPV+rLot70dQKgkRZ3N8l9bDrvw==
X-Received: by 2002:a17:907:980a:b0:a7a:bd5a:1eb7 with SMTP id a640c23a62f3a-a7abd5a1fbcmr40793666b.59.1721822290912;
        Wed, 24 Jul 2024 04:58:10 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7ab999db8esm33348766b.184.2024.07.24.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 04:58:10 -0700 (PDT)
Date: Wed, 24 Jul 2024 13:58:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/5] mm: Document __GFP_NOFAIL must be blockable
Message-ID: <ZqDsUZDLZOXTPwuA@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-3-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724085544.299090-3-21cnbao@gmail.com>

On Wed 24-07-24 20:55:41, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Non-blocking allocation with __GFP_NOFAIL is not supported and may
> still result in NULL pointers (if we don't return NULL, we result
> in busy-loop within non-sleepable contexts):
> 
> static inline struct page *
> __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> 						struct alloc_context *ac)
> {
> 	...
> 	/*
> 	 * Make sure that __GFP_NOFAIL request doesn't leak out and make sure
> 	 * we always retry
> 	 */
> 	if (gfp_mask & __GFP_NOFAIL) {
> 		/*
> 		 * All existing users of the __GFP_NOFAIL are blockable, so warn
> 		 * of any new users that actually require GFP_NOWAIT
> 		 */
> 		if (WARN_ON_ONCE_GFP(!can_direct_reclaim, gfp_mask))
> 			goto fail;
> 		...
> 	}
> 	...
> fail:
> 	warn_alloc(gfp_mask, ac->nodemask,
> 			"page allocation failure: order:%u", order);
> got_pg:
> 	return page;
> }
> 
> Highlight this in the documentation of __GFP_NOFAIL so that non-mm
> subsystems can reject any illegal usage of __GFP_NOFAIL with
> GFP_ATOMIC, GFP_NOWAIT, etc.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/gfp_types.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 313be4ad79fd..0dad2c7914be 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -246,6 +246,8 @@ enum {
>   * cannot handle allocation failures. The allocation could block
>   * indefinitely but will never return with failure. Testing for
>   * failure is pointless.
> + * It _must_ be blockable and used together with __GFP_DIRECT_RECLAIM.
> + * It should _never_ be used in non-sleepable contexts.
>   * New users should be evaluated carefully (and the flag should be
>   * used only when there is no reasonable failure policy) but it is
>   * definitely preferable to use the flag rather than opencode endless
> -- 
> 2.34.1

Do you think the following addendum should be folded in just for
completness?

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 313be4ad79fd..d024cfd1af8e 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -215,7 +215,8 @@ enum {
  * the caller still has to check for failures) while costly requests try to be
  * not disruptive and back off even without invoking the OOM killer.
  * The following three modifiers might be used to override some of these
- * implicit rules.
+ * implicit rules. Please note that all of them must be used along with
+ * %__GFP_DIRECT_RECLAIM flag.
  *
  * %__GFP_NORETRY: The VM implementation will try only very lightweight
  * memory direct reclaim to get some memory under memory pressure (thus

-- 
Michal Hocko
SUSE Labs
