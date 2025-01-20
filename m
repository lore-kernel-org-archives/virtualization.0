Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D3510957
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737333414; cv=none; b=MC+0CFGtdltrQO5D5Az6FcLYZSikvO3dQR+3JHbNB0o5BYG8DGJlXPhRc5sSd8mtOp5jLEk0pbI0mtNSVTZ//4gw6oMaayRFCTbEKWa8tqe93W7fTm21IZP2AD7lEoromzwWVLpcttGGIqYZm6EeMAdfnHBVKi4FWzdOBBgSpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737333414; c=relaxed/simple;
	bh=sBrzjN252amelDCl8v0nqe8T7UjrAIPyRfaO63v6GNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH5MSpQmBM6leqX+thvVzKOmcrb8CnMotNbd2oR78s52Oo+FjEaPlgRNcke22sRBRIhehqDdx/DW/75MYOdvNRe5TvGWdPexyGmDYKtZWbbxKBV561/3Z4GgdZGt6rKQ9BM2AEwb6APWbCrJE8KW3IuzIHZy+dxieFAVquPxr5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0iieEqo; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0iieEqo"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CDAD84B5E
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 00:36:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pz83XuuCqEzR for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 00:36:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7971D84B5D
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7971D84B5D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E0iieEqo
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7971D84B5D
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 00:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737333408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3H0nYB61+8LVuoJq+zs1egrUFpcaWndWQWohYstwrpY=;
	b=E0iieEqoMj/8wphs6bOMdHcY29uh8lXR979v6Yft0hx7nhTdmE9RbbTPbbPwcuMpTRdbe8
	Hu8ogij+m3tyVNcCytGcEtCLr+OPKeS6eqMkfMaG1f6KMFwY4M8E19WKnBASdBnRu44gHs
	MaMSfa/rwQsqJcUxOc9qj9nPNU/1HmE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-BzX0iTA_ODmzWpHAq2f1qA-1; Sun, 19 Jan 2025 19:36:45 -0500
X-MC-Unique: BzX0iTA_ODmzWpHAq2f1qA-1
X-Mimecast-MFC-AGG-ID: BzX0iTA_ODmzWpHAq2f1qA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so11116657a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 19 Jan 2025 16:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737333404; x=1737938204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3H0nYB61+8LVuoJq+zs1egrUFpcaWndWQWohYstwrpY=;
        b=LTIsW7ASGNffiwBd6DLt69T+c8vxoKljNk9RMmhbyf1fmBgf9f67dBQ0yEc8ZrMwtf
         va+6yIVKL8SbWNhmyKgo+SrSFQt8A5rY9ue6H5v+1XzbuWSuP2MF6DoJ9G0z8XtSjEj9
         GRHXH9nuHi86Xsd9wVYSKU4Pz6Njw6BwqRQv/flZ+B5RH/UB3gABPoUPrLxfF/PWnI0H
         S+/essshA4AQLK6xv+oh6my+YIAC0CINOckhkuMf9NEpT5YkJIj3vyn21w+mCJXvWoDv
         RQoKacoMEy77vIjsOEWWrW3HPT0UIcta0fvNqjxUP5Z3cVtIkTRF2zQwNToCRhXzhEQt
         0TYg==
X-Forwarded-Encrypted: i=1; AJvYcCUkePCkWXbdiQDLjBtEzWIXk/Iz9QZK9siF7s3BhIgiFRikAxnOIr7i2w1XP8jj6QkyhCiKUhIdYSMEsfP2JA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwdSsOCQMcNwqTYq5MTd8W3Vvg8apftCcx10vwxhP7zzXeej8pL
	1MeAyh4w9FW0vR6fM79BsBCwz19A5kEO//E/iM8fJI+wgkbv3EKzRuEv3MB448VB1loDRCyEo1z
	9bVrKZMDRXHEan5oMOXHPWHdn5jPHRgA4F1g0Cn+6GKwzeuWLpIrrpprd7z6bpmTqeTI5IwwBZa
	iMMIe4jS2dwFO3EUMOXULzTDziMrN0yxPFXC5frO0HLkCG5HtIpj4Tzg==
