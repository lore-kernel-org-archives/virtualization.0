Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548835;
	b=H7mAsppuVyeE/qSMjm3TlcVxxgKmjoYciNKQgcoFamD617AxUU3yREv2cMSd6encrzDc
	 ciZY5dht+PXZQD0+0lGDgk4FDsoKfCE/y6gcgXDjVTCxg5tE7//Xr8WRmFLk8wtgtYX/f
	 cPQWfC8Y+O51gQA10J8uXDanYCLSMG/oHdwh8yWlySrNj+pkcR9254E0Za1XfKdAIQgDr
	 sH369KviblAYMWrh15Ek810WRAV6XoCTPIBn+oa7szmeZTcsHUkX0vEjaJaZWju0/7IFI
	 PD/zBT0IMFm+TOd/jc8Fcr+CtHPMSMBlF2M2lFypmCBGTMCgBT/dVHux7YUHQmBu9PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548835;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
	b=1Ew5x+TfA93s2JJyf6LKoGz7o+GNseuioxPOLpA1xWYR7BpX+9TBZRd6UxnjDNbPDk3c
	 6C55T3fZNUwt+t5Lw4Qn2FK8zrsuPDFT+yVC9g//+Q+xiPR6cKbk6DhDx0osgOd5a74l1
	 IAgqLbJyxBKJSpjMUIW+d6Ish5LtsVUvWxCalcrEOdSuphR6PsZZGM9VrVHm3OsY8VSLv
	 xBoiJ/byxCaBkU1eKaBii5XTPZLtSveiG/W2IPylcGa246tdYHHH3Jrigoonnt5me1omE
	 QcpkoOvfC9tFY1NE8kZQEAdSklXGF96KP5U7pzPlaF6ksUAWPpJZz/yrxPHspFM51UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g9DG8+fh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F4606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 05:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 773F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g9DG8+fh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794548833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
	b=g9DG8+fhQxS28Tg5VVPkhKPQ6yHZ5IFiA+e+nuQjLg9RutFW/4x01OTci1wnboGH6bWvCY
	hmSPs6jI2DFjAiM5O8Us3mkj4Tkg998fVz/u2MYSGTyDjOzbMu+GA76HbGlQLMm4DvnRvP
	98NiWBW5MrBouS6Jg3rr4f7eTdkZeyo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-5K6zbonBNs-qQYKQtYDjdw-1; Fri, 13 Nov 2026 00:47:11 -0500
X-MC-Unique: 5K6zbonBNs-qQYKQtYDjdw-1
X-Mimecast-MFC-AGG-ID: 5K6zbonBNs-qQYKQtYDjdw_1794548831
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso4330405e9.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 21:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548830; x=1795153630;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zv2dwLznTDzlBwaiBmqu3E6e2BGNnEevgfuztfawCII=;
        b=w2C2clvRvpV9VucfqXjjr810bLQc5lbDs/fYyrrtPGdhctOc2HuT9GcZfzcYZkCoUi
         vscIfFtvj09Zw7T9oMy3mG8p6t+V0S0TqoxysMDVjV/xXlcweRciYW0B6/zXaLFgm890
         Uo7+ztvOGL5yaToBFvikTuryYJqwXhdUaJTe4WpME4y3gEroASxsxveJeIb2Qg031Dxl
         XGfsAQghdUpOmr20fkG//qT3F1tUbKu4Kc0NMwK0dDs0D+eRRyhx/CuoDqYxdDuvLW1C
         w7Vd1jkoiM+OSiMgxht6hZfF1YYtl9xy7hMqWH3D9+/HJYh8WuLm/GAedA0P6NGN7qFz
         pY3A==
X-Forwarded-Encrypted: i=1; AL+hErGljF39RRKcYVoOA+GjXNMUtyrUur4nxHf5L+nVTnhNzwSRUgiDEuR2s9EavhEeSY9BUdHNRDxLPWalqymf0g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+BhHm4iTPmCC/XSDP8Iau2z7a7eAEbQZ6mOrfq920n/mrYdnGK
	tMEpY4AbIPKA76K25SAs4jr0ZCq0c3aQvjDjJcRqZSYFWAJq/ViOf9qvyCaw4aK3ALHm2U+T/uY
	waMEcRYUZm0qOXUfhYlH5VCx0gJldcLvrb7bpUg3l1/AQs+vcxbrItqnLWzLve+vdIfVc
X-Gm-Gg: AYBFou1gfmApRTa5HCtqo2Dke9C67aD5YFCHP9PzwExOnctMuzGKqwuV/CuccAXx41z
	owcywLwowyWfap3Evs2GjBycNpUO96GnAMEUFkV7dZ1JrehpAKtuLG/maY1HYUJL4ve5aYZmwBR
	zN3JyPnv0xkIe5Lgy6Os12CSHmQG/UU9r18ZwppX4oosyGpS2LIPPVYSRDdPv9bKNwFjqglDnNK
	WoUA/fVbpW4VrmKmw9siT3sasqzMHL0QQRpMpNZ7CHwGjPxBmzG8OyrdTTRofmwGiVHMIotiaHJ
	wVwniwQe1fBmiH9ng3AWNd0qwQ0/u6B6O9kOyjt6hMvDVTSb7ane8tZnNp1RCoVrlnk7zq/3zRQ
	Nza3+lYLf3AqEbfZgfi6eXjv/7RJH+L9ECL63JM6+2g==
