Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52519C553
	for <virtualization@lists.linux.dev>; Tue, 19 Nov 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012324; cv=none; b=HqTVmw+X0+0jjEIMXHS/ikp4TJxaHqTV9J+5wTZqVIm+eoKMYfCO3GeOWBeIu9l+7rMn/+6UFDNAttqCcga7PUFORVT+W8p9JufxEp+ikGsSlJfUnUNZdFTOalDL7sNwBnO3FP3dZZU5tfF1OcfdtA1tbCpyzSzRBPw+QqnlS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012324; c=relaxed/simple;
	bh=BlAjTcLgGJY8uAZ7SU9fmGPwNwkxmWnaguL65nNmxGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aKxKGFY8m0KmolnizIbarUuhdjbKiD6bVL9txg47M7qw0aqK94MrYXswXqYXpxUsor37GQySsy3MMltgS8OeOg6P7PW/rTjwtuvub7YsCyuCwmJQyuK4uVJHQ5P+O51fzCih14nlmT1M8wj7sGsdzVxW61cU4LKz38L3ivAcH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYPZokXi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYPZokXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732012321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XZR/k63cZYtzau/fs0C+ufqda6l8PKbNVPXXgaTEROQ=;
	b=aYPZokXiUnz3PPTssRP6mm2ahpRdvoHAMbEyyp25MmWCbv/yjvPTp213/+O5thG/3DC4mA
	k7OVzuDsZwh+XjmCcYrtoZaY4oLvTyQrx02h+UVBBU9XmcKgEMbCVTSvhmegJICJN38I3W
	XfI9GxZ2g9ak0FAVEGKq7XttiMHQK+k=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-lmwBqUpIMQip9H6auqnTOw-1; Tue, 19 Nov 2024 05:31:59 -0500
X-MC-Unique: lmwBqUpIMQip9H6auqnTOw-1
X-Mimecast-MFC-AGG-ID: lmwBqUpIMQip9H6auqnTOw
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e790cb28a8so4178413b6e.1
        for <virtualization@lists.linux.dev>; Tue, 19 Nov 2024 02:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012319; x=1732617119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZR/k63cZYtzau/fs0C+ufqda6l8PKbNVPXXgaTEROQ=;
        b=ghc0ROitpaY+t5BHMtExybqqOGqzwHw1pTlP8BS/V0isBX5b6Ad7tc/29YyOcZXp9S
         mLpPwukLwa2K9QUvqrv1V9JNOqkVgZ+cfXW2Mbthin1e1TrcSYNDz/1VRcG0VoTo1mMs
         uRip9rkesY5T5Z3+KFFT4ZokgOWYfGdsEvItL0RYA1n07CIs+bNjogrCNFpgqDLbiKEp
         Yc3BNe7lUhtybvh3zscFQUletcd+7a/6stZBM49uG93U8z6T455S8M2Iy8NGYul79ACh
         yDoZqUbyOlBPKWJKCn0r0yP5CE/XhyOV64eaWsJfxtzZlH4Waa8P8RIx7vbnWKgTj9Rp
         nFPg==
X-Forwarded-Encrypted: i=1; AJvYcCW9w6KiKrLDYBiMpl/MfARVLe5GlPH4AuxwpQHdnKVqT0C0i2y5tOacovQE/FzOZ4SrDEO+C+kRkc0MpVoz8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIMjbEg/yUYdCmTuljBMyhQiY3OAPt6Ivxh9Km6KqUP95bD6hd
	he16brV9eI/Vo6PUPfbKFmtf9+oTauCtChkjMeFVs68i2TpWQQAeB1Q+K7sV8c0wI+8eDokNTlE
	mWRXfWTl370/xv7MMcrD57MJtSPKAfmT9nBr3q/XCHsc76/bMVvZ7T5M2Iy3bNm8l
X-Received: by 2002:a05:6808:1a0f:b0:3e5:ed42:ef13 with SMTP id 5614622812f47-3e7bc7b5902mr14809446b6e.11.1732012319001;
        Tue, 19 Nov 2024 02:31:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWEwvUPqOGaW7LnP5oJa5I+dvpQDN13kppHSp+DXkJ5wuJF6S6yGrtvxP38Z3lsuqk+AOaDw==
X-Received: by 2002:a05:6808:1a0f:b0:3e5:ed42:ef13 with SMTP id 5614622812f47-3e7bc7b5902mr14809420b6e.11.1732012318535;
        Tue, 19 Nov 2024 02:31:58 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40ddd02cesm46568686d6.121.2024.11.19.02.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:31:57 -0800 (PST)
Date: Tue, 19 Nov 2024 11:31:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] virtio/vsock: Fix memory leaks
Message-ID: <7wixs5lrstuggf2xwgu6qva2t6atqnthcxycg6mpfpx52gl6fq@qmwb6gtgpad2>
References: <20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qEBXpp14F7430fMLcgWzABRiikKOLD6kUjHmcJLjVsg_1732012319
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Michal,

On Thu, Nov 07, 2024 at 09:46:11PM +0100, Michal Luczaj wrote:
>Short series fixing some memory leaks that I've stumbled upon while 
>toying
>with the selftests.

Are these tests already upstream?
I would like to add them to my suite, can you tell me how to run them?

Thanks,
Stefano

>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Changes in v2:
>- Remove the refactoring patch from the series [Stefano]
>- PATCH 2: Drop "virtio" from the commit title [Stefano]
>- Collect Reviewed-by [Stefano]
>- Link to v1: https://lore.kernel.org/r/20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co
>
>---
>Michal Luczaj (3):
>      virtio/vsock: Fix accept_queue memory leak
>      vsock: Fix sk_error_queue memory leak
>      virtio/vsock: Improve MSG_ZEROCOPY error handling
>
> net/vmw_vsock/af_vsock.c                | 3 +++
> net/vmw_vsock/virtio_transport_common.c | 9 +++++++++
> 2 files changed, 12 insertions(+)
>---
>base-commit: 71712cf519faeed529549a79559c06c7fc250a15
>change-id: 20241106-vsock-mem-leaks-9b63e912560a
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>

