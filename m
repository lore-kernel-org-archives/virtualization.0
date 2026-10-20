Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527739;
	b=h/CZOlF820px5Y1HZq5eNDfCLR1UHrUSdmi7qcxfmr+65aGyAUe47chO28P1WaRCdtC3
	 MIPmogZ5ey2HH6wB9rNIYhWb/SdMSJpnsi0qZavm4iupFe4jVSez8dzFJEeFD5xeR7SEU
	 sIxmzqBMmLNJqRZVyuPTNY+mgsaBicma3yhkYu9x/eY5OjliZOtCim/XzF7geGr2jbzbA
	 un/uULHYllGPpD40RveyWRkgDUH2ESOLMYRsFGcmKx1yTNoFUfJExMQeb9MnOPWXHi2fV
	 klk5dGDLXRJBfKrB5dQwGYDhL55O/ZX560OwjS/UyTz1MJiE8F69FekMVQ3wH7ZOj6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527739;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=O3Fa0tNjFaT8a2Kp5IrJp2nupauYC9YO/ztvfGUmcCA=;
	b=sJT8PNGpnHEE/oABTwGNPaFdS5Z5A8MIJaJOY+cL5pY23LvQuXyIq+VEQ1d8Q0vgyrif
	 korUemDrayzEhjHg+RiqwqPSe6BWkYIT7S5hE+1Zn7Vfsx/1l64GIA8o6Mod60OuSVjXx
	 wB0tez1Q6ihjBLrEf6On2uNq2aTCD7vDrRZea6Se2baFLPUHSsx1Le/7oNipLPBX80xlO
	 nIZWWrCU5TKi3N6iVn8EG4V6ZSeCEDJeycLkUfdY9aKNUSdTqzck6gFmljUI3M/Im7knS
	 p1Gq4FG6PY0bAfLo6XwXEWGsm/Qn2EQdQ12BjAPbazNQZoEeC8yWHxSQgZwnIcr8wXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hoz6KitP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8C606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hoz6KitP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792527737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3Fa0tNjFaT8a2Kp5IrJp2nupauYC9YO/ztvfGUmcCA=;
	b=Hoz6KitPx197Z23FbDiWFP4Zd8nr9b6PoneoZRjYAvgt4LvvyiqoxyVvnTmrZTbY3zhErN
	RFx7kDGpa9Rmqv45YnCzD+We95TVTcpTF/7m2NgvMtV01UTlK3re9dEyVhlc9Jha7xjqLD
	ifVY9nkDATNRqMMzydOgwzxoHx9P6VY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ZuEgYdw4MaifLCdpMgn2Kw-1; Tue, 20 Oct 2026 20:22:15 +0000
X-MC-Unique: ZuEgYdw4MaifLCdpMgn2Kw-1
X-Mimecast-MFC-AGG-ID: ZuEgYdw4MaifLCdpMgn2Kw_1792527734
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso151645e9.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792527734; x=1793132534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3Fa0tNjFaT8a2Kp5IrJp2nupauYC9YO/ztvfGUmcCA=;
        b=u35zahIkJ27FQPWlUT502rVwhksOpZem3mTeQpnycRwvcS8CvskYDNAZnLVENXkhgd
         UmY39cvAmXBdzOS7I2qRjnX4VGbko+0NElggPfcSHjRAOzDzqrorJvBz9tg9PLoeiMBK
         V3l3yueR4o4Wi4Cp5zgJMWWfhL2CKhjIsLf3PU4UxEyIqYQRQ+KucN7efwGZ/qn/cIH2
         kKv5qzQjMR4Yohf4I54tpX0kmz+88dKl2vCh0uqhfmRhjsWZee6c4naAs0ScbpG1eN2j
         bM1E/Tud4qcG3quanGkOLVT3VQe9G5LpU75BBfhOQMgtgdkY5HDPzF6yGIX1OzDUHYRY
         wqZg==
