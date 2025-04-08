Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655A263F4E
	for <virtualization@lists.linux.dev>; Tue,  8 Apr 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097692; cv=none; b=sp/QuVsVVjYRfCj5QC6D6XxtaEGt3DnhiCOZvHkDsoGHJNMb3CudJLu9wBO/EBCW4r4HCEi0A0T1ySYgrl1KotpFx/i/lYIt1WFVt7JWDfiXzs7xE3LBC3IGstilgnDRLuCtAn0rg2R1mBshVa2alOT6MM4amk1GY5kL67V4RAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097692; c=relaxed/simple;
	bh=Zw+nvfP4oH7YCpjyBFjQXUE7wWFGLtslccfPR5HCSeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk6como92bM07zuaM6qIefMlULIF/2BF1FPqlkeGwwoJa8d3SQ4MCaxOByUzZ6QO/vtqVS5IjookugD/Ogn35aH/cmOkSVYGgku8mhNnm+fzJbXOFw3LCuJtxMpoSw2whMeA3+UXkZJit0xiSVwGjAmorG64LCiyj5iYY+VhI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EvZlmC67; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvZlmC67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744097689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgX/95pHI72BHQsp4Gb1Pk041dCapFrrBn2uranICwk=;
	b=EvZlmC67CykixpE2Ell4fSedXehwJHGU1lwhsQt9fo6jflnpRKstIA1iNn9nJC0qmkViVw
	tYSVul3aMqRX6uRZ6Xkttd8SOlGzANZQo1SznS9BQIEl2I7H3kLbQIog/yqTkOQt22DXGl
	BRqhmSqRx27GRnYImLH6FgWh8jCzAOM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-GTDY6MefM_26M1Bnm3OCKQ-1; Tue, 08 Apr 2025 03:34:47 -0400
X-MC-Unique: GTDY6MefM_26M1Bnm3OCKQ-1
X-Mimecast-MFC-AGG-ID: GTDY6MefM_26M1Bnm3OCKQ_1744097687
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736abba8c5cso6748712b3a.2
        for <virtualization@lists.linux.dev>; Tue, 08 Apr 2025 00:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097687; x=1744702487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgX/95pHI72BHQsp4Gb1Pk041dCapFrrBn2uranICwk=;
        b=BVDYZZqpna6HgPFryhQFkocn0tQ97Zjx70cCc9g/kyoGfWWrOVHiMFx8cPxuhS7Kye
         WycWWtA8eD4ydLAyEhex44qpduGaEXZzqD79eFdbkAeHF0rAz4Ou5+e/nI/mr1r3vXHO
         j44oONsLSdY4jcD2ZDqgsnUK+VK2/yLY1C+MNUxYCXlvgSJvRYk2lTm5iepANQO7rnUT
         TJY/biWfdu5awt6PqACBpo5AeJJsOT/wZAbkSolBOYGAjfC4u+R+96nrNa+AF3AlFgw5
         EdWNksvvJC8JXCnoEG+PF+i3JFzDXd+H1EpNt2Hfab+C0OiydDuMNcToHe+LBnMuHBqA
         8jGA==
X-Forwarded-Encrypted: i=1; AJvYcCUopkx2taDsMbVx0p8Gm/uY2PvNov5eSnzKJIe2PFTsVbIQTVFnrmZvPy0Ck1RMbRqNgFQBbJkFa3y1InOyKw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyxn35C6zbW03X5amG2KgxjTYOXVNAnvtaJ8xhEaUoBWY8q9ZTR
	stoUYd0sKIhSMWpdw946vyZEga6D53+Tqw3MuxBXTnBDyk6yVrjn0z4uDDwgbthV/2zKSjNdvHB
	LED0PZaN7+aPH/6q5nXDUddbu/G/z37a0iuUOikDeFBz+gG0+VQvvfexzvbg/bvv5rv3BXBpJ/9
	7HHwlxPuPcIPwcBw7y5ZX4V/MxpS9TS4Cs1i2UMBw=
X-Gm-Gg: ASbGnct6hOmxMRlbc0QDww3FxH/FfTFcXfILy9qfNOYnXIjDqHIgWiPGSRbfTi2ZguK
	nE+IDx3iYzqR4JI94vMzmNBiYlu+IKhTg1FlkPks4+mYfH1nIN8G3MzkjZSUKPvWJZHwKRD07
X-Received: by 2002:a05:6a00:181d:b0:736:520a:58f9 with SMTP id d2e1a72fcca58-739e71136bemr15844017b3a.17.1744097686691;
        Tue, 08 Apr 2025 00:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEebzBktuzT34vutceE0Q+8ZimqM8gtaIQXLjH55vRIG5tqmEkA55owC0umuPvdKpOAEVEgy7rBakY9cJp/e3c=
X-Received: by 2002:a05:6a00:181d:b0:736:520a:58f9 with SMTP id
 d2e1a72fcca58-739e71136bemr15843995b3a.17.1744097686309; Tue, 08 Apr 2025
 00:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com> <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
In-Reply-To: <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 15:34:33 +0800
X-Gm-Features: ATxdqUHgOtXPv8x4ai3wnnr72S-UplgKPeU7AsldG5nqKrldqkZgJy1CXzhAwHI
Message-ID: <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: disable delayed refill when pausing rx
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IddRQL78eCN1CCjbFjYpo7yHE3a7txn0leNk0QhoxKA_1744097687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 10:27=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 4/7/25 08:03, Xuan Zhuo wrote:
> > On Fri,  4 Apr 2025 16:39:03 +0700, Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
> >> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> >> napi_disable() on the receive queue's napi. In delayed refill_work, it
> >> also calls napi_disable() on the receive queue's napi. This can leads =
to
> >> deadlock when napi_disable() is called on an already disabled napi. Th=
is
> >> scenario can be reproducible by binding a XDP socket to virtio-net
> >> interface without setting up the fill ring. As a result, try_fill_recv
> >> will fail until the fill ring is set up and refill_work is scheduled.
> >
> > So, what is the problem? The refill_work is waiting? As I know, that th=
read
> > will sleep some time, so the cpu can do other work.
>
> When napi_disable is called on an already disabled napi, it will sleep
> in napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck altogeth=
er.

This needs to be added to the chagelog. And it looks like this is a fix for

commit 413f0271f3966e0c73d4937963f19335af19e628
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Tue Jan 14 19:53:14 2025 -0800

    net: protect NAPI enablement with netdev_lock()

?

I wonder if it's simpler to just hold the netdev lock in resize or xsk
binding instead of this.

Thanks

>
> Thanks,
> Quang Minh.
>

