Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F7944F
	for <virtualization@lists.linux.dev>; Thu,  7 Aug 2025 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754529652; cv=none; b=uiCuLGu/T8+isB2sMpv5eaWaW2kQ/sNmD3iNgg0ZwZXDo1VxAT9ljjgDbzKaiL5dK1lYyFmVsHtzqgooYOYFEWS3UXZawCbbMpwtmlKLGOGjjghMON9bC2PabmzN29kz3dSggmQovCa4dKva6VhKlYy2siQGZUQ8aIb15A5on90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754529652; c=relaxed/simple;
	bh=EdG5h2XMWMMxJ7yemQmFSa4bc5diWpKiyMAF5xqNq6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+l74sb/A3vg3ZWp2AG2DjH0MleabiryTWoF+MhDIOXkIH7jXfMX+tAgKctKcTH1L9hPDnXx+5aRkQtIN1uP9OTl3zuRkS5bgbcFz4IBXNJLv4YJJ5HCqkF0x/FEaFqZ1TGCA9iRQZiMKqiMb17IH2dX5pKRAEzRqiBgOmcuymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTW3Eovv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTW3Eovv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754529649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEWrYjjWGNjohxH9R8UlGTMdvalBWlYjle/WluhTEow=;
	b=GTW3EovvjIYPx8TeDaCdv3r+zD+nVi8BA/fzoxsndawnZVx/KVPA7eABJtdPieFAaGx/I+
	H1F/7Jbcbro+ADh6iWx4q9X2fPTvLKJkHv1xZFlYLieEOjVdPlySO0NXcoSLgG+TmmORzw
	kfQcG/5F4BVwAHANgHqw4Pda4eX0oSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-kPv3jA3yMYSfweEK7bUvwA-1; Wed, 06 Aug 2025 21:20:45 -0400
X-MC-Unique: kPv3jA3yMYSfweEK7bUvwA-1
X-Mimecast-MFC-AGG-ID: kPv3jA3yMYSfweEK7bUvwA_1754529644
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-af955068456so43024866b.0
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 18:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754529644; x=1755134444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEWrYjjWGNjohxH9R8UlGTMdvalBWlYjle/WluhTEow=;
        b=FGPaSuJ+nH7JROF/VbzUskY+xxSEva37muTwZT1aAevkLDwTTxo+ncJVDVxfH1e3j9
         fHFl76NB6DBUVOy2C+59XL99Iy9YhUrCl31IL0dIezo98Vg/HZduv8HPlgWOweuyms/8
         u+0wNA2qIdF8gyZWEOxzKTt2XP54ywLhKZJiC9EENGMu4uHp36hAuK7TVkpRixtkAMkx
         I2hRtL6SXLTLzpZQuKpc2zM/XQka+A9xU0aPkMBxahOeCN1F3pyCQIzY5Np7SgDY2qo7
         hH6OSw/C4J0/0OymBoahbdXIcvrVXHpR+tuaWPZMu1096xtuoB7kwkLPuX/IUpxOKgdG
         Xbaw==
X-Forwarded-Encrypted: i=1; AJvYcCV4/0IDOtanzQ7l2iHwxIcjsLQVLFtVMS4GHI6PoboIRo+9FM6T4MIS9xtRzW8GlmC7K3GuH1ayKVyTQv/RNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJFkCjta8qm4j+NmfKoRXMNp+ZELjMwTK7yN0n0Vm7JrKm2OjZ
	E4ygv4DZ8vyppyJdH4u/RhlmyHSNmFRC6fprVtTcqKm7P0ZKr7RfeQmYXH/ZRKEDOm89siCBGlI
	k3M3DkCg/LYe8bAr9FajFpURzjapivNwxnLqJDiOXHZDyx8jfGfNJYY/OMPQFRf4t66NcxlwcmD
	DEWVcrfA/1+Uot8cpOCkpuqGfYu+fiHvbDccow6n/6Wc4=
X-Gm-Gg: ASbGncuFrisUDWsgj1wAaIQhy7OUluVqnKL+uAcp2RHl2ii1cQY1zIHRvfQrzeb1iYZ
	U0T/NDD8XDSITGJf2pEx7XXfH20UVC9aIRdq6AEXYC132s9YYFijLPTICrXhMirEFyZCvNWcPOQ
	RrPigwPHCDnwKFdh+8/7Z7uQ==
X-Received: by 2002:a17:906:478b:b0:ae1:f1e0:8730 with SMTP id a640c23a62f3a-af992c6c33amr362296666b.57.1754529644133;
        Wed, 06 Aug 2025 18:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuVKYcqXyRGEOsTk+t3Ivio5HYohT/1PPb5lwl05ILoEYx6eYSe0xYK8By9jiCL6X1UkZ8aNd9kBreFrsaNRE=
X-Received: by 2002:a17:906:478b:b0:ae1:f1e0:8730 with SMTP id
 a640c23a62f3a-af992c6c33amr362295166b.57.1754529643803; Wed, 06 Aug 2025
 18:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
 <7b657acb-7186-42bf-9be5-8c1253c6316c@tls.msk.ru> <91aec5d7-7647-41d1-ae12-c86020be4537@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <91aec5d7-7647-41d1-ae12-c86020be4537@rsg.ci.i.u-tokyo.ac.jp>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 7 Aug 2025 09:20:07 +0800
X-Gm-Features: Ac12FXxj7g2hGybmIndLW3D3NWQkijy579ZCYNkErpeCG-tTNz7HqsXyOOt1tgs
Message-ID: <CAPpAL=xEZ+U4PnOWXP0Dtk1p6TmU4F+NxZZug+-wmYBsb1KvaQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-net: Fix VLAN filter table reset timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Konstantin Shkolnyy <kshk@linux.ibm.com>, qemu-devel@nongnu.org, 
	yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux.dev, qemu-stable@nongnu.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nlSjM_88dv4fNG7e6FDdp7IwEbcRI7AvlHar5pLRE-E_1754529644
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested pass this patch with virtio-net regression tests, everything works w=
ell.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Aug 2, 2025 at 5:43=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/08/02 16:26, Michael Tokarev wrote:
> > On 27.07.2025 09:22, Akihiko Odaki wrote:
> > ...
> >> @@ -3942,6 +3943,7 @@ static void
> >> virtio_net_device_realize(DeviceState *dev, Error **errp)
> >>       n->mac_table.macs =3D g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
> >>       n->vlans =3D g_malloc0(MAX_VLAN >> 3);
> >> +    memset(n->vlans, 0xff, MAX_VLAN >> 3);
> >
> > A nitpick: we don't need to init this memory with 0 before
> > initing it with 0xff.
> >
> > But looking at this, why can't we embed n->vlans directly into
> > this structure, something like the attached patch?
>
> VMState also needs a change: VMSTATE_BUFFER_POINTER_UNSAFE() should be
> replaced with plain VMSTATE_BUFFER(). Actually this is the only user of
> VMSTATE_BUFFER_POINTER_UNSAFE().
>
> I appreciate if you submit the patch with this VMState change and patch
> message.
>
> >
> > This, and maybe a few other fields like it?
>
> There is another candidate: n->mac_table.macs
>
> But it is not straightforward to embed this array because it uses
> VMSTATE_VBUFFER_MULTIPLY().
>
> Regards,
> Akihiko Odaki
>

