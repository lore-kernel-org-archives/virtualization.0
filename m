Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D841494C8
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823475; cv=none; b=ZZwFva4mg+I29XLDofoG2ezyB5Y98+O3PwaaBs/Lgm+a8CRNoYhguOpyH9vbsj3+eZv7BJlEY7iFk34h6UCUSuhuDRPiF/enKlm7ILVsAsyHaxp/ouns0S6p8Y06TNXB4hahnPGDKRQow38xjVrFlM8izLmlfz93FoZOsqNmMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823475; c=relaxed/simple;
	bh=JK9JCXnNFA+Q88R0pI3Is57I6tUtCQ6aLilbZ+7avwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oElu4HWNDf51RVbK64M9TuX2jEhLLw+y8rWwFPIspEwTs3ykVPrkQjwz30yEwzMvNchXtxOD8O2qhLlg2iL5RoHU8t8Ml4kDA+BlNJidNd0KMzsX+GsohQ+ZdwtnJ1rYIpE6zVwW52bSP0gOvy1S7ZudCrJ4m+ti97dye89SC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fHoTy0ya; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fHoTy0ya"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso6823725a12.3
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 05:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721823472; x=1722428272; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AH6/60ilSqogotIa0Yn+76PK3sWEb69NY//2ZTuyhAE=;
        b=fHoTy0yaJGn7SN4D+jMnSrSfj6VmTqjp+raJoy2QqzNyolSIfOfY6yDHg1zMqqZlph
         79FtWqmft+OMkUnaSLi3lLriBZvLLaKJ0Z28UH5+g/v4kCpKkw2QL7VcjiBTT/ajq+e8
         IQtAPHZYVegSHLvArILBCQCWMokh3++PSFcigEoSrgLB2eihgpbI/c145n2vYv1BcoDT
         lCofnpk6bs6XUaPgP418HBs9/ph/uq7s8tocvMSX+n3KpZqkLV7sPN6jZV6Y+vZSTkVY
         8Cr3jcw2slQ2OX7P9APaLtjgvs+wnocYd1MzDYHDNy4RqShCfts3UoaLnhgO6Zv8bi/e
         xLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823472; x=1722428272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH6/60ilSqogotIa0Yn+76PK3sWEb69NY//2ZTuyhAE=;
        b=t+0hc5g0HFcnq2g5W0xrLgZ90mWkVT9kfJVjsXlFz4tkjGYJsx2AZii+K3x9Mc3doL
         wuM9DDoGFctP6ueGouTVX3JzAyYboRQaouMgag0IdTTfOEHuEGr883o8II/FJ7o4KsG5
         f5lKedy0AdozAlzR6MkM24P/ZVwm3QgWfHA3KU5ClT8F/Hj1J4tEJ7+h9Uu3+zacAGDn
         /z/YrP6NT9x7CU6PgJ/yvOuygucWiHkQUawWakvdqwFK7YsBQr/sV56YwZiVSf1ubmP8
         1yzeXxrXka1zNovh7Et1kBUaJ7j8NCcxcq2Q95aPyGL5yQNdLJP/em/piUzEfgCXll3x
         +UYw==
X-Forwarded-Encrypted: i=1; AJvYcCW69OxzOlFvuFvH9ktCGmVCXBYj48r7nqKlQGCVWNscjWaJ3A1xWpleaVJVsQVzz9MRy/zvQIrAOo2efYg9kp23nlk9W4oeV5QM7pcd8EE=
X-Gm-Message-State: AOJu0Yy66mExaW3x1pOwyrDaJ2VHQp1K72bUGnJUZDUhLRwA2j0Kc5gT
	4MtdIdSROYNWZJtwqSnpHynunZrkfoKODms0AfgamLREFkmUcEBICHx/HSTYpQA=
X-Google-Smtp-Source: AGHT+IHfYQ0bvxc2iNBQgy+rvJ4GtEtz1AIw7oKDKgMgcbTYPs7bQokdfT3snYcXpjGEyw6Qamqg0g==
X-Received: by 2002:a17:907:6d06:b0:a7a:9144:e254 with SMTP id a640c23a62f3a-a7ab0d081c8mr141848366b.10.1721823472048;
        Wed, 24 Jul 2024 05:17:52 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c786162sm647262166b.18.2024.07.24.05.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:17:51 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:17:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 42.hyeyoo@gmail.com,
	cl@linux.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com, penberg@kernel.org, rientjes@google.com,
	roman.gushchin@linux.dev, urezki@gmail.com, v-songbaohua@oppo.com,
	vbabka@suse.cz, virtualization@lists.linux.dev,
	hailong.liu@oppo.com, torvalds@linux-foundation.org
Subject: Re: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and
 encourage GFP_NOFAIL
Message-ID: <ZqDw7qoaopnYt3-P@tiehlicka>
References: <20240724085544.299090-1-21cnbao@gmail.com>
 <20240724085544.299090-6-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724085544.299090-6-21cnbao@gmail.com>

On Wed 24-07-24 20:55:44, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> GFP_NOFAIL includes the meaning of block and direct reclamation, which
> is essential for a true no-fail allocation. We are gradually starting
> to enforce this block semantics to prevent the potential misuse of
> __GFP_NOFAIL in atomic contexts in the future.
> 
> A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
> and __GFP_NOFAIL are used together.

Ohh, so you have done the migration. Please squash those two patches.
Also if we want to preserve clean __GFP_NOFAIL for internal MM use then it
should be moved away from include/linux/gfp_types.h. But is there any
real use for that?

-- 
Michal Hocko
SUSE Labs
