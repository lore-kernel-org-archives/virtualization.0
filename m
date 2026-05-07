Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F52E7F2C
	for <virtualization@lists.linux.dev>; Thu,  7 May 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171559; cv=pass; b=TkOl3O2BnwiVPIhNJiPcvJiwCHZaQCJiNs9z6U0FfrHuc8KlRRyapuiBfWnRlxVhiCdlLq2FuU2933tKkQgwLrzpDZ2PQbz6XjV/ZaXtTkNyZoUY1aNor9FSLD2/ccSZuq8sRXh32febbhvHaQU6/pAQ7BMnGIWF0yZ2bsz1/mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171559; c=relaxed/simple;
	bh=8VRBFuEjBtdNxMc+0CLtM7mNvR9Ak+SZIaiiqsTAXjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8qTr0Ne71CqQvnukS+8A60ILxu/yr48s9LZGW4Iu92w3xbnE9v9QMnW7l/kJIyTNFZOiHQhv47wfxEyko9SfLjIK45Z9imkVCIB1rdMOIbiJc+mvcsveRKRnZ6+xOoqaR7UoBp2+kgW/nG9z3soZy0tkoCmrW3GQaTbNz/g+H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gozOsDR5; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gozOsDR5"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5102582e23eso7358651cf.1
        for <virtualization@lists.linux.dev>; Thu, 07 May 2026 09:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778171557; cv=none;
        d=google.com; s=arc-20240605;
        b=DgQhVAwjg0JxBESU5nYdPAo1qk/GKHPE3zYgHLYQ0TP60n4Dexf70wFcOHR1jPL9TO
         pGlqVfOO9m7i8goV0tp6lERR5DFj9k7nBn3gu21yedwtp6XiVCBxCqcInyRyisFJPx6u
         h6AHxiIcGt7kYOwg+bmmMrhaqPf0CR5Jg2J4crj8GxFNC2ufZq369/W/uE1N8IaRAaog
         vCvLpxOeaAV6xpcY5RL3XSFp0StYH9pTT/ZkAAVKGKtYailMM8eUkcOinY/0B4QlTdp1
         U5hl7JwmcksWOPr+Y67tsi7dX63SLT+7adF/W4q5KlkGL02hSpLZ6nKKmUjN9SQwr3si
         n3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        fh=SWri3iUGCZsKdi6rfs0RLmRR8imJ/h0MtwYM/UzcdM8=;
        b=Q+WYAKbyR1wk6REoNq2U0eCoJ5V+oP0+KB8nH1/ordvTaEC77y1ZVq6FKd+j5x/9DL
         EckzHF3It7HwnQ2D+ILP9jeOL0pHcmry8wBKRP9s43zuuTZsV13SSjxQJnDPNbRCzlUa
         xWkbRypF7SPTHaNnPsjAVhLOP19wEJA6IicWstAJ8MNj2OwpCh75f1I+/vNYNTvkr3OP
         +rpAVmih0C2lXtTAwi6cOewfBdDStkqagrPPWtbyJfsZm4z0O2xCU88Y35W/OieOnEPz
         MQrFr3w+ZOEG3HM4oSoij47bDAh+pv+GFIdZ0D/5VRkVLc1PW3YBAsPO5P0K35rPMQWK
         A1XQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778171557; x=1778776357; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        b=gozOsDR59TTD4KNsp6IVTgRbzKH2DShZkAAmVeEBEmwZwVJoymgF4Ms4hDSfqEMw7g
         1TtLCpQIjISVNjyQukFLcNCnAc5CL39BHHKgaLlWVCmXbn2Wg0JDOrF6uFkf73V6NvWM
         VpUZ83oey2dsvNEbHrvLMBM3jziBrErO6pnDnwNlj5MVgFUv36x9briFUKhaxRxOjBsU
         WT+JdKWzg51a4neUxg+MZicu0RPb+JyPNPApmxAPCompVZyQTHCBO8+Po2R6eTRdN35x
         4VfseDNvhT94jluilIlFuTN+CiZy1a/i6Xa5V3MW6JOZ9aIj8k1iJSxrc/ILbGM9+fAR
         EOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778171557; x=1778776357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9c9Ph+69ZwWpRAxYxtwXGr1jYxWNZFenTXWLY82Jkf0=;
        b=VJ3fYEroDR2zxt9pgxCRH421s5CFBtoYpcwEpsHAGDnpyhpAVy/6y4+R95xTj5BGPh
         PybqctjAE8xNumrClX1ykwdl5MuxAiHU9ggm3rf6w8nWM3w5Sn32cnlHTz+dG+iRYFwF
         Frn2hEgFc3PSquA3yEjKs5EVjzESqS73hij7j8UkO3ZPRAITpvFD6SHzxfMdGMb3e4W/
         2owjf60kqtspLZ0M47XyyitCG3i4mCQ1QXv1dhLNew+ZiyntJkkwq8kf4g24xEM1X7HS
         sbPFU1zCiaFqeKxbHoL1lcIOYvtNc4IjNKLtDU/OYKkbQ9A89m2hDs4mnBvl2LuJYMtl
         Z0kQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qICa4JlTM0YlCHQVAlmJyJ0cghqTbOrPJYqF1tOOYENtPaft2BFglsbux7Scvz6dLl+xDvRHAz+Kh+gOVZA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzrl5AjX+aCIJ1xbc9yOADPovU4XjMVsEKE/jXutkRDErzbxFuY
	g25tu61udxZ9eZ4QrTnjWYjkSxUOd0Z6+SqgHAaWryqJh28Ha8NTeAKbdMBGQ8z/nehN6BghRi2
	gmE1hLlc95dmjaJk1CYjU1rRF7wYm3ETkuqkflgIA
