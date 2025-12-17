Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1793D6F
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766007091; cv=none; b=jbiJ7EgX/S3XaL4PSY68GKNwvDHp75R9FG0sYdXqYMBtsJioLfnB+U10uz4RimPb2oTfsRbCJZm7dSfjbvV0u6RtM+MvG0Y6JM3j1/tiCEKGKGtwGRI/WRmCTvARkb04hUZECDOO/lOvIV96QUcGCA8X3sp33wegmOxvqMF9W5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766007091; c=relaxed/simple;
	bh=ZrwbbUW3N9FfT0wYKVT7nAip48ht2GpZQbyeczMtBq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqhG4VdQNBdqOYrx6TG5hgitGQZvwwfzowyK7Mj4UbWUFeBQ+d4PC8g27jYqLphFb1y4H/Nh3vtlVCSpoy3y0JXXaQHtNMvWfqVfjoBmBsLsD8oFzJDLsNgOePgSVNHk4QEPKgDt4cR4ovaEersWKkS3Re/ogXlPSqaZ2IBV1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v22wTlpv; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v22wTlpv"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-34c718c5481so3839701a91.3
        for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766007089; x=1766611889; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5JApYGuzxiB3a2BPggX8fFjm1eExovTMlFNv757Hsw=;
        b=v22wTlpvRMjExwnDe4j7hjJpsm5EeWnSOICgaLkIP+27MAN+ufS7V9NYa1hBeHfSeJ
         1+K3PDhwUdrrMmIyhfLO3T7XvRxMRgr4N8ACql41/RT6e4kfi1LvPh3w5BrMZYolSf52
         Us5EGezgSDi7WwlmgzdMCNRUsFFwsWCHx7fgg039+ad6LjnUAU7uAD0JafJv5apMBXfr
         KN/Qh9Tpb2bhVyoDbom97mtKPyBPkxb8B2eXWJsGWsolzzNd901IrMK8Jy4DtR/yeWAB
         ubYhO5OuvObsL7sMT7dZA3yuQc/HMFb3keis8fga4N3rBtgLjU4Hk1o4PQskFvp/kFfz
         i1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766007089; x=1766611889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5JApYGuzxiB3a2BPggX8fFjm1eExovTMlFNv757Hsw=;
        b=J8c4h6ltqvLVcWCOMvz9LNo+72GWz3eufLaCvWQlBwFPxi6hXNy6YhyQAgqTu05yBC
         GIl0P6kZ6d3Niq9SdFlY75fV0NvYghFBFPQoESK4r9NKNkWTmK7mBbRugqw2P+BVCOT/
         IAAZqzPq67D5YC1zRqYGXGHRWEwdd9dGFhcyQ2SO+yfPIQ23pVCzsrSdNp6tPyeHZsxD
         XKM6+MuD1tcPiUlOYJeQZamdeHauA2BmC2kzSdh3PYeq+knuwpIHEKCOwyZjoZ4Tvwvs
         GG3AyKDthzoms4i87GZ4/TKeYU3nE7FKWmxYpKnpV5RotTYIx8LetjijMbPs4TXFoi1d
         gn7g==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ89vYodqmsyWSmxnM4v9znz4ZBZv7oG9TR7XlHM0bvqXeLeY9TJKc8an1pP0jQm9fIh30cUBAxwwoBDKFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdU2uvmd18hv1ZPFF6cz2AjxNhm5D6WRrLbUmzl5b7cLGQ2AD/
	9nKE/SgDPsCUP1Os/tcwWgOomN5tBt6VlRhKZE/4WKa9bomECoVMjQOSgrweHe21fEI=
X-Gm-Gg: AY/fxX6fyCZgLE72AZXXhdN5Qc/4nDCJnx2UrNZ2ohJ6mJVajKit0QGacrdabLYh4l1
	lcdhsjWs/CUGwwMg2FmkAa3AJ/pnu2XONBlQTpit/4eVTFcb8Su4K/YRW3l43h7DLJ980pnxrMA
	F7kprHHwMe5ubj2z+YLrDP8Rzgjft00nQhD7ZUP9vdrcDqKNgvQIFM3NfQf1L3i05dLdBZ4LZBb
	VlmdErNkULH1Is2j1j6g+Cf6x9xyYS6DjABRCXpXw8QvzZGG5CIMTFAoMeSjWRBKrTZQ2t1hCCu
	l84k/1lGz8badwzq5fkMOx9kFQstrmi/MK3W8CxMx5dC9VelDu9Q1CUJZdejpxRvLDX1rxJCi39
	9tdUMz3caAJF5DDH4VTl4PHiTG5s6wth1vUOMj7jC131EeXA7PZu6CBMQMaf3AA8cxOHEtLfhxE
	MkDCyl/XuQxKnN
X-Google-Smtp-Source: AGHT+IFlj92JtrStaZk3eC4JfdqeXsQIYzDTBERa3lbqEjrJAEjPEyL4DDHJKpCXCawtFFErwViJ3g==
X-Received: by 2002:a17:90b:1fc6:b0:339:cece:a99 with SMTP id 98e67ed59e1d1-34abd6dd2fcmr18316438a91.13.1766007089154;
        Wed, 17 Dec 2025 13:31:29 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:cfb9:c35:9f28:8222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e746cbfb0sm293722a91.14.2025.12.17.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:31:28 -0800 (PST)
Date: Wed, 17 Dec 2025 14:31:25 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	virtualization@lists.linux.dev, xiaoxiang@xiaomi.com
Subject: Re: [RFC PATCH 0/2] Enhance RPMsg buffer management
Message-ID: <aUMhLc9fe5inQN7X@p14s>
References: <20251114184640.3020427-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114184640.3020427-1-tanmay.shah@amd.com>

On Fri, Nov 14, 2025 at 10:46:38AM -0800, Tanmay Shah wrote:
> Take rx and tx buffer size from virtio device config space in the
> resource table. This allows each firmware to configure RPMsg buffer size
> as needed in each direction.
> 
> Original seris:
> https://lore.kernel.org/all/1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com/
> 
> Following modificaitons are done to the original series:
>   - Separate dma allocation is not done for tx and rx buffers. Instead
>     allocated chunk of memory is split between tx and rx buffers.
>   - If vdev doesn't support VIRTIO_RPMSG_F_BUFSZ feature then use the 
>     default size of 512 bytes for buffers
>   - Change MAX_RPMSG_BUF_SIZE to DEFAULT_RPMSG_BUF_SIZE
>   - move virtio_rpmsg.h from uapi to linux dir
>   - RPMsg buffer size must be set to hold rpmsg header at minimum in the
>     vdev config space of the firmware.
>   - align total buf size to page size when allocating and deallocating
>     memory
> 
> Xiang Xiao (2):
>   rpmsg: virtio_rpmsg_bus: allow the different vring size for send/recv
>   rpmsg: virtio_rpmsg_bus: get buffer size from config space
> 
>  drivers/rpmsg/virtio_rpmsg_bus.c | 105 ++++++++++++++++++++-----------
>  include/linux/virtio_rpmsg.h     |  24 +++++++
>  2 files changed, 93 insertions(+), 36 deletions(-)
>  create mode 100644 include/linux/virtio_rpmsg.h
>

This set is going somewhere.  Please address the comments that were received and
send a new revision.

Apologies for the long review delay.
Mathieu
 
> 
> base-commit: f982fbb1a6ca3553c15763ad9eb2beeae78d3684
> -- 
> 2.34.1
> 
