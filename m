Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13035028E
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760767; cv=none; b=fxOlrVznY/26mOOJVVwhCh/B9MEVEOdxEVlSzP4wZvxhBgEj2tLiS7q0bFjoWIoHIgumJbuzNtXvZ4moNPtz/AZSa3i29nuOnyWRW0XR3GcdvwXQuDjd2jy3Hd+qgUTvVmSFKJBwsbEDl7ucBgISMyWY8HvvQxn9Su/rCYzFTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760767; c=relaxed/simple;
	bh=E1ufPZsfim8XghCHK5sn6edDV6sz+kmUASLRyr1n7A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJkHI82qMD4FqeqhCdlAsG0h+LznWrh4hgdSYWLlMbZAB0OT7vUUU27nY6oQ9DmdyXs/rzqmDUZKAWy3xUPwc8uPv6v+FmKVvLP7GPGOWX7b5ioNa8t0ugdjCwYIo33oQqhxMuyKhRaRZoQC1Pm02qDK1pCTC3QwXQVSffYI25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ll2YFqu8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll2YFqu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769760765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYUNva6rU/t5dJwLPSR7br1klDdo7adSCQPcmOSIJ3M=;
	b=Ll2YFqu8D73YTZ44jSBOVnJaRyjYymVUREO4FJXPAFmH8wUse79hXcXmC5Pit6Lefi1A5B
	iVRBiU6/ErtUrOchYsyme99/+Hl8NSMCmMmyzghVQ04fsHE4cCPn1A6X/168bqSeTAdCP4
	5JMCNBnJOYhdVyT/bCtWXEe1pQDgD9o=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-F49QFEDcMTiLBjjrrmd1Iw-1; Fri, 30 Jan 2026 03:12:44 -0500
X-MC-Unique: F49QFEDcMTiLBjjrrmd1Iw-1
X-Mimecast-MFC-AGG-ID: F49QFEDcMTiLBjjrrmd1Iw_1769760763
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-79477dab067so23712397b3.3
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 00:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769760762; x=1770365562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYUNva6rU/t5dJwLPSR7br1klDdo7adSCQPcmOSIJ3M=;
        b=JAUjTJYUG6N/qFOsP0INmJYf6qFA+Pnj/kY/RRzdQawAkmrzC2EEQEuPiN1Yf8j03Y
         6e6Mton5zO/gRU2933bx+juKe4GNBN4zC1H/BucyIxKi6eMYlBJzAW7d8tdAfKiYyw0F
         7T+q5tfrp1kOOfpooRigOXYiLcwpp3Ftd9sg+B7uoJSl9jEcQRzeCqkJSZ7ouLPSaucp
         QUHufkAxTpZd8P/Ye06pvajlAKGP1v5J0QANMwFdcpfchymmnK+80l1u36LNZFsxbOpF
         2WHKGG7ES68eSmys66AHqdyGgtXmc4kA8UvFe5j2X1vJvUGVgkNpM1Vtph2skuyzre48
         vCVA==
X-Forwarded-Encrypted: i=1; AJvYcCULXNABsaYKL2UMb7mDFM6oRPE0qXHduA0dCZ/rihEq4eqKMLgjqcHJtZtmZUlXpLP5r8OZpXJf+2AcTWa/pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQH2Px5dI5apP1bhQnqG+qPABxn+4tV6jycrozsXzw+XY6QjdX
	fcy46iI9fJUHj29r0OgKPt6ntCCbvBcaxioU94J5Vxs+tZHnFy5ZXZbmSABDJoynmevsLMFYboG
	CbQ8BF5frzBo2SfTxHcJ+az2BM23vlpnLKipOuxTLIkjFsKNnXIMpCpi5laJgXbTnDUJ2iBqBAA
	1Fjp+X5T0UqHZDCkX7mBqHVG7Enq2hueB1L9xePvrGBOtK3dI21wk=
