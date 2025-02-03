Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3E1FBC87
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Feb 2025 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571168; cv=none; b=bGUkMqNRJsBDazWv5zWt1B8EYBtKTylguk2FPHw+tKLVTrqXqnMoVeyXrRvsVIWz/jH2XKUEgeKiQzBI6MRWSGmkXZz8RKciW4hkkvRyjeFR68Tp7zByLa3pMQs2Y0NXPgBrMXWhvN94KsT8g/U4yBDnsF3yAFNdES13Tm/RofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571168; c=relaxed/simple;
	bh=/Tr5JUZYV3LVg3vQ13XaGg/DMNKQjaE9ux4fHBb1RTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0enm4Zpgp4C1/zJ5GFBJFsiawWVCZ/OAouQ0m7nwsh5JL76zN3KIf3FTIznxrMO1clel8o4Cv6l8P2Ot/QYW4Wy028mGdBwkfNVpGAqsBLo0JbdgjbF7w7HK4VxGeiDPn+my128r8i/SUXynCFNGuBcZNNE0EmoOpQ6F0VkcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=kTxrWLdO; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="kTxrWLdO"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB837416DA
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Feb 2025 08:26:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mUIo0iEjJCEi for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Feb 2025 08:26:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C8EED416C5
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8EED416C5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=kTxrWLdO
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8EED416C5
	for <virtualization@lists.linux-foundation.org>; Mon,  3 Feb 2025 08:26:01 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2162c0f6a39so88123315ad.0
        for <virtualization@lists.linux-foundation.org>; Mon, 03 Feb 2025 00:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738571161; x=1739175961; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7lQIQ5MioRS7p56iXT3+pmVZjZaMiEEtNeyBXs9W1Y=;
        b=kTxrWLdOgs0figNhc85qzlAgYBBU8CN0p5f+qKlI1Q+JyK5tJEhuUNCQGNj1J+wYY/
         Nn7JNwlajXK7/eHQTi6jt35BzpWiWfSpxtl6fjdLAOfE8L3E2QPCw0dc44YfdTnedSG2
         mQtXySYzMbA7Gbr8Gs6SiwjAsAXAILRuWizS+wBB0rV+o+XNPs7fM98PqMp5MtfD0QlK
         pQgl3eiEi207C/UCD4PhxCohSrAd5GHgeWYLNGLBTldcVW+BfbBUg7CUtRjxYH6kXHpA
         Igvycr8lGYuJgTLJk4bw0bKqG7syb4e8U4/wYcuDBcN2gwXZEXe86QMCbJgqgeYIs9Qq
         xSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738571161; x=1739175961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7lQIQ5MioRS7p56iXT3+pmVZjZaMiEEtNeyBXs9W1Y=;
        b=vcOFSL5AbCyPGair68fwMJBo200PCbYKaMsta0ZjvBnASYYypASnIAtLWJDIWBTWKD
         UBQBMn8BmtjFvOkLL07wDbn/tS+tsFEttjZZDJnfuZ8e2ttvRT9TUbAINu/WN6ByFim3
         VC/gnSI1SjDfVjgHka0mSe+VoGYJ+tGIpmpc8ZC5E1QU7d3fNtayNbKHf+5GrEw2p54K
         0auIPBuk6RX2A32vs4chCw2h5v3Tuj+XRXDarOWgIRzYdCxQOJajULEPhmxyojI5/fjY
         FkntI8w00rWyeUSRbO80ZLU/CE2ssYyvLWVyVFD83wXXijANJUBwZtlPhMR7+F61Yy+V
         Pjyg==
X-Forwarded-Encrypted: i=1; AJvYcCUHTEkYPAMJRMe9aH4WqB8IkB8IofETrIALZDXmLlOOfv+O5nNu4LupCxDSn2cHD0IZdpV+f4g5ZQuLHCcBOg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx7OztdEL+PL3+3sPWzfWEItP15RvCHxmndv70cayXaEDRJSwIh
	elu9DzxfHt+tOIwRQOa6GoU+e9Vgf67YMW7kSMAbG12kmb3eiCyh8GMzdfXA6gI=
