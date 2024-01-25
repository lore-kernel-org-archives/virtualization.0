Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A37460
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154515; cv=none; b=WNSJP3Y1SK8c/U1V4qfQh83GsrBGn751EOydhJvesCuQmKfMLCQgTkSUv2n3EAKcDURp7JzGbqYqiYFXW1jxoEbLSNd7AZ4iMfU2fT/VYrL5LnIUFa7u1sE+6W2Njk+HFP/iE6kiGeN/3vTQ2Pca2oJbTvL1s7ZhCwaljJ/rWnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154515; c=relaxed/simple;
	bh=bBevjUjT1huD29t3h/NaxpM64oREcTWJc/SMjCAPABM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5Q0cY9pWIzI+PQzAog8Po2OhZtFXCgm2C18Y+n0ZF/hbp6UXJuvl3Ryi5v4XzUzgKLSd/poQekHHx2YTStWUSxs1GYRnHukT0ZJwy/uLmQN6lnadMX1zPc4L2ckUEvI+BOGxZuvYKkVX5et2PxYhdu5UEA2FSYurgvEWYhRhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvlKQ91d; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvlKQ91d"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ED6041772
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 03:48:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ED6041772
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CvlKQ91d
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRKp8vH0VeiY
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 03:48:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 450FD416D4
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 03:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 450FD416D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706154512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Oex+9bxQoM5lZR85M4x8kxFVXC381LSPaJScy8SPKE=;
	b=CvlKQ91dg+xdDrUYxIHUx7PALt5DONup7QkmdQRRTU2tQazgylVZmrjduY9xmIMC6q7Vfd
	Kce5h6InrYPF5tsQI+zPm+kNm2WPxkJcO2sWmTSm96Vzzput+n7ApmF2Stq4AohZUTR3I/
	WBCu6TFUZ+o3/uPMmc+yQCR2I+hYPgg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-Uh18hcSIPmyvc0ghgvSZ7g-1; Wed, 24 Jan 2024 22:48:30 -0500
X-MC-Unique: Uh18hcSIPmyvc0ghgvSZ7g-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd36b9fd9dso6303035b6e.2
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 19:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706154509; x=1706759309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Oex+9bxQoM5lZR85M4x8kxFVXC381LSPaJScy8SPKE=;
        b=O+Iy1/jRsO3ozwJP7uZXsvegurBRA84Aw6Wd989PvbvO/2TeO3X34jJBiAWKgU1EeU
         SbHh+WmpUEjhdwRuUMmArVdqNPflCxJwcgUQ+T9qOjdIzbybUFUCvOrHdByz/yUcfDLU
         xwtdwaaew+OsGRsNA/984oJejGwopOr5UvOtKbqFcXtALhKJkAxy3eaL8ldSFA5wF1Ol
         QqLa/nHOues0oAow8M7gjledzEBO548MY1BK2l407jT5Ke24SUDrRVFeZW/mJ5AiSZ11
         Ay4UeYL5Ct6EJRE7in7Hp9BcrP8cZFH7EkMbemSpixJ6fikscBx0vzXlbnUtOM0sqSB2
         KIfw==
X-Gm-Message-State: AOJu0YxcTAEt4Sw1LY298Iprf3Fo46qyD3c8t4lccpnxBuQ1QFLARGqY
	PjMtJ0s2D8RaJFRcn0FkQdSnQ6oGSwFs6XFaaEWY/zsyYw+wuaNt4GQl1ePuoOeitIEjXjUOtxT
	zuDi1vMl6aJOZygFIMDcUXoHIk9jFTDtgxrmpnWr0d3D34/EhEchvMNlZI1B8hfvfmNcX+Ligts
	cXE1NEC/btUD1L8tK2RNdmoi2Q9auM5pYY35lpG4/Z6Udgvk/wYT2FcA==
X-Received: by 2002:a05:6808:16a2:b0:3bd:dc70:fcad with SMTP id bb34-20020a05680816a200b003bddc70fcadmr27542oib.89.1706154509381;
        Wed, 24 Jan 2024 19:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa11YxvgPS1ZLgaOqg1jLfBIwlTSwrok1dhvTJIz3CcuRakx4fnPIlNVNtjTz6pDJlViAd3Xt/5f5zPCjrNDg=
X-Received: by 2002:a05:6808:16a2:b0:3bd:dc70:fcad with SMTP id
 bb34-20020a05680816a200b003bddc70fcadmr27536oib.89.1706154509150; Wed, 24 Jan
 2024 19:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com> <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:48:18 +0800
Message-ID: <CACGkMEvQTXmyAeUeWxgxgMPJ3VQJWH1DRnt__Yb0ifnSyuZ7Cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Liang Chen <liangchen.linux@gmail.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, hengqi@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 24 Jan 2024 16:57:20 +0800, Liang Chen <liangchen.linux@gmail.com=
> wrote:
> > For the XDP_PASS scenario of the XDP path, the skb constructed with
> > xdp_buff does not include the virtio header. Adding the virtio header
> > information back when creating the skb.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
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
> About this, a spec is waiting for voting.
>

A pointer?

> This may change the logic of the csum offset and so on.

 Btw, doesn't it need a new feature bit?

Thanks

>
> Please not do this.
>
> Thanks.
>
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
> > --
> > 2.40.1
> >
>

