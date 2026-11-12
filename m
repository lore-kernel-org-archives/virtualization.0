Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479568;
	b=sgXa+HEehPBx+bvR5kyYMfQDU+Op8bRzYP4d8tHnZUxej5YUUTzJ/CUBmb+rT85zW8qy
	 UOUE+a9NFlR/13P6I9Hjlr7DnR8QXYUIfA8iJlSt6nOd3mj/+p8S1AtMUPqt5GCYletQu
	 IoC7+LlKA3ctPLfUarjobcgqdIBALdRCq+/tvK5d9Ft2L16ncmuFkjMJrNS8IU14/KjYr
	 /JYkZwjyb1dDe1hECAZa+izwbjYiI8JEXkWVG2UnRwTxLz6UtfQ9YKifqwqF4GSJUd/el
	 azxHKao1XOg8C9I3YvikyzsePWiFv+oa2Qd8xhYXBsz4RNdiIe3nc8lpxwnpwWWy93w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479568;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=UL9CkfGicYHskzbB7QLYGJW2B+YLZ3fPF5rU/gdSK84=;
	b=25lOL7gTUmb2NCV1i222RcipgylcAsk+SZuF2nfTN5AeLmMYaMrC5FUIeX63ptlhhwSJ
	 GazmvntDbKLRKTNS3jMQfckunF98k7v8mBPLtSVpQamzdWPrVquAxNyL8X52tvTI835yT
	 pbJvIZDyZ+zZkJeavY+U286XVyUnVzi2NXgvtEW9RmYY08NbvvdpXf003Li1KVMbIsM/0
	 Z9rRh0Yvfk64Ey2Yi1sJH+6OtcGDnLYyhIAr3XWxW9aR3nEn6dKWIQdH9ggBBf7gRu02h
	 zqSAGvnb+VCLyd7ZKEh2B9doyBYXTWF6fnPBz7ejwFCAFwrWAfSUG59O3vmsTbDLd0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CAubyWKD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94615606A889
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 10:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94615606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CAubyWKD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794479566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UL9CkfGicYHskzbB7QLYGJW2B+YLZ3fPF5rU/gdSK84=;
	b=CAubyWKDhOVaXpxgdKED6gXaSlOGaZOEN8Z9aGo9WQG2jupCh8MTCPC8tfggLGgENAh7OC
	CCAUyf0DgwCR57Ju1B7u0+Buqs9A7Y8+4UbC2ozrRmXh9RWJZcZOQKPqk+gDj/dC2BOLpY
	n0crpWVMYfDseiqGckreyxA8OO936ik=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-1wDuQiiOPaiNpywvgCX2PQ-1; Thu, 12 Nov 2026 05:32:43 -0500
X-MC-Unique: 1wDuQiiOPaiNpywvgCX2PQ-1
X-Mimecast-MFC-AGG-ID: 1wDuQiiOPaiNpywvgCX2PQ_1794479562
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0461e040so3150723f8f.0
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794479562; x=1795084362;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UL9CkfGicYHskzbB7QLYGJW2B+YLZ3fPF5rU/gdSK84=;
        b=eEVn+jHHBuiLGDPlvbajTSXtPrRHPWkq98LBeUu4j7C6e/9UPAwlyXUn/SVnunSu+E
         xs4omypXkqwU7F6PWAPH8OPoYRSsynCCmAL7/y03Atz3kWh2PCq5arceANsFEQPV4u6S
         WwuF3D1TE1C4rBa5tvhTYfK3Wm1JcX16E5zPGQdXVIi61IPlHvEycClvhWtVs/sO66gV
         ddujE+UKg4UAImyeXy1t894bbn+YPuq7XJ+Lacr9JgxwqmvMTqbeZgS0bz6SYny4t3Zf
         vc6Fi9up+czZHXvorm8qIWZlkbPr18b4pBwUW+s3YkGj9m9HEAliIX6dFT47C0lFqX1R
         /ibw==
X-Forwarded-Encrypted: i=1; AL+hErGWqXm1z7SA7EZnVxmCxBeuQTNkbIFN6JSLOIc1UMdgfa/U3zPsSUVVT+q4yuqbMRRF7/d/J2HKq2N1HElmnw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/EPken9P/7pezxQkhLf+YnXYB2wDGOCtwtn9Yn6w2sg0UR1znO
	4mmsHCN0ofksfg5UaQY6dQP5+Qx1JFp2hDGSX2MN0kAG2LrKBgWENFiWbCzRbPGFQIeNMAG3rrL
	cCbUUpXvSWGsYMKxRysGhPVesypVUXSsL7ARvgmQT3zotCWCpXKRohf+Td3L61zodHMIj
