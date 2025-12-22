Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8270314A97
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404689; cv=none; b=pYzfuu6J/Ji49bPMifRoCY7kudFhdDUuOEfUAYHV8pvd3HRqXH175SLt4zh84A9r09U/9nsYIOEQsol7nD9EkRQLIJxAChu4JCslQGZJ9QPFjGMwB3Zhk7vDbhF3HCAewf1lnOBVxDG7v+cQCANObG3mTCiUGskLJFBtbYG3UVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404689; c=relaxed/simple;
	bh=Y6ymdBuHFXIFtcbNCFI8HRsRKRMfhKrlCr8RRBNi/EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHUrTHTHi5S/jPaNbxP9wGbE3yVOFcSh3GUyqdmHna9rTLOJqi9Tp/TL0B436e+xvtxfOO7f6whk7590gsWTOSBk/Bb7q5WgcOLp6WQjJyDL4yWob5p8qd9r6O7d2U2OvKZbpLQy897rjdnGDk6dsqprmePy5KR+WbWZRWoiF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYaLTHIV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYaLTHIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766404686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
	b=CYaLTHIV8LQfge9t21aIxBhEAN3yW1WAZHiiVHy6suK1KQR6qNnthKj6Vv5zCDqS3QPbHy
	dX4RzWFwdA4YKCNcrOBhAX39ogm9B09RtBTDxXaxzQnr4IVzfH674NOOylH3BpmnvRz2ox
	h9OEvbtT5Yw/NKHBppWmAKtIOO7a78w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-SGP41-AtOXysgJe5ClmxCw-1; Mon, 22 Dec 2025 06:58:05 -0500
X-MC-Unique: SGP41-AtOXysgJe5ClmxCw-1
X-Mimecast-MFC-AGG-ID: SGP41-AtOXysgJe5ClmxCw_1766404684
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477c49f273fso51717715e9.3
        for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 03:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766404684; x=1767009484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Utvi1mro76oUopcgneS5kZCr+uX6+hRQVjhQCjl3EU=;
        b=F+pTh0H+Ri0ryxcfnhYu4O3DRlwqHGWz4mF+MHwIGAXT7CrENFiinZuabPeNebTqXH
         toQAuLhgN0NMnXhN9N0DEcf+dk7R5p7Da5/f2XSzT8wqJxmxtmHD9R71B/QL2XViJMR6
         0mAtOZuU+c52S8z5YfEU8LLZysJlgA+QvoEq9O5FSv7itTV9kaZpKvjsfaITBUpj3wID
         1G6/2WWwceGq9CH1rn5gNSsK2iUiV0q8dYa5ovAg3D3TwdDMIlsV+g03VEQEJ45282sA
         xRqZCTHErLY8dWh4X3SH/efBGQPKIx0Nx1AVJCTIj3u1s5Q5I9xJCexT8NbbwUg2J1UC
         gJHw==
X-Forwarded-Encrypted: i=1; AJvYcCX9CLTLJZF3gsb6j3KUjoRTCe3+JNkQm0U1NAdw12HnWYI4+/5XlkjvibTzSzNunpSQn33C9paXWfdJpDb8cg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yytelh0BmzGO6clt5+WOdgM/Cgfw1bzaQe+Sww3ygidcJmjFHO+
	e8DvuIsdkcchB1GKh6jVMgZAC75ABLVEO4dvgkQg0XifYDb9bGH/xbEax1ACuezTPfbv/CJJ1Nb
	5g+ETEJ5uCmU0FmagPLmkHpfxIr4ugNUa/nTm/OZBgtT38VxHOHPqvIur17JH19wcEK2O
X-Gm-Gg: AY/fxX429aXMw03nZEPIdHRsZt9zW4Cb8j24PvlfIzvw2x1sQEwgXSQOVYRRW8+hmSo
	FGZ3eAKMHrOkVz8P0+j4Ywf71T6I5Jzl6xDkrCRU4bSQIBcJUEK6QGsclscBvAYCA0TZp6JPlKx
	8kVlEngdGYgpAarJl4NVDWT8gjCAixPE2Gf8MoUm93kGXcBFB86pHIogSmzNa2PkNO6pT/cMfQ5
	vxLTNB8/E3QbsiMiv7rAS2vZ2XdOr2apv/sSTb89EPua22JPK51BCqOeI/fD2700rggZWp68X0W
	3AsDCoVJHQcVYdSRFAGBLTrvWpfDwxldWX/MZX97QufSg9C8bb45DvVSadnvjE/F+/rFLe2ELSL
	MwsCadLZ3f0Nq
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr103621405e9.13.1766404684297;
        Mon, 22 Dec 2025 03:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeV6Qm1+Tt8w1qhLiA6tTt299NR05W/UxteZMkGMX6sQ+7Yl9QWOwxUWib7gajoXvCn4TXoQ==
X-Received: by 2002:a05:600c:8208:b0:47b:d949:9ba9 with SMTP id 5b1f17b1804b1-47d19566f0dmr103621055e9.13.1766404683858;
        Mon, 22 Dec 2025 03:58:03 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm21593237f8f.39.2025.12.22.03.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 03:58:03 -0800 (PST)
Message-ID: <8e69a404-18bf-4c91-a6c7-59d5ae831591@redhat.com>
Date: Mon, 22 Dec 2025 12:58:01 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
 <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
 <20251221084218-mutt-send-email-mst@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251221084218-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CyQsnkqQmm0Jx87tC2mc6pk1i35E64uU7DDsDi_LBB0_1766404684
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/21/25 2:42 PM, Michael S. Tsirkin wrote:
> On Fri, Dec 19, 2025 at 12:03:29PM +0700, Bui Quang Minh wrote:
>> On 12/17/25 09:58, Jason Wang wrote:
>>> On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> I think we can unconditionally schedule the delayed refill after
>>>> enabling all the RX NAPIs (don't check the boolean schedule_refill
>>>> anymore) to ensure that we will have refill work. We can still keep the
>>>> try_fill_recv here to fill the receive buffer earlier in normal case.
>>>> What do you think?
>>> Or we can have a reill_pending
>>
>> Okay, let me implement this in the next version.
>>
>>> but basically I think we need something
>>> that is much more simple. That is, using a per rq work instead of a
>>> global one?
>>
>> I think we can leave this in a net-next patch later.
>>
>> Thanks,
>> Quang Minh
> 
> i am not sure per rq is not simpler than this pile of tricks.
FWIW, I agree with Michael: the diffstat of the current patch is quite
scaring, I don't think a per RQ work would be significantly larger, but
should be significantly simpler to review and maintain.

I suggest doing directly the per RQ work implementation.

Thanks!

Paolo

