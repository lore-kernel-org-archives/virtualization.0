Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559BC598BEC
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573132; cv=none; b=U1NWbhb+W5FhLFsQHD9hl7tfw4e5A06RquWqAAU1Jr+jqiRG9rnJPPRh9/1+y5AV+hXorrQ89n+vz6dhiOTYUXkiVJ7OII8uWUqd97YFHt+VZUNgIr21RIBsZbLg0UfwnegmJ5NNqH4jXICiaN12BKZOdpSEkC3xo1/S+jgNEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573132; c=relaxed/simple;
	bh=huEs+LEHo8cFHfOkkR7JHzzpk8mAxFJ2h/PPE9NkvtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=B37RAK4e6cqP7dstVkUy8YrRu0VA7K1z8e7fstx5Pr5dr5f9jC+HkZbLyzpdjCOuLmL+TY2U+elVG+usxo/XS3n+mtPy8jVcGLq3F9IRjgJoB2U/2fF3qMxMb9yXzPhxLFuNG5yRMDAlbmz59OWpABjsaXOaGdRLuHVEBAJZnqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqWM01rr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqWM01rr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789573123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
	b=BqWM01rrJQwkns/Ue7qeVG1W4Mv2Bh1DEPQKs5cCvIjaTR1waUyVQXr/Ps2zE3cqyHJqf6
	iJ/f8ROTnODICBz8RshJcc+5BqMK+yJ4RzIw7MX7eaXkrAi5Nz/s+h6fPHbryJ7sBmAPog
	3aMB9x93xGDRZkr9mDN/3tn0Tm4zh3Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-SmFD0Ol5OYqZN6dxT4kLEw-1; Wed, 16 Sep 2026 11:38:42 -0400
X-MC-Unique: SmFD0Ol5OYqZN6dxT4kLEw-1
X-Mimecast-MFC-AGG-ID: SmFD0Ol5OYqZN6dxT4kLEw_1789573121
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486f3c0d896so2941337f8f.3
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 08:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573121; x=1790177921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJCqqA6Q4AOgIHS7UBKFb/3fKqTDi7g5pa0Z96svO8U=;
        b=S3+lGblUCO50G4l9y3/fZ0DkMhoVtL6xMPFy29dwFm6SoknAcF56aU5SIewkMQGCED
         E8ogjBIKDfCLLliMhEjOIU6Z3xQ+v8ZpY7SqQsIYxRJKwImzDfFdjMuqwe7MPQtdGffO
         2mLviK4hkqJolp7X58eN47zQch4WK0O/b1w/fgor4D8nLkGUoI8vQHqDXErRjO/ej/9u
         iMyTmiTr/87uzbI6QE5vd0m/RcvevQr5SKj0qpPc7CaFTDAgvJ5FX2+nHNTR1o1aD7f9
         dQMMEBEQokvfgiLH1EBf3RbXaXMn8huQ6sxJXVKI/sChkNPulc/nzYlBGT/YwD7W5M3T
         4dLA==
X-Forwarded-Encrypted: i=1; AKwUvBx483bui0MaVt0ffrYlDRr1xbsRPPdEoRQRjiL36wDRbFiRvhAzcHvgub6uWchK0Fw6iwzje35SAimWs9NFBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++miod4Ji8NLW18MQroy2Jx5dLLJIIGqnKafAOajb4CQ/Se0VMag
	k03yuZV1z0rp0lIS4uzVG3zgKUYJZ4+wZxX8t5IGEIXZl1Q5oyXFjP9y4lkzXAW3JqzxSD0ww2V
	hPI1rSrwYRSORXMkCOIt1nIpZvlQL6vq4Lu34gDguU8RgVOpWbVOJ974sJ5WV4mL97fZZ
X-Gm-Gg: AYBFou1mzoQKxGuMKejKW9Zis+BEZD6bO5W+f/Kk5x+R8XEoush+85kpbTCKKhJEdfc
	C62ss/jchw1SV5GCIgI99uE4sfhpW36Yt/JM1upsvTzhBjBJlflolwX18ZnI4FE+f66CvIKKYwd
	yrOqc1uCLpr/sSeyVObM+JSSD6eJ8/acGQAa8QmuAh7XUB0W8vvliLuCKLYI6eCHcL4+f8KTUbC
	SFEfE4DbkaOz9p5DV2Z8cVwg6jPABXdSkLIzWRD6IpXr5XraGB12/bhzKaeDO1atNHIi6G/mxtG
	wJD0pdBrpRL1x6Se8Eci1mIyNBoSoYL+SVAr1nTAc7AaJxr0FKEc68Y7eiZrdH86bql2pjQB12N
	74+b0Dr8Cx/KQKTPHKENZARIDy5WKqiJHjjluF1jgIa+PAA==
X-Received: by 2002:a05:6000:4711:b0:487:fb0:9ff with SMTP id ffacd0b85a97d-4870fb00af5mr2913409f8f.22.1789573121102;
        Wed, 16 Sep 2026 08:38:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4711:b0:487:fb0:9ff with SMTP id ffacd0b85a97d-4870fb00af5mr2913360f8f.22.1789573120615;
        Wed, 16 Sep 2026 08:38:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm7165977f8f.12.2026.09.16.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:38:40 -0700 (PDT)
Date: Wed, 16 Sep 2026 17:38:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	Luigi Leonardi <leonardi@redhat.com>, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] vsock: ignore empty child namespace mode writes
Message-ID: <aqq3t5p0hN2jsSpT@sgarzare-redhat>
References: <20260915141547.3010692-1-qwe.aldo@gmail.com>
 <20260915173050.3176344-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260915173050.3176344-1-qwe.aldo@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gsQW6XyGlJHiaC5Gemy-gz3xJE-25EpOx-gnOnEUtPs_1789573121
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Sep 15, 2026 at 02:30:50PM -0300, Aldo Ariel Panzardo wrote:
>__vsock_net_mode_string() returns success without updating new_mode when
>the transfer length is zero. Its caller then reads the uninitialized enum
>and may permanently store a stack-derived value in the write-once child
>mode.
>
>Return before calling __vsock_net_mode_string() when *lenp is zero so
>that the helper is never invoked with nothing to parse and new_mode is
>never read uninitialized. This also prevents an empty write from
>locking the current mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Cc: stable@vger.kernel.org
>Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
>Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>---
>
>Changes in v3:
>  - Move the !*lenp early return before __vsock_net_mode_string()
>    instead of after it, as suggested by Stefano Garzarella.
>  - Add missing maintainer CCs per get_maintainer.pl.
>  - Add Luigi's Reviewed-by.
>
>Changes in v2:
>  - Return early instead of initializing new_mode to the current
>    value, which would silently consume the write-once transition.
>
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 622dbd0467..XXXXXXX 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2879,6 +2879,9 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
>
> 	net = container_of(table->data, struct net, vsock.child_ns_mode);
>
>+	if (!*lenp)
>+		return 0;
>+

I would have moved it even before the net assignmet, but in any case, it 
doesn't make much difference:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

