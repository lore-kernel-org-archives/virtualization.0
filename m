Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866142F60A7
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548759; cv=none; b=csYbhroIWf9ILjQi8n+huB4ALktuNX0WLBxqgalefrbC6opxBZLwvBoFoGuuuylUc/Xoj6B41MtE7kenQzJNfWduf1bQeKTmbE0MzzvPZT4R4LeIqvMofxmlmbUt6xFBP3m/ftBalRa5Z50Kx48plG1sVY82m6g1uZV1LufFCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548759; c=relaxed/simple;
	bh=stz4Pa+uWK6qjThPUoNvH3MgPUSIwIBtdDJOHpJeICc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZp4igg3+CWh2i63LWKxZ+oXpoy4JIbJRTk1s3zyy/ST/uCAEF0qxn8DZFn4gwEDTYAnKiU+XlQltXhST6a2eznkx0as82o8gObX8i4k0hEeX23p49ZMBmMe70/9Ixy1EPr2wv8eNQz1DzGgIyrOy09SlCiogYOicDhTDmqbr64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8YDZy4p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8YDZy4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763548756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stz4Pa+uWK6qjThPUoNvH3MgPUSIwIBtdDJOHpJeICc=;
	b=J8YDZy4pasOnG19AK/WaPB+eUCyqEU+eZqUz/X5jBfYErVkVQD0M+ItapqOGjZ6E5RP5PY
	kZaBgs9UUwIDmxPVqwfxbd7oRjsSlm+Qq0g0oWEl4PRTK+oByCkmKPzXwn6Dzf42dmAlmW
	hyRy6MvFjSEpFJD5h+Ya1Xc+JGut+M4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-p3i-DgIdOJuGI8-kU-VCFw-1; Wed, 19 Nov 2025 05:39:15 -0500
X-MC-Unique: p3i-DgIdOJuGI8-kU-VCFw-1
X-Mimecast-MFC-AGG-ID: p3i-DgIdOJuGI8-kU-VCFw_1763548753
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59434b284f8so4929552e87.3
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 02:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548753; x=1764153553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=stz4Pa+uWK6qjThPUoNvH3MgPUSIwIBtdDJOHpJeICc=;
        b=wBmmgR4O7CXFUyNvg/dUSVIh6mePZFGQFoWgHeHqmxgB6pneCMBBFR69UOFkhj/gAM
         y2fxRcbHGE8JP+fxdbZ8sMaVT90WcLtGLRHL+GZdkIsH8Wgp5NOzMrOSNSQdBAb8yeIy
         n+Iu3t5g+9X7o8yVPwOKx9aTxyCp0/Gq66vf+pdXKVmCaX2mDG+jMnzsqRAznAwGKuzP
         PpuptCzkv2UMnX94R3nXlsRvB612JoL9m7b7JjUX+P5ZHIJ1+Uo9p6Aq6z50Q9d8Ju5A
         RxgqXMb/KhuJYf0DD8dC8UKGX68f3hWgFOJyRpZ+vLivMIAZDu8xI2E+r7BY2bBIHolP
         Aq8g==
X-Forwarded-Encrypted: i=1; AJvYcCXu7h6YxtqcvdEdvuWUbz3fYZQ7jx3DIdesSrvgf3wOPgXh3G5rbwTw4SL+yLamjEBsVMj0vwiklC8NW1K/zw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMU2DHKl5Js7oFa5PgrcOihHuGbtCsaD9PuKvVFNPqzmmpiZlH
	TXG9/UlF0zeP3IzQ/hVysfvncWEqE3q1NYENJxcqgOD2/IyzbXA/uSpm7TfmXe/C1AW1Z+SC5gP
	yT16BTiR+BydROKVlXezzSR9/xueVIsOBJbs1pljxHrlPGJ5U3Mdxb8yjayIi7bInSm1HSjxfk+
	SdDaZd8pLopAwqBNd/+KdUTq6MODqNwl8cZIwIXGaoBkg=
X-Gm-Gg: ASbGnctfFM2O4EQpkc6aKmTDuQLU3RY9Fk7ztPin8XHSLwZLEvMHCdyeD+5kCdYAxgx
	p7q3Q4lShvKc13SQ1LaUi/iJmswbtHx69cPFgIBIc9UbRnUGwATj3A/NAKapiyVfGs0gPlCs74g
	fU+58J+UafbJf/t3+wtXhP7fkIsU8dwjhsZH8jE0KqUi80r8m4GQi267k1Q/l4vr2EndI=
X-Received: by 2002:a05:6512:6d1:b0:595:8200:9f87 with SMTP id 2adb3069b0e04-59584205a52mr6947759e87.17.1763548753375;
        Wed, 19 Nov 2025 02:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqv0zlShxJxReCDsCJmo7I65uLtxoVyamZSqaLiA1FuvJXc81M5FKfBBp2B3z69/5QPky6nm67AIGMv1bvJOo=
X-Received: by 2002:a05:6512:6d1:b0:595:8200:9f87 with SMTP id
 2adb3069b0e04-59584205a52mr6947745e87.17.1763548752925; Wed, 19 Nov 2025
 02:39:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
 <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
 <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
 <CACGkMEuzAo2jRgUwkxhM=bgS4a4NvpP6BYZB1zed00C6J8eiyg@mail.gmail.com>
 <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com> <20251119042923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251119042923-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Nov 2025 11:38:32 +0100
X-Gm-Features: AWmQ_blInQ3_Bgii2eOchFG5U2oorcByZEwGTUpd8YrwGVPhdnHNd9JEA89qYrE
Message-ID: <CAJaqyWeAoVzmWaAwcK9kjj=3VuRmYc1fco7a1ausXB=z-0oK=w@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	virtualization@lists.linux.dev, Maxime Coquelin <mcoqueli@redhat.com>, 
	Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QkIS7rEWVy0xj7zim5lkmn2lwYCRKSZ02I403-2Lg2g_1763548753
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 10:32=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Nov 19, 2025 at 10:26:43AM +0100, Eugenio Perez Martin wrote:
> > > But this is not the logic that is
> > > implemented in this patch as there's no synchronize_rcu() in the
> > > vduse_set_group_asid_nomsg().
> >
> > We only set the pointer on the writer's side, we do nothing like
> > freeing resources. Should we set the pointer before or after
> > syncrhonize_rcu()?
>
> synchronize_rcu is called after writer makes it's changes.
>
> > What do we need to do on the other side of
> > syncrhonize_rcu()?
>
> Presumably, return so the caller knows the as has been updated.
>

I'm happy to add the syncrhonize_rcu() just in case, but the caller of
vduse_set_group_asid_nomsg does not need to know that the reader has
been updated.

The first caller is vduse_dev_reset which has its own way to avoid
being called while vqs are being processed. In particular, it reset
their addresses which is way more dangerous. I could call it with
dev->rwsem down though.

The second one is set_group_asid vdpa callback which is called from
the ioctl itself.

Moreover, rcu_assign_pointer is WRITE_ONCE by itself so we know all
the readers will get the new value after it. So what's the value of
explicitly waiting for all the readers to finalize their DMA operation?

I'd understand if we need to do modifications or memory management in
the now unused ASID, but that's not the case here.

> However, user-triggerable synchronize_rcu() is almost always a bug.
>
> If that's what is going on, you want srcu.
>

I did not know about it, thanks! but I think all the code that can
sleep is out of the RCU critical sections now, isn't it?

