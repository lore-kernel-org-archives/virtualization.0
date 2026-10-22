Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661352;
	b=bKBtQ4D0rB3Xq9uS/1AqR5mcz+onmnZJR67Cj4xNwnHIaXpoztjKlG/fQdq0GdhQGZvy
	 zwGmoGb0Vq0wwZBwl0CpriZOfYZlsxvn4jLhNPFxIgt61aaoTk1+UGY87J+zdIwfeAIJc
	 HL88gIPMvYPiF/G9AueSd+qwai1aQAd8Zx07oTJgUwKXv2qyuV8KjnHauN9XJwq9DFHRb
	 8XP55Cd6K5SMhFpNnEwBe9g7c2bNFTFnRnxrRJ6oayQZp0Ub9REzFXcOzzQ8M31/0QvVs
	 mTpxkhOf6JV8tGNi7nEVt6AxMEcRS/VZuQ+L/iZ1Pkr/2yogR9gl8rj5m3PD6j8Edgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661352;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=6C0nwTWJOi88sDum8VGip3YZoxwI0Nc79E5HIgWtPfM=;
	b=iY3GzC+e3fvP/2HIycJB6JYEeDWGR0VSLGmJR5LdJosQpD+6TU9/vf/6fTa3cTDbzReH
	 VQQNLo7ZtKS+XxR12cO3HYgcF7WFFXdCpB6zcet5XPSZ3E5t2+RFkMnhvcpVTNZAS6v7j
	 GqUv/QbJc5c4aB0G6atMDOuPU2YChHZUU8wLKedK4E+d/7Tp43pbTtff8m/BWifhmzTRV
	 KlgeyxA5bwq71Uzt+x7c9eSi/zgSqaDnQ8maBMs5r0yipgWUKMvp2eCJVnHrZTgHM5RHA
	 b23fSnLrZJYGooWbas0DD5Gb124OieG3q1xmAAhTEDNNj8DfEP7KCFTWv8VI/kgWcGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKogVBnj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6C606A31E
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 09:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aKogVBnj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792661351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6C0nwTWJOi88sDum8VGip3YZoxwI0Nc79E5HIgWtPfM=;
	b=aKogVBnju0fKsOUL/kesKMM2Wp5JtDTTGKhjuN+9as/8zBiJ0BxWR02q4WRG7/FcJUZJQa
	Jd01YiXKOT0ZY0AriPRzdvRTmxneCgLhuWhtA0fKZ9X5ktwTtlKdz6dVeeKAEmdOqLOeio
	HreCxKqSAcHFMlrjJAvj+eG1V6A9NGY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-FhFRuxuOOm6y_LIv8-dMnA-1; Thu, 22 Oct 2026 05:29:09 -0400
X-MC-Unique: FhFRuxuOOm6y_LIv8-dMnA-1
X-Mimecast-MFC-AGG-ID: FhFRuxuOOm6y_LIv8-dMnA_1792661348
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so12796865e9.2
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 02:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661348; x=1793266148;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6C0nwTWJOi88sDum8VGip3YZoxwI0Nc79E5HIgWtPfM=;
        b=P0G9MsmiCacBHit0RVc/2k/k6kyYzoK602mIXV58tJfXCFdPuUiqiczfHgQwVkmbx7
         AcITYETXXdwDgva67xpscKK+FBJj94TTJN5fCUmilhDdNqpD7g9sdXiQAF1ebUw0Hni7
         ic/C/9F/pULDmxadlsjbK4+J7+CbypnJSIuDKOBAGeiScJ5vby+H+5g2NsqycgtEQ0In
         an/nTkk6HVAnXeu1dzIUdWqlxVRL1VFaD4yquQ3x4cepmf6RTsimb/hbOKst/Lq9dYyS
         K7I0k5SyKumThafFiFemub8PhPcm09vB+SF5AN3C6Pg5Zw0DZz0UdC2GOvRLNbhTWBD8
         4jmA==
X-Forwarded-Encrypted: i=1; AKwUvBzOvvNgND9F02pwPTP5LW75bJQVV2GFmmmXaYbbRERpf1a6/LYpq01M4vlQnuF+DJR0HZyHKTwh1KAjX6lNzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIFGfM4siI5rtzZuIrMXDXyucWOu3qgPb4Ng7hoVQp2xzi9h4yy
	V0Tl8Co9vhjDFGgHyiedgMKBegxZVFJO+rPRpgqEKjvY8xMo3iHT1xhWUHQquC9lcbMT6AnPnc2
	/W49uUxqb6FwdvGO1QvgxfGR73eF0U89f35/AUUpv6c1pygrsauBHrGtiERcDkmHJ4D/X
