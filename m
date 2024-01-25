Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153510A24
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165585; cv=none; b=pYpfFDJngPhl+yObLzapMPyB6sfqE0QEhu8Z8fJuJIEU6XklR9fnCRaPxtcziBGOR40qUD0RvUHwHet5MC3NL2pEPz79rScL/vKdLqPOpaeENfe2VlozvHr3WvqcelukSgSoMDj18Nm1uWVH4scpGs/+HjsGD0ye+pub4ks9158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165585; c=relaxed/simple;
	bh=ez40Hiks973HTdNYyPZ0h1dvEzreMQy5gsShFgPphuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPD15I+8cwCkfPz75BxXPCBUso7GfLkOndnRrLSn1/Gtv08WA7NqrHBoTYMgA7zStfepqKXQcS78MPBQ2aDobslLWw5Mtijot2uch4/nT6NbXpA1HNAwvXauFe73KvQQelLrM7agL6bBS11zy8WBrtm9rmd58HzpeSfX9vPB/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEhJhHGy; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEhJhHGy"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B8E84038E
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 06:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B8E84038E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dEhJhHGy
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TrsshlF_eow
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 06:53:03 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D151240338
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 06:53:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D151240338
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-55cef56c6f9so506519a12.3
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 22:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706165580; x=1706770380; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EVz39pSu3r4g8xcNZ73J3NLB8OQE3qZV4lHSi35Q0Q=;
        b=dEhJhHGy2ZKRvWT5mjJyhDIWLfOzZKDbSgxzGLUu6ZrgXGh2cukG+ZzzzilBmGCJA0
         zqi6MTg8BCrFjRAmRzVdPmXenyCnS6jk6gZg914x0APPHndO1G4VIJs28AaUn/lPxz4X
         rIzkr13aUksDi6sD1CEA36kuqgTcvOxUodZFqn7UpAP5QuD/CZGhADrmIWQlDUSZXaOC
         jSEWjh8LpcH3nF4arv+8TnRciaiqu2J4gax7BLLQLz4NdcKBPaER2rAi8qdnAPKKK2uF
         hlJH7bZ0QBk7atwPuzduK1AmEz3Ljj/U6D/NaqTSGSIb7aGQjrR8vGmCS4asvLV8PsEF
         JCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706165580; x=1706770380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EVz39pSu3r4g8xcNZ73J3NLB8OQE3qZV4lHSi35Q0Q=;
        b=fAoGGRjdKvEPz55GeeYu5UeJf7Rph4k/qI3DDKGlt64CQ1TLYoh6Djdwoat4yWo7yR
         O7l01xH4XL4LR9iFo82/umzrWPsUnPQuWXcacxYwdNcznuDEwreG5O5mmPxLekf7JwMP
         8mEzWnd/uweZk4Vot1It4TTcCVq8FFBzqxwibCgldamnMhZ3+9xRCghBXlO5TKbs4gLb
         sH4n4nYPAkslp90aEU88PSfsYbOaVtfmmEXdKuGESWTR3uHL1ir8j2w34rqt0aX0wduG
         LzVxdXQMvOLsBWmYe5HuAmnXQa7wc1QKetSxZSTH4Bvsde9VNXCLinArVSDPxZ1qKuSr
         XXrw==
X-Gm-Message-State: AOJu0Yzithhk/dhdhowasXiN7bsjvfnj+VPnf6g5Vf4Xb+cknkByYUUl
	FYn+Tu3aNz5eGvSvcV+q62vALCBJ9KPu4418gsyNhZWTgzWWwTs5lMpYxzTyHC+ZEjutzRmSR5X
	oNupfRLE3EZgUm+x47iVnS4SIvLs=
X-Google-Smtp-Source: AGHT+IFyfX5j4hHaJ5PWa31hvMgEZNaXpF6meOqSVo9coOsPvYcm0tQboIho2tsiwbd8kO6jVuQPHID7YOki1oXXjpM=
X-Received: by 2002:a17:907:96aa:b0:a30:6278:3968 with SMTP id
 hd42-20020a17090796aa00b00a3062783968mr287716ejc.116.1706165580432; Wed, 24
 Jan 2024 22:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com> <896749de-39b6-4081-91f3-1e316706a0e9@linux.alibaba.com>
In-Reply-To: <896749de-39b6-4081-91f3-1e316706a0e9@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 25 Jan 2024 14:52:48 +0800
Message-ID: <CAKhg4tJRM4qMJBwNs=HWczq7muw0_m_szH8L0CDaxpC+kJSeNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:04=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/1/24 =E4=B8=8B=E5=8D=884:57, Liang Chen =E5=86=99=E9=81=93=
:
> > For the XDP_PASS scenario of the XDP path, the skb constructed with
> > xdp_buff does not include the virtio header. Adding the virtio header
> > information back when creating the skb.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >   drivers/net/virtio_net.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index b56828804e5f..2de46eb4c661 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
> >       if (unlikely(!skb))
> >               goto err;
> >
> > +     /* Store the original virtio header for subsequent use by the dri=
ver. */
> > +     memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);
>
> If xdp push or xdp pull modifies xdp_buff, will the original header
> still apply to the modified data?
>

No, it would be an issue then. Anyway, this patch will be dropped in v3. Th=
anks.

> Thanks,
> Heng
>
> > +
> >       if (metasize)
> >               skb_metadata_set(skb, metasize);
> >
> > @@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
> >               head_skb =3D build_skb_from_xdp_buff(dev, vi, xdp, xdp_fr=
ags_truesz);
> >               if (unlikely(!head_skb))
> >                       break;
> > +             /* Store the original virtio header for subsequent use by=
 the driver. */
> > +             memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr, v=
i->hdr_len);
> > +
> >               return head_skb;
> >
> >       case XDP_TX:
>
