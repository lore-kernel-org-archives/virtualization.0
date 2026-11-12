Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478215;
	b=jeHTri2U3W4tX3W25HIi8eA9O9l3d5OSHhvPkcMiHTYBrOyB/D0dhL9q/GGsZIoMVpeX
	 jbFOyGy8pMvEgeI54HB0hv8BogvkuQBajBwonD0SkuRrEZGqR+8eUmobqmme4nFBicCpR
	 AaeWYAYw32JtG5YOspvcC+heyUOpETCpqptbwAdF1MMXYRshJLO/WyhB0SfaWJoMYQ9/9
	 +iXbpgOxOqJ2FqPCMQOF6kDqfoyaM8xS9EYAZTzMibUwYmHFWilnc+scdN2XCms/jqaY9
	 ER6wyPs3O75t9vfcmOYkmpKeIHfqITjYWzEi3mzjI8MkW4JeTYbaYHcK5FScfw+LUOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478215;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
	b=W4G+F2GWV7X1OFC1/dFsnIUo01VJ6mr3jLltV5vPj5gq12gdSooa3sIITmwL4VNutfjE
	 58l2Q4xZgbZaaqIoyO7c0Pe8hXzQgqRijTNvVZQKIOfqDwb+5Wts2CFhFAP1ZdOepPgUx
	 WE3t1XFX+riWst9GQZ2zmtj9yP0VFz3kYlbDRmHiNQOuInRPDBImMbNGXs6NKqSRDenP0
	 C1LFoLnZNZqybu+VCQHA2Vf5hnhe/sjYMH6b2L832SBepIUIbmxbLmUK2GD1v+scqYsU1
	 VY/tJfD4rtFeAZB5/+QoYQhomboYaSLFy3xNNDXMQD0+pjG114FnvDvAL1uIGJXp2Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QQrBqtsI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A787D606A32A
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 10:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A787D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QQrBqtsI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794478213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
	b=QQrBqtsIUCFfSxE0LtH6ciVAJuzh0yx3iXtu8OdcCyy1Z4D726B6PeM2lDMXz39IkHIR0q
	eHK/mfbPfh0/rD6JBOoMBU2VVnpk871lVkAUWF8ZSnKASb69cU8eAmdRZhMxXt0yb+24pG
	Ofk5HGFZkwh9G3llc/8kaWQoSmKMYZo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-x2FDc0rmNoKpK_lIPBWVgg-1; Thu, 12 Nov 2026 05:10:12 -0500
X-MC-Unique: x2FDc0rmNoKpK_lIPBWVgg-1
X-Mimecast-MFC-AGG-ID: x2FDc0rmNoKpK_lIPBWVgg_1794478211
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b64722b5e6so45192515e9.2
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:10:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794478211; x=1795083011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dZQUAiljUbxO/eu4TRCEfrOqVOK81+mbOuXnFblvr+8=;
        b=q6vGubu/1NEbIRWRb0/UrianV2FirZ7zN5cFg+1p+EWcFO2WhS3x/H4gT+kVT+LKHa
         I1qojdd6FgsqTHuruTnENEqjHO8vtDnbQ0Jo61rTLzXZlULIZje4rHON2UIZmRkceTn6
         k8uKCuinHbfH7t7Aqk3ZSPgL2T5CIt3bbSLDiItihXCPmfd2/qdLGtiHvgdXu33SwSeP
         uP9BX04HuatqmwzGkYTcMqgRCEY/BVyRV5y5N67QQEIDamFMA9E9TQu9pxOb3R8UBYUr
         cBwFaGzN24tIfS2eywq7iKGkr5sdy5H+DvIoh37pa+H64a5CMa4qfEXDKW/9XJrjfLxn
         rYDQ==
X-Forwarded-Encrypted: i=1; AL+hErG2KnAHzobitAe45k4ZPLcSpEcheU9HN4RHd/mk2hSQKXxWMSmVdpWUOW3jZVRtAnzJr08SyWy0tsRNpMGmNQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8CpldgD/MLbQNJRTf1MtZjBM74b/xy4RP1QnzPix5JZaYIoafL
	JRmSUI25USm0NnM26AzAt982U8rsadsp/OCI5c5kVE5qSbvwZf4PzIMjnczngbNb8mggRzF//Mf
	Nk45sDjDdi4WiBmT6znRSm527uobf3o5iPJeKDQgv7iOoMwumcPXf9sOR8S00+YnsBKYpAFk0oz
	ZM
