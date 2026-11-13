Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577906;
	b=vVZM+s/aggnbTLd1TNpeiKkc4yIPZw/aFSONkKDeVXJ1Uuvq4KUONrK6MYyh5zPBCAnL
	 v9KOwEwyLfAKw1AbXeQWUHzp2yjcy3phNhmHSIYvMytVZdOj2bCgX3fA+3v3MklH43qdc
	 u1vDzhyDhLulcaMs7+GLfwpv4aF3Nl2aIwg1X4Z+rwP3Kxqo0SUJtOGwx286kEL3MfLGx
	 8XDNIfgry7ub4ewR0QZFrkuaEbKcejpRs5r93FA6jgwGvMtNkopFITS/QeaglB3OWLAM/
	 PYACvlTSmPqofbgePcOeuokJRK02YzdBaZaE5p+LyG2NMC84oNVGS+bo/nmOvZSSMYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577906;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
	b=J6bzProQQZWu2WdgBVGd3ehubbFsNCsl9L3VwuSsKWsuQ1LwUczTCAyFQJqfeVq+xNWu
	 H/LuovdqLrwf2DW4pR3UzjRw3+0hk1kesWZ8Cwz/A2LLBVpebiC9gy1gcCkw8lHmJWzrg
	 pP9uhLK004jk0SKtQDNleRR1fynCrujnXIc6AKHeeXm+F3EQZfAifq18DuIja5ib6qRap
	 z5WjJardUjkIIPMEc/KriuwR7yDSSFD6mrwkHjYdCf/HzCFBIzKTrNk/0xN+reAJGdjt3
	 3gG9nixJsWtAwSFlqmn5VGQRsGjvUXGPAsDpDmqFQjtyev56TIG97Rnd39+QafL2f1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PquMVjty;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FBD60A5BDC
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 13:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3FBD60A5BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PquMVjty
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794577905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
	b=PquMVjtyZGfGYCr47ArvAw10Sx6XB1xjzp0Gz0SxHI8qWIFs80PQfh1xTcp4QHWjyKVu2g
	ysiGasak4ZP6CZkD9riBMfdwJ6fkwRcbc/cmQa9nrDb/CSlWsAJ3FGmmrtlZkFxNO+vfCj
	vjUaX5eIoNlUZBmyfUDOniWrUznGHQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-JMyuN1X3OUa0i2vNk0Mddg-1; Fri, 13 Nov 2026 08:51:43 -0500
X-MC-Unique: JMyuN1X3OUa0i2vNk0Mddg-1
X-Mimecast-MFC-AGG-ID: JMyuN1X3OUa0i2vNk0Mddg_1794577903
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ba078f26f4so5976255e9.2
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 05:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794577902; x=1795182702;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nzwVW9fNWfGXZUemLc1dTW/hhZ3xpHtCMfznCyx8mPI=;
        b=LbsFXcavKNs+utZRXYBJamOEFNSRgIywQV5gy9GaU1ZuuS7sZKbJiRBnEzksLdrCF8
         qozfz9fBSdO/MHOXzYFe05HzS0Bz7FMax85472FDRk47rVnA+sJroet7z0+z2zFOeg9q
         dhtFfAyS5pqEem8ZnYrdFeFUjSeZ7kJSI1nl+q+ls9cwsnvWc1ChYDwo/rkTGXs1HiSf
         P6/GNxWTOs9k33ev7OxtyTCvbZsrUgmwKcDefTsra3ybxx/ADHnb6VzkrvQoB+lQgknR
         zHc70Zc30G0CECtJiDyT1xIMpD1hsKcZLKSZXf87xQkpW1WOOxkBIBMnKIW0us3/NCPG
         spQw==
X-Forwarded-Encrypted: i=1; AL+hErE43sA7hHqhpp3O/C2Ie5Cw+l84RtEmeJNS1wUCM3cBnPG3kfUptXKw2IKul8Dnqqw7wTsJwourmuz0QkqMCA==@lists.linux.dev
X-Gm-Message-State: APuU4Z892fxwsYOsspn11bgfyj861Z+I/IvnlM49V2yRHCLSLL/fDTIC
	w8sWwIhc5JirQyeBVlgxQkgw+LVrjwOiMRm3hpVl67ZXBIfpFQ7/8UDyCUSiFkkyFfJj1D/cOfh
	80WEX33NMwBB7Oph/0fOrVSE+fmhxf/MlZBqYjWmBjucjf5b/+56E13Gz51DntulooCeg
X-Gm-Gg: AYBFou1rsthmQemVD6/V2Q0MZIkFnq87gfSDeULrrLBcJN2TkaJ9IJKJTjEpHBGYvsi
	mQt1v8y+/fklEQ2ILI6RuPKdndLouTPl6naD8I9YCi2Kq0pGogsZrMmv33srS+hbFXKCTRET0T2
	mzDB2WPLtKujke1cqSBza1LZ0EFfC+zvxm0Iqf81L0vC9EXHxwN2e6Z6GcK+1ZZr1WugRSEOBKk
	IveZNnk5aZjYNKN3JWBcM+MajGQYrbT7VdN9GqxTUZnaPo3UeOwAS5C0fh308Dzla0Ov8mmq0Rh
	i6xUk+DlwoCqizeeIacQ5ZAPF++2/gtgDhy/qhSKDJN+bxiVq6dB7ENFcpc5lbARkVxcjxMi6kJ
	8Dtr14Jt/eNwEOn3JR86KijZdBjLcASClTWRIGPKtqA==
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb55a3e3f0mr51424305e9.9.1794577902447;
        Fri, 13 Nov 2026 05:51:42 -0800 (PST)
X-Received: by 2002:a05:600c:c16d:b0:4ba:495c:2f5d with SMTP id 5b1f17b1804b1-4bb55a3e3f0mr51423795e9.9.1794577901867;
        Fri, 13 Nov 2026 05:51:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5667a8aesm42328895e9.1.2026.11.13.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:51:40 -0800 (PST)
Date: Fri, 13 Nov 2026 08:51:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: bp@alien8.de, dave.hansen@linux.intel.com, eperezma@redhat.com,
	hpa@zytor.com, jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	netdev@vger.kernel.org, tglx@kernel.org,
	virtualization@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261113083351-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: dkLaHNlTt58rK0d04kc2stPr866HN8nxYjJsGaDtxCY_1794577903
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
> No access_ok() here. vhost checks the log range when it is set up and
> I couldn't find a way around that, but GUP used to reject kernel
> addresses by itself. user_access_begin() would keep the check (and the
> nospec barrier) local. Something like this, build-tested on x86_64 and
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


So, you were right, it's better to check access. But I don't like
paying nospec. Let's use the modern scoped accessors?
Like this maybe? Very lightly tested, no time today, sorry.
If you want to use it:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..0bffa43e02179 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,28 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = -EFAULT;						\
+	u8 __user *__p = (addr);					\
+	scoped_user_rw_access(__p, efault) {				\
+		__err = 0;						\
+		asm volatile("\n"					\
+			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
+			     "2:\n"					\
+			     _ASM_EXTABLE_TYPE_REG(1b, 2b,			\
+						   EX_TYPE_EFAULT_REG,	\
+						   %[errout])		\
+			     : [errout] "+r" (__err),			\
+			       [ptr] "+m" (*__p)			\
+			     : [mask] "q" ((unsigned char)BIT(nr))	\
+			     : "memory", "cc");				\
+	}								\
+efault:									\
+	__err;								\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

