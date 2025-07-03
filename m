Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A832D6622
	for <virtualization@lists.linux.dev>; Thu,  3 Jul 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534754; cv=none; b=pHQ83gy3/DwOVSKBvi+ZrQEDFpUyDrvUpmxcPECx8Ymz7HA8aqfb+2K0WgdHGQ85WwiW2zWCfrSizsdT+6Sufup7zgyjigEvd6foBS9gan+ejKIS/bnJkwKH8/9sNBR6lmbdfJ24PEiSlNSGQJgAv4KFitpAzIq7TYU5lV9/bK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534754; c=relaxed/simple;
	bh=STzWJep7C0ueCylwebeqomoBi53CDoyHXyyg3q6vros=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNcaVXR83qbY2I8ozjH9rKvNAqFcNCIu9Tz8dwxgngZckeuE4kMG7U9SYR/xhBkykY2vKya1u8CN/4NMOnW8V/UKKkKe1qcKmWenhhhnu94fBgO3VnQ/Ba0+FGMInxMFC2PkF6IL/l7yEVwnK/DflWQfRcW6wViQ0NtGAfR/Gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIPgo60Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIPgo60Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmUFP/5otJp7Yva7rirEL2lRiqI/PxhyfiBWQUHadCI=;
	b=aIPgo60Yx1rUEP7wrBc57yg3ki75N3xHe+5dmEIYGa71+TANiHnUPsLEHt7NZaHd0mFs2I
	86pJTwveZex9LQ06bSikcYQk1Ntz9QhNwccIW+nhnrGxqG2+p7NVbUbSRnvl1EtGQ+YZBk
	FgpR9P1A78Er4D60dLYXf6sgOKgl6JU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-W654LNRcMIW2hRDVvrnT6Q-1; Thu, 03 Jul 2025 05:25:50 -0400
X-MC-Unique: W654LNRcMIW2hRDVvrnT6Q-1
X-Mimecast-MFC-AGG-ID: W654LNRcMIW2hRDVvrnT6Q_1751534749
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4532ff43376so48179705e9.3
        for <virtualization@lists.linux.dev>; Thu, 03 Jul 2025 02:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534749; x=1752139549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmUFP/5otJp7Yva7rirEL2lRiqI/PxhyfiBWQUHadCI=;
        b=KvXDbx9LYk7nPmuCnsueAGlIC5Fzsw58ErN2r9YK0Td2YDQxq9/8U9kQHbB+jUsmVX
         24BgqeyksiHkBC8rieQ1rChK+NShJV9+dzAIbs70FvP0eYZFjkWbAU6QVxboBqXz+g8T
         cvXQZfu67CI1tEZpRs+uAvK2ZpxdnSixmFFZg4z7YyzsUCe7T989R1tax1sNhW7BTaao
         pEKCQdNwIk0+yVH9DaA3xh6Cs4wwIivwYcei2fzLZwkeR4NH37rN9PLijPQzMLS3sGZj
         C15WvWuuK48hbfeFj0Qe63pnxLAk40sLOaW2MBI4GnuTb/c8tXRLk66AhlDOVttYUuDm
         6m5w==
X-Forwarded-Encrypted: i=1; AJvYcCXPQh/D2fCqoH/R/xPSd4x/DknQEKb6UMra1/OWi1/nU8lvwRj1q9nh9/FPpgiBDHxHYSfyHRh1WvBMOJ/CtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwN9kIyTW2895PU4vmFMzDzOMYON6xGp3L4xroEi/Xar69Qtaz1
	CFTJGY/pUTZH+0R0GFj+ct5X5Bwo4t4UvUWWmIlsRQX8Ux87ixcF80OMopqpx3K7MQSvmoNDV1U
	LUQa11DggwxItg1LCuA5fgRMpZoAGn8vfy7K8aw/2v/+BfU0fzs1v0bgrKaRgcM24WeBZ
X-Gm-Gg: ASbGnctVYssQ7gDn14EYBBk2FQmDAPIFthi8yNqQK5x+Xhxs3Wu4kDJySbKZNv5w/8k
	pe1BDialx3iu3ae9GnRjuSAwou55p4wY6S310vMAJ/63ANlYw2wvuV3BSBfEYovL50gYMfcL4a3
	+hqRm9bjep1dpnevM9wGLmk8jIGopFFPkXCyxV7watRd+SmSL2kcte2hq8yHh43n968IJrWCn73
	in6JtAb65uqjqwUHZ/GjQlGOeLxYukbSk2dMdNOYh+qAVvzETGFFolmm+Qh7zHaZWYYGNDEq+gP
	D85cgsPCLPPK/D7r3cQeiGBclWoxeTtDuyxOQAXe6ks67lw4OYpZFWqsYBKbhQWJsPI=
X-Received: by 2002:a05:600c:608a:b0:453:8f6:6383 with SMTP id 5b1f17b1804b1-454a36e996cmr71174245e9.15.1751534749309;
        Thu, 03 Jul 2025 02:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEihb3DB580vG3swYDdikiInjReCzKhZiPBvQTN0giVHizEK3OOIkuH4ihxHrIuTcVlib7I/A==
X-Received: by 2002:a05:600c:608a:b0:453:8f6:6383 with SMTP id 5b1f17b1804b1-454a36e996cmr71173955e9.15.1751534748907;
        Thu, 03 Jul 2025 02:25:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9969058sm21577325e9.3.2025.07.03.02.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 02:25:48 -0700 (PDT)
Message-ID: <869be9b5-846a-478a-b90f-5e9068387601@redhat.com>
Date: Thu, 3 Jul 2025 11:25:46 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Jason Wang <jasowang@redhat.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250630151315.86722-1-minhquangbui99@gmail.com>
 <20250630151315.86722-3-minhquangbui99@gmail.com>
 <CACGkMEtv+v3JozrNLvOYapE6uyYuaxpDn88PeMH1X4LcuSQfjw@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtv+v3JozrNLvOYapE6uyYuaxpDn88PeMH1X4LcuSQfjw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M7VhuyMCcOdfr0yrD5d-JH1-txnyBjMQaUlPmLI6vsA_1751534749
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 4:23 AM, Jason Wang wrote:
> On Mon, Jun 30, 2025 at 11:13 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>>
>> This commit does not do any functional changes. It moves xdp->data
>> adjustment for buffer other than first buffer to buf_to_xdp() helper so
>> that the xdp_buff adjustment does not scatter over different functions.
> 
> So I think this should go for net-next not net.

Please, re-submit this patch only for net-next after that the first one
will land there.

Thanks,

Paolo

