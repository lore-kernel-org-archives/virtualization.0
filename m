Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E039CCEF
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614259; cv=none; b=BLLjHigk/D4YFFH0HyeupL6FEiVutOvfCCxGiG7rW+OckkHlPxj56nE8lidicCiXZM7f4Pkaakw+bzfceNvUvb+tkW6Qvhi+07NWW3ljjngjYWcnHNEf8uH8IKm4Mz1qOG2biYPvjmEKoxGV2W1bdWXidqy5zgplFX7e/HLPikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614259; c=relaxed/simple;
	bh=vgzaF3qPw7XT8z3S/p3BGnzqBFJxnHBrEI32qQLtUnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BWnu5yUXCMZTgSOGbls8v/6H1KGYe/kpkGiMBRKTu/Iuc/ZfzPUY3f5/YIABvpyrABpxgjQXtJJIQbWpjQ3KbqVrF0Rf448zPMB8rrQSKRPU3aV3UzKhL1TNj9ZCUWWmJgIaXYsWWtFOBix8y3AHoQ8ZpxOxHJFrrfkCYcu6quA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DG2sotBx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG2sotBx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786614257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
	b=DG2sotBxatZ7YW7cIEh/34no3zfxewcIgwXdUK0WCxeoEOapCN491PhZwM1cl8/76Tjp76
	QFXGbh6/vfce9wTYZnFVL/uF/0J/vz/q3QVnUyyLTBl+z6nkIYlWC+wJkYbMT8zWtOX2hr
	Yy0slL5aOCr+ioYcsu6Sw0nVUrp3iDg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-bj66NvXaOr2KtmiryvUOUw-1; Thu, 13 Aug 2026 05:44:15 -0400
X-MC-Unique: bj66NvXaOr2KtmiryvUOUw-1
X-Mimecast-MFC-AGG-ID: bj66NvXaOr2KtmiryvUOUw_1786614255
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-481514be433so790554f8f.2
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 02:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786614254; x=1787219054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8D9Deqo+ItAekvrmdJrfUPwAZJZl2cNIOe034Qvr694=;
        b=jR4WPgUxwrwwO3g1XLcnzaWQSJIBNIUubqJ8Nr80bxUDQ48s/EeOGbyDnlWIymlqMG
         5hNhXUGjiVtNTV2MtJCi7T7C+rQGWLLyPargVRotboojeLfjqZ6mRuEhXikXP9U10f3d
         X8QGfm+hithJMP1W29phov8KOngbmCYMm+Tf6gsK7pv1Lvm8eHgsuoEOvE4OJplkky7d
         SKxFD1tX2QBz8TH2ajFt4M8PLzjFW3iar6nEiBKlC2+CR6RCrtzanhJ7njJQ7XRu7hYp
         dWfJbZcuva7DfcUPcwZiyjEVsTjpIM0Dn4AgOUBPvJhrjsbf3sr6aFhHFUju5u7HQH5w
         bkmQ==
X-Forwarded-Encrypted: i=1; AHgh+RojMb+R4g1cXFSBHDpL8KxYmXzh2JzZBWFQcATGkX+zf+MZNhtFO44eTQKNT56Ak2Wiuh4APbWDe4LGoSd5mg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2nKIhn6dMbz0W+OOrZdP/pk3iVffqneV6HOFN7SCVmWfo0kOY
	3vrhADDZJGa4zD82Ge9BerX3UidsG2ba4tS0SHPix5BPpA08w6ZzTeLRruauCGGuLyC2E5/4zBL
	Niz6z4XPHJz6OR7Ed0tmBcAdf8XQW12frxjqGnYFICZkNBrKK92I4vVYqLnPWj7ylbyiv
X-Gm-Gg: AR+sD110rWoakaPl+/DMNFJ9HDZ2lFa/MGo25Ul8LH8jq61LkMkryp2k7NktJBuSi3m
	I942zmu2FR2YiHRBEgvdIv365Boh8VpeRcsWLnL/aCqhMKBk/+czrKE6aAE1Redpqu2rFM/pWQw
	Rh1WqPclN6u5z8DidPqYOlSJ7Fol+IWOIx9EaKMXjnfaozksHrMz2YEFigG3ez6i7hSvJ9334mG
	fQIjbpVfgjCmIh/hKkd6tGvTeFQYTJ1fnhauNZgnwN5NYUhLCUDRb7Lffm9N458+ZT08gphxJXA
	D+KFEDJalDlrHx9KD3K6qCbuFMVKn32iN+WiyZE5u7jbZyZ3HJ9/+3AmnUsXIDtSiCAmxbxE83s
	+GRs3HErkrY2AIau2xwLawnkDtGxDjKIQnaA6AoI23yW9RLpfX+uT
X-Received: by 2002:a05:6000:2304:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-48159fe3877mr5877708f8f.15.1786614254494;
        Thu, 13 Aug 2026 02:44:14 -0700 (PDT)
X-Received: by 2002:a05:6000:2304:b0:47f:81c4:36a5 with SMTP id ffacd0b85a97d-48159fe3877mr5877650f8f.15.1786614254041;
        Thu, 13 Aug 2026 02:44:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it. [82.53.135.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5613e2sm6594939f8f.6.2026.08.13.02.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:44:13 -0700 (PDT)
Date: Thu, 13 Aug 2026 11:44:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Message-ID: <an2RzeZ2zI8mWFRM@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-3-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260810134018.143973-3-physicalmtea@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: W_9LM2pk-ILeK4JJiQlFkqyVhl2LVZIVTagfASB8U6s_1786614255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Aug 10, 2026 at 09:40:18PM +0800, Jia Jia wrote:
>VHOST_SET_FEATURES is also used to update logging while a device is
>running. When ACCESS_PLATFORM stays enabled, allocating a new empty
>IOTLB on every call drops valid translations and forces avoidable
>misses.
>
>Initialize the device IOTLB only when one does not already exist.
>

Do we need a Fixes tag here?

>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> drivers/vhost/vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 7372c22691de..1beae7f5b9a9 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -889,7 +889,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 		goto err;
> 	}
>
>-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
>+	    !vsock->dev.iotlb) {

Do we need to do the same in vhost-net too?

Thanks,
Stefano

> 		if (vhost_init_device_iotlb(&vsock->dev))
> 			goto err;
> 	}
>-- 
>2.34.1
>

