Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B418FDAF
	for <virtualization@lists.linux.dev>; Thu, 26 Dec 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248257; cv=none; b=gN+owvVe450I4uchNTC1n+grms+3hqPV8fvN1dh2ok2IN5gyrmqZUHI+Co3J5ZVfucz4ZbQnIEVajxnh+6UhHsAyrAb1dQGMhpj/ze2BT5OJ14/ZRQgImtp04Yi7BePmW1x9CdhDoxSq6saCF6hSanmRJmu29SrmT4Cbe848HZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248257; c=relaxed/simple;
	bh=UtPtkiMC9aMLooraJK0OO9y9CL0h+3uSLW06oAagplA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PSCjA/r+mN/7ugwr3Ea6C61dI6sBOiooXVuF28peAyEe+rrvD/4qa5S5l+u64g0wl3npsrYj+6DxokEGvWaWUrekG2p3ezcFUrwlll52DKCTVZyJT74VE2fOYxaNPjQILnhz7402N4JNt+w3y7UWwqMQAKUVOnKTAH+/Un4xMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUFw8yZ5; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUFw8yZ5"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467b086e0easo35335291cf.1
        for <virtualization@lists.linux.dev>; Thu, 26 Dec 2024 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735248255; x=1735853055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfeX401MSHvmmCPqi6qpPfC5xzDKFLL9ih2D1zIAmnc=;
        b=WUFw8yZ5DgXOdHxIqaWsz32ofmrXTpZPdcC/l47FkxMQGdALQrPlQZvZbnw0SQm81v
         mH5uo4bGMcWktM1gIQ/gbW+E//GRPRFhVdE2Ce4aqp2Ug0qInnv1+qiCPRoP3iQ/7h4t
         ZgY4wA/aguqIcg1fj2VYorqWI9gGF095cMMWwY79rXIue40CAzS+x28rj0hMDYrxStm+
         aIUJGh6kEzrqffk48BFXpJvmSAEiOrVEdZl+paGihfy+I9alJMyCz5MK8g2uTSL37QqB
         S0Gnrhe/8ARslxtVKUtRTnts7qxHvocNmZiZjyL0elRHK4l41Q4ZxdVQjlpUU42Vw/sP
         QReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735248255; x=1735853055;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VfeX401MSHvmmCPqi6qpPfC5xzDKFLL9ih2D1zIAmnc=;
        b=M5pw4M18bwwuA9hbBUS0tov8O58vhntq/EAwF5pdsDpVk4drtOtuZx9tIuTqYl7Pw2
         Jt2Lnf6H/QMrkwfqugYnfuEUMHsoNPGKd6yUNp44pwRpEenlUNbNJBsbRt/DfKtpuNxr
         LHQR3bUJSef0kgFhg5buY8PfCuDDzRZC8J8Sntc3RNgDeB/OGJY2Fzy5cJNd8GDb8okf
         owFHzy/l6hyWqi1dsTSzZfLHWCkzvUJJxfea6LwS9tQeWqrcGqoOZtS/5P7Ya04Ejj5D
         SOX8tvuTlu9v57ZSppP6FhPj68C57BX/kzHVoXd0J9LdB2H7cAILgmOz/QhPEmD/JgvX
         mYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUOE543ygYYY/rLnz0zndT4J18i8aJPIwp1aNXweQfjzGjpvD6eDgrecV/5LV8vaz6TtetKVtYROiJEzMj2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkXxvh4xbgtSA+V8pYSJgQGEu7vNT+ZkkALpA4E31RJqQTYrAf
	Jf3dirdGKd+DhDj/lEBogGt0c/+VpZHwfabMaI24nW/NlRrGcas1
X-Gm-Gg: ASbGncu4Tt1gkKMKxY2Bf6bwc1LvYg99Audi3M6kTnQJA4vvfErr4qYlueLZVanfOLC
	EsVU5eKLRQOzobqCinW6BJfodSBOZk5rWzE3Yhsin/vQZNVI6e30qyqMU+/HGF4wpS+PjwpEbJh
	O4nRbFa5hkUBmSyo6DExAcO+AS4a5KTxU+bQl93yr81Uc3MRy8bRu8MRz9b4ViEQHPiY/im+otP
	rwzpM5ysHVXVTIrQsEOzxpnS0AjQFdeob7aVSEXv5wmrvrXVsc5QzdvJZP5NtZ8SS7Kepbo7WwU
	eBpQF88kBMn1VyxCMY0Ursb4QWr2XJNZzg==
X-Google-Smtp-Source: AGHT+IHU4gOFbrplgEWifYfJdFaG1u/QGgASBA2M+5ivbCzO+XzXulwv1NBgHR7vrK85NZx/bB/gig==
X-Received: by 2002:a05:622a:13d0:b0:467:6c18:9855 with SMTP id d75a77b69052e-46a4a8ebb04mr484623951cf.27.1735248254929;
        Thu, 26 Dec 2024 13:24:14 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6553e8sm73991201cf.11.2024.12.26.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 13:24:13 -0800 (PST)
Date: Thu, 26 Dec 2024 16:24:13 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 kvm@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Joe Damato <jdamato@fastly.com>, 
 dw@davidwei.uk
Message-ID: <676dc97d7c311_1d346b29456@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241221004236.2629280-3-almasrymina@google.com>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-3-almasrymina@google.com>
Subject: Re: [PATCH RFC net-next v1 2/5] selftests: ncdevmem: Implement devmem
 TCP TX
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  .../selftests/drivers/net/hw/ncdevmem.c       | 261 +++++++++++++++++-
>  1 file changed, 259 insertions(+), 2 deletions(-)
> 

> +static unsigned long gettimeofday_ms(void)
> +{
> +	struct timeval tv;
> +
> +	gettimeofday(&tv, NULL);
> +	return (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
> +}

Consider uint64_t and 1000ULL to avoid overflow on 32-bit platforms in
2034 (currently at 1.7^10^9 usec since start of epoch).

Or use clock_gettime CLOCK_MONOTONIC.

> +
> +static int do_poll(int fd)
> +{
> +	struct pollfd pfd;
> +	int ret;
> +
> +	pfd.events = POLLERR;
> +	pfd.revents = 0;

Not important but since demonstrator code:
no need to set POLLERR on events. Errors cannot be masked.

> +	pfd.fd = fd;
> +
> +	ret = poll(&pfd, 1, waittime_ms);
> +	if (ret == -1)
> +		error(1, errno, "poll");
> +
> +	return ret && (pfd.revents & POLLERR);
> +}
