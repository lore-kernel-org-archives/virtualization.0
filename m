Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54B157493
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017789; cv=none; b=UVYbjN4olwMfOB2uZokA2RTuQhN6kNyzcKdD77aHNyqVWJSsumXXDNO8JCVA5/lvz1JtmpDSDC0mGdFLtVSApOCsR6tw+r5jsHx46SvEnSpGpHdlcuxu7bw8czYBN9klfbYADn4JNgbYadqYZcL1LWcMlXk7PXxVEQitHpX0Fvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017789; c=relaxed/simple;
	bh=KARzJmw0IGuWzPo8hIPKqlcttmgHPmhddQ93IyM/uN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvFpbu42ROnN4ciyHolnBiG4tMEbDNrtniT9hr+9cyqUwxJP3dSf7s0vZMNoLLO7+COHRmgUKXpryAR5ARYySO7D9vMeOYvIU2v0DX9J1/Q9pENnSU/ipCIL2Ahw7U3Aybc4zljGkym1T2Xqybu6I4LWP9w6ue9cJTCV8jo3IbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBB2MbBN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBB2MbBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYcSSFbr7f+P4ic+LlVnNjiunvRAoAHvjqnEje36UNU=;
	b=JBB2MbBNneRxVRImBZPsrdPWsAGiZ1M2gbHkjuv5My9cRyBguzVpWYoMIk/0imOxDlYWau
	AqAKwO/jInRAumbsMryB5ZyQ0o5cvE4ZrBID+5luSQR+hDP0FypFBMhcPB/RpBcbLIb5Ge
	Su/pn20j2ThVIh6PNqDBNflse1p1sPE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-dGqDM-EsP7WkF69fVebnGQ-1; Mon, 20 Oct 2025 23:36:26 -0400
X-MC-Unique: dGqDM-EsP7WkF69fVebnGQ-1
X-Mimecast-MFC-AGG-ID: dGqDM-EsP7WkF69fVebnGQ_1761017785
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-28973df6a90so50354265ad.2
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017784; x=1761622584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYcSSFbr7f+P4ic+LlVnNjiunvRAoAHvjqnEje36UNU=;
        b=PJpHFioTObPTFrUpedqpteu78RitjXZKRm/3u8f76NleJc6thvoe+U+/hOLb9k9Z5v
         YeK36gppgoH9FI2IQ05eQAtNfSxh452Zhlr1asbykcnXTVM28Kp3dFNZiJklCSvEoVtD
         sCP2Qhx7cZtdeCd6MjvSlvmAzM9QX+VPgf+ANU3DJ0aO83XfOiMa4pABgNEfp9vr9+MP
         Bi5fzdwhOJbcyRJR3Ziqo2KraIIIjL3waf0WdKjxuXWTsUj9MwLK8hpEEy+4YJXoS8n2
         C08YPsKLgJy3VBzD4wcL2rbrnznEXZrdP/kipHsXDE1SRQnan6EIHmEdXPLDZFil4pg1
         /4xA==
X-Forwarded-Encrypted: i=1; AJvYcCVc73VdXTQRyCNaRPyMfwByHOBLBREQRyee5GcICa6r09u5dWfeBm9XE63BPcc4zO3AR/1mxLZerbCtHT4tsg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmJgWGwVhLybEcr3z7gLVVZZw17oCSxX/YF1g8xCedmEWge5nb
	O8zK6l5kJy0JLrkXPfKzT49wDeadS9efHVT2vSbYh31JiAcC/a8yWWhJg7SNYmeLxp4T1pG7JGj
	8xGPAqBEduOd7D7V5632JD/0UV5+nzSxHN8PuNAMwDxZZGLdaj/LlJfVKD0uo5oKn3fjvgh57g0
	CLIraQ6aJvMorp9D9Evpy5SKmujue79iGVHU4xuyI11gFEdCjc5AAgA3RC
X-Gm-Gg: ASbGncscLyfq0lRHZiIgD49Izd1CPcmLTLNH5WcheJdam5/+RyBCglJQDPOauLFn1/c
	sU3rb2W1OiERWumSEw0RxIoauqC65knEOz3iLOci0f/sihsELykiah3KwHu643OGJJ5pk5ZhOHX
	D8rHkdOEHS/Dc1o27yPUPfqezvKJv8okqk/qHI6Yd2L9qLlmMb0i6b2qYo
X-Received: by 2002:a17:903:230a:b0:27e:f018:d2fb with SMTP id d9443c01a7336-290c9cf37d3mr180562535ad.6.1761017784666;
        Mon, 20 Oct 2025 20:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnIECeEdtsIf+Sgiji3j5dUiEtg4R2S0qf/lDOwtGAJI45rkS3iRSDJoNiLAbeEZ0BroefnaRrHaukACvEvm0=
X-Received: by 2002:a17:903:230a:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-290c9cf37d3mr180562315ad.6.1761017784259; Mon, 20 Oct 2025
 20:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020111413-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:36:12 +0800
X-Gm-Features: AS18NWCvWFEXQm4CJsrSie7GqZjQ5OFo_ZDtZeYcavpQ1UuuKcolFSbgF2tcggk
Message-ID: <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t8GjVNo0XOmVlfy8gzyPw0aGtH1CZmcmZP_pXodR86I_1761017785
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 11:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > This patch factors out the split core detaching logic that could be
> > reused by in order feature into a dedicated function.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index 0f07a6637acb..96d7f165ec88 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_virt=
queue *vq,
> >       vq->split.desc_state[head].indir_desc =3D NULL;
> >  }
> >
> > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int =
head,
> > -                          void **ctx)
> > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> > +                                       unsigned int head,
> > +                                       void **ctx)
>
>
> Well not really _inorder, right? This is a common function.

Yes, but inorder is a subset for ooo so I use this name.

> You want to call it __detach_buf_split or something maybe.
>
> Additionally the very first line in there is:
>
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
>
> and the byte swap is not needed for inorder.

I don't see why?

> you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)

Probably you mean a leftover for hardening? E.g should we check
desc_extra.flag instead of desc.flag here?

while (vq->split.vring.desc[i].flags & nextflag) {
                vring_unmap_one_split(vq, &extra[i]);
        i =3D vq->split.desc_extra[i].next;
                vq->vq.num_free++;
        }

Thanks

