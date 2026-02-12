Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708F2BEC44
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770881397; cv=none; b=NpxTocDHmGI7GPtYP+Q2CEg2PQkxp3eMN6gxjirYTmgOYahhlqjyzJ8kzUtYYHJYqK9D4buSv5KGaJMEo6+pC8DLQ7Ti2r+nc1Yr8a8EKp0VC7M5//eRHUwY2Q6EBsXUMkyl/qRY18rHLEY2y6egvVKq1ekOGFhymYdd5PUhr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770881397; c=relaxed/simple;
	bh=zO+hFB/XNykEPmOHYVCIykOgF/5FeY/JtT1N8MAYZ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frmjd5a23035RTTN7RksW+mLdlxicdJudgvfSEDCg1QjbwiClsHga7TJx7hy9er+2FS31WUP7GJvdSwRBvkoDol5mwvr8xrlS8Td7mnyHI1Vk5X83e8bNr+3GdBlt2+Vb2ReGp99Rj0xPB60XaolsSBpIn17I7CFnFyRGEMmckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I1DbqItB; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I1DbqItB"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4805ef35864so64433995e9.0
        for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 23:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770881395; x=1771486195; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2O6Sm0cEIfahlqGv931PH2G0tMd8cyKa75kNbunAo0=;
        b=I1DbqItB+5vkUkVI46m23a/fjjgy8+cGruKEqtosGB/I/o6kZmDtu0InRpT290taHT
         yGNAxKU/HwSsaDd3pSiPwI/8Z94k3rmYLBVWOwQGb150ydUxd9LVtOi/x5vVatb0UwLg
         +FDHyjAG7xQDshEJ6neAxGYwn73OIgop1b3L0uEbmXvSrcls/0UI5RDgz8VdpnBJ5tgE
         Avz01q9a8BQ2VezrpZ+9dirdT+fU0m/2uyqv4vL6uK8ll59VuVh5gReGqpPoGZvnKS1W
         4xXC0uSkoB1g59tXVXqjMG92G/4hBGGhMr1g3xNb2EjPhXUlYw2gUaX72Oq++hkH1gG1
         WYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770881395; x=1771486195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2O6Sm0cEIfahlqGv931PH2G0tMd8cyKa75kNbunAo0=;
        b=Md/fQ4o/Z4uIktYbrK3K5j0IojMlimnD7gJWrT7J9itLiOdcWIA/XHhIQO+2Hk/oCb
         v3lgMEfmq06OVWlv9YoBOmOG2kvbViRSdttoiGwWc1U9zJ4Yb7T+rD8vvwpOEb8bC/+d
         h8zhjp2CTNcgOyTcKJF4HQR9G/J53SeaWwLR5UhnHt/Aon19ZE1JBLKdktC+3BT60CXF
         7xWKBlxQTnjar7xOEi8e31F7u+qI+/uk6bgAbCvCbrizc5nxLsra8E5mb3ubvS0BJU4l
         oWWMak1+DB0ITcVyTzS6/xcP/eJnB6Bi9aXLw5JECQz9QNbarQjJOEvNDiLAS2ddYoj7
         t0TA==
X-Forwarded-Encrypted: i=1; AJvYcCUKtZS13F1iA/9glC4ebDQ0f8vrt5Ou41CSUF3lQW5AX8ypng87TaYSCDCETLMGLpCk90fdyJ0AshaZwSDP6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8OnVCaq23NYpkAeIdD9ARfBptWennzt4n497SGAg8epj4+nE8
	1vnBpqGlfjYhe18261/9Q0VrMn2P+EBH5Q98ohMETJGn2/EBbxI5pDJw+Dj/wWYRDQc=
X-Gm-Gg: AZuq6aI518LVwMH9xKrM9OnqRvOPgvbY1ZntXECTC0pJFUFL7kOOBY9JfhTg9u0QLbk
	GNOuaymOC5DbeWxb23Xlxorv8GBbho2RjCAoHc2W+3DF8ti1TNKzBp5AJEVZ+ZpLQaiyJC8P4xJ
	BpEmnXt3R3ZclJSPyLfiW2v8iat2OExtifal42r8NX7Gj4Rfklmv+K9/3/R5lefuaRuOHa6xM0S
	lagcSdu708yfxRVIAa+n1cq//5+9E/7mJWz5UrSdfHrrYlftWb/9mXQewGy4wk8JpSDqu2jAUDy
	whCI/ZeWxZ0V8rHHDIGtXxzeWlkuJSoVwhSc+FuiEIz+TGWmeKVOvqr3tqHk3Mx2mdl6EeNioT6
	fSANZhF5moVXdfnKr7nrzdE6RJu9vuNBpCDhIr2gN+6jllpQm+wPYDc8bKixFyItTaJoba3Xjf+
	OLRvff1YFNTjPo2x09+7FSXth4o6bXn6DQqgk0
X-Received: by 2002:a05:600c:3b1f:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-483656ae4a3mr22015335e9.6.1770881394566;
        Wed, 11 Feb 2026 23:29:54 -0800 (PST)
Received: from localhost (109-81-87-131.rct.o2.cz. [109.81.87.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e0ed5sm164667535e9.5.2026.02.11.23.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 23:29:54 -0800 (PST)
Date: Thu, 12 Feb 2026 08:29:52 +0100
From: Michal Hocko <mhocko@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: linux-mm@kvack.org, apopple@nvidia.com, akpm@linux-foundation.org,
	axelrasmussen@google.com, byungchul@sk.com, cgroups@vger.kernel.org,
	david@kernel.org, eperezma@redhat.com, gourry@gourry.net,
	jasowang@redhat.com, hannes@cmpxchg.org, joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com, matthew.brost@intel.com, mst@redhat.com,
	rppt@kernel.org, muchun.song@linux.dev, zhengqi.arch@bytedance.com,
	rakie.kim@sk.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	surenb@google.com, virtualization@lists.linux.dev, vbabka@suse.cz,
	weixugc@google.com, xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Message-ID: <aY2BcIHIARSwwQpo@tiehlicka>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
 <20260212045109.255391-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212045109.255391-2-inwardvessel@gmail.com>

On Wed 11-02-26 20:51:08, JP Kobryn wrote:
> It would be useful to see a breakdown of allocations to understand which
> NUMA policies are driving them. For example, when investigating memory
> pressure, having policy-specific counts could show that allocations were
> bound to the affected node (via MPOL_BIND).
> 
> Add per-policy page allocation counters as new node stat items. These
> counters can provide correlation between a mempolicy and pressure on a
> given node.

Could you be more specific how exactly do you plan to use those
counters?

-- 
Michal Hocko
SUSE Labs
