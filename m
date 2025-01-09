Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460692147ED
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407905; cv=none; b=VouuNdZppBqbyY/ZaKbq2EaPQBOtOfnzxWxkJ4K0d7KcIxtnRRZtcEMwCCJCkTQhfqOjnmpgByK5q7Cbc6YyX/Mn49wgVEaZUNz44mt6kgr0+SCreP+4YMV16YXKtcOPhcJKfXTvXifKsttWPQbPaDL94mT2UOWTrIW5220s8kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407905; c=relaxed/simple;
	bh=rBPdYEnZvtSaWGeIKaMzYx3ocXn/sfrS1kD4E5tn0hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FvvopoBp32sLyLsrvwMs8oYQN95706D2Hxa2G8s+UCaz+DeO5twh0mJelgVGf/DyAEZQvj3VvF6dNspE99vgdj//cS+tTo4RwdiPVeRXPJTgs9oxJFwPRCtUobBM4Bdtw6MZpLaYc3a2l9X9jj9dQTTVWHOd2L0PCh/bBxUueLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNLUKGhm; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNLUKGhm"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7CA8402BD
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:31:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYKdtZg30AfA for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 07:31:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E16864038A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E16864038A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HNLUKGhm
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E16864038A
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736407900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pr4ssIrc4EtFfekk83GYUXsTrXGomg6Zpaa+C070Fnc=;
	b=HNLUKGhm6SCt3oyDMvXbdLFfbuFvA5CsBmvocje5pbNRQwNsTBMC38Xzr6dbQ7h32iy4qd
	GaiaAvO64x/1SmsaBkQ0t5QHN0rsK1huPTRj8snoXCplh2fNjsXFGXtQoOu1WbCj4vbFqU
	e/BA4euhYO8V71d1/8zWeE13BQZtQ4I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-U-OBjUkMNMCk8U-BPH-UtQ-1; Thu, 09 Jan 2025 02:31:39 -0500
X-MC-Unique: U-OBjUkMNMCk8U-BPH-UtQ-1
X-Mimecast-MFC-AGG-ID: U-OBjUkMNMCk8U-BPH-UtQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa6a831f93cso68011166b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 23:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736407898; x=1737012698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr4ssIrc4EtFfekk83GYUXsTrXGomg6Zpaa+C070Fnc=;
        b=PV6r/6r4h3Gau/apC/UlVU2q7W5YrN3rt2+DrmGKxbJ6d2JZLJ+J9APbTbnWpV5gIV
         A+NdEbmhM1y7ukV1HwX4REK7U+4u/CSwlz1WM9i2lxwB1vk5Oywa8a6PKQhAajk49pAi
         OdBMHJTTXjVwc3O9WF9A7romyTYFNoIsQCiI7lnrV8kQI1bRQlJNbHsK3MXlrn97rwTd
         W41poy0zUOqWQBqem/9RIsfOzFgSJHqVSUHLh2o+nLHr9oGwNGRyacdKkA8s8XSSX5Ep
         UtQgIfs0uwo++ik1YJv0aut8YPLATupox1wf3TkmDiwhX+bXZHpe7paOPBUXOPGTmd2k
         NxCw==
X-Forwarded-Encrypted: i=1; AJvYcCUp/6cdC0qFNtBNufUjFM1j4iARJRMiw9Y7LxTSHTjzmc3WAtY7Kw1MZBCP/0fzBkkLB/UOeZCT86oMowCjyQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwQLYj2S93+W6dH6cpOqQt3tXj0Mn4pZAmPzw3TlITk0ikfdoa0
	Arl840Gx6X0shTZss3lqzyRkXC3QGyL6ToT2bCwxHwjkz3QxktB/dJPXhqCOpv+dHsXjb9WCqnN
	O1kkmLEy0fQhvDWFD2rn+O1J7E/613zJv+pq3TlJGF5YeR0N8LvhoaPF4ngK36ChczRep6ham93
	Aur+w=
X-Gm-Gg: ASbGncsYCOtrMSOuo8C3zhMnvBSejW2wlxh3mZKqlzdqvD99M+6zPwXlJWv+7e4EVWi
	Fs5qWsbxpwYE+MM5nmEd40m/+vrAM6cgrINHcqs57otJOTwJbun3mYA51xm5UTkcpGIFALliACA
	xNRKuFcZLEI6KgiN7rzdYctKvWRepmPgJAh4ML5HiF/oG6P7bdRpLOdY3vY50iJSORDUmqjZHao
	XR8P+4G6+qsHjB3BIH/N+U7kzZU4VSNahEZxs5O2UpbfiYy/mU=
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:128c with SMTP id a640c23a62f3a-ab2ab6a8dc8mr488065366b.11.1736407897993;
        Wed, 08 Jan 2025 23:31:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4ZKe0mzkcp2svj7dRwqQX0ex75ZtTovLeEL0VhHSiIUTDBhHXztbYHy36NKkZRj6x0d75Jg==
X-Received: by 2002:a17:906:6a04:b0:aa6:800a:128c with SMTP id a640c23a62f3a-ab2ab6a8dc8mr488061666b.11.1736407897607;
        Wed, 08 Jan 2025 23:31:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:175:d62d:93ef:d7e2:e7da:ed72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90638acsm42482166b.20.2025.01.08.23.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:31:36 -0800 (PST)
Date: Thu, 9 Jan 2025 02:31:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Message-ID: <20250109023056-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250109-tun-v2-2-388d7d5a287a@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cg972iHrfbqEnjYJ1IZMWbxNHogCUPIkhePTBuNP8oQ_1736407898
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
> 
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

But if the user did it, you have just overwritten his value,
did you not?

> ---
>  drivers/net/tun_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> index fe842df9e9ef..ffb2186facd3 100644
> --- a/drivers/net/tun_vnet.c
> +++ b/drivers/net/tun_vnet.c
> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>  	if (copy_to_iter(hdr, sizeof(*hdr), iter) != sizeof(*hdr))
>  		return -EFAULT;
>  
> -	iov_iter_advance(iter, sz - sizeof(*hdr));
> +	if (iov_iter_zero(sz - sizeof(*hdr), iter) != sz - sizeof(*hdr))
> +		return -EFAULT;
>  
>  	return 0;
>  }
> 
> -- 
> 2.47.1