X-Gm-Gg: AYBFou0SNXx69MtQeynDc2FczXjkahfUZLRrzdGmGf8f4Ht1JZmYlC5kywy7QoniD5M
	/vdnPHh15/3lpye2OIdU9qxGZj2bud0Uw4R6I2qnnHZG48TwKSQ0Iw0vP54ZwQ1icWPwvxCpPlw
	Qwz4vF1OXY2Ku1nfvcur3RdnyexdGWLnFoTPPoGZbUGQtBAI4mnE2MkkQ6E4RAB7x6BZhYCqVv4
	4lAsfvvpn+7hupjq143rs6sCZpHqKXmyZijvwUcNNFsQIWPVRtwAWHTWw6UCsEh/1ffOvAaC5Qj
	ZfcZm9cmq1HOd0t1G2I4SuzRQeiCAi9bQcKbd8XkkUyuoNDgk/EReRneOBRDugJq7Acb+0Id1yd
	Yp9pSc05EXh3pNc4069upsFPSpmOC8jTkuG4LI2qNlvMot7mF9jhqclye4BWFRCjtMcs3L4jHPQ
	==
X-Received: by 2002:a05:600c:620a:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a1fdb1a609mr83563715e9.7.1792661347978;
        Thu, 22 Oct 2026 02:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:620a:b0:4a1:706f:b40d with SMTP id 5b1f17b1804b1-4a1fdb1a609mr83563385e9.7.1792661347465;
        Thu, 22 Oct 2026 02:29:07 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203b42befsm54154205e9.8.2026.10.22.02.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:29:07 -0700 (PDT)
Message-ID: <9756cf25-6951-4330-959b-3260f4760c3e@redhat.com>
Date: Thu, 22 Oct 2026 11:29:05 +0200
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] net: tun: zero-copy path can expose uninitialized packet
 data
To: Cheng Yongkang <teel4res@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio Perez <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261022091847.3654028-1-teel4res@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261022091847.3654028-1-teel4res@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3TqCZ0meNML7EvhQE9lnvTSHYcdCpvk_ObTJL-OcyvE_1792661348
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/26 11:18, Cheng Yongkang wrote:
> The experimental vhost-net TX zero-copy path can hand TUN a user buffer
> whose effective vhost virtio header size is smaller than the TUN
> device's configured vnet_hdr_sz.  TUN computes an skb copylen that
> remains larger than the bytes actually available after stripping its
> configured header, publishes skb->len from that copylen, and
> zerocopy_sg_from_iter() initializes only the real payload.
> 
> The resulting frame contains an uninitialized tail.  The tail can be
> read by userspace from the TAP peer through normal forwarding.
> 
> Observed on Linux v7.3, commit
> 08ab31164c55f20c7a2653de3186ae333470e2c1, with:
> 
>    init_on_alloc=0
>    vhost_net.experimental_zcopytx=1
>    TAP vnet_hdr_sz=200
>    vhost TX total length=256
>    real payload length=56
>    TUN copylen / skb len=128
> 
> The exact control with vnet_hdr_sz=10 delivered the expected 246-byte
> frame.  The corrected trigger delivered 128 bytes after submitting only
> 56 payload bytes.
> 
> Sixteen of sixteen corrected triggers produced the overlong skb.
> Eleven of sixteen had nonzero bytes in the 72-byte uninitialized tail.
> Several contained recognizable stale kernel allocation content from
> previous skbuff_small_head users, including fragments of environment
> entries.  Those bytes were never supplied in the virtio TX buffer.
> 
> This is a userspace-observable kernel-memory disclosure on a
> network-forwarding path.  It is configuration-gated by experimental
> zero-copy and an enlarged TAP vnet header, but the overlong skb occurs
> regardless of init_on_alloc; init_on_alloc=0 is needed to observe the
> stale tail in this test build.
> 
> This is distinct from candidate BR-023/BR-025, which exercise
> IFF_NAPI_FRAGS.  This reproducer uses the non-frags tun_alloc_skb() /
> zerocopy_sg_from_iter() branch.
> 
> I found no direct upstream fix or CVE.
> 
> The vhost ring reproducer and complete program/console logs are
> available on request.
> 
> This was found with a multi-agent workflow; the
> information disclosure was reproduced in QEMU/KVM.
Please stop this AI-generated test-walls dump: it's not very helpful
except for other agents consumption.

Really, please stop now.

Please instead ask your LLMs to try to generated fixes for each of them,
manually review the generate code if you have the skills, and share
the patches on the ML, at a very limited rated (no more than a couple
of series in flight at any given time, with no more than an handful of
patches overall).

Please consider collaborating with other already in place projects
(i.e. nebusec) to make you finding available to the community in a
responsible way.

Thanks,

Paolo


