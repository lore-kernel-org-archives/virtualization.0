Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D1D20DD60
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672167; cv=none; b=YQbAI3fxg/WFCKtS74x8RNcWv824QCHlWgbG1ZwODgrG8PX3zldI577DaHsTyEp6yPpR1NQi/6qrH4F84QCClczSLkRtejNIsZtYa4nf+xshAgK6mJMCGCuhRQ5U8EswUP9/eBFi7BbmEjRnTTNMdHgZ0nUXpJ8iuyaasb5oCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672167; c=relaxed/simple;
	bh=u6K1gc6fqbQ9CyQmR1XZtEDc+/599QHfU81+5JM+XJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HO2UXXKixT2WEWKD3OVMBN6sSHKSa66ru7pM9HHTn+NLRDGXhORzYngvVsn/FRJhe8UPlG2QeMlpm7boCR5Dvj3Qzf5fipxYkMzPF9f8FRvKMgD1zlB4+yLwcATt8epvup1ZcBJ1WTXLLkHQyrcstmsJDLnKrDBbcuaZmSHKV0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpf4dkAg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpf4dkAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738672164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVt11t4VdzXmaGrVYonLKU4tNbyq45g4LumiKNuZLV8=;
	b=gpf4dkAgfZJjGroqrLhLo3yFumiFQAk31z5ESXLMhDdRsT+lQuGavqltxlpN/7zOUmC8nh
	aTwS84LAU+1deAaNSOI9AuQ2yVC1ACrk8zt+e2NXiwMKgha1x6qno/cGPZp+dWxl/+QdRm
	nlNcTk6Bf1bHEzcw+QtC4YaaxFYDY2o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-6ND9xproPVKPw6UJxQ8-Zg-1; Tue, 04 Feb 2025 07:29:22 -0500
X-MC-Unique: 6ND9xproPVKPw6UJxQ8-Zg-1
X-Mimecast-MFC-AGG-ID: 6ND9xproPVKPw6UJxQ8-Zg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4359eb032c9so38998985e9.2
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 04:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738672161; x=1739276961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVt11t4VdzXmaGrVYonLKU4tNbyq45g4LumiKNuZLV8=;
        b=c/QTyQ/izd7sx8D9hXhbc+ubqEnwPx7ZtNyRg0rNmcc5fNyPVRnTZwkGpsWTbuL3rp
         Dit/mSlvhIZ1LnZekOZPcoutS/sNU8Ur10RW2czUQi5YVuJL6OyBAAerRG8KdYY77vYU
         JFZfmRF/70TQJG0CsDS9YJiioUHO7HwMRwPEbCUUjRi9UKQvvGhDRy0j+KmM6he9zOs5
         jfdPkpsJ3umzVosD8MJJxCkeMH00f+2H4x0DZWpxeuDXTBuAoSAZgCIKiCyuKgPyHOt/
         oKJaie2r7eWmtCgZJOjJclojeYdb6SwKV11JtqTrfIb9wOLHj4Pg1YkUX3nZGljTvIM3
         sCww==
X-Forwarded-Encrypted: i=1; AJvYcCWWDKsXbWPtUYdwvab7e2tZs2bHkjNRIf+HzNA1R8GjBoM7Qy4RrrceKi8wVY1FOoRbg4Zf/GXOzFhhdyXMqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7y6fG6ASNjC6KhD/3coLgT/f9R9Q9i2ySe9DIhogIey/NmMK3
	p6w7S8Ul1GNymzS7Lk3ZwqVd7VCvOLdlK+CGqvcznxDDpPphrRCYOLdFU8rBUHOYEnyowbv2kY+
	E9td6+BgTBabCeOQn5QWkZ4vxMoXYBE1qTZrF9tZDip2/n6lM/52i0OGN/5U+Rlqn
X-Gm-Gg: ASbGnctUchtdJrTFF4mDnRHK32o4T2mCN0B3DE4LOGX/82DfFrg/EsLxye/eTuLi8z+
	DXqXGLCgG6G4TCv6tGBrldFLSJWQ6iE+n70fhBie6mXflVfEZQwwqxBK/3vUy5t2QYyqJEcsJl2
	tq34M5CbhMZq161LinuVX9Sto7Pc51I03UgmrW4ZwkdkKHGzsBaKQY8TIS9bwRy7Jk9ICnHDUSS
	Cfhxdtk+qoOpOSiUEz0bqFVgTcoxz+ZQTVu/XwsEz5CSqtRsJVCUT+kgCgC/DqX8f4B6v7Rwzjd
	WfJsehx+ZdTb7e+cOTAP4TmpfvQJoCAqYfM=
X-Received: by 2002:a05:600c:5248:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-438dc3cac3cmr242156235e9.14.1738672161574;
        Tue, 04 Feb 2025 04:29:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6sf3mUWx9f6oCktAawZ1NkGZse1Cb+QiEWr0dnqS8PjvhkiCOef50Jj0CTOWCanLTCjNSYQ==
X-Received: by 2002:a05:600c:5248:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-438dc3cac3cmr242156005e9.14.1738672161191;
        Tue, 04 Feb 2025 04:29:21 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc8a59dsm228847985e9.40.2025.02.04.04.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:29:20 -0800 (PST)
Message-ID: <c8dd0458-b0a9-4342-a022-487e73542381@redhat.com>
Date: Tue, 4 Feb 2025 13:29:18 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/6] selftests: ncdevmem: Implement devmem TCP
 TX
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk,
 Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>,
 Pedro Tammela <pctammela@mojatatu.com>,
 Samiullah Khawaja <skhawaja@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-3-almasrymina@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250203223916.1064540-3-almasrymina@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kStBEqLvq9CF-D38O0OG4sagHklbu_bR_9U2F_yg3no_1738672162
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/25 11:39 PM, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Usually the self-tests are included towards the end of the series, to
help reviewers building-up on previous patches knowledge.

>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>  1 file changed, 289 insertions(+), 11 deletions(-)

Why devmem.py is not touched? AFAICS the test currently run ncdevmem
only in server (rx) mode, so the tx path is not actually exercised ?!?

/P

