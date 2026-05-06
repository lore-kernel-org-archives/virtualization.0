Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F148C3F2
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080538; cv=none; b=LRrHj6ow5Yg2HxSsaCSJTz8D6MVXZFEwqznuwLphBy3a0mjxBN3UtivJ/vQkSpfw4xi6jjCnr18VuUf/cVDopWXsWefyfJ2QpUUoBevUl4F0v3P4a5Fs1yaO8b3bggGNzdxGRgScdjVOoR7P63N9F2mFMeaEX10fALki5XFciRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080538; c=relaxed/simple;
	bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pcT2PRIN0ydE6f8IJcGxNDGJ5veTT2EXfnbU+Bu+OtH9PVkHwC6nyrppk2f6tN2dn1KtLZY7u1aZvrvBPO6V0eYLoQl1w/Z3/bBFGevQ5Jl9eRd6aPdoG/p/7Tt4khC9N8k8RYqea1QPU69hlYSiPIsGv+8Q0pLr9abQNPZA0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiOw/G4i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiOw/G4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778080534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
	b=KiOw/G4iEt8WHH5dbou55LR7tET9E4j62w/kULJWudTlEs9aW3XIF35vtg/EEpf5oRSnrW
	oWvJzT+aK2WXtTLKwKJfJuWLbi1b+tqAE6+GAlxwQFfu7PC6PQwhdrvDOxLHKyWSnnzTjk
	CfLWIwXYxljc8XNZhiB8I2PrMWQInF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-OKWiMIRnOrGaJwlHlEtO6g-1; Wed, 06 May 2026 11:15:31 -0400
X-MC-Unique: OKWiMIRnOrGaJwlHlEtO6g-1
X-Mimecast-MFC-AGG-ID: OKWiMIRnOrGaJwlHlEtO6g_1778080530
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso47504705e9.2
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 08:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778080529; x=1778685329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyYVoDEtFDSgPhQADtst+OcAghGp7Ei9IraYcw4HcQY=;
        b=gT7pzL6Kynxw4UM8HIvPp/rA1VETUT7MmrA8R1DV0/pqzXCHXyVJvmhlA8fOjIQ5Oj
         QYGAEiA14d8hBBdHsOtejcjXiqQtAESa8VwjHxNcmkaIN+gt40bIXzpDwafUxVIffmcM
         bzPotfHaBVSFMgvwF8tN8AZ/eQUmMPqiQ6taCJsaHQKfy4STPNjv5wi/YauhOg+tm1P8
         rNft+jOHOzFdr2xl3/EJGtH9FLdF+OaDysJXTM23286SHQpiniACtpDutBJ54otgaZJp
         FW1cE7hdoOeLy6pB3nkRw4HSuCLo7e1CxJIIg9G81XCtdzNrEeX9vgSIZrittI7j/Y3S
         6OUA==
X-Forwarded-Encrypted: i=1; AFNElJ+X2zWBOlrLGxs3pBJ9StdD40kN4cg0YJ6BJH5KI1yvn1Yw4hX5nqG8AG3r6aQdeuaMdInmObujEV8tjfLGiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwT6HcPx/uT99WHtwUVy7SLzINXHRYivcIYEX8x9t1wIRWqVpLS
	Jv8WPB0WJRtwlpq4sWsqQZGUa/yOROTX4ayAkLkZEsLg9g2QIQG1MHlNrgpKzSBiEtjmN/3jmGQ
	8LVMPZyA9XEKlclDGV9XM7yIddzlIRnU4eCpRaiOJwCRgHtHwN0PT2KAF9/+TE5FSHH8XjCdvqx
	us
X-Gm-Gg: AeBDieuMkr0ksswEfx5VQdgySnzrrfLoSt8m9k2GKmGBdPsLFbpgnO1NskN3LaQZSDR
	P9GiVbO9VhQu1VXAbtH2OEcKemLloKYHwKHwrQ5g3rVA4u9bBlsZhCOD8fpayNcw765DFqjnyux
	mgy/lcsj6T5tUjr14XDCt8GJkMgQjH3SpCPffgdWONfE6ZIw2au6EOOsidD3Z7+aQOSeoBDVavH
	q3v2jVXYMl+xY9q+69/kfzbG5YGg7z3KPOqynooVVysaJBIU1JWmlu/AVBKRJwP1ImOFiRTlK7t
	KFLJlAgY8E6EqBZ8qlc853aWdrxxXqApi27qsIxOe3gG1zXf/6mp5AM209e5IdFsqWw5VlI8x+p
	CeQOr9k2spmHPYg9Jsmx1Sqq6CKiVii5irzHl1kWS1g+zUhYjzQM=
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr62856745e9.17.1778080529272;
        Wed, 06 May 2026 08:15:29 -0700 (PDT)
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr62855865e9.17.1778080528659;
        Wed, 06 May 2026 08:15:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b26a3sm95210515e9.9.2026.05.06.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:15:28 -0700 (PDT)
Date: Wed, 6 May 2026 11:15:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260506111507-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hpJOZ_6i1xUlQvpOdFgTKE2eW81qae5vXchC9q82rL0_1778080530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> There is always a discrepancy between skb->len and skb->truesize.
> You will not be able to announce a 1MB window, and accept one milliion
> skb of 1-byte each.

We can if we copy.

> This kind of contract is broken.

