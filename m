Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339C2C3265
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 04:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503355; cv=none; b=qFWVj/7Ff9aC+f/x4MGBmpbDsS85enSAh3Vp+h0FlX7zAh037BTpeF+2G0tCoUc0kB4oVhBBFFFQTS/x/TJgKLZkucAu2mCYb8hELgzs00icNpLlH/TP8W7ikrQR6N24Touj50u1TOi6qDIzb3oa9XTcXDhDSZFs7FEszAVZhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503355; c=relaxed/simple;
	bh=+5ZF4RyJyHpvniDSxc7hWwmXqMHK28ij2c+CP1KkqKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPtvrjqK6rZtfWDlTwcQx5ATvWUEG38Lq8RfmiW+sr8xcgdWVTn0Jcb5neDeliBsAlklfcQeS/iyZrtFtdVrpTJD8OKbtGDOAHJSSk6Mej1TSgTC3GdT2DbPIsLLBfI/7BTVPye9XDZclmTVDlq7AkxWE25ukWDmNcSQd4cEXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcBwNAky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcBwNAky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760503352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aV/fYRVLDrIHpgp6BZgVLDjuKKgLmK3HmKlkssBfu6c=;
	b=LcBwNAkyfbA2rxJju+KYGLgkr+iwHPyCo268+rrrcEmh98FYMyECRGaf4i8BK6mIv/rhuo
	ruvuJQhgdwKadXeEhKdkgT1nC3VQAGjB69U7fmUAz/CLv+f5fLqrYvH9pJbQb5oiKwYN4k
	D0nh7Ob/4x7pQBQH1NKh45xuhYAo9Y8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-Rm-T0phQMcqWFdy6QZb5TA-1; Wed, 15 Oct 2025 00:42:31 -0400
X-MC-Unique: Rm-T0phQMcqWFdy6QZb5TA-1
X-Mimecast-MFC-AGG-ID: Rm-T0phQMcqWFdy6QZb5TA_1760503350
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33826e101ecso526395a91.1
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 21:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503350; x=1761108150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aV/fYRVLDrIHpgp6BZgVLDjuKKgLmK3HmKlkssBfu6c=;
        b=kl+S4svegj/7gdId7DjYMTX9X4LhAvyPd7UPd2bsX5/3xhXD628XTVfO6kTCoadYw8
         7Nc785H6iOY41G+lqBkYdKmLhq2c+BJ66HtcpLFsjYM/FPDN5F1rMzhq37acuuyLb+Ia
         MZ+e/X1YbzxM9hBnkYZw8hlW0ILeoR3pvJtVBZahbzB7JwUcy43AhdxTeUMz5Ujs0DWz
         /UudfwFpbC56qmiNU2jyzFkZXt8oZnCzAS4Z1EeUHLcKITd0n9JcLgCirpeTgmstby7K
         LyL6WzegMJZjgk90NGnuPJDp029yQ4Hrc+XggetWkMifVf4aKiOWjNkcOK3BhjEOW30x
         /veA==
X-Forwarded-Encrypted: i=1; AJvYcCXPScRgXxQ64tueyJ4+7c8474tjSMQP5FPdEUiYO6QgDRs0/hoEgLG+5H7sYQc981oLbKt52f9Jyb/C9Ab7ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgqW4O7fO8saCx2W8R9QA1Pc2m7b6rr0KbG722ij9Yh0zSKjoX
	mntSddFayOKrkHAZFB1+f+Q9RP9BJT8zbJSI4uETS/xtldL8CG9v6PSbietiE/efbLBKazwsOLJ
	CaT3m6R6TYSBsjb/JDOHPFdOn+irJmEmnvxvAGhWpQcWHu4rW1LdN5V8yfTQAt7lL3QhUuAneuc
	TLiak8jpTyF4WiqLZvxrY9JiWyQh/aZYOycOf72F4nHp8=
X-Gm-Gg: ASbGncsrStqqbijyOTZ+KTLVuW0C9pnsctCQeqLygYRGPU2+087Yg7aRklXV3IoCezZ
	OZ8tgLBH9F0l9dpkGRxdGJrGIb0HPMvFGmTnMYe61/9Mot4UgOFfZZsqKItMWy2BELOLykXLKG/
	Jx1DKj1eKIvr+7PT3uKsTr5g==
X-Received: by 2002:a17:90b:3b42:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-33b516770a2mr37677963a91.6.1760503349865;
        Tue, 14 Oct 2025 21:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/q3+lPQ5DLfIebWoXdeLkPswrE6RMbgEMJJk+z4itpaPQsFcdWz6AfYn4yR/oQPeypZaAuMRSSDbvWumqXk8=
X-Received: by 2002:a17:90b:3b42:b0:32e:4716:d551 with SMTP id
 98e67ed59e1d1-33b516770a2mr37677938a91.6.1760503349405; Tue, 14 Oct 2025
 21:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-20-jasowang@redhat.com>
 <20251014050901-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014050901-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Oct 2025 12:42:17 +0800
X-Gm-Features: AS18NWCAApHsVnDxGYBndRcoZtUTawY7kdOzVXOs0YEWXm7ivQ2w_lFD5C1Gm1o
Message-ID: <CACGkMEtDgs-JXvuTAbAJX2qcx5ZrkS=gK_4aw6bmxhQ8pLY4vQ@mail.gmail.com>
Subject: Re: [PATCH V7 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HDwG91k-zxsTOmV229kuE9Ig3Ti-MNr9LGA-fxtKpUQ_1760503350
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Sep 25, 2025 at 06:37:08PM +0800, Jason Wang wrote:
> > @@ -683,7 +707,12 @@ static inline int virtqueue_add_split(struct vring=
_virtqueue *vq,
> >       vq->vq.num_free -=3D descs_used;
> >
> >       /* Update free pointer */
> > -     if (indirect)
> > +     if (virtqueue_is_in_order(vq)) {
> > +             vq->free_head +=3D descs_used;
> > +             if (vq->free_head >=3D vq->split.vring.num)
> > +                     vq->free_head -=3D vq->split.vring.num;
> > +             vq->split.desc_state[head].total_len =3D total_len;;
> > +     } else if (indirect)
> >               vq->free_head =3D vq->split.desc_extra[head].next;
> >       else
> >               vq->free_head =3D i;
>
> So in order is clearly doing something funky with the free_head.
> It's no longer a head of a linked list of free descriptors, is it?
> what is it doing and why?

Since descriptors were consumed in order, it's not yet a list. But
it's still the free head.

How about something like:

        /*
         * Without IN_ORDER it's the head of free buffer list. With
         * IN_ORDER and SPLIT, it's the next available buffer
         * index. With IN_ORDER and PACKED, it's unused.
         */
        unsigned int free_head;

>  Please add code comments to explain
> both where free_list is defined and where it's used.
> For example, virtqueue_vring_attach_packed only inits free_list
> if not in order. So who will init it for in order? And so on.

Packed virtqueue reuses the next_avail_idx, so free_head is unused there.

How about:

static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
                                          struct
vring_virtqueue_packed *vring_packed)
{
        vq->packed =3D *vring_packed;

        if (virtqueue_is_in_order(vq))
                vq->batch_last.id =3D vq->packed.vring.num;
        else {
                /*
                 * Put everything in free lists. Note that
                 * next_avail_idx is sufficient with IN_ORDER so
                 * free_head is unused.
                 */
                vq->free_head =3D 0 ;
        }
}

Thanks

>
> --
> MST
>