X-Gm-Gg: AeBDiev8Uw2pUyVWsfhjpswj/4fL9RQ/YvraQ4OVLT4svVyZM63lZ1tIE3GavMt74hi
	l4NJRMVPiIbu0FNstCjoTsvtrliezBqbdEm9yfQQcJtabDXMrNbNlsK4M0pr2g8C/n04yFqTS98
	CL52pAXMKkcX2PCMSKcv2oOKxeGoP/5Ysc8yES/ca+2Xc7emHr47lPh6mfck4lF85wZlG8k287V
	mQ2cuqmADnfwQ4Mx3sbwvICjBmcfh8MsoZZL+Lc8AqyULHnsK4hPcyxMox+tMT+OvlGJCqQZZAV
	e07BOTexw6+I2iih5Hfiieg4UY5DErIP0tNd0nVuvgewJ0sjC1EfBaiup6MilQyQNM0aD7j+0ce
	aEtxdJ0s3/VmNbAr2R9DJ3uanoo1lQBU=
X-Received: by 2002:ac8:5a16:0:b0:50d:9b07:9c46 with SMTP id
 d75a77b69052e-51461fa0213mr115677391cf.33.1778171555577; Thu, 07 May 2026
 09:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430122653.554058-1-edumazet@google.com> <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat> <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat> <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat> <20260507073340.0604667d@kernel.org> <afyy9CeniTBF3o2I@sgarzare-redhat>
In-Reply-To: <afyy9CeniTBF3o2I@sgarzare-redhat>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 May 2026 09:32:24 -0700
X-Gm-Features: AVHnY4K43sQ5GiXATqMbu7KFCF7zUxmTlewiAWXiJfdc41BJ0Cit2Qu3K7HJSFU
Message-ID: <CANn89iJ+qOFPSUACvda7djOVKGM8t+FfwdA5Ymjxe+g_tJtmnA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby Eshleman <bobbyeshleman@meta.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 9:05=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
> >On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
> >> >well if you want to support pathological cases such as 1 byte message=
s
> >> >that would mean like 100x reduction no?
> >>
> >> Yep, but since this patch is already merged, IMHO that is better than
> >> losing data in those pathological cases.
> >
> >We can revert if you think that the risk of regression is high..
> >Please LMK soon, we can do it before patch reaches Linus.
> >
>
> Some tests in tools/testing/vsock/vsock_test.c are failing with this
> patch applied.
>
> Test 18 are failing sometime in this way (I guess because we are
> dropping packets):
>
> 18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>
> Test 22 is failing 100% in this way:
>
> 22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> Resource temporarily unavailable
>
>
> With my followup patch adding also advertisement to the other peer
> (still draft locally, waiting for Michael proposal) I saw 22 failing,
> because tests expects that can use the entire buf_alloc, but now we are
> reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and
> double the buffer size, or at least digest an overhead equal to the
> buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah,
> AF_VSOCK has it owns sockopt since the beginning :-().
>
> With that approach tests are passing, but I'd like to stress a bit more
> that patch. I'll send it tomorrow as fixup of this patch, or if you
> prefer to revert, I'll send as standalone.
>

A plain revert is a big issue, now users now how to crash hypervisors.

This vulnerability allows a compromised guest (controlling
virtio_vsock_hdr fields)
to continuously flood the host's vsock receive queue without
triggering any memory
 accounting limits or reader wakeups, resulting in unbounded host
kernel memory consumption (Host DoS via OOM).

A vulnerability where a KVM guest can crash or deadlock its host is
classified as a KVM DoS.

Am I missing something?
