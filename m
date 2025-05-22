Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D672620D1
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901294; cv=none; b=q8AP4nuImA4kolhrsbhBf8CiS75pHRIAZD39iMU0OrJkpC7ojbNObBrx2G/CTOk8dRU7jarDyKYRAGiyHFJxU5a8Taz75ppYty05x3iHmrD7a/srO2U2l+fMPrF++qkVzA0DlQLeHcpHDc5l2TlAiKC+EqpsLldF8nicyPQKzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901294; c=relaxed/simple;
	bh=EX5kmSVBRAEXjNP2+5QT/wObVkwCn7KBTPH2XSu0cww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K9Ej7I0c/+GSKDpVZNfqx+uPeaB6vnRMK6YqqAjg6T1OuDxrrUMzbZC7E9Bc2GAzHyW1SIZzOibugKaSGEU2KNPrrQmtgxp/PNnNNzSOy59+eNqXUBtniSzsOuTEi91Z0Xsxg/bXsLhHa+LTiIEGIEofubY2+ixTNt63TwSrEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoMu+Nxt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoMu+Nxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747901291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4Wd+YCxX35LZrCoOEx8nIlaA1xFBFeFa5Cgo0fIeyo=;
	b=MoMu+Nxt0igH4ftuPMxDzFqwHydL8oeRKOxQPx1ot2iUBLc5Gzow94zHgNsqhJreNojH50
	d38geBDugG2pQWaC8pxnzm2Mt0kEXtjRQDmUZGogVEbywj/MQGKUuwfFk7fUHaKlXy62DB
	X1atUYa5nFUJpoUea8QLkExsEyuQJVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-l-vzqFDyO4iM0ce8Wjm6rA-1; Thu, 22 May 2025 04:08:10 -0400
X-MC-Unique: l-vzqFDyO4iM0ce8Wjm6rA-1
X-Mimecast-MFC-AGG-ID: l-vzqFDyO4iM0ce8Wjm6rA_1747901289
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a3660a9096so2280711f8f.2
        for <virtualization@lists.linux.dev>; Thu, 22 May 2025 01:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747901289; x=1748506089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4Wd+YCxX35LZrCoOEx8nIlaA1xFBFeFa5Cgo0fIeyo=;
        b=qCehfeHy/h3kJ4OoEzDcPMOw+r33T2a9F+/gceigATmwYowJwKl50flZKQkY4bNhB7
         vRCVPn/P4tOOF6orZE5ShxEG6bWeeLu5D0aHZ1YF2v0MCjLdn8hH6aKeVKOnYgnBwWn+
         0UYTbNAYHAn0ZzDdMi9ZtBQip5SJiDXvsnM2DaOBFrDrbwLnQRjxWsR0ofExuAirGHjK
         7b7afWV0FS6FYiqG6qL5VUCjRAy0NRrNSZRred/yr8l4W/NFU83b64jCWbOZeYyQedyH
         NUrR01gD0LZEC5+u/fGKKNheGiejB1/3skUrAO7aEdnI/CtPXO21VGpHTc7Gi7Z20n3f
         0uxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaAagDh3wVC2XFTOQwupujKd3ZVSvKri3kM7bufHRlWzmJQfH67i4DFBd2+SXOjAdKRgwc4dhhfRMMuqm+/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUf4/1cP9uHdARcjU3IqB9xjlWETCa2ndRLqOro2v8hbrBgpO/
	gBWd+ELUOke+uejD5b4klP0VrIGoIlJNH4HTgAiDAUmcYiKZQuz0mfIX+/jFCMBreBNwZhzB3U8
	xzN0sBWJoyLa7SHcnRPxLbXQtXXHlP/jXSBd1kjUrG5cU2M3KsqhvVOXfRMVOe+jHCf0A
X-Gm-Gg: ASbGnct4m0rLppqk5EpZsBBh45I6E+5G6WqdpNM2d7LkobQ4gtA55Ck4we60XoCCivt
	rnV61z0Z4TyBv6jIm17wA4pV/cFqoo7egkJv++SnKikzT1dYnJDAEXO3Ij3lziVYLeDa9uDgGHQ
	dnF43qBm/M2AR0E6fPxCsdO4JvGq6ymurubrC707bcYOv/KltyqmyUxhIgjzAmWJGURAKJCAjTH
	4AAZY5yHBKrL0jH3o7cj8pOnJt5GRgg2qbziS0/TC7iIkNzwFZVbg2d7wGPXinKF467UDNCk7RX
	OWS4xGQdySC0SxFFj+z6cpFOLbRblbkCMIJOke0i8jItpKK1v9LQrrDie0/G
