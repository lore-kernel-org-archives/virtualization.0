Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC919D092
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748414; cv=none; b=agWFq9QVyMueGk+zVHjO1NgQbAdVa9U9qgFnHcgOQayT3oFa9whtEdF7Qe8/MNx5sEPi97Wvz7/ja9UZGHlclRHqeUDP3qtO7N6Gr+dgPHGtj3SfPoI5ABGDKN+fVHSpuD6vQLDLCIgnMeN3bRCbv8Vu06ebquZMiuDkE8ZPZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748414; c=relaxed/simple;
	bh=uh729120lBrgt14eq8/qws4JD1PfEtETFf5h4dUiehI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u05jH7HJBTNgPAnicY2WoHk7dstYASQdCFEJTDK0lYst4mrV2RCKfOOcY8WXPtuMztCV4rzbCNsgoZejAsBWA2+ipPc6Q3hxQOGyUFchNuhnJ6bGO4MqfQRiofglxujVlIlDr4DY8QI5X2BvHi+rh839cD3ULaI+mB8Pnf4anDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mp4Fz3tb; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp4Fz3tb"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEA7340BCC
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 03:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7A1oPNvggK2 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Mar 2025 03:00:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4330640D13
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4330640D13
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mp4Fz3tb
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4330640D13
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Mar 2025 03:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741748409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPO7R0eIW5tnFxhT73UA9jvPdIiqGpsDvnFvTsNRiiU=;
	b=Mp4Fz3tbxJiZMvsD6hfvpeFdwo03iVMThCe0yJP/vcVlrLwFNIN98Qu4OGgENceB6CjewT
	nesvGG4rg58Rx4kUh8gDN7Y0lEUgmhDEzwGkbnG9semiqNCfiEcf5sUyqtQ7ezvqfAuujJ
	j+X1sSZAAIzBvsITJ/nABwjTKXd7xSA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-Tu9e-dJJNeeNrAi0s5uoaA-1; Tue, 11 Mar 2025 23:00:08 -0400
X-MC-Unique: Tu9e-dJJNeeNrAi0s5uoaA-1
X-Mimecast-MFC-AGG-ID: Tu9e-dJJNeeNrAi0s5uoaA_1741748407
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso7855511a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 11 Mar 2025 20:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741748407; x=1742353207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPO7R0eIW5tnFxhT73UA9jvPdIiqGpsDvnFvTsNRiiU=;
        b=bHqCRwSaKIlZTSsXO4GOTtinFwgby4zfg8egR1W1p/1L2Ig+4oPsLQvr09FM8oGOWk
         ghppxOnaNFCmuG6G0KubA/ML7Cpz8LUMS6zL97nmLKLIWRJZ/oA4oRt4bYDY8pPuMEPv
         7bfCHd7jV5sTQFeE29mXu7CLqNuIZI1nvmSsaHSXmFH91CyaTbSU/xMxKlZ9jtjrsein
         sBXiUADRxO+bbkGURmHsVDu9qN8voviCj+cs0zK93aS9cVObBsO+rMYDRpGRWwAe20m1
         ylYGp9zXj/ZeOQe2MuDBgsuvaElRUFLRYVpxrrMV3l7CWWPmBi1B7atDfqM2DEcZ2F/e
         KxBg==
X-Forwarded-Encrypted: i=1; AJvYcCWD6ndNZ4189ymYkj+4+rLTQ112JGRM/qENUvF2gNY+iiXcIgrac415dxTdkd/LTy/G7+jSK4ITi3Au+8kBBw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyBAqmun2k5SFnUuy8aGZvOkEQzmGO0/xHY1oNeQccj8Zireptp
	j/kZzqCSXrh3n6ZnuYUo6SHwXD7x4fQ+J/o+y1heFVM1UHiVvRrq6a7SP48qF2rJiFnX9e5zZgI
	OtZyv57v8wFEPx+r1x5V6pP3HdPEvZuWW3rQEOS2SFkVr5gOyppi5eNXHOW404e67IjBgaVk5o2
	WXX645rmb8uQRh/RewIJIVJbG6xIMdEuXJg71DE2OdxYCdvsUsONR1XQ==
X-Gm-Gg: ASbGncsC8Uzv0SvxJhJY9YzkGG+mYJ113IJL+R01c6neRTFiFa/D529B7Qat3HuJQt3
	Ej9OqQn8zseCFagKYXGF6Lh4dput7MT7Wa7BkePXwTOoqx1mORFTnhT/5rwn9CsRnVSwVwQ==
X-Received: by 2002:a17:90b:35c6:b0:2ff:4bac:6fa2 with SMTP id 98e67ed59e1d1-300ff100782mr8803691a91.16.1741748407249;
        Tue, 11 Mar 2025 20:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET6lsV/yTA4z+MP1noXOIunYsp3qN8L1Z8eiyVimjBwI0oZIPPsINtQsWF9heOMDn6TbEv142XFxBfq24rdok=
X-Received: by 2002:a17:90b:35c6:b0:2ff:4bac:6fa2 with SMTP id
 98e67ed59e1d1-300ff100782mr8803670a91.16.1741748406897; Tue, 11 Mar 2025
 20:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com> <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com>
In-Reply-To: <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 10:59:51 +0800
X-Gm-Features: AQ5f1JqQKEMLpBM7U-YYsZ15IkMLY-FYatkHcqLxAc5jqhv4juthUfs4s77Xshk
Message-ID: <CACGkMEv83iR0vU00XGOGonL1fkd=K1b-shCcNb1K8yJ9O+0BDQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: QUJWHT69thbcoy9-un2AwYYzBf59cDNCGfOdxwOGmMQ_1741748407
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:17=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
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

[...]

> >>> Let's has a consistent name for this and the uapi to be consistent
> >>> with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
> >>> tun_vnet_ioctl_gethash().
> >>
> >> They have different semantics so they should have different names.
> >> TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP
> >> reports the value that can be set later.
> >
> > I'm not sure I will get here. I meant a symmetric name
> >
> > TUNSETVNETHASH and TUNVETVNETHASH.
>
> TUNGETVNETHASHCAP does not correspond to TUNGETIFF. The correspondence
> of ioctl names is as follows:
> TUNGETFEATURES - TUNGETVNETHASHCAP

TUNGETFEATURES returns the value set from TUNSETIFF. This differs from
TUNGETVNETHASHCAP semantic which just return the capabilities.

+static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
+{
+       static const struct tun_vnet_hash cap =3D {
+               .flags =3D TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+               .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
+       };
+
+       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
+}

TUNGETFEATURES doesn't' help too much for non-persist TAP as userspace
knows what value it set before.

> TUNSETIFF - TUNSETVNETHASH
> TUNGETIFF - no corresponding ioctl for the virtio-net hash features

And this sounds odd and a hint for a incomplete uAPI as userspace
needs to know knowing what can set before doing TUNSETVNETHASH.

>
> Regards,
> Akihiko Odaki
>

Thanks

