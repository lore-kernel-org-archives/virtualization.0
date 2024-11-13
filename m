Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8676BA34
	for <virtualization@lists.linux.dev>; Wed, 13 Nov 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731461757; cv=none; b=D8rO+6mY9sylwdge5d7vRlt1OdbRJDxPM8VdwFiNRzx5uUCL6QwTEQm/0V5PGoVkcGbrwil8A0zjbgn6TGWG38K9/0YTR2XxP7ACTypbTJSUgdlSVwPOBzIZ+rPYtpEVQthmmlSA2i/IYtTqE9JLcwPFPaD0u47dLpQmTYoeu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731461757; c=relaxed/simple;
	bh=Hai8CbjxxvC65Grfw0z9wldwL8Fsqy9AZwn2qJq5h1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxpmZT0+g4p/l43QTIdmoBd75D4XyeEq8AiUAioX+4q3tHSqFFFuhiBFupze+iluAhCSNzNqJIKv6f/kilfDYGiX5FeWAwtGWZh9aJZaZstd9MqAefWueiZZSBDn3nZZW7D2WwuhoW5rHc3EXfJxQYaOehzsntNd2MrE97zFsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQe+rCDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQe+rCDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731461753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGkqVBD/cl5HjbeUZbHpW2I5be/ruvQ0biy0GT7rtWM=;
	b=WQe+rCDVgWb8JxI7mJta5qiv3u3tNZiPcvTpSYKWExLutngQLzSfs4MQ9deJfmYYvkNuy0
	BeUZINO2AgP/NxbYLKD5PV7RacUIn6bNE2lt/UhLizPm6CoU08qE5x6WWtMi2SDUlLMUiq
	r6QzLziFF/H2RBZVb+GVnyFW/BK5a80=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-UfJIPljzNfaGXW8tFBetzQ-1; Tue, 12 Nov 2024 20:35:52 -0500
X-MC-Unique: UfJIPljzNfaGXW8tFBetzQ-1
X-Mimecast-MFC-AGG-ID: UfJIPljzNfaGXW8tFBetzQ
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7eaee07d665so6117051a12.0
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 17:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731461751; x=1732066551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGkqVBD/cl5HjbeUZbHpW2I5be/ruvQ0biy0GT7rtWM=;
        b=wLoMsmAGBIJHLcEXYU8Qn4MO/MJVcdhxXvwXetsNolZJLWYzQpug0RgkO9BINR2zUF
         7Wy8R1tXIox4H5cNKz0Qy9HhwhhKberbKDPsF49P3jx1UVv9rVsiZIq25Xef2gn4HADb
         IoxlCZ8gq2tXSVENfyiMIg5jX3Xg64xd5zWBi3VwoG8JOAFxVj+TZSOCy8x54S9qUEZm
         NNLvBCeEnnkdacJNozD8Bw2jQ8fzSEJkT4mE5PWm+mPNvy+ORLK3mr5sWGQgO8xVak4P
         gB2cOPdtlx9AfZulubPQ3Zs72odctVSLRECyWFqzVwS+z8QZEwR5JSNLX/14QivR9PmN
         wJrw==
X-Forwarded-Encrypted: i=1; AJvYcCW1mOFkvbTu1GU1GsPHIvHJM+N1LV1/OSf8tOI0UURYokUYtKgZ0j9bIyeRL0viiyGFJf3yjnAR4VC16xklfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqrzdw++6Xie4y6jbKCbxO1mdkLCMAjKrqR18QLp4TBsTHeieW
	kJmkVbsTvsjUHX/WYnj8svQ0tK+xy9xtTUTJ0U3fEHWlWR5ibNyLtK7+HvR+Jt8vX6TDOI1JCLG
	yh0H+QL3UQ3JsNgkpQwEkCC0rvNR2Ppqlp//7XZtvdcc63yIDZ9gRNr9vHIEyYjNDleTZI+n/iw
	toEuClZ/9DhKgFGz55La5qISog2de/jmGEXs3mirc=
X-Received: by 2002:a05:6a21:339a:b0:1db:ec3e:c959 with SMTP id adf61e73a8af0-1dc2292f6fcmr26523384637.10.1731461751499;
        Tue, 12 Nov 2024 17:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZH7pMNwQm2PurwVVeyExbh2UXkF+eg1HiSNrj9jmjuk8eRgNriNhqFYzaWC3Qe2loS5SKWogSrS5vWm8Txp8=
X-Received: by 2002:a05:6a21:339a:b0:1db:ec3e:c959 with SMTP id
 adf61e73a8af0-1dc2292f6fcmr26523358637.10.1731461751071; Tue, 12 Nov 2024
 17:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241111025538.2837-1-jasowang@redhat.com> <20241111022931-mutt-send-email-mst@kernel.org>
 <CACGkMEuCx=ht2Q75xJ11EGsjuZPWcTTpGh7OyVEHCOhGDB5f7A@mail.gmail.com> <20241112164527-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241112164527-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Nov 2024 09:35:39 +0800
Message-ID: <CACGkMEt-mD8=wkTLua2-3c6bSYzWfp+m4TW8Pm_oe063gsWqMA@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d6pK_ezIYQrrFDxJTOyFBsI0JHY2IWhFxhQP78UfNNU_1731461751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 11, 2024 at 04:36:52PM +0800, Jason Wang wrote:
> > On Mon, Nov 11, 2024 at 3:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> > > > There's no need to sync DMA for CPU on mapping errors. So this patc=
h
> > > > skips the CPU sync in the error handling path of DMA mapping.
> > > >
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >
> > > DMA sync is idempotent.
> > > Extra work for slow path.  Why do we bother?
> >
> > dma_map_sg() did this, since current virtio hack sg mappings to per
> > page mapping, we lose such optimization.
> >
> > Actually the path is not necessarily slowpath in some setups like
> > swiotlb or VDUSE.
> >
> > Thanks
>
> I don't get how it's not a slowpath. Example?

I'm not sure how to define slowpath but a possible example is when we
reach the swiotlb limitation, in this case. vring_map_one_sg() can
fail easily.

Thanks

>
> --
> MST
>
>

