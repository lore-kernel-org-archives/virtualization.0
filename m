Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2191D7989
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204636; cv=none; b=WeVrKCeoQz0oPGdBgoqGgXc7CQxBw9WShEMLUFziJTy0y/oLGMNvnEXI3TE7WJjzfe92y2GUJLQMHC2hYV4z78O3UhBEHGdm5JwFLYFnRr7agzvHdNcZ941HBZHdDBcHrIhrYAnZOcVE3kXrPTuk3XqSTBfIzpGGVTuVTQaD9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204636; c=relaxed/simple;
	bh=Qr8aYaNg+4LPUFYtFSiJL8vs/bYQwNhv1687v1mNwC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8NhpDuTimCslMPJjS+bIaXEGP1te76PQod40w+SoM9UEplMww4iBgj70dDaJtQ+T5SPD79PM7mtbfQu1Px+YAj5AqCq0Ogb/NvWZHR3jsbaS8Hdq8tOlu1BPa8ZL/nIK4nYpbY7JK0hUweF2b8nlmw50Ar1bOQXJ8SlJkrEGIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwUxuK4h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwUxuK4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745204634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLXDtRgA6ayDeCz1Y6vWEq0hT6V9yJ+AfUHP97mEHh4=;
	b=RwUxuK4hO3q11StluSzGTdt4eZPi8wAAtYWR1KW7jlDQHhgn/JqxzMS4O3XF1s4kBPXaJK
	QuCfbipW2xzk7xj5Bk/zdvWl8C6VvZ5wZoCbKeaZ7UpeulPGj38hKPTJBtxo40xxVFIhXd
	ikt34FCaey9RCJsI6uVenaZM6Ep3Hqk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-RYIhw-Y5OCaAlts40WXPDQ-1; Sun, 20 Apr 2025 23:03:52 -0400
X-MC-Unique: RYIhw-Y5OCaAlts40WXPDQ-1
X-Mimecast-MFC-AGG-ID: RYIhw-Y5OCaAlts40WXPDQ_1745204632
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so5334385a91.3
        for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 20:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745204632; x=1745809432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLXDtRgA6ayDeCz1Y6vWEq0hT6V9yJ+AfUHP97mEHh4=;
        b=B0FeLyFQg7LIFAUpiEKxQhFNpcGDdpFi0qR8Z6JHKZQPIunXIxxRZNiZHVozHCvEuV
         zb5CGB7vNOk3B/KAMRIIbG8VD5gdDvPnnozAbcCr9/S+Z6tcVBDQHZ9LHDAyVKjoVsel
         K4YMp2hCy8g8uM8ER3fIw8aHVeisYUq0Z0fHjmuGpN7tvL3JS0Aqjfg3yF9bVLAWcnb6
         9AB3aRaKmsyJ57SmqIDNt/jcx05+bYUf8Syj51zn8DKFMtzO533tc8tIERv+HHy68uDT
         ST+GYhTpx66mg/Yjnj+gxQ9KMDZy1WEnCUGiEcKVoPBDfU/VRcI0KpVZtcDbezd3FZlr
         NVbQ==
X-Gm-Message-State: AOJu0YwtoJoDRGcXiDVvHdSYmoMcUZayNXq8T9IHw6RoE9rJbcoAcZkL
	2amoprfJO4dw3WfGnpkOQIYmMI75VxXGUvvfBDTJpe6UjoYDAjmZrufYdxaA7crqYSuk/wMX/h+
	Q4wZeG5EQ+AU6kTrPX7toUr2e4UVws4Sh6DXH1f95bPTU2ObUZLAK2g5ONZWApotxd8FOvkamrq
	47wD0S5nc1p85CJekHX+aOoQpaNjjkw8VsfS7coBo=
X-Gm-Gg: ASbGncsrUtWs+/n1dpQuPWhSusjEEIe0SElBxopik0oIA6lo82nuvhAAXLe/ZRPNQfN
	kkxPrl19bgsjhgRLBUkc/BbOjZb/muiZHNacThKdFKWjMb9B5GnLIbBdn6qxdpWsFqPFHBw==
X-Received: by 2002:a17:90b:4b89:b0:308:65d4:9dda with SMTP id 98e67ed59e1d1-3087bb6e794mr16806378a91.16.1745204631880;
        Sun, 20 Apr 2025 20:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZtnoZd7x/9jpKNzZ+LTBMBCaS6scxdcgAj8rPFvVSJbcKlGfoHCLn1pYbSk8Af1Y6oKwZSBu3haMJ+dnfOJM=
X-Received: by 2002:a17:90b:4b89:b0:308:65d4:9dda with SMTP id
 98e67ed59e1d1-3087bb6e794mr16806325a91.16.1745204631397; Sun, 20 Apr 2025
 20:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250417072806.18660-1-minhquangbui99@gmail.com> <20250417072806.18660-2-minhquangbui99@gmail.com>
In-Reply-To: <20250417072806.18660-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:03:38 +0800
X-Gm-Features: ATxdqUGyEA9DUKHVB0iflKLulL2Ewuk2b0N8F7M-x7RCvH29fTxDE_M5T6xkicU
Message-ID: <CACGkMEt5=r_JbfHeU=dpk20F5uE6TJouTPdKUUScYtQGfAw1tg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] virtio-net: disable delayed refill when pausing rx
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: b4uuIADQPob257_ajoXetIuA5IJYBQ9VbWhXiBzO6NE_1745204632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 3:29=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi.  When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
>
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
>
> This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(In the future, we may consider switch to per virtqueue refill work instead=
)

Thanks

