Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E39320CA0
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049506; cv=none; b=l885BE44Vu8X+UZSFo0Azc6DanOZ+1PSKn3Z11K4f+Oz25H2t+iYU9uQKO2JHi5Lo53kXoz/GcWBNYySNTz0o2tgHqWNulo0T73QsJwwNs0SuN/J62xBc91WW0xgzQXPEVaY9i8smkbLGKlqyd8QLf20w1/yQFM/C1i0Kjn3cc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049506; c=relaxed/simple;
	bh=RcOUD8PizUrveNi2sWL4N3Or/VKczgaKQcnCIdRnJWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k0XBYMm6cYOmfNkzvhqAQoZOqUiW/TDvjlhgljXRab2QgoSrURIKuyz4/IHYU1Pige7CIBYXJysgx83AtJNB4ze3sgphgQW5UoiYJfRah3g5dR3vcj4Y2SjIQDBMuYyVa+Ap2B3F66YXSLKPTaTe5q9hh/UIUfwbQYckxoSTXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JClLM5ps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JClLM5ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y8NO7Mq1adk0vM4mhl9J4FEFJM+mdoyo3nQIjYbenU=;
	b=JClLM5ps9W8m04MDAQU+zt7Y5pSkpJaB6qoEXi8AOllYAn/e26qUipsu0EqUXC/l7Ys4/f
	bF4D7ZlwkC8N9lHJXOeLZkTspd5Svb8yYgXjfaHRDV+1Bp9GUxm96KD7/iYp/R487gGBDb
	gg1lOxFkVHyjs7g585D3YpXRJ87abno=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-FFPkN_SwMj2oXZN-6bPqQA-1; Thu, 18 Dec 2025 04:18:21 -0500
X-MC-Unique: FFPkN_SwMj2oXZN-6bPqQA-1
X-Mimecast-MFC-AGG-ID: FFPkN_SwMj2oXZN-6bPqQA_1766049500
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7a43d7a1d7so32740566b.3
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 01:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049500; x=1766654300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Y8NO7Mq1adk0vM4mhl9J4FEFJM+mdoyo3nQIjYbenU=;
        b=v6atcDHbv3XzxUiFRzuOkbj0Py7+iN2HeRhs1YrvYROGj8R4qCNM/RoCarM8KGtiRA
         9rddq/DC806QdoOFn1+60/GJl7eRjZ7sIwKAA+8lCaq6EGYFeIXv4KRr5pRjnd6CUAqg
         5W9YMzgtT4Mo/hDiffKp8vu7K93M8MBFYjVJQoZ1hfV7+CUoAwHaxbBlWo9p57DrqGKI
         mlDQUzrB0WP8gEmbbiVIg1auUY0yjTO37t6Besjo4jbo9voq5zJPZhSkyfgQTO96D+0X
         HDPKgvdnASsQePduttTHGlnIJiGiwn6j81Gbhf9xusgypYs7KRYnoWIpCR+xIJh+++dC
         YUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKcIusXkwDGI+vTlYxp9De2ueHKSkD2fU/PCoE3h4tm+2ekhUOogm8vSdV/dJUkiRYQwbMnesypzqfOjlRWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxuf0avac3FUMXRm44lV70LhPuM3cIq0wDrCyiwFPO9FdYA6Dly
	DacoBSk524nblUn0AKEF7RG/f0gqL0vMZx1N2uxxeMwJO0L0ercalvl8cBoTV+NQhiDPbfdGtXm
	JHOhR0QU8vx+xQrIHDoRtZQhwS1BqRF5yahcNNQJw3caEWvF3sKvd0S3R1auYezeGBAFX
X-Gm-Gg: AY/fxX70WH+No7jHNL2wyIONgcjhUCr2+HdwGPi+r1C+ABCSy2BB2dm8XZhQduhKUxy
	ZvdyI5yfCzQu+KZCmQkSA9lEKUBsT0bg17/4u8uQ4O+SYBF35qHUfnUS3i5b2zfWnI5pbmIrEIh
	u/LB7ust+C4SdJOmr0w4CJwwqGbsk5X6iZvRCBBFeEECvhAhcBauNJzGJn8oEHVSgZS3/MaS0fm
	Y46pvtr6dg+Ok5bfySBIE8jin+VCiwQgEOJUEEm+Fua4Zs3cZBL2a8cMxOooU7fJm+qY1+lxt3n
	WSJznpsq5pCavTJrIwk4C3ZMBzjp29YvyPBmjyG3Uan4t4Bmmm+JbtEw41dDLYFa45J+JPW+47y
	2urxDu6S315+eWRQ=
X-Received: by 2002:a17:907:9494:b0:b76:ece0:368e with SMTP id a640c23a62f3a-b7d23a401cemr2117452866b.47.1766049499999;
        Thu, 18 Dec 2025 01:18:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcKL+BM+WSBzW736mQ01Q9Qz517mYVZpBrWNfzO0M26INZM8AbP6Rm/+n3aYe01EJOghEvnw==
X-Received: by 2002:a17:907:9494:b0:b76:ece0:368e with SMTP id a640c23a62f3a-b7d23a401cemr2117449966b.47.1766049499454;
        Thu, 18 Dec 2025 01:18:19 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b585b52afsm2060402a12.7.2025.12.18.01.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:18:18 -0800 (PST)
Date: Thu, 18 Dec 2025 10:18:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 0/4] vsock/virtio: fix TX credit handling
Message-ID: <xwnhhms5divyalikrekxxfkz7xaeqwuyfzvro72v5b4davo6hc@kii7js242jbc>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251217181206.3681159-1-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3XyTnxZOrQjghbwyonuK3dhJQ9HvwJTdJPK0nZ1dLoQ_1766049500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 17, 2025 at 07:12:02PM +0100, Melbin K Mathew wrote:
>This series fixes TX credit handling in virtio-vsock:
>
>Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
>Patch 2: Cap TX credit to local buffer size (security hardening)
>Patch 3: Fix vsock_test seqpacket bounds test
>Patch 4: Add stream TX credit bounds regression test

Again, this series doesn't apply both on my local env but also on 
patchwork:
https://patchwork.kernel.org/project/netdevbpf/list/?series=1034314

Please, can you fix your env?

Let me know if you need any help.

Stefano

>
>The core issue is that a malicious guest can advertise a huge buffer
>size via SO_VM_SOCKETS_BUFFER_SIZE, causing the host to allocate
>excessive sk_buff memory when sending data to that guest.
>
>On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
>32 guest vsock connections advertising 2 GiB each and reading slowly
>drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
>recovered after killing the QEMU process.
>
>With this series applied, the same PoC shows only ~35 MiB increase in
>Slab/SUnreclaim, no host OOM, and the guest remains responsive.
>-- 
>2.34.1
>

