Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474940;
	b=JxBk0JnyAPu5/MiqHGRWnCpZOcVymDOGkfivRc6OPWLo04p/qfWhQt0mA2dIRYv97oKj
	 uf+jcDT6Mu6tZXf4hNPpHFjEuTR3F14gGia5S4d9JjOMukyQYqkEz2MOC28iXdN4sHb1S
	 wUp2iIu0TAnL07HQSK4l2dkWVlfIQD0aZ2EtSN+0BQqS4BNozogZmb+Prc1xeKr60Ua4e
	 wSHeovH8007oPXXH1gDBTdEBjewXL9k9tF76EUVRiIm3oH1/wQvOnaxiCMFX28mkyV4ob
	 DCFXyfFImrHZ9A3zZCytexY8l3uQ7mzrE0s/TJBb3AWCJTRBMQa/DPIZSSAp5kKcb+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474940;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=in0wT3kSv8v4L0CNiG/ZIgaYFBbYCntKXbAs/Vd5cP4=;
	b=et68dbJ65jUzUdpU1lTQwmMa+qXEldVL5vL7DxM/FzSVJ6FxJzrUoEQtua4R1w6TOG9Y
	 gBtoeRRbfmC2RLwhqDp93+qOYObNMQ3DeJcN9670iDV1YRhh+jZSPTxyxUwMTkMeNg6c8
	 njC5Shw6csbkm65kNR2E35iVx7fsrrEHIYyHWZ7fBkT5YOUMUZaqca88Ape1HxSF1QSBV
	 vs3wFheVgDUioee774BB7XNqJJIOE7j1VNRmww9GIEMW6cH9AWd1qE9XV8AiJe9QBaIpY
	 BlD4Ng68bATJiuJhtor9R33EQ0Bzx2I7a3BS4L7BKHyjEOat2mzP8OLRF9s3h0e90kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMuTvq3q;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B119606A8A9
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 09:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B119606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aMuTvq3q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794474938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=in0wT3kSv8v4L0CNiG/ZIgaYFBbYCntKXbAs/Vd5cP4=;
	b=aMuTvq3qIoH43sv+1a7P8mAUyk7hzIxGncQhFZS7l5317fpGTaPqEkVvZk8AEWtDZgKSf/
	TaUUy3y1dNhIVRxz2oO0WwtmwY2WePLpuTTo+D0BoeK6BYN8YQ/YcUyZS/yDPgRp54OsGX
	Tk62qEa3stwnAzxKVZq2EX1rI2opIuU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-sgrQnOssNG-Oc3K_GsMWOw-1; Thu, 12 Nov 2026 04:15:37 -0500
X-MC-Unique: sgrQnOssNG-Oc3K_GsMWOw-1
X-Mimecast-MFC-AGG-ID: sgrQnOssNG-Oc3K_GsMWOw_1794474936
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so3951902f8f.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 01:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474936; x=1795079736;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=in0wT3kSv8v4L0CNiG/ZIgaYFBbYCntKXbAs/Vd5cP4=;
        b=kjEAanDVB+LxEpynwhcexgn5obfp6k34iLtPdF8mMWJ1dqZaPaeCYz2A3hGgtQ6b0K
         NEAozMEEekzFUvrzmaUgZpJhP3ucxv4CHbgUu9KNuDfIVR0xlqYBMQgzS5mn0Zrdq9BR
         oMIECwved6d+dBt39gFVGXisE92ChqeTa/vc1B2c2P6GXle5iXrAWgdAXCJ5RDq0VaPC
         R9wBzWlfeoVlxSM8m4qInFsfLlHPg+5ioo2ankciT6CDb5eF0viKtttPK+w3E8jVs4OB
         bDxulN1nx/lBPLCoieYF8Y1OEru5GbxbpC1QVAorDiCcN4xXD0KogftWU//F1M8n5B5t
         ijEQ==
X-Forwarded-Encrypted: i=1; AL+hErHTdVXR+0n1RlORFR3YnzJS9f90ZM+RNcLc7ADp3n6sn9RUU22mOQXga3G6StXC5pu3WbQ6M9Qs2TW6mho2gA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+d/KuPjLFkhlByX7qdfdbl7yjvhdE5kf21wIHHpAI2kq8qDHKo
	RZXSdtyZj8zK4zWGJARyX93kikxH3N/26A13Ptxz8/bKJA/Mz7YSKWhp2yFaj+yn/QS6tR20KdR
	ifCsUCTeSO1i5CXGDyN9nA2Ok79ce87gVJTLM6woG86dn4HUvtGb2sFrVF6ZenR6D0XoB
X-Gm-Gg: AYBFou3C41s0RnnvKMge9oT6hTF8dQ9FBKynW6QYsIGhFnATomN3VJ2R1s31qkdq/v2
	/RXfgeVEQ0vzkhKpc4kYqWygRlsgzQyWzIwBydTWmGhe7737LGY6IKJU7+eVPfZlIZeZ+JytdE4
	s1OwU+tDioKeD8KZt1GhXDZAK51aELOPJEaIlMtFqi1YrOR+3cxYG+3QTWwiVWNmmrn3Jo17LnK
	VRX1LSafVoaDj6jnAxeBQ5iagLxCsQSZcyvNbnoNDyKBhwLcD3rWjE5t2qn7VMKKpf6jDhT8LUK
	P1glI78FtOErdf/CMQX4SMJ4Y2lyI/I+V+AvMBSwI1GNoimwF5WDRyCIJpsG212N3Bj9OpwWEfO
	I4gGfylH6VBSEOJhdl/yr3YSlY6Lexm4zUFs+9ytFJw==
X-Received: by 2002:a05:6000:4b13:b0:487:88b:4681 with SMTP id ffacd0b85a97d-499c6027597mr7970518f8f.10.1794474935530;
        Thu, 12 Nov 2026 01:15:35 -0800 (PST)
X-Received: by 2002:a05:6000:4b13:b0:487:88b:4681 with SMTP id ffacd0b85a97d-499c6027597mr7970448f8f.10.1794474934931;
        Thu, 12 Nov 2026 01:15:34 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498361f674fsm15808324f8f.33.2026.11.12.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 01:15:34 -0800 (PST)
Date: Thu, 12 Nov 2026 04:15:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vhost: set dirty log bits without pinning pages on
 x86
Message-ID: <20261112040926-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: HSHeccLv3Lf80e2FHJJqAzczkIEvC-a8zMKmyJn2pE0_1794474936
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

Yes we wanted this for the longest time!
But can we use the nice scoped_user_rw_access API?
Something like:


        pagefault_disable();
        scoped_user_rw_access(p, efault) {
                unsafe_get_user(old, p, efault);
                do {
                        if (unsafe_try_cmpxchg_user(p, &old, old | BIT(nr), efault)) {
                                success = true;
                                break;
                        }
                } while (--retries);
        }
        pagefault_enable();
        return success;
efault:
        pagefault_enable();
        return false;


maybe?



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
> -- 
> 2.43.0

