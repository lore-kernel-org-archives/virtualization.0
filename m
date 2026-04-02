Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A626AE5
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172636; cv=pass; b=HweqjGM+juKS/o/qMIof/N99ATh1gw0RVhJsU38Nuxulxph38/WGqK2ez8MkCz6Yl3c1W0TL6+NYKfUNrPKkfctT9KOFvHD3vWj7lfTTTZ90zCe5w3HMbXPEIB44zP+IoPHIOxvRbx2nYRJrTG+dkwLATwy+c0OgMKvOHSeDWzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172636; c=relaxed/simple;
	bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcCwT6t26WeRM6FHgafGAPSDYoG8KEhfmCbR1RPZUAUES3oM0kk1ZQaYhFxNuSiHc8LSydZRDsz3AsPQpB0rdFCbrBnzCAjg+4e/yMpUOheIgSl+4FFMKRMLF8yu1W01AAFj8vps24GRWHrbjNu73osAaJL/6SNw1SiCsLC4EkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU9Vptdg; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU9Vptdg"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66e431964e5so156966a12.0
        for <virtualization@lists.linux.dev>; Thu, 02 Apr 2026 16:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775172633; cv=none;
        d=google.com; s=arc-20240605;
        b=WzvJkwtdqecO0arGeSvX5t0ATbSndAzFqcu1F9au6jEiuSqu0IkDW1eIiMhoR5BDMm
         oHj2OVnNNBZK3pBkWKiAkuAcG2H1eO/TZONvMdL7Se6fQtokKm4VKfP1HuIvbORtQjBz
         bkr1/ZKjxAq7DJnU5zuHE/3SpG3Pf9HCq68ZMUF/bURnvl7WSyqDn1R7gaxe0NNbFcBn
         5yn1MyVGRAQygJunI5a/7IP1pgrzCIayyYXll0uiqtwrpLKC+8sFpqKaj75i2OnrznVZ
         lDvbCkycazI3vd2x3HCUxh0D+Da6Wj/AoQm1u/EwCC5TRarL50bP7zcGUC+yyf7yli2B
         zc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
        fh=LH0XHQ5VSc0M1nnnyry7/zfrHrz6qFSJIs79VQ+uic4=;
        b=eQYUIgDY8mzT/8ogDKLM0zbKT0uKxU1jiLaEGfi7H57dp+NkvJR0DVjhxxnRnlpBTl
         0gP5DT4h3pD40DwxlhzCi9Fa7HC9H3yHzNMQvbAP847yC8ZujgAW2VgQRBk7YUJA/NI2
         4OM0HFmyYwmzjV/7kvwptccKBjmInVH/RKHb/nCB6eQCeMb11nuoE/k6YwVWxAPhy2TI
         6Sf8Yoni4uHxIVA683s9DM1jo3xi1YjitZSbuypwo/P6+TIjzhxLdceDuMsGjU9nd4tU
         u2flhE8zcv6tPFhUOqsGc96AqqVhHdbyfWsA8HZUjsuw1wnLhfr8p5iObX0zAGvmOVh1
         uGUA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775172633; x=1775777433; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
        b=IU9VptdgUAKvCAetvVt+pXvJZ1ZXiLboa/ngqBzBlYDiVQhG5ytyKzkszLyL7886sY
         to6J7g+DHN9W9/3w03nsLqltKmv0KNV032l+iBsHM5KPkd1PQjt9JiK9Hf1pIriOwkbp
         U1tsywdkvzqNgzYtQmLnVIGh7tF26qA3PMPLjP3oDtJyFqu12lYzQzcWLmcFUAh08Kr1
         ygBliLkg1NGfhpHeTNcZBphCc99TCLbGQ2Efx4PsCu/rVshdVSY5ByQZ42uMscWlCo7N
         wzP9KX0LjVZvmVBzCfon85XyX7dP1pvMlvve66cQYlzz4+M4wUIFqRSABzzAGcqT20F+
         RVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172633; x=1775777433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbUP87vEKVaqyp4f8DtXNZITW0zWjhu5ZVPcgNumnAM=;
        b=kla1XxrmgvqbuF/n4ghrxE0hfeYgLB1++P1TQ0JoxxPZTLtXzFm6j/QPUELcTuynZd
         0toAdmPpqM2V+DPZFqr7TR7CEs8qgEesA78Hu2LNmBTJ+0iaa4aQspwki+lVaMJrGi5L
         FI6PoV2NBDIUv9XvoBJXmTGd8qyCQvlv3d7Uyh2pDoRwsLqx/yz+LiNtchN6A7IL3P7A
         zsVYRa+Jhzyl6VPGrwQjhvdNRD/Noileh58+rn5Cvuk1q9/8/JQeMMS75dsCfaUxgwht
         Sx4tXNNCWYDGJTTMn1aTcMarqh+FvlfttLQ8C1SWEP0Zrz5rBzS866Jua6mF2rguXf2a
         1dHw==
