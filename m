Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35155351FAF
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550283; cv=none; b=K/Fvp5ELmUB3E70KJEobYEv0gSY8se+3SlQEnPoLkEpcGJa7cSHV1+w07JasFOVq+ID7tooaeOBU8vrTvwrHlMv8wL9+y72GVCgfIYicfq1RyAQhMOddXEpjsPirj1ON+G1fCwIRzmVdAvQW2tVET6spxLqWpFLw1EwqehWbRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550283; c=relaxed/simple;
	bh=QJRpxNJ6nM55oUProzvGLMXrymnGB0HzC7vMJLxqOVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I9klLiwJtgruUMkYNWfH3Q7dsPDnp2eCtKM5dRMNJGnWoO0kkHjlhpsN+sjy6yi76zhb7OxeqpmMdj6wCF0YowU15QzyOKHzsikaq9gvk6U6y4soQuiRuNqKbxsyoo7nJGTeFTlsImgq69r3owdW+3A3mEbHZvcNT7vaUM71gxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAxaz9si; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAxaz9si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763550280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
	b=XAxaz9siEu3dufMJtmuP2Lkb8OtZenxaH9Ko5MrLjkpsJNqwEpli5c/qSu5vUW5ZFqRrKR
	z7IcJvqDdtkpB/S0pmp8ejyHHLH9Nrte5J03RX7sgcx69Lrrb8Mm9NiJMby06Nj7gu1tXT
	fQIIl68vG83Bjh5SNp1xy8IP2ATt9k8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-N4C-6eZUN26lSadN3DehEQ-1; Wed, 19 Nov 2025 06:04:38 -0500
X-MC-Unique: N4C-6eZUN26lSadN3DehEQ-1
X-Mimecast-MFC-AGG-ID: N4C-6eZUN26lSadN3DehEQ_1763550278
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8804823b757so21598006d6.0
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 03:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763550278; x=1764155078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42XSTDD+Tw2WVGrVsFAsxHT5sZ/yd8/fKSBACD6leIQ=;
        b=U33cxtYe//qU/dsd8uCFMfZ3/wiCL42cJmKeU74C6957Lq0arS4Q4K0WOjO77vo0R+
         Znc0LYAb0hFzcjx8eiqtDoGhYz8i9dZbAWE1ItZOGw+xcH8Y0prd+/NvJU4IBS5fnNx4
         SO6bfebt8ThVgNu8xljL8AJnM8fYsVZbsXHNj+HBbxK4kaXhmk63eI0nzU3hWPlOsIOS
         sL8JdHBvESkrKz0SS1umAb0ds5cD/+w2g2ZMcnloeDnZ1rjKHWglmZHxL3Z9KuExRlS2
         XlpWU0lFDl40LVTvZ/BUSYTnE7Au3pFFHr4E0SNd705X14lzP+mfvE/ILAaR6a2FFO35
         wA0w==
X-Forwarded-Encrypted: i=1; AJvYcCWkuyjHI+XVdgSl0JgYWXZdDgQAdbvnWAIR30t6uA/OLc1Dg10h/k4MHf68b/aZ8NeXnl9cDxuP3mACKwjjxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5gLFKbC3rOgeOAsWrI5QX4UOYtNYAxM00FUr6mD+rokSK2syV
	FO9lisw1I8djsmlaxixiNPdA5v7ZLiQumJvBKIWuHTjXWUTGaPHoPjlSqHMYxN2xqTHx6tM4g7N
	dwl9X9Pg7JdKpIxxR2esvfUJg7r4RyS3MMTP/73BXY8cgH84TbXL666+gS4ErbpxXPdT5
