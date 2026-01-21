Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34248A2D4
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998964; cv=none; b=Ajjkx0G22SAag7yr4r0GvFg40T44TnRVEiUHmN8xpt9HPnnfdu8bffsoo3GDgCCHSbCHabeiNizVNVeSd3+uLL/7r+HKL9A8mTo/UIlmbAR+UJyFmZbpKgQRVlk7tKFDYAwwJcQfBRiqkCkDHdlGAAFGIcUYaoUmlFkrZ0RaXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998964; c=relaxed/simple;
	bh=mha0I0VeVP1yXEtwsIMyiWq7J0MEXEEXF4v+brwB7Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WTL64NFeumP2nQqT8Wq3mkbOxPVsCAFWwtn3DWdor4JgGdZHkO5O/iA9hahbnLotOmXOao143XwRqq7bO+spsrjZsuUvmcAVXef66M3uZUERwiUiVGHIQiSNXtkpJu+a1T/H2eO2E6CcH67hJAVHm82IoPHv5WEpkeFvWDqvDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAmK8f+H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAmK8f+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768998962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnPI8AJirXqjwQZgXHxL6NbBtlFdMp2kOfgYwwE6c8I=;
	b=QAmK8f+HrvFPtnmAS3nkhCVx3spQKtb/bwJMHrh++5SxhAPlobiZUGNBIM2v6mPQktlpOS
	0IEjl4Wz3OvWCnwcrAhlbYX6qOwXPiZGPmnEjBAaGsLjCKy7Nucrj9VhUaJdLufsmAV2Tv
	KZkc9wXEyEN1Ubw3YEu5oZu6Pky7YAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-8PyCWvnZNGq44jf4OI5T9g-1; Wed, 21 Jan 2026 07:35:59 -0500
X-MC-Unique: 8PyCWvnZNGq44jf4OI5T9g-1
X-Mimecast-MFC-AGG-ID: 8PyCWvnZNGq44jf4OI5T9g_1768998958
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso54283975e9.1
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 04:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768998958; x=1769603758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnPI8AJirXqjwQZgXHxL6NbBtlFdMp2kOfgYwwE6c8I=;
        b=pkTu2nQGp7x2Mg2XXsd+SpjSB7G0xVv14Z1tQWwwXGyB6vPJPd5TwlA3DAaZ8T708q
         B/4Hd1Ii+ZvjM1Kpl0B4DFWl2E+cRduAvMlivflnWryjA7qxw5xSWV5cJg0ERUow3cQr
         wRY7U70PAxhMGuezPLPpV0IKpFbY46aWzTalQvix2SMJjb0rH0pDGHpTU7jdc9byPDqH
         Vb4frmXWMUvUszDB0nbcDLvjTo9cdEn+4l7gLhCdj3QZP2OGK5mFyDXYM9CSx9b1aZJ/
         cDsa4u9FIyZ3Qh+dCZteVOneFuOdp3gaGckQnIcogRQU2D3izo/dOpb0cVA1RVCa7r6Z
         kC2g==
X-Forwarded-Encrypted: i=1; AJvYcCX50blZBNqFkPcZGYmiNhobJgD+dmRO69PdiZ0+kl4XnWvZ5dnQM4Od9zXGY9vbYKkN7x0lQo/wZQ37FiFSBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFePAYCCci2n5ALtHU2x4Oz3ssi+0c/05NMX4Z0Q4p6T81GEzV
	jJHoMBLML5yyi2pMDSd3Tr5DL4bKreD9RUK2eT48IDAiN/9Prl1qw1bLSyeJQ17gJrVWC2pITf/
	gCa0jS+LZjxDBpkr8fLYJOE/pWFODd24XB0P0klBrQLHX7ge5Vz3XFRN3wrO6FRQ3tQQ8
