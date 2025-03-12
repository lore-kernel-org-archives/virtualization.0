Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068218D620
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746967; cv=none; b=UmFYpEDTKO1QJHFZ+cept8CV8tdT2AgHBWXoRgw6JJv10lHJKuTlyULaF9arwnaIimDWPAtZLqzJSvApp1zKsOZ+gSmiHL0bXBeLThQtxtGkX+7LTDdQb7Ky+IpwSLWerRKD6xDtKNtCUVa/d0BSrS6dLq6oJF6iV9NDGn3AklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746967; c=relaxed/simple;
	bh=/Y6ryLM9U1SmUsI7JJnD4HP0YRU2PkTH5Sg0867JL9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTk75N66eAM1Dg4M9W2IuaePLuUzfFibd7Fa1DqrSIqUpgN8mvhtLl7/fZmaig0B+QM9jD2QpEqP67FjaM+X3sWL3gKPdLf8ymTvJXQ/5n5WnvpReSzC0CfuUwgEQGc03lVAoEADsTJ9eMqTLoKZVxV0bre2muGmUbVt2/V+iVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RCi9/iCc; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCi9/iCc"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD0D82115
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 02:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U-kbepsDAOoW for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Mar 2025 02:36:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 715278210F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 715278210F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RCi9/iCc
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 715278210F
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 02:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741746962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0Qdf6BCD5X+PG4UHFD0dZOYm8Xo5mFSwYaydb7HeOw=;
	b=RCi9/iCcrh6ZeYr2F7vkY/5FAFQqzINaB6xA+Vd5r7OoNW1/NKlMb03YO2UtWpGkrupVN5
	E0FtogtX8u9vkRgD15Tdp8QWWAO0GO6r+SOy2N9xu3Dl6WE0VJE1q/AvTbzvmVjD9RYjzi
	VIF1w6JqjEaF/Sw6P20/6YhDkzUuG2o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-0vipStk8PS6_dPZnTQ5osw-1; Tue, 11 Mar 2025 22:36:01 -0400
X-MC-Unique: 0vipStk8PS6_dPZnTQ5osw-1
X-Mimecast-MFC-AGG-ID: 0vipStk8PS6_dPZnTQ5osw_1741746961
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8c5d185aso11831078a91.1
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 19:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741746960; x=1742351760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0Qdf6BCD5X+PG4UHFD0dZOYm8Xo5mFSwYaydb7HeOw=;
        b=hegw/ty5xAyAnn+BDROOPs98cbwkVmWQIVyoRLJZ2keA1ORq9Z05H7sa5FGUmnPW3v
         ASBbp0Tn7PukVQZoFmnlpDFlEb+dRv/FTFOkY5QbXtFjVNnjqiC07uKUzYjcMBMDypyw
         2ltgdkrw7bj+L8RiCTAYTcFvLkk4vsonFsEc9+ZFu6bqcsVvqi112v4HKkaXUv/0WhX+
         Q1kkRhPI1pRX/64MpNCPwFNgeGGgcL3uv46XUeR9UdsM94wwjv2+NrL8XP/LLeGixGD6
         KYYqrapjYalmxR5NVipNtcyo5VlDckmX4z0DEScVaTgAT0v2+hJh5/RXSs1hjYVe9hwl
         qp3g==
X-Forwarded-Encrypted: i=1; AJvYcCXO3+44ZjI5JkYlSXNByIfzbRWiaagaJ8K3LtYEbjMzyqiV6oH0Zt07B7yFE/2uiY2Zk/Cvt4KziY+1V9ST6Q==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyG4RhZL8f7rjpSzV04Z7HifD5aIvKqd9wjqUN/L+qTnIUBH2e6
	ObPSLBgoSaZh7Mk/eNUI+6WW+YrlscSHodPigcxib2gy15iySLOSH8tftTX5MWgJmxd/NFKntAz
	qeZQrlzc9p4qfcdbcbq3JzhxZv/fLABIATCK7ANrK1Z7hIS9AIZhmm7ygDya+e/0TVzW+ygMeaZ
	/Vh8i8zYo5mUz0ONKsn/Th4gWzu96vL4gb/grdjE/gqLG2OgOmwiOF5Q==
X-Gm-Gg: ASbGnctNEcNzCCUaox0841hCc6zW2R35nmcqlkJJiREyiZbNKrQ5DeYMoitAHi1AT0P
	SpU5GTR6QCCEbTbypOM0RMeb1ZFvYHfYBliyQMNdyqZi7ddMVNj75PABebt7cxO40FhWVxQ==
X-Received: by 2002:a17:90b:3c8d:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2ff7ce7b230mr27082193a91.1.1741746960585;
        Tue, 11 Mar 2025 19:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlLyYz8YJAVDNTXvlrIkZ+ah2U7LaY6qVBnKj82yTIAhQAQGr7mchFwjJakUBUDLzrmHkg5nzqFWCWqq/bzbU=
X-Received: by 2002:a17:90b:3c8d:b0:2ee:7411:ca99 with SMTP id
 98e67ed59e1d1-2ff7ce7b230mr27082162a91.1.1741746960104; Tue, 11 Mar 2025
 19:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com> <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <edf41317-2191-458f-a315-87d5af42a264@daynix.com>
