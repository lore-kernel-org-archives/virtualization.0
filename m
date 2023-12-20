Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC368C0B
	for <virtualization@lists.linux.dev>; Wed, 20 Dec 2023 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkXU7d9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703044141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcEKCuZCISl6MmvUHOcZ8wbgYmHDedpsTc/f0SRr9EY=;
	b=CkXU7d9ltu7FxFCyhUyOYOa4buTe/QYUdrzuE3R/px5zS/NOoYXSRUAuPfO/4N/UMGOikD
	MKE824+qZASniKx2ykpAe3eZil6kmuXwqWuPUYS0K/kBSPoCLGIP5PJRGQqgPVEOCCj582
	3Au0NxGkjLOhwaAooS6j0kqGyOv1zxk=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-NB8qXiZmNauTkzAmA77nww-1; Tue, 19 Dec 2023 22:48:59 -0500
X-MC-Unique: NB8qXiZmNauTkzAmA77nww-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-591315be419so6362466eaf.1
        for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 19:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044138; x=1703648938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcEKCuZCISl6MmvUHOcZ8wbgYmHDedpsTc/f0SRr9EY=;
        b=TYlFVToWJJW8TMXkJvdSo4vPNjd3v/SzAIGoAQjiqNnR+6yx/J7asKCc5thaXSqLxI
         GgtLwgen1AI2ZKey7mBKCVWOcnWToBFCKkSpDGnM/2KJKqrgvgpaOMkqhao1mbnSIRxD
         YeqBmhS0cRCzbCaSfa2VptBWkgZY03kJKqBW8Va1V/7HDePPv5oBDsY54PrakwqzR/jV
         qHDx5SRbEuAijeVVDDWNi3bZ0HiNSCzw+l46y4RLxQOHdEimJwAIRMURhhD900C37YIW
         YAi4/ZVTB+O0QLRKvd314XKe1rVgeL8exRCQiueOhlcquMC7AdpBLUakJ6Uw9n6BSx+Q
         52ug==
X-Gm-Message-State: AOJu0Yz5zs2sEIa4vdvQxuCY2bVwCazRmfK7YYrg54W0RoHapkagaXek
	L1jjkfGrH1uZmY3TI5jwvPWqVSXdJGJjoQB03/CPHjmvuAdGzvNRLvtLDbE7rcFcSjLSzEdbjzd
	h/+iftreBKhmj4SKmrUOT/FhM/L2JQGJyE2p9Rw4osEuxvL7hmsGSzw==
X-Received: by 2002:a05:6358:2919:b0:170:982:5611 with SMTP id y25-20020a056358291900b0017009825611mr28623946rwb.32.1703044138515;
        Tue, 19 Dec 2023 19:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaWh6Q0+sX3khUGlVzDT+nrVdy0DPPOrc9xz+Dh3vmGUvcZjZ2nthFRcXi9qE3vyRl3qciLiksVeyICTqENg0=
X-Received: by 2002:a05:6358:2919:b0:170:982:5611 with SMTP id
 y25-20020a056358291900b0017009825611mr28623927rwb.32.1703044138196; Tue, 19
 Dec 2023 19:48:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
 <65807512bc20b_805482941e@willemb.c.googlers.com.notmuch>
In-Reply-To: <65807512bc20b_805482941e@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 11:48:47 +0800
Message-ID: <CACGkMEuuz3R5CgBpKrnBwtFP3ZxWULDMm47LhtxYYHSSUy_2fQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] virtio-net: add tx-hash, rx-tstamp, tx-tstamp and tx-time
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:36=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Steffen Trumtrar wrote:
> > This series tries to pick up the work on the virtio-net timestamping
> > feature from Willem de Bruijn.
> >
> > Original series
> >     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
> >     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
> >     tx-tstamp and tx-time
> >     From: Willem de Bruijn <willemb@google.com>
> >
> >     RFC for four new features to the virtio network device:
> >
> >     1. pass tx flow state to host, for routing + telemetry
> >     2. pass rx tstamp to guest, for better RTT estimation
> >     3. pass tx tstamp to guest, idem
> >     3. pass tx delivery time to host, for accurate pacing
> >
> >     All would introduce an extension to the virtio spec.
> >
> > The original series consisted of a hack around the DMA API, which shoul=
d
> > be fixed in this series.
> >
> > The changes in this series are to the driver side. For the changes to q=
emu see:
> >     https://github.com/strumtrar/qemu/tree/v8.1.1/virtio-net-ptp
> >
> > Currently only virtio-net is supported. The original series used
> > vhost-net as backend. However, the path through tun via sendmsg doesn't
> > allow us to write data back to the driver side without any hacks.
> > Therefore use the way via plain virtio-net without vhost albeit better
> > performance.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>
> Thanks for picking this back up, Steffen. Nice to see that the code still
> applies mostly cleanly.
>
> For context: I dropped the work only because I had no real device
> implementation. The referenced patch series to qemu changes that.
>
> I suppose the main issue is the virtio API changes that this introduces,
> which will have to be accepted to the spec.
>
> One small comment to patch 4: there I just assumed the virtual device
> time is CLOCK_TAI. There is a concurrent feature under review for HW
> pacing offload with AF_XDP sockets. The clock issue comes up a bit. In
> general, for hardware we cannot assume a clock.

Any reason for this? E.g some modern NIC have PTP support.

> For virtio, perhaps
> assuming the same monotonic hardware clock in guest and host can be
> assumed.

Note that virtio can be implemented in hardware now. So we can assume
things like the kvm ptp clock.

> But this clock alignment needs some thought.
>

Thanks