X-Gm-Gg: ASbGncueb/nOV7GdToVPrErqKIGakZRSaH2KVYBtdS8LbE4zbH5Yhs4VUaMld8BnyVX
	yieS4Pngh745VkFF/Adw+krrQOMExm47IiEH6q0uz8AooFnvEMEUB
X-Received: by 2002:a17:90b:2b83:b0:2ee:fa3f:4740 with SMTP id 98e67ed59e1d1-2f782d86690mr16043477a91.35.1737333404219;
        Sun, 19 Jan 2025 16:36:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp1Ois/gQ7usRrA6ey98y4JMzYea7jlE0C3PdWtBxN0mj155LyybzQ3UYqgF2HjpbQV22UEWHRbWe4ES5xwPY=
X-Received: by 2002:a17:90b:2b83:b0:2ee:fa3f:4740 with SMTP id
 98e67ed59e1d1-2f782d86690mr16043449a91.35.1737333403779; Sun, 19 Jan 2025
 16:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com> <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch> <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
In-Reply-To: <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 08:36:32 +0800
X-Gm-Features: AbW1kvaoh25v05-5WCQ_wsN2rqQ8xuqgKjHNGkTQtJgSpKoEbixeVohO4Epfz8s
Message-ID: <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ltF3PDMJm5Y8YNFj9vWribwfWIUhRfTt0bYS-aVBbPY_1737333404
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 6:35=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/01/17 18:23, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> tun and tap implements the same vnet-related features so reuse the cod=
e.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   drivers/net/Kconfig    |   1 +
> >>   drivers/net/Makefile   |   6 +-
> >>   drivers/net/tap.c      | 152 +++++----------------------------------=
----------
> >>   drivers/net/tun_vnet.c |   5 ++
> >>   4 files changed, 24 insertions(+), 140 deletions(-)
> >>
> >> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> >> index 1fd5acdc73c6..c420418473fc 100644
> >> --- a/drivers/net/Kconfig
> >> +++ b/drivers/net/Kconfig
> >> @@ -395,6 +395,7 @@ config TUN
> >>      tristate "Universal TUN/TAP device driver support"
> >>      depends on INET
> >>      select CRC32
> >> +    select TAP
> >>      help
> >>        TUN/TAP provides packet reception and transmission for user spa=
ce
> >>        programs.  It can be viewed as a simple Point-to-Point or Ether=
net
> >> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> >> index bb8eb3053772..2275309a97ee 100644
> >> --- a/drivers/net/Makefile
> >> +++ b/drivers/net/Makefile
> >> @@ -29,9 +29,9 @@ obj-y +=3D mdio/
> >>   obj-y +=3D pcs/
> >>   obj-$(CONFIG_RIONET) +=3D rionet.o
> >>   obj-$(CONFIG_NET_TEAM) +=3D team/
> >> -obj-$(CONFIG_TUN) +=3D tun-drv.o
> >> -tun-drv-y :=3D tun.o tun_vnet.o
> >> -obj-$(CONFIG_TAP) +=3D tap.o
> >> +obj-$(CONFIG_TUN) +=3D tun.o
> >
> > Is reversing the previous changes to tun.ko intentional?
> >
> > Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
> > over this. In particular over making TUN select TAP, a new dependency.
>
> Jason, you also commented about CONFIG_TUN_VNET for the previous
> version. Do you prefer the old approach, or the new one? (Or if you have
> another idea, please tell me.)

Ideally, if we can make TUN select TAP that would be better. But there
are some subtle differences in the multi queue implementation. We will
end up with some useless code for TUN unless we can unify the multi
queue logic. It might not be worth it to change the TUN's multi queue
logic so having a new file seems to be better.

Thanks


>
> >
> >> +obj-$(CONFIG_TAP) +=3D tap-drv.o
> >> +tap-drv-y :=3D tap.o tun_vnet.o
> >>   obj-$(CONFIG_VETH) +=3D veth.o
> >>   obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> >>   obj-$(CONFIG_VXLAN) +=3D vxlan/
>

