Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C9157493
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017301; cv=none; b=btmOMtzCmxy9V/HDUWKXZnjObXL74AuS7suifbzKzwQBCK8UvWYchaqvk4jwoobWBIabWOPwANEQMk4tQAkXJLK1KXvSs70OVydUpabzjhBnNpe/E5Knf6/Ku7W2TEjKGLmmnzRrTuqBbefNTSMJbroYUd/Ty+PEt8FYdxNwRgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017301; c=relaxed/simple;
	bh=HEGMvjk3kZR3n2oI48nE1ykXlS05o/X5C2tS0W5EHY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuaxhkiNfScp1VCew9XLslGOSTl1xxNDZMMOgTuFeR7vxNywZ31yq953U1v34VC4lyUpgPOH/WcueUTbtDjOvTIjDQcxMbjbR1GE/7QxU9FtbkuIELDq7csJrdVugjlSDeawO12JaFcjcweliF71QJo0z7YhhAWqYWMm7QAGLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkEgq3vm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkEgq3vm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfZuOVwGtgd4PrNc5P78K81w85wdLxCgwPzZydRfAcg=;
	b=bkEgq3vmdaNKESiuNveNEPVu7zaOMCzgHy6zT9L1fdBVhrw+CRhqHdA68RLoPJ7vwa5NpV
	chwKs8PFIrqQIrpcJo8d2d7svyKswj3bwr7PPadfyjagtdG54S4wtALNsgkj4Y07YPc/I+
	3qp+ugeiHbiF/KPjCVhHKOIDHDS8MZ8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-LphcyuWGMyix_I8u8AH1BA-1; Mon, 20 Oct 2025 23:28:17 -0400
X-MC-Unique: LphcyuWGMyix_I8u8AH1BA-1
X-Mimecast-MFC-AGG-ID: LphcyuWGMyix_I8u8AH1BA_1761017296
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so4237710a91.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017296; x=1761622096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfZuOVwGtgd4PrNc5P78K81w85wdLxCgwPzZydRfAcg=;
        b=bgiEH0SAnawmJSUC1DAd/Ve+F979YCXAiNCxFpOE/vGcqpvBrwjBdJusPUZABgzlQB
         8u9j43oLrWTKtFXHP450etMIQiSoklNzw8F9YF1BTPNa54FVGSG4p8ecWUniO3sMpHGe
         Wye9i77qHDVL9JZ1awz/9kUhq96IeQ4sr2HOlyerkzGw9PacgRWJ56rxuP+aWezgIK3C
         /9CJZfBbpJ1m5EJ6VdGsCErMLI7i8f385fSvMSKSnt+dV6WTwEYA0oWHbipP0jO88fjz
         cJ/VQjBBg9VkhoMVVtZrN1AbRMyNYxCQ6IwwCoT1LA9jqXN5fHfx6Gquye7mcwTkrxwZ
         9wBw==
X-Forwarded-Encrypted: i=1; AJvYcCXTVORn40VriqHr7/bzYJMwswX+k5pvpgCNeVZXnqNHqCYJnXhxWbQDlI7OKx0Z/Ap4DMJWywKiVuRNvwC0nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvKK9HuCxbmISdT7k7FbtLoy75CfjHFFtdBkXGm5bJIP3cPTxH
	u25dID6Y5Zdqz/gIylWZzjsZUNLmP0k9cDrqm/tfb/yOdB8NiepNiC710AvB3mcouWyiB+U8U1Z
	DhJmEQijNeVZLcxBGdE6TNVZOUZ7HWNLkVUsKiwbu6rLv00N5jW9ATWyYN9dUrp6OIR7ZITBvUG
	zZKwCWm9fbRJqCnHetEc4a/uW7ErfuULuIEsPX5MQ9rtquz/yCi/cg0RfL
X-Gm-Gg: ASbGncsi46R8qiT52ZXvsshX1mge2TPDbgg84w1EbPbmRSVek60LR+5GzaV9QDRBR1z
	mYRpY1FXzcReoKeLtEbKei763jBvYQVWNmw1hy2fa0Je2VReNDdP0V7I3oSbMForSUDF6QPf3Yt
	nqqnerqWY0Pr2tJODtSUJbdviZLmo1okWYLxuhHvU9ZwrIBM89lpVPWWOH
X-Received: by 2002:a17:90b:1343:b0:30a:4874:5397 with SMTP id 98e67ed59e1d1-33bcf87f454mr19765974a91.9.1761017296303;
        Mon, 20 Oct 2025 20:28:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLR5F1yTh6UvAM+yt/mmNnIaJmeG+kzrguiTm14i/ZpGaf9HFDzxjZ/spAYnGfgoj3YhSe9gJOhePaEh2MCTw=
X-Received: by 2002:a17:90b:1343:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-33bcf87f454mr19765960a91.9.1761017295954; Mon, 20 Oct 2025
 20:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-14-jasowang@redhat.com>
 <20251020063831-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020063831-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:28:04 +0800
X-Gm-Features: AS18NWAm6h2gvngBbEyIE06hhxVZUe2ONMXwHHb5XhqRCO0vqhsDkT2dCpp_0OA
Message-ID: <CACGkMEt3OCWT635djnT8O97B7Be2Xi=2kjnMPb8u1U=_B1fKdQ@mail.gmail.com>
Subject: Re: [PATCH V8 13/19] virtio_ring: introduce virtqueue ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zGFDwXOqOM0KMnhmkfO2PjXqTIu2nwYCI5gSX4g_FvY_1761017296
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 6:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 03:09:57PM +0800, Jason Wang wrote:
> > @@ -2782,7 +2874,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 n=
um,
> >       if (!num)
> >               return -EINVAL;
> >
> > -     if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num=
) =3D=3D num)
> > +     if ((virtqueue_is_packed(vq) ? vq->packed.vring.num :
> > +                                    vq->split.vring.num) =3D=3D num)
> >               return 0;
> >
> >       err =3D virtqueue_disable_and_recycle(_vq, recycle);
>
>
> This is exactly virtqueue_get_vring_size:
>

Yes, I've switched to use virtqueue_get_vring_size() here.

Thanks