X-Received: by 2002:a05:6000:2384:b0:3a3:6843:497f with SMTP id ffacd0b85a97d-3a368434b4emr17223457f8f.2.1747901288971;
        Thu, 22 May 2025 01:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB40eN1djVba1zLi/ieq+7/sYLnQly/oH/G63SZEMaHuLSaV/Sn473qGuURKSe2USXv485dA==
X-Received: by 2002:a05:6000:2384:b0:3a3:6843:497f with SMTP id ffacd0b85a97d-3a368434b4emr17223414f8f.2.1747901288395;
        Thu, 22 May 2025 01:08:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b295e7sm94333515e9.2.2025.05.22.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:08:07 -0700 (PDT)
Date: Thu, 22 May 2025 10:08:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v6 0/5] vsock: SOCK_LINGER rework
Message-ID: <kqm3bdj66qkziz27xsy6k6rnyminleqvebgqoudmufa424jlzm@khnzut7q4nqq>
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TOB7jCbxCG1F-te7N1GfpNzUaGA_NbLj30t3PYKG0MM_1747901289
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, May 22, 2025 at 01:18:20AM +0200, Michal Luczaj wrote:
>Change vsock's lingerning to wait on close() until all data is sent, i.e.
>until workers picked all the packets for processing.

Thanks for the series and the patience :-)

LGTM! There should be my R-b for all patches.

Thanks,
Stefano

>
>Changes in v6:
>- Make vsock_wait_sent() return bool, parametrize enable_so_linger() with
>  timeout, don't open code DIV_ROUND_UP [Stefano]
>- Link to v5: https://lore.kernel.org/r/20250521-vsock-linger-v5-0-94827860d1d6@rbox.co
>
>Changes in v5:
>- Move unsent_bytes fetching logic to utils.c
>- Add a helper for enabling SO_LINGER
>- Accommodate for close() taking a long time for reasons unrelated to
>  lingering
>- Separate and redo the testcase [Stefano]
>- Enrich the comment [Stefano]
>- Link to v4: https://lore.kernel.org/r/20250501-vsock-linger-v4-0-beabbd8a0847@rbox.co
>
>Changes in v4:
>- While in virtio, stick to virtio_transport_unsent_bytes() [Stefano]
>- Squash the indentation reduction [Stefano]
>- Pull SOCK_LINGER check into vsock_linger() [Stefano]
>- Don't explicitly pass sk->sk_lingertime [Stefano]
>- Link to v3: https://lore.kernel.org/r/20250430-vsock-linger-v3-0-ddbe73b53457@rbox.co
>
>Changes in v3:
>- Set "vsock/virtio" topic where appropriate
>- Do not claim that Hyper-V and VMCI ever lingered [Stefano]
>- Move lingering to af_vsock core [Stefano]
>- Link to v2: https://lore.kernel.org/r/20250421-vsock-linger-v2-0-fe9febd64668@rbox.co
>
>Changes in v2:
>- Comment that some transports do not implement unsent_bytes [Stefano]
>- Reduce the indentation of virtio_transport_wait_close() [Stefano]
>- Do not linger on shutdown(), expand the commit messages [Paolo]
>- Link to v1: https://lore.kernel.org/r/20250407-vsock-linger-v1-0-1458038e3492@rbox.co
>
>Changes in v1:
>- Do not assume `unsent_bytes()` is implemented by all transports [Stefano]
>- Link to v0: https://lore.kernel.org/netdev/df2d51fd-03e7-477f-8aea-938446f47864@rbox.co/
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Michal Luczaj (5):
>      vsock/virtio: Linger on unsent data
>      vsock: Move lingering logic to af_vsock core
>      vsock/test: Introduce vsock_wait_sent() helper
>      vsock/test: Introduce enable_so_linger() helper
>      vsock/test: Add test for an unexpectedly lingering close()
>
> include/net/af_vsock.h                  |  1 +
> net/vmw_vsock/af_vsock.c                | 33 +++++++++++++
> net/vmw_vsock/virtio_transport_common.c | 21 +--------
> tools/testing/vsock/util.c              | 38 +++++++++++++++
> tools/testing/vsock/util.h              |  2 +
> tools/testing/vsock/vsock_test.c        | 83 +++++++++++++++++++++++----------
> 6 files changed, 134 insertions(+), 44 deletions(-)
>---
>base-commit: f44092606a3f153bb7e6b277006b1f4a5b914cfc
>change-id: 20250304-vsock-linger-9026e5f9986c
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>

