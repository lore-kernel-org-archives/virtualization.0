Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF34184535
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092200; cv=none; b=eVJsBLdkSlPqHEcFPtezvua7VdzCjMVc+C2w3Ta0MKnNdD8zvUDdr+Oo4gtduRvJKxCMT+UkWOjbDdLS2ywarYINtdY2clx3ZOk8/evrpz7MArPpxVD6m/HgGTKwzsHoGds6ZcggenWGEVrrBRNHCClgXihb0rFS4i0wuJjKeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092200; c=relaxed/simple;
	bh=r2CDGCTvlxF2ba/tf/zgcURMpYEa29c98Q6T52zLk8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P/0irnzPAsOXzGIQklhsZaNtOUKsUwpS5ll5h4NNQMCoJULGZcDkep3hxHEIzSuvzPVjl+pZqZ5eNrtFe0jZ2EY8h14uSt3krMW2M/sxZQ+JYR3sK3vzYjjYKuMg4/9KPg4Z2un41r03qKhPfOzWGcrG5pO85pFjgg5gdMVDHmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2RRfx3A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2RRfx3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724092198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4lFIiiMRye69cO2CDTKsNTtf7eVlTg5I3EBKNS16KE8=;
	b=f2RRfx3Aj52YarkZreXojdWbCRcN8He7/bev2sJr9yNDMdDlA6d7qT0eHO0iieAayC78+w
	TcyeIognduwCyFQ/ZlpczEVkx02Pql9rqO60uKP3SmFcbyeBrZLUdISKu/p1m9146TJkXT
	5yB/Cbc5DTBxcq4RGtDv5elL8beQ984=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-XM5qZSemPsagt7yR3iOcgg-1; Mon, 19 Aug 2024 14:29:56 -0400
X-MC-Unique: XM5qZSemPsagt7yR3iOcgg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428076fef5dso38944115e9.2
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 11:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092195; x=1724696995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lFIiiMRye69cO2CDTKsNTtf7eVlTg5I3EBKNS16KE8=;
        b=kgUXoTkWloTPSkHHTi1ECWZV4Slk/V0oU2cNyojO2fCzvRQqG9HmNUb12AmRTnjlgz
         HamCtci6GHmo0H0Rh3l6lv4pmiEpwB3MVQ/tTvYK1XBrtuxGYkr1WkC3tsrpHiGVh4eb
         H6FSDV4nnEaTEtZ1i8z1Z+X8TSMH0ixkdrSrUwmk5fB56fcCrPhCcP6IY92aZVGlxtfT
         TCqltGwyBblctK1QobCO/wpr0SRbEuZsfJhAiPgG5Kan/Ld0Xwobviw6IS3TLb3X6Pvi
         VIsprrxU4WxUepw1gtbwqGDMWyzONHObn5TaZ5/v0SQOWYoJ/zzjLuhVNsvsRYANs2Qk
         fuzw==
X-Forwarded-Encrypted: i=1; AJvYcCXqVuKSS+Na8Tg1B3CxveH4xIBF/g8cK23ylhXyYT7QM6/3msEfAJqGjPIvpLuw3w4UbkKu4tgPJiICgYgqy891tWGZ3qH2u6mG+7sUTog=
X-Gm-Message-State: AOJu0YxOZNO79+bduypkmOne0mK7YgOEtsV625Yy3zqVatj7kOWnPzCs
	7I6/C8LhK/UZyvr15KM6ueO/Idm/c/zHUaXnAriEHlwD5C212OQTP93FQ/HpxlS9w1vX7aUypvy
	rdckrG1TVRKeEafwSjkUN/FPRDGyLW6F/Qrd3066jntUJ7R7PlEe3w0if62qPwM9v
X-Received: by 2002:a05:600c:19c9:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-429ed79c7a5mr83715055e9.10.1724092195175;
        Mon, 19 Aug 2024 11:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk0CorVXceopfXeadLKMfCM8Ki34PcTWH20nY6bDKinP9SMpodZdRD2jpn/mC1ynyKYRSJEA==
X-Received: by 2002:a05:600c:19c9:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-429ed79c7a5mr83714895e9.10.1724092194626;
        Mon, 19 Aug 2024 11:29:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5bfsm174369695e9.46.2024.08.19.11.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 11:29:54 -0700 (PDT)
Message-ID: <b1e442df-83dd-402f-a9d6-00a7c8c51954@redhat.com>
Date: Mon, 19 Aug 2024 20:29:52 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Use XRGB8888 also for big endian systems
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <20240816131310.1008205-1-jfalempe@redhat.com>
 <874j7gld19.fsf@minerva.mail-host-address-is-not-set>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <874j7gld19.fsf@minerva.mail-host-address-is-not-set>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 17:58, Javier Martinez Canillas wrote:
> Jocelyn Falempe <jfalempe@redhat.com> writes:
> 
> Helo Jocelyn,
> 
> AFAICT your patch is doing two things:
> 
>> Mesa doesn't support BGRX8888, that means most wayland compositors
>> doesn't work on big endian guests.
>>
> 
> 1) Dropping the BGR{A,X}8888 support.
> 
>> Also the colors are inverted when testing a s390x VM on a s390x host.
>> So I fixed the DRM_FORMAT -> VIRTIO_GPU_FORMAT on big endian guests.
>> It may break big-endian guest on little-endian host, but then the
>> fix should be in qemu, because we don't know the host endianess in
>> the guest VM.
>>
> 
> 2) Fix the format translation to take into account the guest endianess.
> 
> Maybe is better to split the changes in two separate patches ?

Yes, I will send a v2 with 2 patches, that would be better.
> 
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
> 
> The patch makes sense to me though from your explanations.
> 
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> 

Thanks for the review.

-- 

Jocelyn

