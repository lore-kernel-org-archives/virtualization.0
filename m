Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F371BB6BA
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653636; cv=none; b=VAVdGhRFJbUkQGg0VhH6VkNeMrXRjOet7dC2s9f1eh8StlsxIXMpMoozmVXyQvJWTCkAw4Twrf9H+0wBtW2eiHMN1pFN22jOLyYRcAQPCoV/ArO3uILb3VOiSjVaZ1ZT6mfXrXy/AMesmK+T14q1gjpFB4SZpRBkzZV5Cg5bEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653636; c=relaxed/simple;
	bh=dyw753/H6BTUrRf3jQI1iojuAfN0WdNF+kraI3CjYVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUccX1mOZCAbPNYaGuDBPaM05T3HFSdZQvtAuE+8XjKrMeHllqW/LqWQkCNu45LfPDvIgF4DG+I09fdDqm/5XXwUuj0IaL55qurZXAh8vi0eZOD0dp027s+6ASibyJQLXFcsJ9n6iAihHTzZfl6vtMm3omJSQgciLAYjMwRNJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPOt1I8a; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPOt1I8a"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 873EF8164A
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uANVrI9VLyEg for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Mar 2025 00:40:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9F9E881649
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F9E881649
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GPOt1I8a
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F9E881649
	for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741653628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPFnFp1VkXPuK1wBnfwovz6gQVIIRqPSnwN9UsbsTOA=;
	b=GPOt1I8aQmKzFnM0hzVh5tFGShYXQ1c9Xz4LIaX5BcUV2X2AwPjpQY6+oSBbtFZ37yl4uu
	qoSy5ATkmQyOPvZjZPWXtRkJH9iLzZhTILq928l/aR+z6Dbzr8DzPb+DG1N5uzEszCGyC3
	MP969IQFNSEbVKO0dfYXIXgE/0Q+c8c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-GI8fJroePbmF0FNG6203hg-1; Mon, 10 Mar 2025 20:40:25 -0400
X-MC-Unique: GI8fJroePbmF0FNG6203hg-1
X-Mimecast-MFC-AGG-ID: GI8fJroePbmF0FNG6203hg_1741653624
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff581215a0so13731397a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 17:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741653624; x=1742258424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPFnFp1VkXPuK1wBnfwovz6gQVIIRqPSnwN9UsbsTOA=;
        b=DYuPvwK0oGiTcGVmPCg32q2M1DbNzBrm+EzJ1Jy3KCDscBoD2uZqLXyxN01ZtnV9ea
         psDcgbBZBAsCTO8wE/t4qMny+cWhLPmOQR/7CEPWnQPrVBuZNzWZQBSf8Vvzwa7Igniy
         N3slTPt2Yz+2koWo2ra0ZeGmYNjV5UspZt8SOK4uCanoEAp089OzS6/0GHz8Ro8c2z+p
         KzIZOr4CJNgWGp2LiMnhDU8RfHPTCkk2QgJ3WqL8rj9Q1vErJiBxBxgZ5DBxVOsRjLTT
         9jUfhIGL6yp+pIb+qQuV8VeWp/XLMEmF3Onbmu1lhAXleWXgRXHad1oqkb0+5CqiqrJh
         pXnA==
X-Forwarded-Encrypted: i=1; AJvYcCW5IMOx1fGk2hBCwMN6nOla+URdcKnnPDwP9/THwi3pVeUtJqzlOco+SKo3+93/9SJOA0Sz4OCqYjSZnauilQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxB6lVAhgecFMeyNX95MvOI750fCa0xiDMMRxF3Eru6twgJeaBg
	2XXWrLSsMCwD217koM7WRU3lQh4numlgnAF1se/A7gmhnTE52N+tGVlhptL8jywZoiUwsDjA9nO
	NXjNzQBL718yY6WezRbB2pONSRI7UHMJQ7Q/3eqwfAsSlTl2UMAInYvcHCCtgnA5i48Adv1JC/M
	k4vpZxiByzfatvrc7p5K2jxMsALrc7A3hnF2njc+5gd/uTIBcYl30wFg==
X-Gm-Gg: ASbGnctkPti8Os8TTUNNL2Ry/x6SuWh4lsdDGSpGD5YyrRtQ7QieB/2nP+QB9B+KLXD
	5yJaP5dIbgj2802mtFh+q+SvoBoefyxD8fV7FH+741N+23wnjdwGCTcktAMUbUUksF3F4tQ==
X-Received: by 2002:a17:90b:4d8c:b0:2ee:b8ac:73b0 with SMTP id 98e67ed59e1d1-2ff7ce47c06mr25678683a91.2.1741653623965;
        Mon, 10 Mar 2025 17:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCTIxNW5KVnhioASoe6KuDcaNU+MoVXuWjH8X5aO/fiowwzFcttBDg5Qj2LCfTQUSRsi5colKFgqeeGjkAv4Y=
