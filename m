Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42B45025E
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830406; cv=none; b=twUsOr2BXnN84Q2RIwdDXuY+Jk5Ex8wU08ZCChweYvYXoPpoj4CC9bWEb3qCMGEZ6HwAwcWKRO3wBlALdxIQAmMdD98xLD5n93cH4jtDB7hu/iFm9Dk6nLVxwvVCLeJksf3wu2pfVZgl1T48AVIFdXPbhlJFxr6hXv74PeQZhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830406; c=relaxed/simple;
	bh=dGvw3mDfoRm2OqwtwB2l2AYcNSFBaa/4EZqLBMmmAXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cggCESAN5QT8/ipaFyQoE/MXQV3/6II7nmdurNPL74ISJneO4Aq3IEsnBIMrGG5BqUSRoDiihqpU95jcQ3IbeA6ZPdHD/fVA1Ds4UtF/iYR7JsHSGWDk8fs0POkaEpLCnkWMqbihPD07UenqjBiKMAXHk4fDCVRRoKmG6q3gJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFgB0iY5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFgB0iY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aV5ZCG8Chq+f+KWLvWeKKWksUT2jvVAPDzBGS2R+WL0=;
	b=aFgB0iY5KkHH7vUAB/Zo2tUvQsjEj7+xQXuoiO4ZO19ro79QYR2ny1BeYPKzdnpj36eZc4
	bGk025201j/mbQQaHipXS8NThJwSZu4/ibv0I/bBx9VNQxtw6AD5XqNAQmIR1dSoRTN18b
	RWOxfaA5pk30UmIaNRS0PBfZlQpztL8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-Ma_3pRdvPeCGEuq2WAOGZw-1; Tue, 19 Mar 2024 02:40:02 -0400
X-MC-Unique: Ma_3pRdvPeCGEuq2WAOGZw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-513def50581so2633615e87.3
        for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 23:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830400; x=1711435200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aV5ZCG8Chq+f+KWLvWeKKWksUT2jvVAPDzBGS2R+WL0=;
        b=HPHUSlIWlK3dFP3Qkm2ZCE/LakIIgFmdJdPrrsOyLHkpT3Gy15I2vZqbX8+vhrOhg5
         mEd/oVzNi/d1cO/EGYx+Up5dHVFGu4XV0KaOnhHFkXiAiNdJVPkTIQvv4tEzTKCTtmOi
         DZiherp8XqB5nOPXPZFd6ovkhzCeKT+TlBKm8j9GSGo8kXmqCrbK+BfxCTFQkyOCKpmC
         F/1gCLuX0FQ95oEoQ29tryBIXzT3jg8rFpRr5f0NFlzFwqCFewm14Jr1+66OJ3AlGEvd
         lJ8h4T3Gj83KSiH/p+GVr5R+PRX/MMRPr37MQoEd8j0M2YbrSS1lewXBNfnuaI0g0ush
         kPGg==
X-Forwarded-Encrypted: i=1; AJvYcCUTUpHYQBtfX9HMmVDVPM6jsBPD3hcorA/ceDsJTvH7cRfixyHMMv6xqwde780sjIJT6W/sORvpIpMGEBgR81dFRomtTHjMcQKoq4XXrUc=
X-Gm-Message-State: AOJu0YzK8ZBNLVTEr0IWKr8wbkJINVV5L65LeOSn2yUn1DB1SdU1oFZz
	B3uNDmYfuWa3WJBNWCJnpC3eAqhPw81ZMOf+9zSRcPp9CEae9cvYV/QbpfJp6oLxVAYL34eZpf2
	PUtTFBC3EVGlrNLO0cz+oypBAqDIOQCTWhcWBRgkVXUq3WpjTmdx3S0ltzVx59K/D
X-Received: by 2002:a05:6512:312f:b0:513:572f:88f1 with SMTP id p15-20020a056512312f00b00513572f88f1mr6650052lfd.27.1710830400413;
        Mon, 18 Mar 2024 23:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7QARhBn97Nw8yA/jWe4fWd+g0Kmxm82ad8rvyl1IJRyBKGgMVW0esamEU/LPm0QYcUD2Jsw==
X-Received: by 2002:a05:6512:312f:b0:513:572f:88f1 with SMTP id p15-20020a056512312f00b00513572f88f1mr6650041lfd.27.1710830399942;
        Mon, 18 Mar 2024 23:39:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id jl27-20020a17090775db00b00a45c9ea48e3sm5673530ejc.193.2024.03.18.23.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:39:59 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:39:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev
Subject: Re: [PATCH 00/10] vDPA: allow userspace query virito-block device
Message-ID: <20240319023840-mutt-send-email-mst@kernel.org>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240218185606.13509-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2024 at 02:55:56AM +0800, Zhu Lingshan wrote:
> This series allows the user space applications query vDPA virtio-block
> device inforamtion.
> 
> testing on vdpa_sim_blk, iproute2 output:
> sudo ./vdpa/vdpa dev config show -jp vdpa_blk0
> {
>     "config": {
>         "vdpa_blk0": {
>             "capacity": 262144,
>             "segment size": 4096,
>             "block size": 512,
>             "max segments in a request": 32,
>             "num of queues": 1,
>             "logical blocks per physical block (log2)": 0,
>             "offset of first aligned logical block": 0,
>             "minimum io size": 1,
>             "optimal io size": 1,
>             "maximum discard sectors for a segment": 4294967295,
>             "max discard segments in a command": 1,
>             "discard sector alignment": 512,
>             "max write zeros sectors in a segment": 4294967295,
>             "max write zero segments": 1,
>             "read only": false,
>             "flush command support": true
>         }
>     }
> }
> 
> Please help review
> 
> Thanks
> Zhu Lingshan

It's been in my tree for a while so it will be in the next pull,
but going forward Jason I'd like to know what kind of
timeline do you have in mind for reviewing vdpa patches?

> Zhu Lingshan (10):
>   vDPA: report virtio-block capacity to user space
>   vDPA: report virtio-block max segment size to user space
>   vDPA: report virtio-block block-size to user space
>   vDPA: report virtio-block max segments in a request to user space
>   vDPA: report virtio-block MQ info to user space
>   vDPA: report virtio-block topology info to user space
>   vDPA: report virtio-block discarding configuration to user space
>   vDPA: report virtio-block write zeroes configuration to user space
>   vDPA: report virtio-block read-only info to user space
>   vDPA: report virtio-blk flush info to user space
> 
>  drivers/vdpa/vdpa.c       | 212 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |   1 +
>  include/uapi/linux/vdpa.h |  17 +++
>  3 files changed, 230 insertions(+)
> 
> -- 
> 2.39.3