X-Gm-Gg: AYBFou1AfxsaibQFuwlY2hPHo9XiJs2lbp9AE0Z92oUZOof3m5ve7tmKToSNmXFfc3g
	ZP0QUcFBBJUIUqE7r02hVrHuPWecC1Vp7lFdu04CqNcewHtUBMwuhoILo4G4Zbo8g42scfU+GW5
	lnvFvVcDOuWqr4asnrSfBjvKPcsA1A+OU0j2YIkGp6iHZEeIWBc8G3ltzkblB90lek2xJWA6u3Q
	HwRyxcPHwbbnicLH6rrW1y0bfXVa/hC4vJXBAlAB/hh0ywwBl/N5BgS/w0lmpTBmihXqCYiSNUX
	Aup8ZmlX5UnMNi4t+XJn9QB4oOHo+GrVFJjY9gZ1PznBStpaTEGlFlWAO/Y5oXR5lHXCZLu9+nm
	0y1QGsC8pMWhkaGy66fUlDtR2rNsrLw8zaJ9k3EzaVQ==
X-Received: by 2002:a05:6000:1861:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-499c68d2bf7mr10244180f8f.18.1794479561848;
        Thu, 12 Nov 2026 02:32:41 -0800 (PST)
X-Received: by 2002:a05:6000:1861:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-499c68d2bf7mr10244096f8f.18.1794479561175;
        Thu, 12 Nov 2026 02:32:41 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm16325613f8f.28.2026.11.12.02.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:32:40 -0800 (PST)
Date: Thu, 12 Nov 2026 05:32:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112051259-mutt-send-email-mst@kernel.org>
References: <20261112085631.128819-1-zhaoguohan@kylinos.cn>
 <20261112085631.128819-2-zhaoguohan@kylinos.cn>
 <20261112045853-mutt-send-email-mst@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261112045853-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Dl3YLbkdTX1_34Z-BteWaT61z08b1H66eEmUy6hQndo_1794479562
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 05:10:10AM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 12, 2026 at 04:56:30PM +0800, zhaoguohan@kylinos.cn wrote:
> > From: Khan Zhao <zhaoguohan@kylinos.cn>
> > 
> > set_bit_to_user() pins the log page with pin_user_pages_fast(), maps it
> > with kmap_atomic(), sets one bit and then unpins the page and marks it
> > dirty. This runs for every bit set in the dirty log, e.g. on each used
> > ring update while logging is enabled for live migration.
> > 
> > log_write() always passes a byte address and a bit number in [0, 7], so
> > the update can be done as a byte-sized cmpxchg on the user address. On
> > x86, try that first using unsafe_try_cmpxchg_user() inside a
> > user_access_begin()/user_access_end() section with page faults disabled.
> > If the access faults (page not present, read-only or needing COW), or
> > the cmpxchg loses to concurrent updates of the same byte four times in
> > a row, fall back to the existing pin/kmap/set_bit path, which can fault
> > the page in.
> > 
> > unsafe_try_cmpxchg_user() is only implemented on x86, so other
> > architectures keep using the existing path.
> > 
> > On an x86_64 KVM guest (i7-12800HX host), a synthetic used-ring
> > workload with logging enabled went from 243.60 to 171.11 ns per
> > descriptor, averaged over five alternating runs. This is the
> > end-to-end cost per descriptor, not live migration performance.
> > 
> > Signed-off-by: Khan Zhao <zhaoguohan@kylinos.cn>
> > ---
> >  drivers/vhost/vhost.c | 50 ++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 45 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index e29f154706da..9c3045504709 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2527,11 +2527,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
> >  
> > -/* TODO: This is really inefficient.  We need something like get_user()
> > - * (instruction directly accesses the data, with an exception table entry
> > - * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
> > - */
> > -static int set_bit_to_user(int nr, void __user *addr)
> > +static int set_bit_to_user_slow(int nr, void __user *addr)
> >  {
> >  	unsigned long log = (unsigned long)addr;
> >  	struct page *page;
> > @@ -2550,6 +2546,50 @@ static int set_bit_to_user(int nr, void __user *addr)
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_X86
> 
> Wait this is x86 specific anyway? So let's just implement it
> properly, why do we need all these hacks?
> 
> I run a quick test on this in a VM, feel free to reuse:
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 

sorry fat fingers. wrong file. this one seems to work.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..ba1e7c3f83c8e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,24 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [mask] "q" ((unsigned char)BIT(nr))		\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.

