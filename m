Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804327F8
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843639; cv=none; b=UU0C4CJYOVm3ApxgVrMaIP5kVNLvoBqq3ldeXiG+/M3WqPGjuZPvipiArR2JJFTnEp7CIoeIG/BSzBNpnYS9zloSXxVHIzlApJGGx/z+Q/ThhKLEF/KhfUTsYJV11CshgjTSb2ndYTbbRu8cw4vR9ht1LaGKT4wo4Sl3/GmsAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843639; c=relaxed/simple;
	bh=aE+0RZptDVX4YHqTJhWSMN8xNaI31/QoQy0lckNIOpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8KBXMa+tQ3pAOU2bBs2zvUmU7x0f0TQANHoJo+XcnA8Ae928OnMu2rK1XGIfB2dntyqrxVqV71Wc0L/wtEp77R98qJkaAo0vGwnfo2smBVa09oyvGxzxs2Hgsx8yMUGVbpkNI5RV5eT3zDXeKnjlBkzrIXswB9EL2xMJMDOrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqxESH92; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqxESH92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718843636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aE+0RZptDVX4YHqTJhWSMN8xNaI31/QoQy0lckNIOpw=;
	b=eqxESH92+2meCdsGxSWhkIva9/J9rWjHLJVWuQxQoNRTrTdUuiCRnDuH4L6izxu2IBglw8
	xU3LomHpk7yBBhgnjyaDxiLBcMDGviPZ8jq5n6XEUzU4I+dds7iB81V6VyZ3HZqV18pES+
	UfmLAj3QlYEq9bNma9j9zcvr2AZS2r4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-NGwv-Ck4Pj2keacVuzqF0Q-1; Wed, 19 Jun 2024 20:33:54 -0400
X-MC-Unique: NGwv-Ck4Pj2keacVuzqF0Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c72171fd6eso413204a91.2
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 17:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718843632; x=1719448432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aE+0RZptDVX4YHqTJhWSMN8xNaI31/QoQy0lckNIOpw=;
        b=MKs4kx/tgMGl6pH63Z4Ef1QPQC2o7C/Qwx4Ps0M3MmJjxtkl7gDhUf4CJr/ffGmXGg
         8awgIWwmohWd6rm5sF/BXvOuVfQ1AkqxGAtmomJ9Mxyt+AqfEN9yS3WprncCRtkbRxtd
         kSGQcN90XX/koW7a0PsvPOQ7SH88yi4phbrcURF1X4g4YdwiREd9v30iI5ejL13MvWyB
         KFqhH9nMewfv2BMx7m9T0AoDIdkddaoij5GzUgRD8VvHNYFwHBeuFEKsSenEw4lUGvOh
         fnFJcnqpEqKCemgTlgTX1IQaFMDCQQoI1CSNcWWcXrcrUTVwLOIiGQA8BMNZaFI6nRZa
         4F5g==
X-Forwarded-Encrypted: i=1; AJvYcCUQc98TRnRMv67rN4JMrbe5Hp7Lf6k2TdQs47FjWg/dYZF4QcqQIx83SjlaZM3SuEI4YhlRK7tRW0919dQ8P0LlSvoyhKwJF94S3WqU4XU=
X-Gm-Message-State: AOJu0YygF/quvJxA4aa39xNMrGYZohWTii3ZrBxSnbtoy/Q6leKjFQ6A
	A7jgYGq7eBoMNNqcZNe8tswuNUY7pChPcwPUCPmvG244n/USU8pwA/MrMCaPIIulB33+O0EsYCF
	h8cYenBFcetLvuiomKquU1oCqQaMlwldR2YruZC3xoo7h9IZ1zHY4W5QETNzpvazw7O4C4VGEp4
	E9vCwo0lr97NhOt0euhQayXDwB0Cx+oUZX95E4vd8=
X-Received: by 2002:a17:90b:104c:b0:2c4:caa1:5e3c with SMTP id 98e67ed59e1d1-2c7b57f3271mr4227851a91.9.1718843631976;
        Wed, 19 Jun 2024 17:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq+Z7JSIRE9JqtdLNc0Ec8Z0L7R4p1vPsXN8rKEfVUHHCJEjYvMlAxMkD+6e/BB2Yt1IRjsLNE1R/orwtgN70=
X-Received: by 2002:a17:90b:104c:b0:2c4:caa1:5e3c with SMTP id
 98e67ed59e1d1-2c7b57f3271mr4227840a91.9.1718843631428; Wed, 19 Jun 2024
 17:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619025529.5264-1-lirongqing@baidu.com>
In-Reply-To: <20240619025529.5264-1-lirongqing@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 08:33:40 +0800
Message-ID: <CACGkMEvJ2HUaRW49NBv-vnDXPkUuv=c0-pcnCk9E=tV8gB4UUw@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Use u64_stats_fetch_begin() for stats fetch
To: Li RongQing <lirongqing@baidu.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	hengqi@linux.alibaba.com, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:56=E2=80=AFAM Li RongQing <lirongqing@baidu.com>=
 wrote:
>
> This place is fetching the stats, so u64_stats_fetch_begin
> and u64_stats_fetch_retry should be used
>
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