X-Gm-Gg: AZuq6aKn5zCT1BRBF2eT9te8iI2egZwPEPBFLy7XFJZJtT2p5EcVdJHBuMCB5FApfFb
	M1ypExAuKrjhQzXenYF7CAuV7RE3o+a3MlS4BKdi9DshsaJXnH861iWk9w0qhsq1jqLE72qhBNZ
	xPvXWQQ+tWNfMHRNpLByf2+ylpmkyxXqBCndNdr0af61rdS36HtcWRH1XpMSU7PjmFi4y0JLszY
	XmHGFfbpbFRSrpMihcYAH6SUAp5wyNwSRT8JA6a8OBf0LZXYxyZ0A0MVfY5l3VGKTHHZ5HNeaKd
	xyoJ4EcHx/mtZQfp1iR/6vKiozcGf2h30WYrcSu0dQ+vS/cjQe1LHQP7pVPthGQ/QUiD+MPO8Sw
	6Zyn3ls56AHSB/KAN7wnNsmHUWss9JK0=
X-Received: by 2002:a05:600c:3ba8:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4801e34651dmr231392835e9.30.1768998957684;
        Wed, 21 Jan 2026 04:35:57 -0800 (PST)
X-Received: by 2002:a05:600c:3ba8:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4801e34651dmr231392355e9.30.1768998957206;
        Wed, 21 Jan 2026 04:35:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b83csm362908205e9.3.2026.01.21.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:35:56 -0800 (PST)
Date: Wed, 21 Jan 2026 07:35:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>
Subject: Re: [PATCH net v6 0/4] vsock/virtio: fix TX credit handling
Message-ID: <20260121073547-mutt-send-email-mst@kernel.org>
References: <20260121093628.9941-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121093628.9941-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LpZqWvGz8LV3AlasDCfVw3XB3XPdMzg_RNK5Y6kqPoQ_1768998958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 21, 2026 at 10:36:24AM +0100, Stefano Garzarella wrote:
> The original series was posted by Melbin K Mathew <mlbnkm1@gmail.com> till v4.
> Since it's a real issue and the original author seems busy, I'm sending
> the new version fixing my comments but keeping the authorship (and restoring
> mine on patch 2 as reported on v4).


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v6:
> - Rebased on net tree since there was a conflict on patch 4 with another
>   test added.
> - No code changes.
> 
> v5: https://lore.kernel.org/netdev/20260116201517.273302-1-sgarzare@redhat.com/
> v4: https://lore.kernel.org/netdev/20251217181206.3681159-1-mlbnkm1@gmail.com/
> 
> >From Melbin K Mathew <mlbnkm1@gmail.com>:
> 
> This series fixes TX credit handling in virtio-vsock:
> 
> Patch 1: Fix potential underflow in get_credit() using s64 arithmetic
> Patch 2: Fix vsock_test seqpacket bounds test
> Patch 3: Cap TX credit to local buffer size (security hardening)
> Patch 4: Add stream TX credit bounds regression test
> 
> The core issue is that a malicious guest can advertise a huge buffer
> size via SO_VM_SOCKETS_BUFFER_SIZE, causing the host to allocate
> excessive sk_buff memory when sending data to that guest.
> 
> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> 32 guest vsock connections advertising 2 GiB each and reading slowly
> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
> recovered after killing the QEMU process.
> 
> With this series applied, the same PoC shows only ~35 MiB increase in
> Slab/SUnreclaim, no host OOM, and the guest remains responsive.
> 
> Melbin K Mathew (3):
>   vsock/virtio: fix potential underflow in virtio_transport_get_credit()
>   vsock/virtio: cap TX credit to local buffer size
>   vsock/test: add stream TX credit bounds test
> 
> Stefano Garzarella (1):
>   vsock/test: fix seqpacket message bounds test
> 
>  net/vmw_vsock/virtio_transport_common.c |  30 +++++--
>  tools/testing/vsock/vsock_test.c        | 112 ++++++++++++++++++++++++
>  2 files changed, 133 insertions(+), 9 deletions(-)
> 
> -- 
> 2.52.0

