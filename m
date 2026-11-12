Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477062;
	b=hxFSEW1cBceS59wx/Z/ksTGWm8KATTb4V5J905aPGqTFpLWP3mymwSHw75MkhNRn+T1l
	 3FVWuK930j5rmMR7OG2BrMaOfvlx1dxBJaVKFox/GVfVnvCp3i3xHwdKbUd9OKKTHFCI4
	 lFIOBCxfkBxNdfp6esz1SnRzChAZYGSOadruqhJVrSn2D0aBd92QdI9joI6su1ATYwF36
	 9crqzwizUGTRMyt3G7OVSSrAiwz7pJqUCAk4Q83ExEbHaMMMLkbK7+aHJfrcOYFa437G2
	 N7eBX4HWiDS8zQbKz84WrEcJ12qlveRqb322R2HrZFUDnT9VIHmw1WlLP7NRNUyw58Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477062;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
	b=quGsXcu9eNsBbhUTLMdgBUZDz7FI7yQ/ryYv5ndnIOY8ohChnpERob39+JkZvq4Ao+Gq
	 SxDo8yBFAtQmZw1g1QDlVab2fH44Qz115Y90zV4dxaEqVaLtgMH6QCxtmEGjy4AYlgBET
	 +0KNxJXlNwCkjpoX523FMioDtvQzLMTSHO65M3psslQJzb1Zs4bbKODxOkQKiN77J+gtV
	 vQfMDAlLLgpOEctcZPRGQsbZdrgsOCWu4o88iYDebDLC/Kjdd1wJsIdstiL0WLVM5848d
	 vAHvuUJbUwJO2/xktu2P4K6E1fOQeAliLDta1SB6iJZ2tn8qUjPBOy4R7ZQONiwzN0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXWiPM9g;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAABD606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAABD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RXWiPM9g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
	b=RXWiPM9glKt8c84teQV76D3GrDKVCOBLB6mn2I1ijFJCQb4OMmrlLDFWCcFqryVtl+9qRw
	S3cfhJCt406aNjQazTVjoMN1ShBkX16QufH020lkNxDnsh6+qRCYZrayYpANo3TONKVu6z
	RBoTMv3PIYpNxhWQR2LTSjOAj9vwT1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-XslulDoKOjykJzaGa-y0IA-1; Thu, 12 Nov 2026 04:50:58 -0500
X-MC-Unique: XslulDoKOjykJzaGa-y0IA-1
X-Mimecast-MFC-AGG-ID: XslulDoKOjykJzaGa-y0IA_1794477058
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so3028026f8f.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477057; x=1795081857;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWjpZTISxAW1ioWo7zAlKfMSm3zMo7GsaFnXjvMiMuw=;
        b=tX9n2zzpWZame6h11QIRJOH8EiMgOf2adVobXxKkksQCvb+wQrN14ffZpGfIcim7sv
         3cDpt42DMasVzj9feSGb3nFyFSito88Qdj6glChi5+hTQoGo3gmy6lVtSsotY6LdnaV8
         wVf6a2HswNXNaVTDtImCy5fr1Bm3UIhiiwM5YP6LTjo9+rRmfuWrab68LGiPvWMHtH/f
         SEfFLmlUCfoIgvy516bSL4pgCpn0KZvgrcKJN6mNG9JEt3SUqO6BT01i9a8k6o1yObw2
         w18XOeZWBXJdxL83dr2qH0ib/yqbP7xlaiURhZ8sVeeINAhjsb64s91papxA4IxznC57
         Oorg==
X-Forwarded-Encrypted: i=1; AL+hErH/XnriWNw08ws75C3Ko5Y9Tc3v9buSVTFIcIBQsG/aj90/5auh5tOfqFjKURQawjRnwy9cbCRsDf4AsE9Fzg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pH/hQkA4wrHGGxw6SCfCk3J/D7QEOHikKlbSYJhFixpDd2pOx
	PP8CQxJwHdykj/I9lLop+mVenjuKjgXuIN0Jwv9qDBvBWGO5vdh0locBgB0XuIppxhi6ZaR9MH4
	RpR+7mRSSVzKZXUB1YasGMAWDB+7M+y1Otfkf7YicxtKIUGjtO59PygGtUybOWCq1GxJT
