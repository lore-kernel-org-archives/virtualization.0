Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581C1C5496
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749088548; cv=none; b=Yeok6JHJ+RfPhzydfTaxRKZI0ToVf98ZtfJIAJbWvl4HkWh2mW0RdN+IbuGFdn62QhwjioVhFAXZSoVpp89gxWoH59elp8llvVhU9aaUDVsrmbcm5SDZ5ifZB9p+AFMJtp4iIDenUBMphZJIfBNN1auO1c9jVEsNt042D44I+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749088548; c=relaxed/simple;
	bh=+c9Fev8/Meg10Uoay1ZU/kdCAOWZDW9/gdNngKjH6Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1aEeedOjKZJpdqt9g9jJx2t4umvwy/ZkE4cThNaxax0yk3gKk3SScgn8J7N8Lt5Kr8DqIV1CxXHlcUV3hL36nJdySnaOdt84FGyMTaHnyqJfzYnBtmxpv8f8VfBp8/30P7pjxNxCh5HSTGsMgDVNPrXcfpKLn1KltFs951BuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9dn5VPb; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9dn5VPb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A8447400FB
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 01:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CnpzpxAX3Loj for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Jun 2025 01:55:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D0BA740067
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0BA740067
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e9dn5VPb
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D0BA740067
	for <virtualization@lists.linux-foundation.org>; Thu,  5 Jun 2025 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749088543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AwB0rFfcz08HKP4jJKt0w7l+d02ZrCK/l/MYo9cvhM=;
	b=e9dn5VPbZ6cPgXsKMO7iQ7MzNkm1ovj9A6LaFLwiNX1h5NVcXetUqvVfxQI8mBrgNhXKsC
	oUD0FoTkMG4vV7oUtMGvfdLBZiQPLKCr76DNa1y3bbiN7NxvKfuGCf0XMRPWCS9CBmzm0f
	35Ri7rZ9YuSt05kUdm+Eq4JVxYypZoQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-eVrhLSdrM4OdKkdfoIz_Pg-1; Wed, 04 Jun 2025 21:55:42 -0400
X-MC-Unique: eVrhLSdrM4OdKkdfoIz_Pg-1
X-Mimecast-MFC-AGG-ID: eVrhLSdrM4OdKkdfoIz_Pg_1749088542
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7462aff55bfso441632b3a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 04 Jun 2025 18:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749088541; x=1749693341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AwB0rFfcz08HKP4jJKt0w7l+d02ZrCK/l/MYo9cvhM=;
        b=p4hFdn7aKiy98l26trw7nzHUHzuEGaxl02A5duqj+EoIe5rhZM2+BXVGi8bgXM/y5p
         wtiuvUzM9KipnGHioHS01mkx8dsbsEPL26ig2aGcAm9rZtPauiVfHk6SnXExT8q6BP2B
         YD72b/pb/5C5qw+edupUtKqQTmE5FdGGWhvJEWJSvTS+IpCf/HPOz6kEZ1HE/RhtH4Wb
         xz5PhY8Rn6BnX1vyXOfx43w3acu6fMu+DK9CbErWsr4808lkAL90OlNLXI6svjbzQRu0
         5PmxQavXw+HrFyu3ABThRvEb/FFSqOqtA7wGBpfAxeQXiSmblPtXuCmH2YxkNyRiOorA
         vi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcB0y3hB2OQrnbupzYbDkzHf7YJwfUgGHUhbUVXaIZAKFcip+f0ma5CsT4yWhZHCmArveS5whAQW4ynr3y7A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxSzjpY3jwVtYH5eKKM963EtqmJD6MapZc3K5OmeeJHb+QbvCF5
	+qM7PeHskkEhDURrXzZhCQFck2aKSlSghj7cKgnHK2bsCQq6gconZjOAjaQx2Eu2QFRJLNHR3mB
	tyGphPHSnWd1cxZ/ZEtNODeK3ih825FFV16T8enCGIKOlfY66DVP9OKYsVApB+4OVPqR6ycIziw
	SmKDNKGMZsJ5H2VNQzSZGJ9MVACFPKmPTfhBCxaWitMUwvWj5pcaSo8mgZuA==
X-Gm-Gg: ASbGncuUabmhzsnKT4Iyn4o+1dMG9WdDmVxtGDsvkjvSnRaF8D0cRKVzfRC2H+qsM1Q
	ivi7fQqPx8jKtc/MbkYfa5qTh1f9F4bgRGq8Rr2MBfRLAIOSGIm9s1AMI8jBLNvGoYG3c
