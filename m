Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1D37F733
	for <virtualization@lists.linux.dev>; Wed,  4 Mar 2026 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772603822; cv=none; b=QVSbMsNA0ESOWL43av0lQKK2d/L3eeYYFevXO0uRbAVmMg4umhEfklQHVD9mGpsIxlrY0K8AGzgI6nlBmwGmwLC+nY8Z9mGRScN5YU/FMfVGAjU5xcY3YJ19v9BB/yHBtOhZOCiRBAIgcN1bLS20Ccl7V3ycf+pGrgzlU7FHlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772603822; c=relaxed/simple;
	bh=mKpsoLp5Eh1GFPGnNAL6iAh8qEbQ9K9WP0godDxF0i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmj+1ME4mFqrAlgOhSgnIdkh6OE2TOAVEAZH5rBUyEXpZaJYBIgIyZyojxFYF6oeCQt8kYy2o2tueRZXL2BI/CGYH/nYJenzLCX0dYVCF+p2ZbAZyLh1TuaDIqrrXktRHlvBP4Io9m3fKgMu/jivuH9oJRNjNadhqecCRtFDvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBeGYII0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBeGYII0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772603820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKpsoLp5Eh1GFPGnNAL6iAh8qEbQ9K9WP0godDxF0i4=;
	b=PBeGYII00aygu3sUFmIl+Ua04pq4103lVhgWTVUzLVdryr1QzAyUYMDRr1np7gtHcxp43x
	bNjO+2MGW2/4BiWTLMWIZXXiNH/3tG1XFgH4zg99y8Ew3zcxx/saKAVrLYyFBmtDyOd7RP
	jBDB1BNuciJORm4Pb9EFMjDMNUWOHFE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-xk6xx0KdMPiwWEuS3W-n5w-1; Wed, 04 Mar 2026 00:56:58 -0500
X-MC-Unique: xk6xx0KdMPiwWEuS3W-n5w-1
X-Mimecast-MFC-AGG-ID: xk6xx0KdMPiwWEuS3W-n5w_1772603817
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354490889b6so22931973a91.3
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 21:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772603817; x=1773208617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKpsoLp5Eh1GFPGnNAL6iAh8qEbQ9K9WP0godDxF0i4=;
        b=BBAC77h1S5Hw1F66hVN9PawQSdHcEs9z0ooLz/0QYIjscJrj7h6n6UHoPan/L9VKx/
         VjHU2gfs8laD18VyEX2+EXTDQM8y4GnxJYWDA9usebHFkfFvnmCpnxxWwFNNquDHNn+y
         5VHZw863a8Tqbv1fe8Nl2CmasDdKPn9XVMuORa6VxBVPWgCXpRrmK5uOk+rXeW87BXyk
         jc+5sas+yowP8i9q+XjZWU5Fh1ms8M9jReS8U8wVYfHqTYg94UkCj1FL7bY3WoBKVlOw
         JNJiUynp1hCWsG48sU+CkwtkO0Jo/UkRVwnVMp/mLVIGEHEP11xw2sZ53a2nrLBXdN64
         mkQw==
X-Forwarded-Encrypted: i=1; AJvYcCWoVbiBTZSaAQoj+T9MeLy6pQFYewaJik06k7Oj2Q9CEaFEtWyZdGjqbf4dqhn9+U1y5fpfUozr2VXcY2oU1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2h2kiwziYhTPXNpcGVC0rxPkPBy+w4k13GwIbSZNx2SfIeKSp
	txoC224Fq2mmNjE98bL+YyFJGvTcvx38mkA2+5rVUfeWeg0+DmIi1yk+hHmSYkXFwNwcJri2Z1k
	v/2DSOoQV6ONmBgKsKnFp/iWzesl7/h/LvGSguRynRD+9Io0Dhd6coxwvAdgo6g7lRxkDBK4eFW
	uyTZiaVcIkHvQISAy63cAfBmLJ+bzFjT6uYxXTh8kBNmY=
X-Gm-Gg: ATEYQzwkMHgHDhZ6XTvWkaFR7N5X73bIrUn5EfaL6nGusYSTqO/LVUWgylGpw5P8s1g
	DR57rRDmVWO/ec8CXeDG8jDcQe9C2tjjwSIpB5qWBAJSS15BOGiNOdXGr/Oi9l8n8vzqNzoD7Qg
	THHT9TTOH6CDX+Zr4JdTkyV6wtfbWpimGtQ1X79y2wV7VGmpLqM6tuvmUsD6g9CeRgVEoqdZsfe
	5SckZc=
X-Received: by 2002:a17:90b:4b85:b0:359:8c21:ef47 with SMTP id 98e67ed59e1d1-359a69da9b5mr1079801a91.13.1772603817527;
        Tue, 03 Mar 2026 21:56:57 -0800 (PST)
X-Received: by 2002:a17:90b:4b85:b0:359:8c21:ef47 with SMTP id
 98e67ed59e1d1-359a69da9b5mr1079790a91.13.1772603817133; Tue, 03 Mar 2026
 21:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260226115550.1814-1-zhangtianci.1997@bytedance.com> <20260226115550.1814-2-zhangtianci.1997@bytedance.com>
In-Reply-To: <20260226115550.1814-2-zhangtianci.1997@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Mar 2026 13:56:45 +0800
X-Gm-Features: AaiRm53zWL7rGthRQcOIejkhn6fpEyvmyHv7GwvnBf-pM7y2T4tmtr2zHY4kK-4
Message-ID: <CACGkMEskKHj+r8rJRahQyEGMPpH0OduPyue3GfOoOFDGrZ07WA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] vduse: Requeue failed read to send_list head
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	marco.crivellari@suse.com, anders.roxell@linaro.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VlruGm7Y4vai7XXtmEXITKyw585ypoN1i503DCKRAI0_1772603817
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 7:56=E2=80=AFPM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> When copy_to_iter() fails in vduse_dev_read_iter(), put the message back
> at the head of send_list to preserve FIFO ordering and retry the oldest
> pending request first.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Reported-by: Michael S. Tsirkin <mst@redhat.com>
> Suggested-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

