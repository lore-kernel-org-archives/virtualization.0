Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F961EB5FD
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017158; cv=none; b=WIJfLv3m9MsA7yIwl5OcaPHgMmJPOU8xq6UqGec+WGIcdDMl6YPhuFw7prDbd/eQkxWAGa4i6XagF73uqj1Wvj3PKBlf4IEown/A2sEarxS2VT3IcPpSMoBghbkccPlcN9WFmocpXXVb6TefmeQdN8ZK1zGDm09ukyJz0rrdwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017158; c=relaxed/simple;
	bh=4XjbvpmeB8CFbftLLp5xjmfmwhK5ug0qxb7qEsIO++M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8upVqBc+H6vS0T4UiatLuRPlU3cOFG6EHcvthDhb4VP2vJ+Fw5vZqGVMDtXOfbN01dBqRv13lwrqr+AD2furf+OfDzVmbGgk8yuEleUXGmuUTtDSjVT1RnyJCoBDrIH0PPnK8kPSTdVe+R440sOLH1MDab1KtahrdCV02RUqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0iuDP5+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0iuDP5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761017155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O34Wpp/uWAHWU6aGGI3BbU1pd02MrBFStEOZ6H33qA8=;
	b=f0iuDP5+vbbFmEEV1lFEn43BErFSE3OoEU5eZ95YDBmCUIRdpWTOw9WsjRX3woFAdwWjkh
	WVztFXb6zyRnI0QjkQT9vhGowige6ByrqxY2wG0Pxmzy5HQnM39jp7tLo3INddkGJenxD7
	JvFUsxGD7q69UipPxK2y0L2IiPI3nG8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-6dN6kyjUOQSNC87v-gfdzw-1; Mon, 20 Oct 2025 23:25:54 -0400
X-MC-Unique: 6dN6kyjUOQSNC87v-gfdzw-1
X-Mimecast-MFC-AGG-ID: 6dN6kyjUOQSNC87v-gfdzw_1761017153
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so4240594a12.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761017153; x=1761621953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O34Wpp/uWAHWU6aGGI3BbU1pd02MrBFStEOZ6H33qA8=;
        b=aRLL3sZ9Sqgh6SrkKNlmB3pTZmYuVxKS2Z3MZbyFkBdT5gdFjJ2uoNfJJUI09b0OQ4
         uo1K4BjTymvT90GgD+zVKEjdAazQiaKmB/v/uTgEZOqjph0oDJsWb2iU8UTkSrQFBcqN
         j20hsmNCHHQBeSu+SZwz1jwcYwIvOp6ekRdXUMvvzcznWSg7lMlRKFSdizfrkcsycPn9
         6C3ZEnE3FbX62GI6EcKq09jKn5SkhwuCdhUmUCwDc+tiRwtWYkrl9cJayeYGi8qxt9TY
         PslgVQ4KHGcUU6VJL0XHa9aDvnokS0cIBcKr6l6hs/Qvl2PljhmULxHaQDaopHjqlTo+
         yIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIcjpagUtvdZL+Vz5csaiFGS69FlGtQp9dNjgLLD4YD8bTXkwkPy/QUcGGCQFTe5CNgHQIy4Q1GPRBLT9cWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9m9bnBalo99Xb2r8ib1h90DcdzIr1CwcNBfFvHKaKmBCW4xhS
	B+u1zLNspPltONeUDVGtIrumSWeaaINPyuIKvBZQL1bRAs97xIN+IOv1lSD4MUzodDVSdggQK48
	ykxhYJYW/fnTIAnHJ/Md6DPk+c2B5XN39Wj6a8JkrA2/FMLWup+8wm4eWW5hbQT15GSbZZUsZ02
	EIgixHOAcP/gKP2rgxldhDCVvw6rrdMV4xl7F5I5esXOw=
X-Gm-Gg: ASbGncsmYSnt8NsWQoll35xGfuJXelIMpV0cTzqSsB3iGYsj4i3Pz6W1J4pGwsWhZ/5
	SaTN0FHSl0KsdmBW+uwiwYHAT/vRnjEzETImLmievKrvKGk67xVcV1Kv0bHPihiZPh4wmt0Iv9x
	Ind9z7G/Z1/LDeW462aDR0cvCOFgOc7DjvxCIS16t00P7gkq3Nz/3Mehih
X-Received: by 2002:a05:6a21:6d94:b0:249:3006:7567 with SMTP id adf61e73a8af0-334a8607433mr20823229637.35.1761017153099;
        Mon, 20 Oct 2025 20:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJMM8VRzK9zumCmP4A21xwTKQ8iOGB8leiB5Rmd1ArSdY0b4Fs7PVaUuIwZby1VH35HMdVR6ozvJw1DzzSC6g=
X-Received: by 2002:a05:6a21:6d94:b0:249:3006:7567 with SMTP id
 adf61e73a8af0-334a8607433mr20823197637.35.1761017152668; Mon, 20 Oct 2025
 20:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-20-jasowang@redhat.com>
 <20251020051214-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020051214-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:25:40 +0800
X-Gm-Features: AS18NWBI80otGQLOB3_7-L-CjmNuFZpJDc4NEAiysS0jOFwUtxEK5smdmY0ute8
Message-ID: <CACGkMEsegw23-N75QqUWfS_e5TuTX1122n7B8dgZXch=z_Y96A@mail.gmail.com>
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ELn1TFjDx6KrBDPVWOac_awcyj8iVf9_bAHMqEYtIH4_1761017153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> > +
> > +     if (vq->batch_last.id =3D=3D last_used) {
> > +             vq->batch_last.id =3D num;
> > +             *len =3D vq->batch_last.len;
> > +     } else
> > +             *len =3D vq->packed.desc_state[last_used].total_len;
>
>
> another coding style violation
>

I've fixed both virtqueue_get_buf_ctx_split_in_order and
virtqueue_get_buf_ctx_packed_in_order.

Thanks