X-Gm-Gg: ASbGncvYv9BMmfaQzSGmfgmsh8KUA0ekpC7KBKFyuZKfXpuZktMu68zO/Rag0xPKJwV
	O2TZYbdxcypBtD2o2fuyDCyMyF6LNTW0D2Xgn/dQeT9VamGK5CtA+bypQeRW5PIcaoCekMrgRfY
	akSrAhaPgfGe2s7MN0rnCqAk9vSVsB8uPSSZoL23NrlUUpXti11DtweXQdasLzPWyquHNWPA+0L
	bmA+WulLuQ+rJebtgzWvSe/+ZmNbBGDa58RfzK4rGVgStcOKGHCKECsljU81/N+8LWj8ZXZY5AT
	zPQNU75acKSPWjfI3V6IMOVCLMWjxOaLThlt6SNj7/8wS2KCWu/6KaL82he7kSf7zTnqiReLMCm
	30jdEIZgZ+nYVAellgqQ9ojdZtKcjCncP8VhJB9XkLt8pSMttxViuqTfAnW5Stw==
X-Received: by 2002:a05:6214:5e88:b0:882:760e:822e with SMTP id 6a1803df08f44-8845ffd1671mr19255916d6.2.1763550278377;
        Wed, 19 Nov 2025 03:04:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUx18S7QU3TAKJCuch0iU57e5cRCXq8XDSG2cx+/NGC5m+qevE8BVa0OMVsBGaSQSjDNVFOQ==
X-Received: by 2002:a05:6214:5e88:b0:882:760e:822e with SMTP id 6a1803df08f44-8845ffd1671mr19255436d6.2.1763550277970;
        Wed, 19 Nov 2025 03:04:37 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828613962esm132823926d6.0.2025.11.19.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:04:36 -0800 (PST)
Date: Wed, 19 Nov 2025 12:04:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 03/11] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <tfrb7l3cguctjl5jbd7ykon4aqav4ognxndtnohs7ukmvk7wkm@tpaaicknwwhq>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-3-df08f165bf3e@meta.com>
 <vsyzveqyufaquwx3xgahsh3stb6i5u3xa4kubpvesfzcuj6dry@sn4kx5ctgpbz>
 <aR0arw2F/DmbIrzY@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aR0arw2F/DmbIrzY@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JkkCjKBRt3R6EuyuXz72g1A4zPmiWrIwbH9CZGBl5tQ_1763550278
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Nov 18, 2025 at 05:17:35PM -0800, Bobby Eshleman wrote:
>On Tue, Nov 18, 2025 at 07:10:28PM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 17, 2025 at 06:00:26PM -0800, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>

[...]

>> > diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>> > index 7eccd6708d66..da7c52ad7b2a 100644
>> > --- a/net/vmw_vsock/vmci_transport.c
>> > +++ b/net/vmw_vsock/vmci_transport.c
>> > @@ -2033,6 +2033,12 @@ static u32 vmci_transport_get_local_cid(void)
>> > 	return vmci_get_context_id();
>> > }
>> >
>> > +static bool vmci_transport_supports_local_mode(void)
>> > +{
>> > +	/* Local mode is supported only when no device is present. */
>> > +	return vmci_transport_get_local_cid() == VMCI_INVALID_ID;
>>
>> IIRC vmci can be registered both as H2G and G2H, so should we filter out
>> the H2G case?
>
>In fact, I'm realizing now that this should probably just be:
>
>static bool vmci_transport_supports_local_mode(void)
>{
>	return false;
>}
>
>
>... because even for H2G there is no mechanism for attaching a namespace
>to a VM (unlike w/ vhost_vsock device open).
>
>Does that seem right?

tl;dr   yes


vmci_transport.c has MODULE_ALIAS_NETPROTO(PF_VSOCK) for historical 
reasons. This means that the module is automatically loaded the first 
time PF_VSOCK is requested by the user if af_vsock is not loaded.

This was the case before vsock was generalized to support multiple 
transports and has remained so for historical reasons.

So today, we can have that module loaded, registered only for F_DGRAM 
but not registered for F_G2H and F_H2G, so maybe it could work for now 
and if the H2G is also not supporting it, maybe is the right thing to 
do. (with a better comment there on the reason why both G2H and H2G 
doesn't support it).

Sorry for the long reply, maybe just `yes` was fine, but I dumped what I 
thought because I feel it might be useful to you.

Thanks,
Stefano