In-Reply-To: <edf41317-2191-458f-a315-87d5af42a264@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 10:35:45 +0800
X-Gm-Features: AQ5f1JpYZL86COIp0eU_jp91g3-ub-snbz3KyBvB3RDdU7-3JlIdfCetReW4Pdg
Message-ID: <CACGkMEta3k_JOhKv44XiBXZb=WuS=KbSeJNpYxCdeiAgRY2azg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
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
X-Mimecast-MFC-PROC-ID: JBZdPboF1eiMJNI8fGqh31OsTm64LBdrOEPF9kl-Ids_1741746961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:11=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/11 9:38, Jason Wang wrote:
> > On Mon, Mar 10, 2025 at 3:45=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/10 12:55, Jason Wang wrote:
> >>> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> Hash reporting
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Allow the guest to reuse the hash value to make receive steering
> >>>> consistent between the host and guest, and to save hash computation.
> >>>>
> >>>> RSS
> >>>> =3D=3D=3D
> >>>>
> >>>> RSS is a receive steering algorithm that can be negotiated to use wi=
th
> >>>> virtio_net. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF steering program.
> >>>>
> >>>> Introduce the code to perform RSS to the kernel in order to overcome
> >>>> thse challenges. An alternative solution is to extend the eBPF steer=
ing
> >>>> program so that it will be able to report to the userspace, but I di=
dn't
> >>>> opt for it because extending the current mechanism of eBPF steering
> >>>> program as is because it relies on legacy context rewriting, and
> >>>> introducing kfunc-based eBPF will result in non-UAPI dependency whil=
e
> >>>> the other relevant virtualization APIs such as KVM and vhost_net are
> >>>> UAPIs.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    Documentation/networking/tuntap.rst |   7 ++
> >>>>    drivers/net/Kconfig                 |   1 +
> >>>>    drivers/net/tap.c                   |  68 ++++++++++++++-
> >>>>    drivers/net/tun.c                   |  98 +++++++++++++++++-----
> >>>>    drivers/net/tun_vnet.h              | 159 +++++++++++++++++++++++=
+++++++++++--
> >>>>    include/linux/if_tap.h              |   2 +
> >>>>    include/linux/skbuff.h              |   3 +
> >>>>    include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >>>>    net/core/skbuff.c                   |   4 +
> >>>>    9 files changed, 386 insertions(+), 31 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/net=
working/tuntap.rst
> >>>> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e5=
58920be42ce0d4217465 100644
> >>>> --- a/Documentation/networking/tuntap.rst
> >>>> +++ b/Documentation/networking/tuntap.rst
> >>>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disab=
le it::
> >>>>          return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>>>      }
> >>>>

[...]

> >>>> +static inline long tun_vnet_ioctl_sethash(struct tun_vnet_hash_cont=
ainer __rcu **hashp,
> >>>> +                                         bool can_rss, void __user =
*argp)
> >>>
> >>> So again, can_rss seems to be tricky. Looking at its caller, it tires
> >>> to make eBPF and RSS mutually exclusive. I still don't understand why
> >>> we need this. Allow eBPF program to override some of the path seems t=
o
> >>> be common practice.
> >>>
> >>> What's more, we didn't try (or even can't) to make automq and eBPF to
> >>> be mutually exclusive. So I still didn't see what we gain from this
> >>> and it complicates the codes and may lead to ambiguous uAPI/behaviour=
.
> >>
> >> automq and eBPF are mutually exclusive; automq is disabled when an eBP=
F
> >> steering program is set so I followed the example here.
> >
> > I meant from the view of uAPI, the kernel doesn't or can't reject eBPF
> > while using automq.
>  > >>
> >> We don't even have an interface for eBPF to let it fall back to anothe=
r
> >> alogirhtm.
> >
> > It doesn't even need this, e.g XDP overrides the default receiving path=
.
> >
> >> I could make it fall back to RSS if the eBPF steeering
> >> program is designed to fall back to automq when it returns e.g., -1. B=
ut
> >> such an interface is currently not defined and defining one is out of
> >> scope of this patch series.
> >
> > Just to make sure we are on the same page, I meant we just need to
> > make the behaviour consistent: allow eBPF to override the behaviour of
> > both automq and rss.
>
> That assumes eBPF takes precedence over RSS, which is not obvious to me.

Well, it's kind of obvious. Not speaking the eBPF selector, we have
other eBPF stuffs like skbedit etc.

>
> Let's add an interface for the eBPF steering program to fall back to
> another steering algorithm. I said it is out of scope before, but it
> makes clear that the eBPF steering program takes precedence over other
> algorithms and allows us to delete the code for the configuration
> validation in this patch.

Fallback is out of scope but it's not what I meant.

I meant in the current uAPI take eBPF precedence over automq. It's
much more simpler to stick this precedence unless we see obvious
advanatge.

>
> >
> >>
> >>>

[...]

> >>> Is there a chance that we can reach here without TUN_VNET_HASH_REPORT=
?
> >>> If yes, it should be a bug.
> >>
> >> It is possible to use RSS without TUN_VNET_HASH_REPORT.
> >
> > Another call to separate the ioctls then.
>
> RSS and hash reporting are not completely independent though.

Spec said:

"""
VIRTIO_NET_F_RSSRequires VIRTIO_NET_F_CTRL_VQ.
"""

>
> A plot twist is the "types" parameter; it is a parameter that is
> "common" for RSS and hash reporting.

So we can share part of the structure through the uAPI.

> RSS and hash reporting must share
> this parameter when both are enabled at the same time; otherwise RSS may
> compute hash values that are not suited for hash reporting.

Is this mandated by the spec? If yes, we can add a check. If not,
userspace risk themselves as a mis-configuration which we don't need
to bother.

Note that spec use different commands for hash_report and rss.

>
> The paramter will be duplicated if we have separate ioctls for RSS and
> hash reporting, and the kernel will have a chiken-egg problem when
> ensuring they are synchronized; when the ioctl for RSS is issued, should
> the kernel ensure the "types" parameter is identical with one specified
> for hash reporting? It will not work if the userspace may decide to
> configure hash reporting after RSS.
>

See my reply above.

Thanks

