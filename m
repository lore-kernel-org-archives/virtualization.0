Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFB20B02
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815272; cv=none; b=j4AYu0eVlCLmUsJ/v7d4lDLTCOdp+mUyagqKCUEZAMGBwCL6SEDKUdw6KV+wF6ZwZ+Z6BXtMZoZnN6mRqM6Gxq5zzjal/Gv7nB/op9do4IuvVRKKHQ5cLFs7rbhcjPlwxa1Kf5zOnfvGQkdNhLUfBmQNvn/Updl2LN6DVgYfbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815272; c=relaxed/simple;
	bh=ybnop7dbPwRnees4BYoRMUIBLz2OAtisOjmESPrNXtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p0t+s3+7UWYWTo0DSNUzYbAmzZDhmVFsL3Me7XEGmCLjBxroSVIDGOiQRF1m8D3rscxZI3d1c3JzJK1JFYnyVtoaNXa1uiNNtub2fxqBsndreqbcWXfnqU6+7PfijI2VPL15x/A9y1y0MEkoMPZeZqf+8WoPjRa1/2uSy2l4OWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KC7v7A8i; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KC7v7A8i"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D609B60B03
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W67D9Ff6B9rb
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 09:07:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F29DD60A71
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F29DD60A71
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KC7v7A8i
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F29DD60A71
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707815268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=varjZjBxBFqiVHNuiFV3KRQmhIyNRarw3ydRqMvY0A0=;
	b=KC7v7A8i33AQ7dfJq471WVLW3CHY4g0MmYefgrjSvhyqxVAsjrXGQeSMb/EI5m6TEfxd6e
	RmWEhw3GIyEJ8yNtmWvrv0WdjNIRbqHItjR8Dug9WDGF2cLqJ7p0SASmiIs00/+4YIzRwQ
	t7bMOhpB913nZU2EtbFTngoXpQBT1Aw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-g2Ibnr_CNZ6Uuts3dUWqbg-1; Tue, 13 Feb 2024 04:07:45 -0500
X-MC-Unique: g2Ibnr_CNZ6Uuts3dUWqbg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a388c223625so186180266b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 01:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815264; x=1708420064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=varjZjBxBFqiVHNuiFV3KRQmhIyNRarw3ydRqMvY0A0=;
        b=Io79rNX8mYloswCUP9KOU/DVVNPh2nIYG0wGcQZTfFJq/b7PMPPwzXiKpkjHMmiMgc
         h4O45dyFPDrbOc74Qr6TYZDz+yBC5qutyncd8qTfa5tImi+tYjFZ4noLzU8gfwEsB/YY
         9b0202cQMOMhOgkusB3vcjbd3SrJWXic+ebfqefoDiMFg8vDhC2p3vPyECDVll1SizTl
         HGHTLoBi3qL8Rk3VK3arC5WUfpgBhK3yEVcYoTkXimdgy4v/+ajlTCrtt6bj6yW90ty9
         8tN1Jh7x5gt9amM5uaUgIixz4G+fyF8iScGXrVc9JGYOrMKgDb0BcDkNj1F8XvdJMnS0
         svZg==
X-Forwarded-Encrypted: i=1; AJvYcCVgnnp3UcX3L80USLUT+3muod3MINMQcL2mO7FLRc3WrmURDL4Zxyk+GPVI+5QDe11mPQzHZvtGRB1/XIiJpYdb7ot/AWXD2uB2hYVTAHJq5Kmmzkxv7cjKkw==
X-Gm-Message-State: AOJu0YxauvFPPt5/uIW+UXiX36fcgz5E6VL4P3JOmU/OEDc0ZCipJ1Ar
	dPQ8KqugvS5najXT+XU2yOtM8MZLkz7f/pBdndRV93gnHCnioxLqTtFyugdqneNcctqZaUBgEgp
	OcCKWSuPzgqGbx44261N9JCAMzfVkOr0CKM7YJxbs9azaa6BRXnTI91D5J1qZl+dJ+ApH0Nfsjh
	sD2cI=
X-Received: by 2002:a17:906:5a92:b0:a3c:9d1a:8dc5 with SMTP id l18-20020a1709065a9200b00a3c9d1a8dc5mr3568433ejq.63.1707815264367;
        Tue, 13 Feb 2024 01:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/xK+Aor/xzZTH8ME0aRC9uoXcmBdxOZhpQPgo5eNwxfgfoP2CKnpOj1sxDSyFQjvppURq7w==
X-Received: by 2002:a17:906:5a92:b0:a3c:9d1a:8dc5 with SMTP id l18-20020a1709065a9200b00a3c9d1a8dc5mr3568406ejq.63.1707815264001;
        Tue, 13 Feb 2024 01:07:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXxvJmPUdeHNhcIV56A+eFY+jIFHXqBuVrnXrw1vzKVCoicf5DD7YBH2FP/A75tPGUjqR+Bc7XZxFsYsZeq0HBoO9Z0tCIO7k3EOLK7Rl3bi2ETScxzuLVtCBJnX3e+hJlelVaztSoUjWIhiujpMwgrFJYAVTVbhAuD9h4nK8+Qa9yOlIrhcgi4L6nIlbe4ExdIO/Glr2sj0sGQ0AdFrmnLWj1QJTyzoyL39rGoAVKf6P5LmQxe4NxPIURm9wuOYcJx6pnp/UaAWrUVKxMf4He4d7A5BK1KcuvGNcHh16VSgmMvr1WDs2UlPvaBp6qNb03Ks8prSMV4bnZE6DRU+xOIr0Jyu31lfSci5aDKPE5sB258A8v+eetmK06xPCqZFYiUwkTWjnhftymBZcIEPA==
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090634cc00b00a3c838b0f1esm1091205ejb.31.2024.02.13.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:07:43 -0800 (PST)
Date: Tue, 13 Feb 2024 04:07:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>, jasowang@redhat.com,
	perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240213040658-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
 <875xyska8v.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <875xyska8v.wl-tiwai@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Feb 13, 2024 at 10:02:24AM +0100, Takashi Iwai wrote:
> On Tue, 13 Feb 2024 09:51:30 +0100,
> Aiswarya Cyriac wrote:
> > 
> > Fix the following warning when building virtio_snd driver.
> > 
> > "
> > *** CID 1583619:  Uninitialized variables  (UNINIT)
> > sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> > 288
> > 289         break;
> > 290       }
> > 291
> > 292       kfree(tlv);
> > 293
> > vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> > vvv     Using uninitialized value "rc".
> > 294       return rc;
> > 295     }
> > 296
> > 297     /**
> > 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> > 299      * @snd: VirtIO sound device.
> > "
> > 
> > Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> > Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> > Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> 
> Thanks, applied.
> 
> 
> Takashi

Why did you apply it directly? The patch isn't great IMHO.
Why not give people a couple of days to review?

-- 
MST

