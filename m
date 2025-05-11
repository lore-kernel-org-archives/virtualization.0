Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3125A620
	for <virtualization@lists.linux.dev>; Sun, 11 May 2025 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746977794; cv=none; b=MXMKik/PWYCSBiSMnem501QE1TpkMk94FqpJaW3gAxRlXdhPd8jm6eqrG+qAeqKpPcJ/v2/OG9O7pA5qWHrrOs7DIgl+udq/LywS682ND9xt0DF/OkjXZ6EEcmkRo00lsXbKzQNX7SYT62hmQjj7+6Lbx+eNAXN57JNK7VcwVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746977794; c=relaxed/simple;
	bh=qGKacZFH6d9H7gZIy5574lz4sh3DAs6LJsxIoFdhtKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M0oUoKNlcoDsvS5S+hP9k4FjgbzZrLNpv125PAutr5QSaOQh9+38CkjxF/xVWqdd/qDzMBJK7Xdf5WHKB23JM5MJxCpoc59/M5eVF0Y9fHVHHZXQ1SCfi7XIX3oLXmoxjDafkd76QrqRgPNRY+IoVULgUcWBrt8iB89r2LyMg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNnKGyaE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNnKGyaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746977791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpNCD9/isg8b1+k2LARZWva+SLP5Kbk/L5GpSCTXRlc=;
	b=UNnKGyaET1IF28iY8j2QsaXLhfwe/uv7/CwDGxT6v45pvho1NcbuVEJMSTQ7Av/ZKD4Fqp
	86eW/URp1RJefTM7DrYiHZ62H4FMCf72Azeufhp8PKwMT8/Osq+NP3BNA5HbqpCUI4XHcV
	WND3nMuyCdr1nXXoplhf+VKl7BrOZ/k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-XFGMw09GOtKdmCoCpNKYBw-1; Sun, 11 May 2025 11:36:30 -0400
X-MC-Unique: XFGMw09GOtKdmCoCpNKYBw-1
X-Mimecast-MFC-AGG-ID: XFGMw09GOtKdmCoCpNKYBw_1746977789
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a1f9ddf04bso1096924f8f.3
        for <virtualization@lists.linux.dev>; Sun, 11 May 2025 08:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746977788; x=1747582588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpNCD9/isg8b1+k2LARZWva+SLP5Kbk/L5GpSCTXRlc=;
        b=n+2dE6UrCuLCmtbU5CvSj3KZmSapqtdkVzlPc0C4qm8CqxU/QHO9oXVhExYWBpKOGs
         O/7M4ciVrbigoUeTcWZD27PjIJAwE7KgBK3QaXf+HpGEEDfUWEKro2tQJRsx5g8W0Moj
         K/PrnNpS65X0Z6os8n1Q2TLGiG8uGXLfgr59mRR9LHEb5ScOtQ/S0qm5Yly6gMXIsvhz
         Iiyo5xNXyU9FEQsuAjtUPsGQ4/HkfAh+hRJ++rf0FfayzJYU8jWjHlxOI82Vi95o6Og7
         B6IV7Zm6XQHafPUhvYrImpg0mhkzn480ddiSg2bZ7ty4lSStik8Y9McYPmZiKejY3tvc
         59eA==
X-Forwarded-Encrypted: i=1; AJvYcCUsGZ+sku9aHUZtMKQ5gTwBfi7iiGJNVUXmLhTpkMiv9RiX+9r3isH0bhYMn57QMndlR12rQBE0CAcB45Jn5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHtNCNPx4RJBGqOdEDtKHIMYe96CWXAwXpMCYft0W6YBtq/9nu
	RwMCC6In0Fdh+NMUt7Rrghv9ypF1INJaa1ua7kdF8SNuFBW8/0VBvh+yBFSLgfSXGlIZyeodb1o
	uby83tmk7Flkqk8Ov6zdEjFs9XXYOExLQrrtYwyi8knBBGL7fw5fzNNZWHb/hhQA1cPTkbNp/
X-Gm-Gg: ASbGncs4djhXgp3V74kcwMYazgsEhdyM2BriwB3q0ZwQx52Se9qdboXxmsodxtaCCD3
	3Im/ZIDFVNaPW/qCYHJ77lD7yXePeT3ws7MgydjQOYAURHPY9QDhIl9R50INBIAdOoowLrIoNMA
	Vej3bZNeP0ws9h6hKCxBa+6aad+6dzevcvgA4ACfG3t00QyLT1L4p758CmbLpsXztGkB2vtT6uI
	1fbQAaYBY150poctNS/AZBGVY2h6TK1j2uJjg7weY2eNy06doUVmg4ErzYg7hGNP7wsxWyxmtf/
	Sx7QHQ==
X-Received: by 2002:a5d:64c3:0:b0:3a0:b807:7426 with SMTP id ffacd0b85a97d-3a1f64ac686mr8842776f8f.52.1746977788373;
        Sun, 11 May 2025 08:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLhSnXG7WahQEWlAeW3ZdNW5sVr7QFEWtLXAW+865LoU/9TSABIPR1jvc6EOo3bowtzEPcw==
X-Received: by 2002:a05:6000:4006:b0:39e:cbe3:17c8 with SMTP id ffacd0b85a97d-3a1f6427a7emr7479643f8f.12.1746977777002;
        Sun, 11 May 2025 08:36:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f28f7sm9439635f8f.41.2025.05.11.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 08:36:16 -0700 (PDT)
Date: Sun, 11 May 2025 11:36:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: SamiUddinsami.md.ko@gmail.com
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Sami Uddin <sami.md.ko@gmail.com>
Subject: Re: [PATCH v2] virtio: reject shm region if length is zero
Message-ID: <20250511113555-mutt-send-email-mst@kernel.org>
References: <20250511114428.2061-1-sami.md.ko@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250511114428.2061-1-sami.md.ko@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2kJZioTN8-DpWjA5Vy8qLS1dtFXVkRYJq_tZnhgra9o_1746977789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 11, 2025 at 09:14:28PM +0930, SamiUddinsami.md.ko@gmail.com wrote:
> From: Sami Uddin <sami.md.ko@gmail.com>
> 
> Prevent usage of shared memory regions where the length is zero,
> as such configurations are not valid and may lead to unexpected behavior.
> 
> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
> ---
> v2:
> - Fixed coding style issue: added space after 'if' statement
> 
>  include/linux/virtio_config.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 169c7d367fac..b641b16d42ef 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -329,6 +329,8 @@ static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
>  			   struct virtio_shm_region *region, u8 id)
>  {
> +	if (region->len == 0)
> +		return false;

if (!region->len)

is more idiomatic

>  	if (!vdev->config->get_shm_region)
>  		return false;
>  	return vdev->config->get_shm_region(vdev, region, id);
> -- 
> 2.34.1