X-Received: by 2002:a05:6a00:2388:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-7480b4d1082mr6213276b3a.21.1749088541544;
        Wed, 04 Jun 2025 18:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwnJcqWyBWgiV7ZC471A+qE9fAqmmsGEYcyWVU07xTy7Qtf9rwO6aj8PQ3oqhbhbV/So3yIUnkKqxQkvKzki0=
X-Received: by 2002:a05:6a00:2388:b0:740:9d7c:aeb9 with SMTP id
 d2e1a72fcca58-7480b4d1082mr6213256b3a.21.1749088541126; Wed, 04 Jun 2025
 18:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-3-95d8b348de91@daynix.com>
 <CACGkMEvVf0LrquZcWSv3vp-r44sTj0ZDnjwbwB20N0aU35+vxw@mail.gmail.com> <517d5838-3313-4b31-b96d-d471b062cd1a@daynix.com>
In-Reply-To: <517d5838-3313-4b31-b96d-d471b062cd1a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Jun 2025 09:55:29 +0800
X-Gm-Features: AX0GCFurXm0NIffhahLwnERAjW3lh1v_d_xG6UdMjWsQHXxbHYsep8L113YBN6k
Message-ID: <CACGkMEvyaY0rdNTj_jP_4HF5TrCCNeTKZZ8U2LsMikLqyctkzA@mail.gmail.com>
Subject: Re: [PATCH net-next v12 03/10] tun: Allow steering eBPF program to
 fall back
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jX-kwStqyFCQHCzJjJE435Xs23ZdjjcDjays9HzvLxw_1749088542
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:24=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> On 2025/06/04 10:27, Jason Wang wrote:
> > On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>
> >> This clarifies a steering eBPF program takes precedence over the other
> >> steering algorithms.
> >
> > Let's give an example on the use case for this.
> >
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   Documentation/networking/tuntap.rst |  7 +++++++
> >>   drivers/net/tun.c                   | 28 +++++++++++++++++----------=
-
> >>   include/uapi/linux/if_tun.h         |  9 +++++++++
> >>   3 files changed, 33 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/Documentation/networking/tuntap.rst b/Documentation/netwo=
rking/tuntap.rst
> >> index 4d7087f727be..86b4ae8caa8a 100644
> >> --- a/Documentation/networking/tuntap.rst
> >> +++ b/Documentation/networking/tuntap.rst
> >> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable=
 it::
> >>         return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>     }
> >>
> >> +3.4 Reference
> >> +-------------
> >> +
> >> +``linux/if_tun.h`` defines the interface described below:
> >> +
> >> +.. kernel-doc:: include/uapi/linux/if_tun.h
> >> +
> >>   Universal TUN/TAP device driver Frequently Asked Question
> >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index d8f4d3e996a7..9133ab9ed3f5 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_st=
ruct *tun, struct sk_buff *skb)
> >>          return txq;
> >>   }
> >>
> >> -static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_bu=
ff *skb)
> >> +static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_b=
uff *skb,
> >> +                                 u16 *ret)
> >>   {
> >>          struct tun_prog *prog;
> >>          u32 numqueues;
> >> -       u16 ret =3D 0;
> >> +       u32 prog_ret;
> >> +
> >> +       prog =3D rcu_dereference(tun->steering_prog);
> >> +       if (!prog)
> >> +               return false;
> >>
> >>          numqueues =3D READ_ONCE(tun->numqueues);
> >> -       if (!numqueues)
> >> -               return 0;
> >> +       if (!numqueues) {
> >> +               *ret =3D 0;
> >> +               return true;
> >> +       }
> >>
> >> -       prog =3D rcu_dereference(tun->steering_prog);
> >> -       if (prog)
> >> -               ret =3D bpf_prog_run_clear_cb(prog->prog, skb);
> >> +       prog_ret =3D bpf_prog_run_clear_cb(prog->prog, skb);
> >> +       if (prog_ret =3D=3D TUN_STEERINGEBPF_FALLBACK)
> >> +               return false;
> >
> > This seems to break the uAPI. So I think we need a new ioctl to enable
> > the behaviour
>
> I assumed it is fine to repurpose one of the 32-bit integer values since
> 32-bit integer is too big to specify the queue number, but it may not be
> fine. I don't have a concrete use case either.
>
> Perhaps it is safer to note that TUNSETSTEERINGEBPF takes precedence
> over TUNSETVNETRSS to allow such an extension in the future (but without
> implementing one now).

Yes, that's my original point. Let's start from something that is
simpler and safer.

Thanks

