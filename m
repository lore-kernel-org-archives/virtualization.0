Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBE27B4E8
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702664; cv=none; b=Tdkfqq1OvyVKUoAzd8+Jh+HCQTgOqY4GrCqn4sk/qvuYJsL+GxAiR20QPd8zA5/07F6FrkMZLhZp25XEtj1RvgTB4fmctJ7Mw9pronhgJj1Ekg+AuuAsElw+vLtlpuIY/dbGbi5vBLMFxydxqC7+vLySn79SdQkzkTUVqUdzPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702664; c=relaxed/simple;
	bh=tvDkOCfsuaQ7GYS4gx1Mnhg3p9IRHU5mftTan4zgXSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giOCd6Z4WMXzq506nF1oMWt+k5Pzj25aSeFNgVnq2qVw3K6yoPQgt8ERODq5r/DkSGa0CTNny1Hi5WaO+biwxn1N02W7Jwt22YlHU0gYc994XAfQJ47jZmBbOFPcHNfySjqcA+IF4NsNfNyqbUyQT4tYlidCVKcxEYerImBbKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG1Tkhwm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG1Tkhwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758702661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tvDkOCfsuaQ7GYS4gx1Mnhg3p9IRHU5mftTan4zgXSM=;
	b=SG1Tkhwm4UYRiyBY500S4/WptnGq3MR52y1BXR8dgpkh7QKnHiE3FniUoGy+EuxqrNWWsh
	MhChkB8qQj2mksCkAjuJmvows9SBoZtdC6DWHCme2f+gMpuYLsFD8bX3W5aj+ADiFbmb/1
	Sg4pbExS2DLFCfKvR9aZ8GzCniTYHKw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-iewFJu1jNMeyRMi9xMei2A-1; Wed, 24 Sep 2025 04:31:00 -0400
X-MC-Unique: iewFJu1jNMeyRMi9xMei2A-1
X-Mimecast-MFC-AGG-ID: iewFJu1jNMeyRMi9xMei2A_1758702660
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32edda89a37so6346991a91.1
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 01:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702659; x=1759307459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvDkOCfsuaQ7GYS4gx1Mnhg3p9IRHU5mftTan4zgXSM=;
        b=qQtcyWMh0m8+v82yhF6Qj3/w4OecVKwB5GWF+LfA4HTJWC9CFiHFOCr//mL8dpoz9F
         PmgW3uz+XHG/FuU9rlBGbGOFuCHdushUQChRNgzV7XJvUY7WMgP2SF/7lBHJgV0PrD5G
         bGhmP34jzOTr2wAejHNMVS1GEiab1vgY6u/3ilEtthMKOfVGA2CFaM3xyBqsN6djBCfB
         UoaggQaYkG7spqor/OvZUpO+J5tODEAWnQW0qLDuvFYNXC5zv5rCGXThediaecp4qzya
         +u2WzareDlJ3BhjthQLPKM/V5FMwpgV3+u4ULPVWv4DVv3plzV3LZN+6eVJKmLv9zOi0
         FK0w==
X-Forwarded-Encrypted: i=1; AJvYcCVvryq4sKnouQv53R/BFIGwMxFL/1/7Z3sfQ1AIpa0w44lX9ukemsy7LUM52kQ4ySoqHvfUeN8zrqnyIkzLpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyAeSr4GmNO8TsJkfJac94dQUlSPoxtSe3LLaOaRdct823e8VF
	gObIQNYaIwo9FfOM8g9Mj26+iKpxgHR0UGmBhoHAD3ZBV3eRQ+Kot5xtThHukvhXKoEWsqpYWjS
	J78K0M5xdfQPTVA69dUneSyFCek2TH8Nt+0y4lAwKuQ3PxJLAI4caA0zNP4wSEQpJmByEYw4wQe
	UmHJI4hATgDn75pEuieA+4bNQzCGuilSA4XGIm3//bl8MLpmeLICr70hTQ
X-Gm-Gg: ASbGnctaG7rN1yhxdFEqSvdjMOwBYZYY8Zk05PP4dZiK4JBsc9gdA+pfYB4OQS3EKAa
	rbMDokWW2xk/kVlxTXIPemAgj6baATUWx6bKqUx8O0FmKa8K6GRo4lwqGW8+32a+KRVTHzTunhh
	BqPOaKXHtTa5DX7CLYWg==
X-Received: by 2002:a17:90b:54cb:b0:332:250e:eec8 with SMTP id 98e67ed59e1d1-332a9513715mr7286800a91.15.1758702659073;
        Wed, 24 Sep 2025 01:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSuHUP7PGnJisv3R6suoi7mEFCXCrr7ybnyTOFly8Wrp69Kyr1dy9P3+Fdf6NLo31cwCaZ5AfWhe2/V/RdhQ0=
X-Received: by 2002:a17:90b:54cb:b0:332:250e:eec8 with SMTP id
 98e67ed59e1d1-332a9513715mr7286747a91.15.1758702658536; Wed, 24 Sep 2025
 01:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
 <20250924031105-mutt-send-email-mst@kernel.org> <CACGkMEuriTgw4+bFPiPU-1ptipt-WKvHdavM53ANwkr=iSvYYg@mail.gmail.com>
 <20250924034112-mutt-send-email-mst@kernel.org> <CACGkMEtdQ8j0AXttjLyPNSKq9-s0tSJPzRtKcWhXTF3M_PkVLQ@mail.gmail.com>
 <20250924040915-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250924040915-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 16:30:45 +0800
X-Gm-Features: AS18NWC70PosrkMr5g8LAeoMZx5xvquUOdY0YTAw2VzbuPvii9GWMNdWpFU8UFA
Message-ID: <CACGkMEtfbZv+6BYT-oph1r8HsFTL0dVxcfsEwC6T-OvHOA1Ciw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sHVZBat1qFK84EwNNN1NeQtzdouIPd0Ai7trKbgw5ls_1758702660
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 24, 2025 at 04:08:33PM +0800, Jason Wang wrote:
> > On Wed, Sep 24, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 03:33:08PM +0800, Jason Wang wrote:
> > > > On Wed, Sep 24, 2025 at 3:18=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> > > > > > This patch series deals with TUN, TAP and vhost_net which drop =
incoming
> > > > > > SKBs whenever their internal ptr_ring buffer is full. Instead, =
with this
> > > > > > patch series, the associated netdev queue is stopped before thi=
s happens.
> > > > > > This allows the connected qdisc to function correctly as report=
ed by [1]
> > > > > > and improves application-layer performance, see our paper [2]. =
Meanwhile
> > > > > > the theoretical performance differs only slightly:
> > > > >
> > > > >
> > > > > About this whole approach.
> > > > > What if userspace is not consuming packets?
> > > > > Won't the watchdog warnings appear?
> > > > > Is it safe to allow userspace to block a tx queue
> > > > > indefinitely?
> > > >
> > > > I think it's safe as it's a userspace device, there's no way to
> > > > guarantee the userspace can process the packet in time (so no watch=
dog
> > > > for TUN).
> > > >
> > > > Thanks
> > >
> > > Hmm. Anyway, I guess if we ever want to enable timeout for tun,
> > > we can worry about it then.
> >
> > The problem is that the skb is freed until userspace calls recvmsg(),
> > so it would be tricky to implement a watchdog. (Or if we can do, we
> > can do BQL as well).
>
> I thought the watchdog generally watches queues not individual skbs?

Yes, but only if ndo_tx_timeout is implemented.

I mean it would be tricky if we want to implement ndo_tx_timeout since
we can't choose a good timeout.

Thanks