X-Received: by 2002:a17:90b:4d8c:b0:2ee:b8ac:73b0 with SMTP id
 98e67ed59e1d1-2ff7ce47c06mr25678644a91.2.1741653623483; Mon, 10 Mar 2025
 17:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com> <5d81246c-1e69-4301-ae6f-63838733672d@daynix.com>
In-Reply-To: <5d81246c-1e69-4301-ae6f-63838733672d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Mar 2025 08:40:11 +0800
X-Gm-Features: AQ5f1Jrq56wv3c7Sji25V2t3viqORzyfR5RJXtNkfnP10Huk8xi4r-Xv7AC1mUA
Message-ID: <CACGkMEv0ehQJPUzkJTkX0=bsSULdRdtgxOpjCJ+56Xh6RAQJYA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: TV0Um8bV8SenwGrtgh57n_81xHcvYDvW7Y_qdhpHP3E_1741653624
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/10 12:55, Jason Wang wrote:
> > On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> Hash reporting
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Allow the guest to reuse the hash value to make receive steering
> >> consistent between the host and guest, and to save hash computation.
> >>
> >> RSS
> >> =3D=3D=3D
> >>
> >> RSS is a receive steering algorithm that can be negotiated to use with
> >> virtio_net. Conventionally the hash calculation was done by the VMM.
> >> However, computing the hash after the queue was chosen defeats the
> >> purpose of RSS.
> >>
> >> Another approach is to use eBPF steering program. This approach has
> >> another downside: it cannot report the calculated hash due to the
> >> restrictive nature of eBPF steering program.
> >>
> >> Introduce the code to perform RSS to the kernel in order to overcome
> >> thse challenges. An alternative solution is to extend the eBPF steerin=
g
> >> program so that it will be able to report to the userspace, but I didn=
't
> >> opt for it because extending the current mechanism of eBPF steering
> >> program as is because it relies on legacy context rewriting, and
> >> introducing kfunc-based eBPF will result in non-UAPI dependency while
> >> the other relevant virtualization APIs such as KVM and vhost_net are
> >> UAPIs.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> Tested-by: Lei Yang <leiyang@redhat.com>
> >> ---
> >>   Documentation/networking/tuntap.rst |   7 ++
> >>   drivers/net/Kconfig                 |   1 +
> >>   drivers/net/tap.c                   |  68 ++++++++++++++-
> >>   drivers/net/tun.c                   |  98 +++++++++++++++++-----
> >>   drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++=
++++++++--
> >>   include/linux/if_tap.h              |   2 +
> >>   include/linux/skbuff.h              |   3 +
> >>   include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >>   net/core/skbuff.c                   |   4 +
> >>   9 files changed, 386 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/Documentation/networking/tuntap.rst b/Documentation/netwo=
rking/tuntap.rst
> >> index 4d7087f727be5e37dfbf5066a9e9c872cc98898d..86b4ae8caa8ad062c1e558=
920be42ce0d4217465 100644
> >> --- a/Documentation/networking/tuntap.rst
> >> +++ b/Documentation/networking/tuntap.rst
> >> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable=
 it::
> >>         return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
> >>     }
> >>

[...]

> >>
> >> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> >> index 58b9ac7a5fc4084c789fe94fe36b5f8631bf1fa4..8e7d51fb0b4742cef56e7c=
5ad778b156cc654bed 100644
> >> --- a/drivers/net/tun_vnet.h
> >> +++ b/drivers/net/tun_vnet.h
> >> @@ -6,6 +6,16 @@
> >>   #define TUN_VNET_LE     0x80000000
> >>   #define TUN_VNET_BE     0x40000000
> >>
> >> +typedef struct virtio_net_hash *(*tun_vnet_hash_add)(struct sk_buff *=
);
> >> +typedef const struct virtio_net_hash *(*tun_vnet_hash_find)(const str=
uct sk_buff *);
> >> +
> >> +struct tun_vnet_hash_container {
> >> +       struct tun_vnet_hash common;
> >
> > I'd rename this as hash.
>
> Everything in this structure is about hash. "common" represents its
> feature well.
>
> I see a few alternative options though I don't prefer them either; they
> make the code verbose and I don't think they are worthwhile:
> 1. Rename tun_vnet_hash to tun_vnet_hash_common.
> 2. Prefix the other fields with "hash_" for consistency.

Or use different structures, one for hash_report another is for rss.

>
> >
> >> +       struct tun_vnet_hash_rss rss;
> >> +       u32 rss_key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >> +       u16 rss_indirection_table[];
> >> +};
> >
> > Besides the separated ioctl, I'd split this structure into rss and
> > hash part as well.

Like this.

Thanks