X-Gm-Gg: ASbGncsLSAt17WAOjj1b/+F6wCZhUk64qADZIX7TpzBdQpty3lGVZsPrTQ7VdF9zgVr
	fr9QRH4s2cIgmOc+YrM3hGj3JSW+S9UrSs0srG15MCcsdb3J9khBuxDEr5k7VutwibtZ30iuEzC
	/9DRVVpZWW0bOTLsgQP7NwY9kuRYhrBRXjlOomiWtsdPRcr+JegSXCAHGjzFJaMBMsowSj5OIAt
	ZlH+2WTI28dDJB/qA8/0+7UgoNoleRiN6WrWoDrimbvsYtT6GTzyMlONHoto2kjMWFa5gbgJKpC
	0x4sHi1juUICnroYdrfH7e0ucZ7K
X-Google-Smtp-Source: AGHT+IHX7wiqWkH9ZcI1oVnOppZdCHPlnSWOncf4WEz8oSiauUBCNlHSvTET6Iebk8Cezdu9r3h0Aw==
X-Received: by 2002:a05:6a21:9004:b0:1e1:e2d8:fd4a with SMTP id adf61e73a8af0-1ed872fe623mr26733156637.5.1738571159383;
        Mon, 03 Feb 2025 00:25:59 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424facsm7848454b3a.39.2025.02.03.00.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:25:58 -0800 (PST)
Message-ID: <a8bf6c8b-5ee5-4150-a9a2-75345fd07432@daynix.com>
Date: Mon, 3 Feb 2025 17:25:53 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] virtio-gpu api: add blob userptr resource
To: Honglei Huang <honglei1.huang@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: Lingshan Zhu <Lingshan.Zhu@amd.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, Huang Rui <ray.huang@amd.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20241220100409.4007346-1-honglei1.huang@amd.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241220100409.4007346-1-honglei1.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/12/20 19:04, Honglei Huang wrote:
> From: Honglei Huang <Honglei1.Huang@amd.com>
> 
> Add a new resource for blob resource, called userptr, used for let
> host access guest user space memory, to acquire a simple SVM features
> in virtio GPU.
> 
> - The capset VIRTIO_GPU_CAPSET_HSAKMT used for context init,
> in this series patches only HSAKMT context can use the userptr
> feature. HSAKMT is a GPU compute library in HSA stack, like
> the role libdrm in mesa stack.
> - New flag VIRTIO_GPU_BLOB_FLAG_USE_USERPTR used in blob create
> to indicate the blob create ioctl is used for create a userptr
> blob resource.
> 
> Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
> ---
>   include/uapi/linux/virtio_gpu.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> index b9a9783f0b14..0a6b56acbc13 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -323,6 +323,7 @@ struct virtio_gpu_cmd_submit {
>   
>   #define VIRTIO_GPU_CAPSET_VIRGL 1
>   #define VIRTIO_GPU_CAPSET_VIRGL2 2
> +#define VIRTIO_GPU_CAPSET_HSAKMT 7

The changes to add VIRTIO_GPU_CAPSET_VENUS and VIRTIO_GPU_CAPSET_DRM are 
already merged so this should be rebased for clean apply.

Number 7 is also occupied since 2023:
https://chromium.googlesource.com/crosvm/crosvm/+/e4c1878733937042111fca58899a3a94002bfef0%5E%21/rutabaga_gfx/src/rutabaga_utils.rs

VCL, a proposed VirtIO-GPU OpenCL driver, is also going to use that number:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/31634/diffs?commit_id=55a1a8a32057e83819b046f2de03aca333b052b4

I think you should talk with Antonio Caggiano, who picked the number for 
VCL, to allocate a number without a conflict with VCL.

Gurchetan (the author of Rutabaga change allocating the number), I think 
you should notify the number usage by sending a patch for Linux or 
virtio-spec.

Regards,
Akihiko Odaki

>   
>   /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>   struct virtio_gpu_get_capset_info {
> @@ -415,6 +416,7 @@ struct virtio_gpu_resource_create_blob {
>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
> +#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
>   	/* zero is invalid blob mem */
>   	__le32 blob_mem;
>   	__le32 blob_flags;