X-Received: by 2002:a05:600c:4685:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb55a91e31mr25254855e9.32.1794548830566;
        Thu, 12 Nov 2026 21:47:10 -0800 (PST)
X-Received: by 2002:a05:600c:4685:b0:4a6:eca1:7d5c with SMTP id 5b1f17b1804b1-4bb55a91e31mr25254505e9.32.1794548829900;
        Thu, 12 Nov 2026 21:47:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm122130755e9.15.2026.11.12.21.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:47:09 -0800 (PST)
Date: Fri, 13 Nov 2026 00:47:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: bp@alien8.de, dave.hansen@linux.intel.com, eperezma@redhat.com,
	hpa@zytor.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	netdev@vger.kernel.org, tglx@kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261113004435-mutt-send-email-mst@kernel.org>
References: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
 <20261113012937.40818-1-zhaoguohan@kylinos.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261113012937.40818-1-zhaoguohan@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EjpUv2fYA0bb6dgYN6l0Awa0iPSnBVzvyU6_gDmbJ-Y_1794548831
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 13, 2026 at 09:29:37AM +0800, zhaoguohan@kylinos.cn wrote:
> On Thu, Nov 12, 2026 at 05:53:47AM -0500, Michael S. Tsirkin wrote:
> > vhost had a TODO to replace page pinning with a version
> > of set_bit that works on userspace memory, since forever.
> >
> > It is really best to avoid GUP on fast path entirely.
> > Implement set_user_bit and use it in vhost, to do just that.
> [...]
> > lightly tested. pls test and resubmit with your tool.
> 
> Thanks, this is much simpler than my version. Two comments on
> set_bit_user() before I resubmit:
> 
> > +	int __err = 0;							\
> > +	__uaccess_begin();						\
> > +	asm volatile("\n"						\
> > +		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> > +		     "2:\n"						\
> > +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> > +					   %[errout])			\
> > +		     : [errout] "=r" (__err),				\
> > +		       [ptr] "+m" (*(u8 __user *)(addr))		\
> 
> errout is only written on the fixup path, so it needs "+r", as in
> __try_cmpxchg_user_asm(). With "=r" gcc drops the initialisation; here
> (gcc 13.3, x86_64_defconfig) it even shares a register with mask:
> 
>      1a3:	lock or %dl,(%rax)
>      1a9:	test   %edx,%edx
>      1ab:	jne    1bd <log_write+0x5d>
>      ...
>      1bd:	mov    $0xfffffff2,%eax
> 
> so every call returns -EFAULT, and log_write() stops after the first
> page.
> 
> > +	__uaccess_begin();						\
> 
> No access_ok() here. vhost checks the log range when it is set up

exactly

> and
> I couldn't find a way around that, but GUP used to reject kernel
> addresses by itself. user_access_begin() would keep the check (and the
> nospec barrier) local.

What we *definitely* don't want is nospec on fast path.

> Something like this, build-tested on x86_64 and
> i386 only:
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -597,19 +597,23 @@ _label:									\
>  /* set_bit() on a byte of user memory; returns -EFAULT on fault. */
>  #define set_bit_user(nr, addr)					\
>  ({									\
> -	int __err = 0;							\
> -	__uaccess_begin();						\
> -	asm volatile("\n"						\
> -		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> -		     "2:\n"						\
> -		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> -					   %[errout])			\
> -		     : [errout] "=r" (__err),				\
> -		       [ptr] "+m" (*(u8 __user *)(addr))		\
> -		     : [mask] "q" ((unsigned char)BIT(nr))		\
> -		     : "memory", "cc");				\
> -	__uaccess_end();						\
> -	__err ? -EFAULT : 0;						\
> +	u8 __user *__p = (addr);					\
> +	int __err = -EFAULT;						\
> +	if (user_access_begin(__p, sizeof(*__p))) {			\
> +		__err = 0;						\
> +		asm volatile("\n"					\
> +			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
> +			     "2:\n"					\
> +			     _ASM_EXTABLE_TYPE_REG(1b, 2b,		\
> +						   EX_TYPE_EFAULT_REG,	\
> +						   %[errout])		\
> +			     : [errout] "+r" (__err),			\
> +			       [ptr] "+m" (*__p)			\
> +			     : [mask] "q" ((unsigned char)BIT(nr))	\
> +			     : "memory", "cc");			\
> +		user_access_end();					\
> +	}								\
> +	__err;								\
>  })
>  
>  /*
> 
> If this looks right, I'll fold it in, run my test in a VM and resubmit
> with the test as a second patch.
> 
> Thanks,
> Khan


Given the point is to optimize this code, let's optimize.
vhost pre-validates addresses so accesses are safe without
re-checking later.


-- 
MST

