Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE958038F
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969806; cv=none; b=XhphOq/UKZGA7cpZDfcUxvRZx5YMYai3cwsgI0KX/VYhQxCE5x09yRcCRxFG4fXNbAHSTzsUVNQTs/MHN+fs015RL3AbSLAqv2FRsYdSnYmwbSYsTUwm/ZaKD/B9wfIfq78SoM1UPy4hy59dXsAGptPm7IqfYRslel8xFcVbW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969806; c=relaxed/simple;
	bh=On06xCFs+45Cv/iSsThW0gWQ416PGgEnZnw/69MIF+I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0KcEnxr+D1BV1xb7eUZVVvUBfsZwmQ2BSrtMVNNRR5vdRLpuYn3hHW7ziRRbbdaDYxOtCHg40CV9Ph5E1g2VdWxTmQIWbCwji6si0XuEv3Oxsd8wKRZx6if0iWApDeHQJPOmRuDYwmOnbzts15WUc95daZcgrS7tJho/XJTPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rggz5eH4; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rggz5eH4"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19127so497794d50.1
        for <virtualization@lists.linux.dev>; Wed, 09 Sep 2026 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788969804; x=1789574604; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AausXKsac6c2thgVaA1TemaODiOlglfugBkNliHU0Ak=;
        b=rggz5eH48UpHKeFxaHhsTHcAQ1+DjXOr9ZsHXTb8OMcVK8USOx1pnIi7drjX5uEYt8
         jl37USFnueZt4d5qDyvIyXzyEwLb1jdR0C7cDlpoesePnF1lnNeGVk+SARzI2qX886UH
         MxrpDy05Y1kHqTQ5kWn5BhuHj0p0i1XjD8O08nsna1+yGpTLBAmcI7yiBc/GjYSZ7xmj
         LgVVcJ+WSexFyvfcW6Xnp1xh1YHNJ9EuN8PzxT/PJ/H6sijIRBm7WAnddqzraggIN8GQ
         GqEla7MBJ/VUO6aanBadTCZtlrsaf08BMh6rxftgYQziej9Qh2J5nxhamW0PEgUrSGEL
         k7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788969804; x=1789574604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AausXKsac6c2thgVaA1TemaODiOlglfugBkNliHU0Ak=;
        b=MMf+OcxVdFCM3mvlfaa2+h3sOBSAuzt02ly20FdL0KuEZca6mZotD+qSHjSd3guIs2
         8OyF/fn7G0Gn0LLb1N98mLeJehFZjb2RNZn2WF7b2htn7zXOfOO5X92HWnfFyD/YEljJ
         t4cylOR36PmC0b0rtfZooNxi3klflBaREOFbqpwUKpNXJSS7YTiAVSyEKFJs+UOTNKa/
         fgaLerHxZnxanjrB3AOTn6WXkjShr+YLcaqnkys6ifYvVI+P3Ri/o0M8wivSF+D7wvaY
         U80mfgYVjJOF7pXsRM+/eWt3KarQarNCgk8dTkY2qbqURp7bGRhfKvSnuLwusiWSEfOJ
         zR2g==
X-Forwarded-Encrypted: i=1; AKwUvBytYU8iuap+lHDzKzx5Y9dhc/v1Y94f+L3WUrgjsgOL1cQ25+8ZgIrvzE9JjaMNMr1Z0V3ux0elbgebBtT42g==@lists.linux.dev
X-Gm-Message-State: AFuF++nnyosfmsKkK5VueKuF+SSyCRVg5cS/+hnGUk6ZG+CSZ7CKTTQA
	F4pl3nC2M8rhjdiYn4VK6Ubb7uDEy4Sj+rs1QiyYJBNbPgn6ivkuD0VB