X-Gm-Message-State: AOJu0Yz7gBbS9v/WuOxup3e/u2etrWuQQAV03r0E/xJ3pkMH0EXrBjIX
	Rn5yrrPjDh5BnYjUPBT/W6zB1y5FqsxJD4t6OcBuRU7/wJMX8ucRdWDoaQJUmmgSILmWshB3wNp
	4lrX0TO9FNwlQdy2Jyled+++wbEj2SGw=
X-Gm-Gg: AeBDiev5rjJLAN7j3CGc+2j8JY5rtAlNesWd/aOlQ1ghSx1vb7b0CLTcLs7Zwkj/4jk
	mxrXrrnII612Gs20HNQCKEiZ6v0zVIGst2sXLppP3a7eN51GbQGGee1GQTpOJb9JP02OYNhFtqP
	IcJm0Bli2VE/dQd4/KSrjzu0Eizw0D4tGY48APJDhxd9FxlDoR8i0oxhHw4S92mcMGAPdFe4I/L
	u5JWMTNVrREtjGMAPhfVU0ocyOS3L1voDznkQWFhWvhPA4ksmSkD1wIifMDXyywxyeWT4tht/QU
	9TbIsPM=
X-Received: by 2002:a05:6402:4510:b0:66c:2fdf:7613 with SMTP id
 4fb4d7f45d1cf-66e3f701e2emr406667a12.16.1775172632884; Thu, 02 Apr 2026
 16:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260402044637.73531-1-laurencerowe@gmail.com>
 <ac47PYPeL0IyRtY6@sgarzare-redhat> <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
In-Reply-To: <CAOycyLTy=ZT0AXiwPrbEfyxX_ZZgwzaetKOqP9cNywTO1_wNZw@mail.gmail.com>
From: Laurence Rowe <laurencerowe@gmail.com>
Date: Thu, 2 Apr 2026 16:30:20 -0700
X-Gm-Features: AQROBzAn_1Pe7hfjJrx-zqQ_xxG_tmvCIn21DwEYx30CeJR1P5ajlpmcc4tsRPk
Message-ID: <CAOycyLR-otKw4jTcNpo3pUBbDx9DVJyPU7b0T6uHib6mSrAvVg@mail.gmail.com>
Subject: Re: [PATCH] vsock: avoid timeout for non-blocking accept() with empty backlog
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 12:22=E2=80=AFPM Laurence Rowe <laurencerowe@gmail.c=
om> wrote:
>
> On Thu, Apr 2, 2026 at 5:03=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> > >Scheduling a timeout for a non-blocking accept with an empty backlog
> > >meant AF_VSOCK sockets used by epoll network servers incurred hundreds
> > >of microseconds of additional latency per accept loop compared to
> > >AF_INET or AF_UNIX sockets.
> >
> > Not related to this patch, but should we do something similar (in
> > another patch) also in vsock_connect() or doesn't matter since usually
> > it's always blocking?
>
> Looking at vsock_connect it's not immediately obvious to me whether it
> is affected
> in the same way. I'll capture some ftraces and follow up after
> updating this patch.

This does not seem to be a problem for vsock_connect since it checks
for `if (flags & O_NONBLOCK) {` in the while loop before calling
`schedule_timeout`.

Timings and ftraces:

https://github.com/lrowe/linux-vsock-accept-timeout-investigation?tab=3Drea=
dme-ov-file#a-quick-look-at-connect

Laurence
