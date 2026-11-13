Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794550188;
	b=kRtpbSG4NuWXprQ6pR4Mj6GoGIA7W6zUkY0KKJfEUUTkhy8txJF3hsCmcnZX+i+45M0S
	 V2ntBzGo4oHy//3elmZpkqTqtC0fffMv7GOg4oAuXx9DYolu/YwDVFW9o3eLDQ6nRhhTN
	 yiDGSDUx3UyHRfUHGwYVMLDp5JqKTKoBEv0BTmnZ2RiDofK2eVgAHZ/sybX7wrXQzfH9G
	 aF+y+Vx/Xj6O0sHLWco1ciCHSG1PYuh8wptwjPPGkWXTKKZYItkRyOnBpDFnaHGQ/ZQyg
	 FObV5xCuX0l4tqRQMnLhiLX1Bk3kqjQwRX28fXCx9k5/LiWwaFFQD9j0QeLWV2g0ZDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794550188;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=1e0yVbVyaUWx+6t8WP8UY8dzBsxW0lJwI5VYRi8sJrc=;
	b=sVGuD8RvCjC2muRxGHCpUmDlVnj/xTpy0SUrGi/5xE3LWbxMuxwdASDZpWcbAuLu6wKi
	 QZzUGZx0KfbMGa2HIkRAChERY1FkkEFZb4ldQj29AzhDEvHQSXrsavDZLFe7CrdUyIg7y
	 c8o7ZOvGx/GC/qNW1cZI2YHml+QL5Z+RhDPFMX8tjpv1S/rPB3sQOgMl+9AnG1YcuFDlP
	 ayFmY+NNG65IXpT4BROUddIWyQ70PNNk/oq1n8RweitvKo0im3WzjH8I53EpsbB9PyAmG
	 kG7PdK4AF9inZgU7S3iVXD8+gcDRZ7zRIy8byHEbvnCm7pBVkbDqpVe8m5lO7aExNLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ROqGFvX0;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD52606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADD52606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ROqGFvX0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794550186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1e0yVbVyaUWx+6t8WP8UY8dzBsxW0lJwI5VYRi8sJrc=;
	b=ROqGFvX0jM4PXrIdC04TTYHXi09p1TKHOPZhS2h5e5qaPZyL7QKwWWpx83Hu0VDyoFd958
	VDMbBN0jW5aTqLuYo6QoWbEacmtUiufbo0QwL4Rv3UPPcl+Ytk+duvH9VQGWSXksj8XM+f
	Au33r+PY9mNiohTkXQJ9XJP52AEy6WY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-g-Hj5ujiPzquj-JtyHxaLw-1; Fri, 13 Nov 2026 01:09:44 -0500
X-MC-Unique: g-Hj5ujiPzquj-JtyHxaLw-1
X-Mimecast-MFC-AGG-ID: g-Hj5ujiPzquj-JtyHxaLw_1794550183
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4b0a307487aso2273495e9.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 22:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794550183; x=1795154983;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1e0yVbVyaUWx+6t8WP8UY8dzBsxW0lJwI5VYRi8sJrc=;
        b=JfcgouRaG6pZjx47dC6s1C49cCAdOoFMMFH5ijup0LLl8q68IYCIo2meyw5jVItWY0
         iXDtK2/Vi7Z6TQKZMFCbsWVpzCMDwCa7Ho90pFZCF4F+NGN3INQtHWvCLn+G1WsW7m1w
         YgzN7BQBQGfsAp2vrjg3g7Oklq+Tn5fiNHk0W/W3r66GMGrNFU+Kgx5UUzyJglpNCcRh
         LI2+1RPEjy1amZ/z/eosQwgZxARotygDILGvAXwp68ARnGyq6s96KvRPQ/RUie/4WxGJ
         S6jtoepGeRqWRPYeCuaIkV5wqRxMNYcYdzS65yDGHihAfx8hrmYiOpz1Al+rfmnrqCWi
         v2zw==
X-Forwarded-Encrypted: i=1; AL+hErGfHvjgu3mUHkxbnHmFzT0MwxbU/PPikV0p9F6nZH5sYD/NaWS1h+BetRYPJR31Zgni+8PqnscpHXT6xubSmg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8U0Yv1rkRNejrQgWdjBzXsrhLqG+/YbvLgP4MgGQQgEOVRslqJ
	4ZsvRQYWH0p/Kn3EX+9nvkKjtUHKu7pOkWYMZ0bDK7LqMWrSwNqKh+lEekH6Ogj9WOKFoPEv9bm
	SyYbmBBOWFlEBNAsVEVTABeabkowc8vbOSYwF6yCXOzgOv8FZv18pfwoW0Wuqec8PEG2F
X-Gm-Gg: AYBFou3k4Ac07DnJUHiS0jLYjE4LNaivnYBdSRKaHD1kzLvGkTe0HyL1e1kbgu+OuFE
	xNg88m3XT4j73YW7KMCmngYrx9JWIAgjBrKwuchiYzwifMKH6+S4YWhMR+eKQKj+e2QsWnsKQrW
	lCYZg8JnNmHy3cdFH5GPMebaidFHWt+CkPA3HtnzJAKLkKA8rYnokmFqhQXIXW/Bu84aUl0jOgE
	VmJjb7wRbb97Obdce1Ms3ujz/O6gSZptptFvqacgz5TZdUr1b3KAVcr3aWaRiEJuR4sAxt2UrKw
	Bp6wmzUshS2WNBQJhfanOKsG4dfT0NG/aJ7G/0LIOqeWE++e0oEr7nHD68Hik9ZMn1SP/ELthyG
	tG2srvz93Pj5lyy1eUNGvIWeIYcAV28FZobac/vY+XA==
X-Received: by 2002:a05:600c:620f:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4bb55a3e3abmr26930815e9.6.1794550183265;
        Thu, 12 Nov 2026 22:09:43 -0800 (PST)
X-Received: by 2002:a05:600c:620f:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4bb55a3e3abmr26930375e9.6.1794550182655;
        Thu, 12 Nov 2026 22:09:42 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af1c5fsm33039755e9.12.2026.11.12.22.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:09:41 -0800 (PST)
Date: Fri, 13 Nov 2026 01:09:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: bp@alien8.de, dave.hansen@linux.intel.com, eperezma@redhat.com,
	hpa@zytor.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	netdev@vger.kernel.org, tglx@kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261113010007-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: OdiDAE414JYYQPLhfJvt3dDg4G7TgTQcTl187xAC6UE_1794550183
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

ah, subtle

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
> No access_ok() here. vhost checks the log range when it is set up and
> I couldn't find a way around that, but GUP used to reject kernel
> addresses by itself.

just a side effect of the api, unintentional.

> user_access_begin() would keep the check (and the
> nospec barrier) local.

To expand on why is that not needed, but feel free to dispute
- addresses all pre-validated
- there is no possible gadget here, it's a write, writes are not
  speculated
- lock prefix so no speculation anyway

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

