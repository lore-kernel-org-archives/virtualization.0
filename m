Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6BD210FB
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 03:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984463; cv=none; b=LYkoeRskiN5ULXD3iIM+j30V66kOQkJePAES/ZZQexATlJwrdOkxCZcdBgStA2LCUC4LxjyCCPLAfXgnenJktvsOhygFXR8XSlcWU8b2ifc5GJjpVZdfk0b+BYXiZqsZ8KkevK5G2ky2bv1KMfPe2b4gPhwlM8xba4HqLJxXP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984463; c=relaxed/simple;
	bh=mEdNUn0BS8Bpg3TcLutb2rxf7eq3EwrKaxs2+zMhL5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlGnsUa/oPNaazLBqHULRnxjGAtyYP7z68auSppgc8oXiH0wuR7yEn7c1X2CwfCCHhCuiLIknMjumIpcMdyJ2WHFz5/Zv2IHtLpNnLfJvcAeNCFeb6JzLfhMo+HjObwLbVMyV5IpVLE8Ln9Zu7QEJ7DbM1wiC618iHOyvk0xqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OK5aQA1r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OK5aQA1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745984460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nr9ZWVi/QH3fppPeNFt9iSDXWWj0zwkcGOOauQmZQ0E=;
	b=OK5aQA1rjQg633oBbq+Ls/0eTekTyHYXum7f3XgHRfU2ahlbvK9FZrK4AiXi7ZAORtJmt+
	4LO6zA+vnIQYuffC0PmN9agS5WE7QfNqxyFObwNhwhnZupysMzHcKxpn77EPfkwFyTUaUa
	BVfEtpiawcgF9g5zbsl2RRblIm5rcNc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382--e3hbfArP6KuPoCMHu7hjQ-1; Tue, 29 Apr 2025 23:40:58 -0400
X-MC-Unique: -e3hbfArP6KuPoCMHu7hjQ-1
X-Mimecast-MFC-AGG-ID: -e3hbfArP6KuPoCMHu7hjQ_1745984458
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3085f5855c4so5912756a91.1
        for <virtualization@lists.linux.dev>; Tue, 29 Apr 2025 20:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745984457; x=1746589257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr9ZWVi/QH3fppPeNFt9iSDXWWj0zwkcGOOauQmZQ0E=;
        b=q23Zm+puAB8L97KLbU5CfIQjWPlSS9/D1PSuXlUb0tiMH/bDqEQmm7UhZTJzEMDAzn
         P22qYdZ+76SZCgxKgGd/d21VGlSz+FEmc6kd39MAw3RWGvQ8Egk1EEbMT/bWX0veeJhO
         /a11GeJXNKEYi9aD3gljhHAGP2KM+ZJ9s0Lm3GOQEcSEJofkNXOM+CjCAfXHy6oNdSSk
         1YULpAOPshSQZTP+35FF1aTHSWTqTCI/+ssDnFH/8i1NsKJ1wrVKDdS+Bsu+/Keb7Qcu
         hptdh9NkIb4s5lX3vTXCzB2GiKoLhslwNZ+W7aqBhEPOpLMPWsQmWaAOLE6JFSeUuqVN
         ifSw==
X-Forwarded-Encrypted: i=1; AJvYcCUMoAklGb7yjkEkuJrmdT+4s8rdmX7XILOcoVWiCs7nOlMw3zvTbgiqau6WbPVYS+8b1TBwMLgCpkkiwUCAMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+5vxVWlMal4H/p4ss0vjh8J4cmPPz9SZk2iEYqRK+IrGXOjdJ
	APWrIMiSHezPCt6rLtSU6twg9da8gZrVBUmWpaO19EAUah/jJGEpvwgtT1rLMIJ8kVvybB8vOeG
	XkwOYZ6ww2+IS9HxusDhhxbqbzjn9Nf5QNWYDKITLHYLHvvKQCjBxSIXi7SEM57edX5Irgjfuqw
	PyWm6STOff73fwr+vwzgGKwH+ErqYO3NA579vByK8=
X-Gm-Gg: ASbGnctoXsc89uIxoDtrjA1QcUQdV2Kujf7gCg8iqnv58CFXagPRlyQpuArrxAlZZo5
	ItEiEuHvKrWDFKXGf8OkeBpnfL4JcOwq0CWs44AL/0R9nW7fPNyYkzEqPS3yBwb7Q/e9J
X-Received: by 2002:a17:90b:4e87:b0:2ff:698d:ef7c with SMTP id 98e67ed59e1d1-30a3336f9b9mr2198992a91.29.1745984457613;
        Tue, 29 Apr 2025 20:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1up9qXV6micad0D+/3oi5NP0XpKeUSziwxCv8edKhspXzKkIfd5gYjnKqHGilFos6yPd7itRi8DOfE5PPWuU=
X-Received: by 2002:a17:90b:4e87:b0:2ff:698d:ef7c with SMTP id
 98e67ed59e1d1-30a3336f9b9mr2198961a91.29.1745984457302; Tue, 29 Apr 2025
 20:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250429164323.2637891-1-kuba@kernel.org>
In-Reply-To: <20250429164323.2637891-1-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Apr 2025 11:40:46 +0800
X-Gm-Features: ATxdqUHiInHKeaVQ9a4b-X0BNW7FtLgPcAiahJGMd2lseIgKH0QntjMZtM_VW08
Message-ID: <CACGkMEvRE-hNRu5CvqdzxnhjQXo8FOqSWUUbg6towh+uUOHVeg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: free xsk_buffs on error in virtnet_xsk_pool_enable()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, hawk@kernel.org, 
	john.fastabend@gmail.com, virtualization@lists.linux.dev, 
	minhquangbui99@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -dQOU0WsWRIOtxYnqwnrRqU-kr1FLWPmypJTLm-0hC0_1745984458
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 12:43=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> The selftests added to our CI by Bui Quang Minh recently reveals
> that there is a mem leak on the error path of virtnet_xsk_pool_enable():
>
> unreferenced object 0xffff88800a68a000 (size 2048):
>   comm "xdp_helper", pid 318, jiffies 4294692778
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     __kvmalloc_node_noprof+0x402/0x570
>     virtnet_xsk_pool_enable+0x293/0x6a0 (drivers/net/virtio_net.c:5882)
>     xp_assign_dev+0x369/0x670 (net/xdp/xsk_buff_pool.c:226)
>     xsk_bind+0x6a5/0x1ae0
>     __sys_bind+0x15e/0x230
>     __x64_sys_bind+0x72/0xb0
>     do_syscall_64+0xc1/0x1d0
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: virtualization@lists.linux.dev
> CC: minhquangbui99@gmail.com
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