X-Gm-Gg: AYBFou2f+12ItxAE16gFYJeyNGgnNouYzGnIzNWJFo8cuuAW/JfVDy3wljqbVB9C5cH
	lJ1ks4DGCy+RejwU7Zdbp6yV49TbLmURe8+LrMDTvatcmz2Xf+iO6nFq2M5Z61xrPYNXdthxlTS
	n1DV8hYng3Ng8/ry7ZS5ebzOKzmMKCSNcnsM+iSvqv2Wforq2ubr2L66E7piiAM7ZmsmohI+PCZ
	qzzHGt2rh4MfI7328zRegVKS3UikQ27Solg5I43OiRqzNguejRzS0M/ZIrphtvVOilamsd+jdX5
	nfm1m5DMoQ5H/YEbyVFZBiuW0meseJsfIR84oMnFT6xldq/shYWbbfWLY4fxmxpNT16HG3w5K7s
	Vuyodpmu9nNJSWG6LmQa+IZYhbS8NdwrgZdZrxQW/gqh/VxIXXs4ftSqQYXPplhFGT3YBvWufDZ
	hNMr5E+CCwuT0WaRDK4IuTEAoZ8vLzoRw1tAzsflszRiitqYTlRRk/u9d+JJnwT8vIozCLbASHs
	uCfx2w30oMpbTzOdIL3+DugA4qA
X-Received: by 2002:a05:690e:4188:b0:66e:ac6f:cdf with SMTP id 956f58d0204a3-6710feec5eamr676251d50.5.1788969803429;
        Wed, 09 Sep 2026 09:03:23 -0700 (PDT)
Received: from localhost (c-73-105-0-191.hsd1.fl.comcast.net. [73.105.0.191])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149ec0e68sm111794017b3.20.2026.09.09.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:03:22 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Wed, 9 Sep 2026 12:03:21 -0400
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	yury.norov@gmail.com, kprateek.nayak@amd.com, iii@linux.ibm.com,
	corbet@lwn.net, meted@linux.ibm.com, tglx@kernel.org,
	gregkh@linuxfoundation.org, pbonzini@redhat.com, seanjc@google.com,
	vschneid@redhat.com, huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, maddy@linux.ibm.com, srikar@linux.ibm.com,
	hdanton@sina.com, chleroy@kernel.org, vineeth@bitbyteword.org,
	frederic@kernel.org, arighi@nvidia.com, pauld@redhat.com,
	christian.loehle@arm.com, tj@kernel.org,
	tommaso.cucinotta@gmail.com, maz@kernel.org, rafael@kernel.org,
	rdunlap@infradead.org, kernellwp@gmail.com,
	linux-doc@vger.kernel.org, jgross@suse.com,
	virtualization@lists.linux.dev, sunlightlinux@gmail.com
Subject: Re: [PATCH v13 02/13] cpumask: Introduce cpumask_intersects_and
Message-ID: <aqGDSeGGIfJvn8uc@yury>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909135617.871006-3-sshegde@linux.ibm.com>

On Wed, Sep 09, 2026 at 07:26:06PM +0530, Shrikanth Hegde wrote:
> Introduce bitmap_intersects_and() to determine whether the intersection
> of three bitmaps is non-empty. Unlike cpumask_first_and_and(), this
> returns immediately when an intersecting word is found and does not
> calculate the first matching bit.
> 
> Add cpumask_intersects_and() as the corresponding cpumask wrapper.
> 
> A subsequent patch uses the helper to determine whether a task
> has a CPU that is present in its affinity mask, the preferred CPU mask,
> and task possible CPU mask.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>


