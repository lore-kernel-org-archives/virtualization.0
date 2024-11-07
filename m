Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11E21858A
	for <virtualization@lists.linux.dev>; Thu,  7 Nov 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015678; cv=none; b=TKzOGxFczieGFgfI17NgfvFjC65MenzCCQaJf3hsosk5D1DOBOCdCMnxs3k5oZml+31gIkt2BX14EtHE48fdOvzTvjceD5Ea8ZOdGLSgCJWJsdq3lX309TaR/5oPnZQG2xZMua6NcuT/pqHFmjeTwnbyWh0xboP93BisW7ufSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015678; c=relaxed/simple;
	bh=fLdfZzo90PzNEL/By0BCWrAEgq+8ZAKgcUTa2z6seJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nQP8gG5TG2YowATfiAM/XqUoFvYGEkS+wNuCLFpzDvly+ZW/2RW6HVFya/bMLjHPSjDwh1seeJ9vb7O1/k2ZAQacxuWfLSpmCvLvMM78mqVuTt+8o0A/BYcLPJMgO/JBS/9l6KO3sMGhUKv3dGV2srX33x5HRQHA7t/dU2f8gI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVTSsouT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVTSsouT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731015676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKXsXIJ6+wujZXZvZ8iEGuUegjY8zfalZM3UvgSSNaI=;
	b=OVTSsouTRQkALc8BNAQy59w/ykd72OMDhzwT+ovrmuhyqrewzEDFGmrFEQb7HdnlbMddjr
	VQW0GFM3C1Fsm/BCJXfSbYU8KPEW6EcrD67T/9fIa2h9oiZYiHIHCujnsU4UuoIAZpZZZm
	9kfni7HXTrAJPPQg5W0oKrPZ/XBx4vI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-4nKHxOrBPT2T6auM_sD05Q-1; Thu, 07 Nov 2024 16:41:12 -0500
X-MC-Unique: 4nKHxOrBPT2T6auM_sD05Q-1
X-Mimecast-MFC-AGG-ID: 4nKHxOrBPT2T6auM_sD05Q
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c95b050667so1681099a12.2
        for <virtualization@lists.linux.dev>; Thu, 07 Nov 2024 13:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015671; x=1731620471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKXsXIJ6+wujZXZvZ8iEGuUegjY8zfalZM3UvgSSNaI=;
        b=RT/J7Qb+BgukHbxW9c20atWy/+uIL7RdCuYfMyh79bXhy3qA/TXEVZjRKxyMdVV6Z/
         rmTsDCUz8dJDWMb6wiGu8dXq0HR/CCRZteQtlKrWdFKTJf61yW3cNkrqHOeZzpBDkikO
         iv04RFLGvNRvRWfJAzX6fQYS4JIyu6y3FKebLnLoLQqPRO5uTEq8USdhmBuhW6EsGiMT
         U07XECzuOnHdPBnPFK2CQKfHNx4jrf2V7U2qvJSp7XDRvLsVYz2oyhbOvWEJ4+kldB1w
         anZOjLKb1qD5Q2Kk6fZP9a1ng38OTYjxR9IOOtjDqTFKDM94CxueeK+8w97G+UD6JAYf
         PP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3gT07bh/MI9/gmhy3uBFFN/etTIekEBR1mrLW9/vJnFvuMG9KCwk7X4DJLAlgUqphHat/XMW1af4wjWwng==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyPfFYaNjj7U+SPW6o/98Nfz2X78z33cIRRi1XtAm7L6RZPoWd
	3odqtWw5ydsPRXwU+xgs/GL5dwuUGMWWZnBzXOI23aGMn0BAW8dIudHcoL5ilJjXIPtqzysrvVP
	/DGvYl5ObujnK1ICdZV+2w37bt2lmvAV34BWkKCP/Ej7tgayZ/wxjK7sYJZ8bN6zl
X-Received: by 2002:a05:6402:2790:b0:5cf:9ec:168e with SMTP id 4fb4d7f45d1cf-5cf0a30b0c1mr242461a12.2.1731015671451;
        Thu, 07 Nov 2024 13:41:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnySyRq03iGTzTmiBoPn4BtW/0y8BdTVR3G/Nk4eaBwgb/hSu3uiHSIE0b1E3DZtVksWsI4w==
X-Received: by 2002:a05:6402:2790:b0:5cf:9ec:168e with SMTP id 4fb4d7f45d1cf-5cf0a30b0c1mr242438a12.2.1731015671068;
        Thu, 07 Nov 2024 13:41:11 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb6dc1sm1292372a12.42.2024.11.07.13.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:41:09 -0800 (PST)
Date: Thu, 7 Nov 2024 16:41:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hyunwoo Kim <v4bel@theori.io>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <20241107163942-mutt-send-email-mst@kernel.org>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
 <20241107112942.0921eb65@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241107112942.0921eb65@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: id5WyEcp4au1_UQNl6DneJnx3sbdnN36qzlhLGyWCqk_1731015671
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2024 at 11:29:42AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Nov 2024 04:36:04 -0500 Hyunwoo Kim wrote:
> > When hvs is released, there is a possibility that vsk->trans may not
> > be initialized to NULL, which could lead to a dangling pointer.
> > This issue is resolved by initializing vsk->trans to NULL.
> > 
> > Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> > Cc: stable@vger.kernel.org
> 
> I don't see the v1 on netdev@, nor a link to it in the change log
> so I may be missing the context, but the commit message is a bit
> sparse.
> 
> The stable and Fixes tags indicate this is a fix. But the commit
> message reads like currently no such crash is observed, quote:
> 
>                           which could lead to a dangling pointer.
>                                 ^^^^^
>                                      ?
> 
> Could someone clarify?

I think it's just an accent, in certain languages/cultures expressing
uncertainty is considered polite. Should be "can".

-- 
MST