X-Gm-Gg: AZuq6aIejH3j8UOyl8r85o2lR7wIG6ZI5WDQG1EVHbK2jkYJvamdVZ5R832WGTcKt3+
	9mQlxhoT38Wc0sD+IQ5Qm5c/wmuVX4LoIBtgQxYi+LcAkEp/N+FrGht1haDTP0TpsbQ4WpTcRhy
	fRXEj64rTYvCDWEKSHlYZ6D4heddXuTrdIbdtjw4sckKqrIssfFnYz3novoDKtm2DESQ==
X-Received: by 2002:a05:690c:6d8b:b0:794:2014:1170 with SMTP id 00721157ae682-7949dec1ecbmr22275087b3.25.1769760762552;
        Fri, 30 Jan 2026 00:12:42 -0800 (PST)
X-Received: by 2002:a05:690c:6d8b:b0:794:2014:1170 with SMTP id
 00721157ae682-7949dec1ecbmr22274867b3.25.1769760762274; Fri, 30 Jan 2026
 00:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-4-eperezma@redhat.com>
 <CACGkMEspErSiv7y5=zHAfJ-G7HVxv5Yr=AA+ttfyxWVVs7Rmmw@mail.gmail.com>
 <CAJaqyWeMuGouepjgVg3Q1nyL04pjJMeVKa6kVZJ-sS_LBBXQXg@mail.gmail.com> <CACGkMEt9YODRPZqstZy8tdNuy66ofz33NfZizhYN-jQsjor4SQ@mail.gmail.com>
In-Reply-To: <CACGkMEt9YODRPZqstZy8tdNuy66ofz33NfZizhYN-jQsjor4SQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 30 Jan 2026 09:12:06 +0100
X-Gm-Features: AZwV_QjSQxqrm05rkZnnhi06PFzid_WMTdxY3p_xcuxfT4kLVA2UF7LbF7DOREE
Message-ID: <CAJaqyWdXqrFUYk_LSM=MNPSbRqt6O6J2=DPm=w3_Ex_m_3EawA@mail.gmail.com>
Subject: Re: [PATCH 3/6] vduse: Add API v2 definition
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TBro4Ml-P83wQQg9Warcx5nxRzZwxroojZfpmcQrrvo_1769760763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jan 29, 2026 at 4:08=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Jan 29, 2026 at 3:00=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Introduce the definition for VDUSE API V2.  This version serves as =
a
> > > > gateway for feature negotiation.
> > > >
> > > > The kernel uses this version to determine if the userspace device
> > > > supports feature flags. Devices that do not explicitly negotiate AP=
I V2
> > > > will be blocked from querying available VDUSE features, ensuring
> > > > backward compatibility.
> > > >
> > > > The next patches implement the new feature incrementally, only enab=
ling
> > > > the VDUSE device to set the V2 API version by the end of the series=
.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  include/uapi/linux/vduse.h | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index 68b4287f9fac..dea89ed281a7 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -14,6 +14,10 @@
> > > >
> > > >  #define VDUSE_API_VERSION_1    1
> > > >
> > > > +/* Features support */
> > > > +
> > > > +#define VDUSE_API_VERSION_2    2
> > >
> > > If we can catch the next release cycle, I would perfer not bumping
> > > VDUSE version twice in the same release.
> > >
> >
> > Following the number of versions that ASID required I don't expect
> > this one to be ready for the next release cycle :).
>
> Then it's probably fine.
>
> >
> > But if you ack the patches related with the vduse features handling,
> > MST is ok with that, and we're still in time to reach linux-next and
> > the next Linux, I can prepare a series where I add the features bits
> > to V1 API. Then, all ASID and VQ_ENABLE will be handled by feature
> > bits. Would that work for both of you?
>
> Maybe you can start with V1 and if we can't catch this release, a
> respin will be needed anyhow.
>

I'm fine with that if you ask it, but if it gets merged (unlikely)
we'll have a few commits with V1 that supports the VDUSE_GET_FEATURES
and others that do not.

