Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CEF246797
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 03:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760413870; cv=none; b=QxHknQS3U/dpL+M46IqsvkQN/M4e+s11KJz9uSxtI7ti+kYzs/6zulxa1QzuQbJf85A8iH0PtC0zgsQl49xjun50ivnPlsqRgZr7trr3ZJBBWMG3XX78ng5mh3TLsPnDUzg0LSiYF10pkmqcMBPxLof7fNGEoPsgvgfDEQsBLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760413870; c=relaxed/simple;
	bh=hOX+xfcv0FIXlgYcgzNXwEUXshb3meXIYtNPtNEbGhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XO0Uss65NgmSPdgu6YZwCElbdcra8PbFtS9vx+uuhvKeiB6LBN8+wIfQIWSVSigsoAmFNCa0hyDzjrjboFCjObTHFv/GpEaZqWxV64yliJLmUGxzmNfSuEee6wG00zkhgZY29Kc6fusrJV/Dvtb2bAxwE2kK2qqLeZXkew/JVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReGZ38cT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReGZ38cT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760413863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpfuPsZvAQi28LvBnYfBJn6au1wKMqKBywHgQemOBWs=;
	b=ReGZ38cTJ2h4mSVM9QtW9s6icC+XlpEkPOJbwiHZ37bgC+LPlcZafOJfK14xY3MMDoKPiO
	xRpiaJynu8qXnbOcu1a9uNvQFl2uZge1ntBYPXFCEpgWPL2rXiPqOTA0YTujEPeAiZyApv
	Z/V3V+fYwx4Oh3u02DUw6/71t6h0ahs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-JbLsrMAYPbydLSo9PlPwCQ-1; Mon, 13 Oct 2025 23:51:02 -0400
X-MC-Unique: JbLsrMAYPbydLSo9PlPwCQ-1
X-Mimecast-MFC-AGG-ID: JbLsrMAYPbydLSo9PlPwCQ_1760413861
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33428befc3aso10927963a91.2
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 20:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760413861; x=1761018661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpfuPsZvAQi28LvBnYfBJn6au1wKMqKBywHgQemOBWs=;
        b=UOTNuJoipvxk/5XwWrxnyBJ1HVUFm6pwVCqUFhVel9NfcGlpPwl7eh7vWzbuS5U98E
         pNa+5ewXmXCw7e2OIq2KHA3uZ3pwR8FrKRF48BDzNQuD7RKQI2p3d2tLthD5xwLd7g/2
         08Sgx1rWEg0adk3Ic9aCLUK9kUJ3vtUa7H3dVU/kDi4PG5RUc2pWQAnazqDFQkDttf2L
         ZP9ZtQX4mmaRw4rjgoJ7FSlZc8Ik9w57kHK65DW0zgxBvxVMZXkW6GtT5G3ohcTZEYLe
         GCjr2CRJ/pEkiZ+Va/ejSv5Qb/QmbCQdY++zH7hBUoTvuedPHbv2kBWPk1FnK2MWaHnr
         PGYg==
X-Forwarded-Encrypted: i=1; AJvYcCXE6gVVDGa0rakHmoTlvO141n0xMuT3OnlKWZeYHPwkv0njrVioUSoeS5RCghKxqLG6loYn5ZI8J2Tw0wkdMA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4ZNPM0Fls31DtNrEZHfvw9m/geAah5JfHfmy3L+L4JwojLsOZ
	u4s6BRpgiUcdoZe8vEdHx7aM+h/eAagRmblFr9xAky3z91Wj3mz/1snaW5XEjI7I7ASuccxY1AS
	zVHIQmGMXDzVYhtXGBSNoTEbswFp4gyVjWaAgFEWcdzag113TYQAQGiyqFcNz8bYmoP2ey3mOqA
	UMCJylfk8zZ22lnU3+O8T2RRmvfr5zs/SnRpoAd5piZ7s=
X-Gm-Gg: ASbGnctFwRYpt5XRKN7+pH+0DRdpxXhOQsvyVIttYC3w+nGWa+uhhz9nJzM3yLXyhmS
	nObmUQ/ftg0/ATFVrY5dXsW3aSB3YUFX4ssHGTXdl4uxxQsK62Bu8/WJW1x8Qxu4NSSQHFbuKef
	+3SLO7qJIViP+msLgUZUTIow==
X-Received: by 2002:a17:90b:1e10:b0:336:b563:993a with SMTP id 98e67ed59e1d1-33b513b3554mr34160948a91.23.1760413860931;
        Mon, 13 Oct 2025 20:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpXfKpuusbBQVRGGSDCDbhv6EzerfzrHPaJASDdrjMHe9ZbODDG7uY7dgAL5EIgQXRHBvuyZ4sdGfm5mo29Pk=
X-Received: by 2002:a17:90b:1e10:b0:336:b563:993a with SMTP id
 98e67ed59e1d1-33b513b3554mr34160927a91.23.1760413860471; Mon, 13 Oct 2025
 20:51:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-20-jasowang@redhat.com>
 <20250926104551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250926104551-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 11:50:49 +0800
X-Gm-Features: AS18NWC3-stlUAKfricYSQ4uF3kg5PAe38zj7A50TpRJE1eY7ej27zOsnOAV7Ns
Message-ID: <CACGkMEszC5kvkWpSiK9pZQ-_T1-74perH=FXkAOYeCffy7kc0Q@mail.gmail.com>
Subject: Re: [PATCH V7 19/19] virtio_ring: add in order support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nKd8pJ6lVWjtAjbiKLcolVD4oYB0axTvOap_mTcSMns_1760413861
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 10:48=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Sep 25, 2025 at 06:37:08PM +0800, Jason Wang wrote:
> > This patch implements in order support for both split virtqueue and
> > packed virtqueue. Performance could be gained for the device where the
> > memory access could be expensive (e.g vhost-net or a real PCI device):
> >
> > Benchmark with KVM guest:
> >
> > Vhost-net on the host: (pktgen + XDP_DROP):
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.20Mpps     | 6.20Mpps    | +19%
> >     RX:  3.47Mpps     | 3.61Mpps    | + 4%
> >
> > Vhost-user(testpmd) on the host: (pktgen/XDP_DROP):
> >
> > For split virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.60Mpps    | +0.0%
> >     RX:  9.16Mpps     | 9.61Mpps    | +4.9%
> >
> > For packed virtqueue:
> >
> >          in_order=3Doff | in_order=3Don | +%
> >     TX:  5.60Mpps     | 5.70Mpps    | +1.7%
> >     RX:  10.6Mpps     | 10.8Mpps    | +1.8%
> >
> > Benchmark also shows no performance impact for in_order=3Doff for queue
> > size with 256 and 1024.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> I'm not sure why my signoff is here but it does not look my
> comments have been addressed.

I will remove it.

>
> For example, see 20250921133711-mutt-send-email-mst@kernel.org
>
>
>
> Could you pls go over my comments again and check they
> have all been addressed?
>

It has been replied here:

https://lkml.org/lkml/2025/9/22/28

Please tell me if it's ok for you or not.

Thanks