X-Forwarded-Encrypted: i=1; AKwUvBxcUqJCnFF80/UQx13EFh3qKUaBsZAW9YXlBhUtNqh3DXBZ2bvZHredg1IHr//L5kDtzlqMMv1vRoSVf8yUJg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJE3PrykZ/v2BerUecTIgYthJft5iv7LGWl9ci4q26crTtgIvHd
	iaIB1QunZkjxEmTrNIKccRQazybskeJI0RhpztL1fhtI3md84hRNBnb8WtcaUpCxkZ83GNqJcOC
	zqPkgcABKNYhT910RKDIp1Wo4BL4OSQHW2dVLAkdKm3X7T+2SvEjqkSWeUIr1XGkX4Zgn
X-Gm-Gg: AYBFou1/JVuCfFY1kMoRX1EQZmvF2KWgfStbkTgOa+JLDL2EVCxTDOZ3lHbtAMIt+CA
	8WJkzdpIMi1/TGhGWecutJvIEh/odnxq3WdI1TgRaMguHTJtTOVrgo9CNsMLceeyfj2hjWssgTq
	mVsXkH9/v8g0F2XXorKOLz2TpY1iCo5h9w2aSsBSxV8Y5ks7Ls3qxy/8kubpVu+yuOrS8e/SEO9
	VmEfkY4BDsq5UHuDHsUkAP8PCbn/v9BxrgV0R+X6gOfWu7AAe7HzjlRiYFZdBt6Pr116f+PvpQ3
	dRK0MrV4OHnYG7XxYdamHqgjglmGnKwDi1MxJKij1eKNQ6VKFB8Fv4EbCUkDVR7yANQUnQ==
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr100028345e9.6.1792527734242;
        Tue, 20 Oct 2026 13:22:14 -0700 (PDT)
X-Received: by 2002:a05:600c:888c:b0:4a1:eccb:53eb with SMTP id 5b1f17b1804b1-4a1eccb55d9mr100027865e9.6.1792527733682;
        Tue, 20 Oct 2026 13:22:13 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm625191f8f.14.2026.10.20.13.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:22:12 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:22:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020162048-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020155917-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.2c9decc16892@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.2c9decc16892@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 66zIcMWC2yooiVQUauMDh4r-be1hDW8MoXi7SDJwkkY_1792527734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 04:19:41PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > The ingress validation as implemented by the previous
> > > > patch is stricter than what it replaced: GSO
> > > > packets whose checksum metadata matches no transport header are
> > > > dropped, and non-GSO ones get their checksum completed in place.
> > > > Such packets used to pass with the metadata unvalidated,
> > > > and with no overhead.
> > > > 
> > > > I judge that this should not affect any deployments, but there is still
> > > > some risk that it does.  In case a deployment depends on them anyway,
> > > > provide a per-netns switch to get the old behavior back:
> > > > 
> > > > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > > > 
> > > > The default is validating.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> > > >  include/linux/virtio_net.h               | 23 +++++++++
> > > >  include/net/netns/core.h                 |  1 +
> > > >  net/core/dev.c                           |  6 +++
> > > >  net/core/net_namespace.c                 |  1 +
> > > >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> > > >  6 files changed, 110 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > > > index e586e17fc7a5..b1a1c4714b22 100644
> > > > --- a/Documentation/admin-guide/sysctl/net.rst
> > > > +++ b/Documentation/admin-guide/sysctl/net.rst
> > > > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> > > >  Default: 1 (on)
> > > >  
> > > >  
> > > > +virtio_net_hdr_csum_check
> > > > +-------------------------
> > > 
> > > virtio_net_hdr_validate? In case we do have to add more validation
> > > later.
> > 
> > If you insist. My worry would be what if that validation is again
> > user-visible somehow and we need to distinguish users who want
> > to disable that future thing and users who want to disable
> > just this current thing.
> > 
> > Hard to predict the future. But I will go with your intuition.
> 
> Thanks, but definitely feel free to ignore my suggestions.
> 
> My intuition would be to define as
> 
> 0: off
> 1: everything one
> 2+: sadly needed fudge values because we keep having to tighten,
>     but some crazy workloads need to opt-out to avoid breakage.

yes you said i just do not get how it will work for userspace,
maybe u can explain?

and what specifically is needed right now, while we
just have 1.