Reviwed-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/bitmap.h  | 14 ++++++++++++++
>  include/linux/cpumask.h | 18 ++++++++++++++++++
>  lib/bitmap.c            | 17 +++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 7df1573a409c..adafbcf2016b 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -52,6 +52,7 @@ struct device;
>   *  bitmap_complement(dst, src, nbits)          *dst = ~(*src)
>   *  bitmap_equal(src1, src2, nbits)             Are *src1 and *src2 equal?
>   *  bitmap_intersects(src1, src2, nbits)        Do *src1 and *src2 overlap?
> + *  bitmap_intersects_and(src1, src2, src3, nbits) Do *src1, *src2 and *src3 overlap?
>   *  bitmap_subset(src1, src2, nbits)            Is *src1 a subset of *src2?
>   *  bitmap_empty(src, nbits)                    Are all bits zero in *src?
>   *  bitmap_full(src, nbits)                     Are all bits set in *src?
> @@ -181,6 +182,9 @@ void __bitmap_replace(unsigned long *dst,
>  		      const unsigned long *mask, unsigned int nbits);
>  bool __bitmap_intersects(const unsigned long *bitmap1,
>  			 const unsigned long *bitmap2, unsigned int nbits);
> +bool __bitmap_intersects_and(const unsigned long *bitmap1,
> +			     const unsigned long *bitmap2,
> +			     const unsigned long *bitmap3, unsigned int nbits);
>  bool __bitmap_subset(const unsigned long *bitmap1,
>  		     const unsigned long *bitmap2, unsigned int nbits);
>  unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
> @@ -445,6 +449,16 @@ bool bitmap_intersects(const unsigned long *src1, const unsigned long *src2, uns
>  		return __bitmap_intersects(src1, src2, nbits);
>  }
>  
> +static __always_inline
> +bool bitmap_intersects_and(const unsigned long *src1, const unsigned long *src2,
> +			   const unsigned long *src3, unsigned int nbits)
> +{
> +	if (small_const_nbits(nbits))
> +		return ((*src1 & *src2 & *src3) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
> +	else
> +		return __bitmap_intersects_and(src1, src2, src3, nbits);
> +}
> +
>  static __always_inline
>  bool bitmap_subset(const unsigned long *src1, const unsigned long *src2, unsigned int nbits)
>  {
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 4c8bb6953107..7c8f16797f94 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -824,6 +824,24 @@ bool cpumask_intersects(const struct cpumask *src1p, const struct cpumask *src2p
>  						      small_cpumask_bits);
>  }
>  
> +/**
> + * cpumask_intersects_and - (*src1p & *src2p & *src3p) != 0
> + * @src1p: the first input
> + * @src2p: the second input
> + * @src3p: the third input
> + *
> + * Return: true if AND of the three cpumasks is non-empty,
> + *	   otherwise false
> + */
> +static __always_inline
> +bool cpumask_intersects_and(const struct cpumask *src1p,
> +			    const struct cpumask *src2p,
> +			    const struct cpumask *src3p)
> +{
> +	return bitmap_intersects_and(cpumask_bits(src1p), cpumask_bits(src2p),
> +				 cpumask_bits(src3p), small_cpumask_bits);
> +}
> +
>  /**
>   * cpumask_subset - (*src1p & ~*src2p) == 0
>   * @src1p: the first input
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index ed685127a107..d1cb8a507c60 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -308,6 +308,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
>  }
>  EXPORT_SYMBOL(__bitmap_intersects);
>  
> +bool __bitmap_intersects_and(const unsigned long *bitmap1,
> +			     const unsigned long *bitmap2,
> +			     const unsigned long *bitmap3, unsigned int bits)
> +{
> +	unsigned int k, lim = bits / BITS_PER_LONG;
> +
> +	for (k = 0; k < lim; ++k)
> +		if (bitmap1[k] & bitmap2[k] & bitmap3[k])
> +			return true;
> +
> +	if (bits % BITS_PER_LONG)
> +		if ((bitmap1[k] & bitmap2[k] & bitmap3[k]) & BITMAP_LAST_WORD_MASK(bits))
> +			return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(__bitmap_intersects_and);
> +
>  bool __bitmap_subset(const unsigned long *bitmap1,
>  		     const unsigned long *bitmap2, unsigned int bits)
>  {
> -- 
> 2.52.0
