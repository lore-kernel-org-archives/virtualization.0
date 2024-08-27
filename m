Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85FEAFA
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725854; cv=none; b=NoZcmW4pfVOBpgcioZBjdJP6LcmXB6kUTGSWVey2LyFDq3hA5pPqzKZ7Wj/KrGWQlGVB3JDpRSQdVzVHmmQKnzn5AyKqYj+vsf2YqlP0VrFtLFEQWneSsqOMfoMrMfC4jO/0CjYTGSbwvxM40EE0JvAIjnb3Wy89oT7S4Um2Tac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725854; c=relaxed/simple;
	bh=j2gfBhvI6SQ3n0GzEH5NhxNTsBJJ1nsJPfCghtWRydM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSKaFZF6X3BQ/LsONoiEJTj5B6EvFFXihx4TNydseW1fJG8WAoLBTgH8K5iKezewLDmmCfFA5uMVaB6IVwTrEuD3+4Q+DoGQ5U2QKCYjKnnDOP8ovJsW+Ol/lIVGwGmiFo/2kh2Vc1iAlc34+1lNZayuaYM9MTs57ueO/kY/KI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4w8O3no; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4w8O3no"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9E5F80E78
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:30:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HMJkhueMyD7A for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 02:30:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1614980E75
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1614980E75
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a4w8O3no
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1614980E75
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724725850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2gfBhvI6SQ3n0GzEH5NhxNTsBJJ1nsJPfCghtWRydM=;
	b=a4w8O3noFHJO0zWu6pH/MbwvfzUNHFVBVJo0Hz3fEUReYY72IWZhAQEgnzr0A2P6CSN0ES
	8oiYnLFHlKspi6RUOOqtekLYRkG8o0pGnaTdCiEy22nb6s6Pfxn4TrGJDE8jjQFtZjjXjg
	RW2OT5I4wMEzTDxzkVyuOUONSE/MEpM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-u_HyMwleO8ewe0xocgOU0w-1; Mon, 26 Aug 2024 22:30:49 -0400
X-MC-Unique: u_HyMwleO8ewe0xocgOU0w-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3c008e146so6585419a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724725848; x=1725330648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2gfBhvI6SQ3n0GzEH5NhxNTsBJJ1nsJPfCghtWRydM=;
        b=Q1DvWR/P7blXIYEA2t5/4Ft4lY0Uoe5AYOqd7IYp0qQuJlCmsaoGSiz+FyUBfCDoxZ
         9uHlAEPQ4m2gjchCIyNlS5S1ea/Eav+oAgflekidxtRHTIPZDM6HA7WGOfGc6/YrDqQu
         iJth6ct1Kz8dvxcl5S3KmiJBrtVIRRz2EmvxTHXdxelUbVw23KT0libWXBKKNbJOszoG
         ml/Elyir+uJMuxwknULKUqvuzQFsJjD2kmfgq+1EnyoJAh1kqRvIyjbaeDMq5IXDkUna
         n5Yj25FdCx4Bya9FdGRZsN0ZoC+m4pua/Fb0Dga2kPi/tlP2oOo96dk0zHEJ9Fdw4PHS
         4Y+g==
X-Forwarded-Encrypted: i=1; AJvYcCUbMb7Ap3Vzpk4OzwFEqQmVrdd34zzBrFr1vxw6LtRvqcG5zZlY9jOnlRnF7Z4QWlCfwGau+nOJNkaWmTjOVA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwK3fJyIeIbOFCaq9QLaDolhzBz9g9nTpZxO8XRgD/ADk2eAdis
	V10swwhdwhmEkcXByi16wuZclhhr66Hi4L2cwfz5KKR6B2S4uSWNQDlDA2vo/t5pomRcvAtSPz8
	6fUqU5b/SDLYx9qepm859QB82LrO+THW08b488AOz2n1fTRJM78p3hj3CYdnd6+gdNm9B8ZGSVj
	q/fIuEjHsU/DSpIJK2VCez/p6zvQFUcLZAulq+JR0KcV1dFU5dvbX1iQ==
X-Received: by 2002:a17:90a:c002:b0:2cb:e429:f525 with SMTP id 98e67ed59e1d1-2d646d2bbdfmr12924728a91.33.1724725847748;
        Mon, 26 Aug 2024 19:30:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtxjf7rF0BSgn0bd8C2s21zAHrc0Jh8ekHAzvE0rQf+abJDfKpKe36cKWfv9uNPfnnnYGc4iC+SQa2VVTIMrA=
X-Received: by 2002:a17:90a:c002:b0:2cb:e429:f525 with SMTP id
 98e67ed59e1d1-2d646d2bbdfmr12924704a91.33.1724725847255; Mon, 26 Aug 2024
 19:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org> <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
 <ZswgHTRUR-wstAHf@infradead.org> <CACGkMEu882qAovckSf7ufak9+hfQ9jpLOmrm2TmCJTRGrm2D2A@mail.gmail.com>
In-Reply-To: <CACGkMEu882qAovckSf7ufak9+hfQ9jpLOmrm2TmCJTRGrm2D2A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:30:34 +0800
Message-ID: <CACGkMEsxzwuUiXYKjnACAa0faBE31BfTJq-OeUvdmRELvYJY6Q@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:09=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Aug 26, 2024 at 2:31=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Mon, Aug 26, 2024 at 02:21:52PM +0800, Jason Wang wrote:
> > > > What is the application visible behavior that the API use is the pr=
oxy
> > > > for?
> > >
> > > Vhost used to be created by kthreadd but some recent patches change i=
t
> > > to behave like being froked by the owner. So the various attributes
> > > that interhit from the parent has been changed (scheduling and
> > > namespace etc).
> >
> > Well, if that breaks userspace it needs to be changed to opt into the
> > new behavior rather than requiring a flag to not break the existing
> > applications.
>
> Yes, if I was not wrong, this is something this series tries to reach.
>
> No flag means old behaviour, new flag means new behaviour.

Ok, I see. The series is trying to do the reverse.

We need to fix that.

Thanks

>
> > Assuming the change is intentional to start with.
> >
> >
>
> Thanks

