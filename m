Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC041251791
	for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376087; cv=none; b=uEXRUpYd98hTe4yeu7W3gNX7xkXKLJEGSNDN57moXRg8zQuKOhx2MVogAntQD7D47jMuQGv68r3KXMJ4JFWdQ/DFs89NeFrkFXH033w4ArY6gtv5j8GvRrP+nlRM2IIYMGHsoAQ5+BWXbt1Mt39uinzvcaZKROO6+2GgXqibKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376087; c=relaxed/simple;
	bh=hayqKUFA/zQJSjM3dzvjLdtKtJ8WDFXlSPyW2SDZhz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fRpm1Eri/D/pI6zQTFIKx7h1aDD8d0zniaOzUZL1R3CI3VYjXm9napZ1J6uZVYuZ41urxKronAEdMhi8IoDqWTnCS9AN+6I+rIl3K4NqH9jfG6XCTkDx7K2+L9+IiiDq7msIOCkPeyMXYIjeDtYyAowL2JElktUb8xeRLrtKsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqfL4RF5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqfL4RF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742376084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
	b=SqfL4RF5On3PKul5OWVvei4wV8b8IBO64+lZ0pqKLcYPyrI3P97llBDZsH6LcLogBjH20p
	653J9Q/XKCdPYlYFh9RSNhRekl9+qG5NGVb/CqsE+jtlL5MuplvwHm3FWg702gb77C2U5d
	v4KUfkOBMq0QeEP9sZQw8mPAdQAEzF0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-9oZC-nlqMCucGKUTOclWEA-1; Wed, 19 Mar 2025 05:21:22 -0400
X-MC-Unique: 9oZC-nlqMCucGKUTOclWEA-1
X-Mimecast-MFC-AGG-ID: 9oZC-nlqMCucGKUTOclWEA_1742376082
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cec217977so28568395e9.0
        for <virtualization@lists.linux.dev>; Wed, 19 Mar 2025 02:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376082; x=1742980882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
        b=YsKMq9CHx7RX1Fg7ULR7JSGPX1Dlprc2DeeCQU8GJKyee3P84kqGcuZ/xN05YK0hJs
         RsCNyf06got12nD80uiV5CngVLszWLWWoG5WJ4WqyWbS73lTgg1AacW9urqL/akQj/P7
         qkPcsFLWXfvfRcE8hkK5nzZaaNXEGoPFQzwwdC4SHis/7zGndBAPGJKzmM/eAbEbMyDE
         C2KikTcjqqRpIRRoIdL9Srta0fuPm0o1zTvrRAuNLY3+EOGBFKtx0+motaTlsPqROIk4
         lgKB30+Ey9PltRLviUhQEkqD68wkAjJml8WWZnwiBHMimWejYseNBSDIb9IttN14gc+c
         YF5w==
X-Forwarded-Encrypted: i=1; AJvYcCXa7JYdXlPZmqgDU3EK60P+k2KBBCOkeegmP7S3tBfe6A0SQlmSxZTjEjHcItYwbjIdukczXp5u75ufYpOHZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOlKt4kF35St1yl9zL+3Nnyt84KWzlw9Tr4A6atODRKAg/nYB1
	UD79GTmKT14EcXh40/oGKWPXW+5FDt/Knlz3NZFM9buWNXixDqdmzo4gcfQHuKlOSGN5/S9R59q
	oRfYdURA4sP+W80TZVjWTfUBo+E1HzL7cG7isZa5SLuHrz0UUtK2Ng0fiC9R+EkjH
X-Gm-Gg: ASbGncvq0SbIHLYLX6hOvlAIDW4jSi4Wvf3S1+/NmXTMhjabxyMxIKzoJFdFcXvy23C
	7WwoygwLKo3bFb0fSCrMogqVIHcYDjWGCXqg1HuTAEvfg1vDGUTJZAL+pEidwqv6uzHv4rwHbz4
	JjB6tPQmF36wlEYEEMXu57RotA9gfd4JvmCasQUhfVCka8tUtcoxGDCGy2uLQVHH9R7/ZzscLTF
	1vybkLP378FSn8ynmhPXRyhSif7PnB1VkFmLUNAo8W+oPleAtTZ3zPE//Vp55r3L16UvNbg1Bzv
	jzBQ9epGZA==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15053065e9.3.1742376081558;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFTbAy+ec2vOHg58y5rxcFbvt1zKhjrhAbtgCtsF91K96gkFV7iO8cXVF5jgAUnN+dJQoKFQ==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15052755e9.3.1742376081050;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm13000475e9.33.2025.03.19.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:21:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] vsock/bpf: Handle races between sockmap
 update and connect() disconnecting
Message-ID: <20250319052106-mutt-send-email-mst@kernel.org>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZTajMQz7-i7NPY1j-28RhRdbxOWnRDpzZpKPTvS5txU_1742376082
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2025 at 10:52:22AM +0100, Michal Luczaj wrote:
> Signal delivery during connect() may disconnect an already established
> socket. Problem is that such socket might have been placed in a sockmap
> before the connection was closed.
> 
> PATCH 1 ensures this race won't lead to an unconnected vsock staying in the
> sockmap. PATCH 2 selftests it. 
> 
> PATCH 3 fixes a related race. Note that selftest in PATCH 2 does test this
> code as well, but winning this race variant may take more than 2 seconds,
> so I'm not advertising it.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

vsock things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v4:
> - Selftest: send signal to only our own process
> - Link to v3: https://lore.kernel.org/r/20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co
> 
> Changes in v3:
> - Selftest: drop unnecessary variable initialization and reorder the calls
> - Link to v2: https://lore.kernel.org/r/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co
> 
> Changes in v2:
> - Handle one more path of tripping the warning
> - Add a selftest
> - Collect R-b [Stefano]
> - Link to v1: https://lore.kernel.org/r/20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co
> 
> ---
> Michal Luczaj (3):
>       vsock/bpf: Fix EINTR connect() racing sockmap update
>       selftest/bpf: Add test for AF_VSOCK connect() racing sockmap update
>       vsock/bpf: Fix bpf recvmsg() racing transport reassignment
> 
>  net/vmw_vsock/af_vsock.c                           | 10 ++-
>  net/vmw_vsock/vsock_bpf.c                          | 24 ++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 9 deletions(-)
> ---
> base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
> change-id: 20250305-vsock-trans-signal-race-d62f7718d099
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>