X-Gm-Gg: AYBFou3HOMwjGKt6jZ8hCROzMESYbg8E0HY/QgfYrg0fHk5Xs6TVjqMxD5WTGXSELiV
	IbtzEuyQIAngeMIcnQ+qH8G2KuNPkTskwGnYN8PFCvPeCCXLescxhfIQ64k8LPOm7ufclAzm7W4
	zuQdWxdYifuNqWjAp0IOxdwaqEQv6NwbncyNEg4YAWwtbJ+vWKpk3wVufmXmF1kmSJhd+ElwneF
	06KJhrXTv6DbSk+gNmdCjerotgxeCptaW8VSgNCX4zm7cZLIrhKsZB2UbA2NMVtTlxg5yJvuE+P
	+BWpVir0wHKjAMiBMt91nATcTbBpdZ8T3l//eNk3JYVc9Oke8gbvGK3pJQzptmVzTHsjAeJp7X6
	NnOWjTJZ4EH9E7oLdLmgGgPEKFmBwHgwkLVLFpOlpiQ==
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4ba0939815cmr87754445e9.34.1794478210578;
        Thu, 12 Nov 2026 02:10:10 -0800 (PST)
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id 5b1f17b1804b1-4ba0939815cmr87753625e9.34.1794478209938;
        Thu, 12 Nov 2026 02:10:09 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbfc6sm16943454f8f.41.2026.11.12.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:10:08 -0800 (PST)
Date: Thu, 12 Nov 2026 05:10:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112045853-mutt-send-email-mst@kernel.org>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
 <20261112085631.128819-2-zhaoguohan@kylinos.cn>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261112085631.128819-2-zhaoguohan@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Feb-LT8hmOQzbY2XktexB5kA7JjzaJQ3FlBXM-o3e84_1794478211
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 04:56:30PM +0800, zhaoguohan@kylinos.cn wrote:
> From: Khan Zhao <zhaoguohan@kylinos.cn>
> 
> set_bit_to_user() pins the log page with pin_user_pages_fast(), maps it
> with kmap_atomic(), sets one bit and then unpins the page and marks it
> dirty. This runs for every bit set in the dirty log, e.g. on each used
> ring update while logging is enabled for live migration.
> 
> log_write() always passes a byte address and a bit number in [0, 7], so
> the update can be done as a byte-sized cmpxchg on the user address. On
> x86, try that first using unsafe_try_cmpxchg_user() inside a
> user_access_begin()/user_access_end() section with page faults disabled.
> If the access faults (page not present, read-only or needing COW), or
> the cmpxchg loses to concurrent updates of the same byte four times in
> a row, fall back to the existing pin/kmap/set_bit path, which can fault
> the page in.
> 
> unsafe_try_cmpxchg_user() is only implemented on x86, so other
> architectures keep using the existing path.
> 
> On an x86_64 KVM guest (i7-12800HX host), a synthetic used-ring
> workload with logging enabled went from 243.60 to 171.11 ns per
> descriptor, averaged over five alternating runs. This is the
> end-to-end cost per descriptor, not live migration performance.
> 
> Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index e29f154706da..9c3045504709 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2527,11 +2527,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
>  
> -/* TODO: This is really inefficient.  We need something like get_user()
> - * (instruction directly accesses the data, with an exception table entry
> - * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
> - */
> -static int set_bit_to_user(int nr, void __user *addr)
> +static int set_bit_to_user_slow(int nr, void __user *addr)
>  {
>  	unsigned long log = (unsigned long)addr;
>  	struct page *page;
> @@ -2550,6 +2546,50 @@ static int set_bit_to_user(int nr, void __user *addr)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_X86

Wait this is x86 specific anyway? So let's just implement it
properly, why do we need all these hacks?

I run a quick test on this in a VM, feel free to reuse:

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>



diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..3ed49c91a7434 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,23 @@ _label:									\
 	__ret;								\
 							})
 
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "btsb %[bit], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [bit] "r" ((unsigned int)(nr))			\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

