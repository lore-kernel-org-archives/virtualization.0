Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076C1534EC
	for <virtualization@lists.linux.dev>; Mon, 13 May 2024 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607579; cv=none; b=Tr6U6zrFsYoSu3IKoV0cIRE9aos+DM1cRq8hoI1yQhV9Lv5sfwHQznYBw+F5F9V+WNVLTgB0RdB4tPirC/0PZKdySxUcZ7FjXhttE7cD32GI9500tiBiHPUfgIvg6InNzUZ+gtiHibc+ma9A6ZYqmFxIpAmcq4wYIDJdmtaln5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607579; c=relaxed/simple;
	bh=oyWkZmzN25DnCf2cGtg1tNTh9mf5fsurFjBPhTmFJag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XZPI66HeZqrdKIl3R7jDM0ei0bg9QQTGH9zzNxcz+Uzu+5cb8UuwGBAyZohbXpnaMgAbrB8xMmvJjCdhmYa2SSVpP+sjmo/aWAYsdkFxt8kZ09l9JcQuEZJT8kJ462+H+ViMh/TePynVNBpf/oFyQxFXGW3oqCLZYwFnTJgdit4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YN5voYXU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YN5voYXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715607576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwO8ckBzkYExsFiY1VM1Bv3gnPhOQlut+2ALR7qDN3E=;
	b=YN5voYXUhzkYdSiJ1ih0snt7XBd7WdiJnNQe6Q93HWk9+HY1R5ex76qsNvrzhdstykZuWf
	LmFOBLnJRtXmg5euQD39s2MDqu7p8ZQszVruAf8KfnxA5qNKWtyq88HzbyRIVkU2R5je0k
	ojIL/QhCfPoUD9afX4Shq7A/SLQFH9U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-gdGPVAGcNAawKdoEbVKYpw-1; Mon, 13 May 2024 09:39:25 -0400
X-MC-Unique: gdGPVAGcNAawKdoEbVKYpw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-522362e8317so2217630e87.0
        for <virtualization@lists.linux.dev>; Mon, 13 May 2024 06:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607563; x=1716212363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwO8ckBzkYExsFiY1VM1Bv3gnPhOQlut+2ALR7qDN3E=;
        b=EPQZrCk5BeVXVLUITPUCSiXbsYJyBZMevzUQropf+1K71GIYqgmGS7YkgLR7yVvmY7
         RgJ+shguitgieaJhL92pGVL6NUiKQ8IZBtxPJSVBKaCJYv9HhXekAccW3ojttNBJGJ76
         sXQdnX1Is+f0cMJb5gIMQI7C8UtCCUnzadWvWtynQmccYeX+Qg3aCwsEXx0lajoxveN9
         px8zOJsz8X0wLrsCVOLqEhQtpy/QTlGHoojoq0yWoBV003GBOCOUQqq1V8nbww4RgqHu
         GrdA7M2sAjh5UwERurVBkU7nEhw7DLgTYa8mptYQWaeK0xMuqFpNTsUVID94nSMpILpb
         51+g==
X-Forwarded-Encrypted: i=1; AJvYcCVvWEEI7taDZdRZImYRS7hlJ5QR31b+hVGewDgmDxn0Q/a5MmuF6sHm6TfZyJAzKXtG+JgaymPTCGsBYNa1BTzmWlFVpdj/Dy+jxkRsRY8=
X-Gm-Message-State: AOJu0YxoWFRnTipb+lr2j55PSO44vIemjs996CqDjb1JT6MaSoCTfcRN
	i+dlcS9EbZMy8InKXO35lp7h6HglwPTpuWhtEwB/6kVs4fd63snuUOkCUbgHd5w/9szqfFKj8Nu
	sztk6tfm9hfV+PRGQwwG8RIFkcvMf2RHxshcyM6n5oFTztCEnrZdj9G7SLQeRyD0+++YPJDTS
X-Received: by 2002:a05:6512:3d24:b0:51d:5f0a:8839 with SMTP id 2adb3069b0e04-5220fc7c529mr10998410e87.5.1715607563421;
        Mon, 13 May 2024 06:39:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHacgcpABYf4m0DczOYCAPIGCCE3LJxjeOM2RM9xqPNfLVH9gyM66AT6SzBI22fy20MUZhT+Q==
X-Received: by 2002:a05:6512:3d24:b0:51d:5f0a:8839 with SMTP id 2adb3069b0e04-5220fc7c529mr10998380e87.5.1715607562736;
        Mon, 13 May 2024 06:39:22 -0700 (PDT)
Received: from redhat.com ([31.187.78.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cfb2sm596464566b.24.2024.05.13.06.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:39:22 -0700 (PDT)
Date: Mon, 13 May 2024 09:39:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, lingshan.zhu@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Change lingshan's email to kernel.org
Message-ID: <20240513093842-mutt-send-email-mst@kernel.org>
References: <20240513212750.10158-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240513212750.10158-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2024 at 05:27:50AM +0800, Zhu Lingshan wrote:
> This commit changes lingshan's email from intel.com
> to kernel.org.
> 
> This commit also changes the title since ifcvf drives
> standard virtio pci devices now.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d75527f7bb0d..b69239cf30a3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10465,8 +10465,8 @@ F:	include/net/nl802154.h
>  F:	net/ieee802154/
>  F:	net/mac802154/
>  
> -Intel VIRTIO DATA PATH ACCELERATOR
> -M:	Zhu Lingshan <lingshan.zhu@intel.com>
> +Intel AND STANDARD VIRTIO DATA PATH ACCELERATOR
> +M:	Zhu Lingshan <lingshan.zhu@kernel.org>

Confused. Isn't it still for intel devices?

We have drivers for standard virtio devices already.


>  L:	virtualization@lists.linux.dev
>  S:	Supported
>  F:	drivers/vdpa/ifcvf/
> -- 
> 2.43.0

