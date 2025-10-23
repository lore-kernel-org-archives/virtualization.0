Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FEF15E5BB
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 02:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187033; cv=none; b=n2ztFqRZl8HCht+dtxzc2KSQ55NiR7D2mqXih6sEN/p5xuu5r7KX6XUX0uJ/UnGfbT0PSMsFqS6v1dRfl7iiS8TbOIHvlF1j+Xpdhd2hahp475jqPLJS7ULebvr8OS7F86L+uhpSI5+Z+tXX2fBKqGCabLRQ1pFRV/xM+muUHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187033; c=relaxed/simple;
	bh=tLELmYBjrIVt2tIe7/6pOjA4rz1yWYE0gX8fXO7gYBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqrhzMsVhWsGhSgIK+9ilJm2TJn2q590cUHd9FMBlh+x+5dYrzES0Aj/9HkKhaUGUZoJq+/f7fzlKu7pZzfYetmxa1qwnYumtl0Nt+Rhqr1l9zSaxU6GlIgtQypr8X2ErcXqQ0QIi31sR/2IGWtuoe4wpZy0SImxP+gRsaMl/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0VjIQzI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0VjIQzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761187029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLELmYBjrIVt2tIe7/6pOjA4rz1yWYE0gX8fXO7gYBQ=;
	b=T0VjIQzIEVygxqlCxCUPXhfCvghQFPj959XuD8cGcOUPUgHvjwkBOIjCHPYKwFyKEPLeFo
	7wgfTSemkz8B1iv4rfmipZQQ7v8WgLpw4agYuApVUzl2HDS/mJej3k46DnibXXxKfhtvoW
	c6bdfLO3R6m7+Ht54qW2588rwb09c3c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-18itDtNgMsupgZsl7Z65qw-1; Wed, 22 Oct 2025 22:37:06 -0400
X-MC-Unique: 18itDtNgMsupgZsl7Z65qw-1
X-Mimecast-MFC-AGG-ID: 18itDtNgMsupgZsl7Z65qw_1761187025
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so329432a91.2
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 19:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761187025; x=1761791825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLELmYBjrIVt2tIe7/6pOjA4rz1yWYE0gX8fXO7gYBQ=;
        b=SNXRoxVZODpVmJmDhalIaV16MRI5GBKYgMmVkFVM2AtXxqtk71HadjP0nRDbYS8cyH
         M7qtC7Xj9iyRWWiC43fUrVASvZbDSSPzr/T+FHbHe8ZNK1KXfzpcGYdzvB6D15L9b7hK
         VxFc9G+bh5wGHa6/GYSsP4THEpufUovsUOuMtcBlbZCKzbEEFf+W0fADllgnBXCNXLuJ
         +99ub7U/1D2lL3jCdfG5dGCbpss2xTjNjw4i81Q0xbK91D8H26cSpvlSz+IvvJY/ZXlK
         oJ/etMP240MT6OzZLbOgLZrFamd7Xc7p6Xh2cc869sM8AruKNGWh1SCivMxTjzyufKHg
         02jQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1JGAKsQG6/iDWRONKq9+nMGZx4hLJNCrw8XzjzrRY8FAks6d0u1u5G0GaSgKJ0IYkSbHg1GjhA4+iNRaM+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxfk/UPlhLYscvYPs84+PCfvD60DVi4vLFXZWWEmgvCMKYv5vj
	6W0ytpGf+HN4mHjb9lvZcWjYSueWeSTNO2NBoG3GI4xqqggvNbeHznCjuNuqOZLehxJzVkqXjT0
	5ghISKKof3vQ+9Ax6Com2NWV2IWkCZjzF13Et+ATMi2fGIifW+HfG511Rn4VVGEZepk9Z3UjLQe
	OwMVTSYN2SX7pKtVtjN3smB2uT6nIHTE1snNfJjyKIIaw=
X-Gm-Gg: ASbGncuaaNB0YFqonlO8AkrpNxamAbAZfs0XgUtQzrLpKuyGJi+Lx9DKcNVL3ldtMo7
	iGSB7XNU0kWXkqcsb0Oix7AYFlS1GHAgw+q/GTTKrhJ9kbCSkyk/JN6QcKybPp2PJK7Tqw6qee1
	180fc4fn1SCThqUKKNi5aH78RM2hy63hnKOu5tALjUs51kLfQcxYvU
X-Received: by 2002:a17:90b:39cd:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-33bcf85acb9mr34016676a91.4.1761187025436;
        Wed, 22 Oct 2025 19:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/QyyERiH1ne1uh++OITBKUZJwW+GZJEUDxDewU6cwuEnbMhLwGR91ccFPAr3mIMgDlrYfBjy0UH2GlIRXE0=
X-Received: by 2002:a17:90b:39cd:b0:332:3515:3049 with SMTP id
 98e67ed59e1d1-33bcf85acb9mr34016661a91.4.1761187025008; Wed, 22 Oct 2025
 19:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251022160623.51191-1-minhquangbui99@gmail.com>
In-Reply-To: <20251022160623.51191-1-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Oct 2025 10:36:53 +0800
X-Gm-Features: AS18NWAKWzREjF0AApyvOANK-aDy0vhZRfRMkPBOWaAVhrOoGWAFI9xvVg3gyH4
Message-ID: <CACGkMEtrdXOCsRQiw659Ygze7AXAHw4-uK_Z+zdi3r9V5XDLZQ@mail.gmail.com>
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KysbbsPU6N6xBVLRbSYQ5ydnuKpeu5FSl6thC7lVtf4_1761187025
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:08=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> for big packets"), when guest gso is off, the allocated size for big
> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
> negotiated MTU. The number of allocated frags for big packets is stored
> in vi->big_packets_num_skbfrags.
>
> Because the host announced buffer length can be malicious (e.g. the host
> vhost_net driver's get_rx_bufs is modified to announce incorrect
> length), we need a check in virtio_net receive path. Currently, the
> check is not adapted to the new change which can lead to NULL page
> pointer dereference in the below while loop when receiving length that
> is larger than the allocated one.
>
> This commit fixes the received length check corresponding to the new
> change.
>
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big p=
ackets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v4:
> - Remove unrelated changes, add more comments
> Changes in v3:
> - Convert BUG_ON to WARN_ON_ONCE
> Changes in v2:
> - Remove incorrect give_pages call
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

