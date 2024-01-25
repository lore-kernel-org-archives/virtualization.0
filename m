Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1210A01
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165476; cv=none; b=OxwDiouY+I4ItoYPqlu//YHellmpvNWQ0Lf2NKJvNRnAT/pUbOORqs/VEHc9TrTmpsNv5Hkz5Ets8zTJF+icNsEyuUhA8X0C68xzd1YABEa+lIUfM28KfZqqYouo6QpFRlSl+eH105HWyLbObJbqdmV/0lCJh+v4kHERG6EzSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165476; c=relaxed/simple;
	bh=+goqnjmhjwCrbgzCPnU67DdoeacZ3F59LFmr585je5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEzMNZQbYCS/gX/pqKMtfcqDP09Q53TJEPobTIEaRU2bqWoFj1Tms5BETGoXxft9a4Lbev7i5mAWozcsamA4vfFANIs17xS6aUI2jbruD6B8x3J8HMG8JTK4xZ9o5UYzfrmcJR/GVSpcx20Douk/8kJ6/ZOqxUPwwXKioco3dGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b93YqoTL; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b93YqoTL"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2F4D415F4
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 06:51:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2F4D415F4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b93YqoTL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jcJ_-zZfTPlT
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 06:51:14 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD7B8415F1
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 06:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD7B8415F1
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so85708366b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 24 Jan 2024 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706165472; x=1706770272; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+xeN85GCAQuC34lteVDcBey5w6Xz4urLxxRWMpJ/4s=;
        b=b93YqoTLcV5vupTXT0TMUmokOGOElU7Nn7TGEvb6aTQ3RT52UEPCORD87ndW/5uHvc
         Io+lS/XJgvf0BVTQuDgBG0XvNHErbRhjBMxTxTviD2o0TSx+EsrjjP/tg1BD8JfKaNWc
         /jUWC3YPc5eXj/2mSp+vzflLbV8/wBVbjmy+9hLRmzOxWtYBsuVlUvm4cnDo0fF+aqBq
         l/HQ9bmgPFxz5aMczfxg/QuhXeIW6brWU3tPSyQnc/w4sBziYCtHlrFMx89tXFan3Mqx
         XqwDpGBTZxP2AdCjUA+RcoV1h1fMLY+hE0DHVpRnIf6DLPYSU3KBs0v+3bn5AbItHMcp
         uZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706165472; x=1706770272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+xeN85GCAQuC34lteVDcBey5w6Xz4urLxxRWMpJ/4s=;
        b=EV8pHiZtoFlvqsfXKXnrrSd0aX8/2iuB189BI2edIcoswpqXVaZGI8TwuHlbsW+28W
         3ag2r7w7jM7ZyRl0xTAUiE8ptaGWcyqfUkgVw95fthGQRC1h7aLFM82np9ahWyU0NIVm
         4nYnAw5X4eMCetAOgT9/9kgcmO67A9Tfa4pCVDYRcquq+k5/T+pT+yAA0WGV3ZyCxBmi
         0rxpVQmwvZ6US3+hsHgJ/9QJcNJfw2t5zFHOEWHaYd8jffGotafNYnviNxKZhSLKtlUr
         RO7i1cZJ6fJ8/aRgkOqlHF4YmfAUzuaid4Q1o9R+gv6KTajYcLKDhOPiaPBcJxZh7A4e
         PXNw==
X-Gm-Message-State: AOJu0YybJXCNH2vftd6kj7BN7JfUuHguEuDzKfDpvJryRRU++/QpjnSa
	9P4tC/paYm9wW75KxB2OMHdMNjVK8xDHcoW8Ng+yKPAJqUroxrRBCoE3yZPixpHjQuExoR4RvaB
	CzBTaStwM0XoNhCNxuKyjWIdQl6E=
X-Google-Smtp-Source: AGHT+IFDaBPwETdq+Yooxzd1JvlgzMI7LmbOlI8dt0gDK8rlK/hv6U+8xPOcEaPZuVCFiIMlIFr4KgGymrBbc9xDfbM=
X-Received: by 2002:a17:906:a3c3:b0:a2e:d233:c312 with SMTP id
 ca3-20020a170906a3c300b00a2ed233c312mr503668ejb.27.1706165471458; Wed, 24 Jan
 2024 22:51:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com> <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 25 Jan 2024 14:50:59 +0800
Message-ID: <CAKhg4tKzhnXKVNfefHBF1vWEgXaX8wawF-7k5HX8F5OArQR1tQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, hengqi@linux.alibaba.com
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
> This may change the logic of the csum offset and so on.
>
> Please not do this.
>

Sure. This will be dropped in v3. Thanks.

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