X-Gm-Gg: AYBFou0n8Uqm0JnpiA+ECN7NKLfsZUUcRRi+uOSgf+Qz0HtdYChiotsu3k4+mGxJlds
	OD+iKeC4adS/PKeN9zM2LPWOMHrccL17lgoKfDGZR2nimh8cizILw5wX1sJLOeSLSvoENB4Z6Jk
	EMfjl3uo0Gt5MQrHYgcWF+53IAf+mlusknuO7yg8wlnP9GuHj79rhIuBo20iB1Ils48uvF3lOjz
	S/5PdoNQLBjQIYLC6Ruf7vVIdwZUjsIeRmhpqyq9C5T5G1MVB8ZEWl416dlIyXxIpxQtr8F/373
	1iGNr+vUvc6Uu5dQkzuc/EkBYAWALA8rwp05Xhczgm4zDIKONNIZ5KmTvVhQqsi9SZm+3SKuylD
	7SvkSocMbWAEYXS+1Zp7Yjt89kDBbCprVzAgw4mJFgg==
X-Received: by 2002:a5d:5f91:0:b0:48d:f9a4:bd68 with SMTP id ffacd0b85a97d-499c7dfe760mr9013239f8f.27.1794477057305;
        Thu, 12 Nov 2026 01:50:57 -0800 (PST)
X-Received: by 2002:a5d:5f91:0:b0:48d:f9a4:bd68 with SMTP id ffacd0b85a97d-499c7dfe760mr9013178f8f.27.1794477056650;
        Thu, 12 Nov 2026 01:50:56 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-499823761f5sm10614988f8f.2.2026.11.12.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:50:55 -0800 (PST)
Date: Thu, 12 Nov 2026 04:50:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112044557-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: 75Pm9g0xjOArP1Pz_ngW7zqpUqdDDyPefnH9aTmWkKo_1794477058
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
> +static bool set_bit_to_user_fast(int nr, void __user *addr)
> +{
> +	u8 __user *p = addr;
> +	u8 old;
> +	int retries = 4;
> +	bool success = false;
> +
> +	/*
> +	 * log_write() passes a byte address and a bit number in [0, 7].
> +	 * On x86, update just that byte to avoid crossing a page boundary.
> +	 * Bound retries so a contended byte cannot hold up the worker.
> +	 */
> +	pagefault_disable();
> +	if (!user_access_begin(p, sizeof(*p)))
> +		goto out;
> +	unsafe_get_user(old, p, fault);
> +	do {
> +		if (unsafe_try_cmpxchg_user(p, &old, old | BIT(nr), fault)) {
> +			success = true;
> +			break;
> +		}
> +	} while (--retries);
> +fault:
> +	user_access_end();
> +out:
> +	pagefault_enable();
> +	return success;
> +}
> +#else
> +static bool set_bit_to_user_fast(int nr, void __user *addr)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_X86 */
> +
> +static int set_bit_to_user(int nr, void __user *addr)
> +{
> +	if (set_bit_to_user_fast(nr, addr))
> +		return 0;
> +	/* Resolve faults, or use the native bit layout on other architectures. */
> +	return set_bit_to_user_slow(nr, addr);
> +}
> +
>  static int log_write(void __user *log_base,
>  		     u64 write_address, u64 write_length)
>  {


Actually why do we need all the unsafe trickery, is there
a reason? below seems way simpler?

+static int set_bit_to_user(int nr, void __user *addr)
+{
+       u8 __user *p = addr;
+       u8 old;
+       int i, ret;
+
+       if (get_user(old, p))
+               return set_bit_to_user_slow(nr, addr);
+       for (i = 0; i < 4; i++) {
+               ret = __try_cmpxchg_user(p, &old, old | BIT(nr), fault);
+               if (!ret)
+                       return 0;
+       }
+       return set_bit_to_user_slow(nr, addr);
+}








> -- 
> 2.43.0

