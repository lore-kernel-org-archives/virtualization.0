Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E700A2E7394
	for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395860; cv=none; b=ml88BiqEMT1R9+fLFDT1urqtHJ0F8a2e5LvkfK7K6DQIxII8c/iMTjpt2/+lNLo9eThhLm/spveOXbqwqxyodvor57zMpPW0R8sYQ0/H08zqXY6bXBXm7RTGdXlSi1/LgS2kFatCm0n5nsNydqprrjyeGeYRksKbssqxqhGDlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395860; c=relaxed/simple;
	bh=09kGKULuxwNRdpnt9MiE6ht8gMXa9r8db2ODWamPlG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIcZNEOsbnxWenJMpfh8VjQKIV1nXmSupyfeJeFnicjjYYFIJhhSlzwq7BM3o3LCO/10cST8kcKkFdBcmDClmN+kad2dwJhFYdPAnn1NLuukE7yGURk09x6Hjk3a4/R5jaO5zBkKvccXo2ZYCDzNXIBgrTWKeInF87eK65N5+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwJy/w+G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwJy/w+G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782395858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
	b=MwJy/w+GeWVAdaDYVIEeNTh7modpmENdfrWmdJhd8SrMIKapdRQi3WB9lRgbjTTataCDld
	2w+r3KiEsUgtFCdD2PQgrwI3ouaEDmal2Oarb8PCxvDqBuKopRzEOrWtqo5ixvW/nf8jpC
	deFkRw7WTGsHN1YbEUsChiT8M4qPKrg=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-WKl-qJwcNs-COStoALTXqQ-1; Thu, 25 Jun 2026 09:57:36 -0400
X-MC-Unique: WKl-qJwcNs-COStoALTXqQ-1
X-Mimecast-MFC-AGG-ID: WKl-qJwcNs-COStoALTXqQ_1782395856
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6628850c6e4so3744124d50.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jun 2026 06:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782395856; x=1783000656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yoPQZfQWpHp3NoKHnLamjdykEZkB9/wUFW3GNiNJpas=;
        b=tWQeJehnqkiMEYlH4XYznDFRZlZhGJwk5N67T3OKxWn7N7LsPrXyOhfuD3dBNPbnjN
         iIjB3qdYM/Euezb4VzqzLoWSr/ER4WrYCpX6+unRpUF8+dqCAFB73TFRYWGZPXxgb+UE
         Gg5JYE/66VYUvfrf/BTtY+BLDpcZqh6fkKzcfKdlpQNTrAnLoKpDf+8KpbE4Sm8QafYU
         UHWbzOukmsidnCAOUA1maCuUx2UMmOE2vRRBC7Jgaed6vdr8sNUyAVZ6jHyXTgpzalmb
         0z48ywiQ8WsWEj/6LCjQ5KO6i2RWmE8hJefu/0VbDRZshP05Gd0U9w/wOo+Gy+nV6Cux
         bn0g==
X-Forwarded-Encrypted: i=1; AHgh+RqbLBpotB48qp/dyE0jqOVjT4bppIubQvfqFDptpb2XugI6CokiSiDMrQ0nAB3EoU+UWvrMLH+SqfZaeCjFmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw4SNsuT4gpW2RMXnbL/4XFzMjeZFgCc9TJmcNWg25iviybhX5
	qcQt6QLwG/REj/LzS8PsPksbTPY/pOP35lc+iw7c3IOWowPiP4e7DotmrypCa4waBmLY9Ydfs3B
	/Siu3MLDftKUF8RT48bgNhtbcNkK1PEwpDLeOph0fP6KqQiEXZFpvifBaehCQ784YkdH1meYzBE
	RHkQEOPK5YSlaBAltCNGRv7r1YduRzJgIJMemPp12kUY4=
X-Gm-Gg: AfdE7clavk+fIWATmJwkcUrvbQCOvBYeyENsM/C8G9R8hp9+FDSGXWwJkw8ilJ1GwW9
	lZBsCR2atzymCRMBTMsJMGlk2RqpVE7oMwQqMI2ubuMeZma1IwC9MGcf6uf8tIXCbTtu0aacolc
	1NDGVnCFF7KfTNMk8Q/6Nj+MpnUjfhOSzR5BqxjmrUm8hVIVvgNGVIxMaLM8TefZsu1oQ=
X-Received: by 2002:a05:690e:118d:b0:664:9032:656e with SMTP id 956f58d0204a3-6649032684dmr1013799d50.17.1782395856203;
        Thu, 25 Jun 2026 06:57:36 -0700 (PDT)
X-Received: by 2002:a05:690e:118d:b0:664:9032:656e with SMTP id
 956f58d0204a3-6649032684dmr1013773d50.17.1782395855647; Thu, 25 Jun 2026
 06:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260526080336.61296-1-r4o5m6e8o@163.com> <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
In-Reply-To: <CAJaqyWcFm0A5ucL5TLP8+T8JNOiZyaL-_mb747_fKhH9Qm83ig@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Jun 2026 15:56:58 +0200
X-Gm-Features: AVVi8Cf6xgF5zkdsxl65CjXk9mAqqpZ16WJN5rElDgN4AmLJNI0ZYQtf2VXrmew
Message-ID: <CAJaqyWeGTKZB7BCHV4MzjRsg0B43qoTDCYjUKvqyyAjyB3edqQ@mail.gmail.com>
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ghEfBMDMlP0WshGT-5SJXvTYYhSa9uvRZBVVyFounY_1782395856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 3:48=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, May 26, 2026 at 10:04=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wro=
te:
> >
> > From: Yufeng Wang <wangyufeng@kylinos.cn>
> >
> > The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> > at argp, which is the beginning of the features array, overwriting the
> > data just written by copy_to_user(). It should start after the copied
> > elements at argp + copied * sizeof(u64) to only zero the trailing
> > unused space.
> >
> > Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> > Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
> > ---
> >  drivers/vhost/net.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index db341c922673..70c578acf840 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsig=
ned int ioctl,
> >                         return -EFAULT;
> >
> >                 /* Zero the trailing space provided by user-space, if a=
ny */
> > -               if (clear_user(argp, size_mul(count - copied, sizeof(u6=
4))))
> > +               if (clear_user(argp + copied * sizeof(u64),
> > +                              size_mul(count - copied, sizeof(u64))))
>
> The fix looks good to me, but why not use size_mul() macro for copied
> * sizeof(u64) multiplication?
>

Also, could you add a new switch to tools/virtio/vhost_net_test.c to
use the VHOST_GET_FEATURES_ARRAY and VHOST_SET_FEATURES_ARRAY instead
of VHOST_GET_FEATURES and VHOST_SET_FEATURES?

> >                         return -EFAULT;
> >                 return 0;
> >         case VHOST_SET_FEATURES_ARRAY:
> > --
> > 2.34.1
> >
> >

