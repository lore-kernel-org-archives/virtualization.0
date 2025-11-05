Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7F26B95B
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333410; cv=none; b=bY79yHd1k/pNam9h70tGeymhiyLGc1sKBILR0esaMt8BzN9v69KsQQBaDQkutY7PpzKstURf8N8c9fqVBO8FH8QEQ48j0BQaWC0OTLfmJI/sp+95Y+5xivbe8g/7VEH2wJLD3LGTZ90skfT5bX9utk6PTkQ4fGHrYtqlvWpOt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333410; c=relaxed/simple;
	bh=7Zg7klTggaE2eo70HRPP2YBG1uUkbzJOxLKYewFYTmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CuJekBcVNqO7cNDtGLo0JakFe05Ppodeodo6StatptBIW93S2FNWF+I+nyaMVUPjEuqZldlkeMm9ZMaqud7GTpKyRLKJaci351hcn1dsj5xMhvIANzZA1ttZzpjoi6T3FmthE4Z2L2OixrdW6r2AdMW15ghlXwU2I4kShZdu1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/xRzeRe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/xRzeRe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762333408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Zg7klTggaE2eo70HRPP2YBG1uUkbzJOxLKYewFYTmk=;
	b=g/xRzeRehRG3TymRtZNkNp+3BqyC4vTLUTbeowzVzC0QgCNRZddK36edVAOnSjFO8Aljhc
	ihTgQ99HwgVIbFdmkAHUemMVb+HdkKbtJK4Cm+Aatw5gIA2IK+6BrmKRXwVI6j3UJ5Budf
	E8TVW2K7XBCpetBy2pD0icoh/qo0y64=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-LrGgwTGhMveT3l-evbTM4Q-1; Wed, 05 Nov 2025 04:03:26 -0500
X-MC-Unique: LrGgwTGhMveT3l-evbTM4Q-1
X-Mimecast-MFC-AGG-ID: LrGgwTGhMveT3l-evbTM4Q_1762333406
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7849f565200so110784497b3.0
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 01:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333406; x=1762938206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zg7klTggaE2eo70HRPP2YBG1uUkbzJOxLKYewFYTmk=;
        b=YHOs1s6Jbyvv+Bue3MpDKzRiJ2PPAoPngUT+0Of67YtPa+7UYUjc8+mAGPduLANeLv
         NuRmG28TlDYrvcqfoGr6rcIqYNpWOB8tswyA/9IVqsMYYORqYZB7RDHsAdI4L5/qkB9E
         JhWBOwZ4XuREaOo287PmqLgM6I6PA45yYCjCjXuPDCvk5hicxEdMsVkQ2sWNjdUQnETW
         tk26koMt6rWBAmzqaQfevI9KswEyZxuzwF/m6x08yNjPE4qsprv5X8/2q2wlwxMQbqmw
         NQRHJsYU0LW5ABAzsJm0+HkUlk7Fu65Y77NDNiKsZSs2/2TCBVdPjwgNn53hyCpreMiX
         zEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcadaAHpdbr5sa9AP7ncSsquruVtZV7dks5pC6J3A+xWSdL4k+c8Q3lKWCWmfqVJs3LrMuedH163yAKnQC/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmHJC9DH1BLze0+TLrwA5IGCjOWx80b3bBLtmzspTojmpH0bcN
	aNs1TZUVKoVK0lfopW5hM5gNazD9WzEx9gUOybWXNB3+lQA2ZVZT/111qvskjS1L+I21h1QJNhT
	hZS3EOThdQADNm8MBaD9doV3TRwIZqkk2zXqwG52aW0VkK5pCLPlRBH/gbeaBwgKdbdFBWCW6Vn
	UHos43dDs4XFhHjPS12vh/WpTe56Lefzn3CTAmmgV3jfSpDDgkT5A=
X-Gm-Gg: ASbGnctogCHnsuD3Mn76FOOxF33/2KmYSPK5KB0OtlfqRtq14KcjeJj2vtaDAs7j2Li
	rUIwN1Q7Xl6Tam1LodOzuLksI9A+nzMmuFgwd9MO3bpiMXsRrfPqmyd/XXpSR9hlUohm0EU+cKq
	oTLuO4zx3y308YKT6ioqqpxJMvwvBu+fAKTzJAplPP+vt+rCKDvNyMW3mR
X-Received: by 2002:a05:690c:4a83:b0:786:25e9:387c with SMTP id 00721157ae682-786a4122ff7mr20366947b3.20.1762333405599;
        Wed, 05 Nov 2025 01:03:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEilkswvviU63NttoK9MAtDFSXL1klsWKg3ry/D6U8PAbuievzJBvc9ooYm/cnkzdsbMNWKMgQJMe+NxJKm6VE=
X-Received: by 2002:a05:690c:4a83:b0:786:25e9:387c with SMTP id
 00721157ae682-786a4122ff7mr20366677b3.20.1762333405163; Wed, 05 Nov 2025
 01:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
In-Reply-To: <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 5 Nov 2025 10:02:48 +0100
X-Gm-Features: AWmQ_bkDV3_RqhR4tpzBJK2B9JtMwFO734bGByXhsKE9cCp88mfSiZ6NtU5azgc
Message-ID: <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7WOhGcJFEzXbJ70nX6bEfZyifCBS_7gxheBcByKXvtc_1762333406
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:57=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin wrot=
e:
> > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > Let me switch to MQ as I think it illustrates the point bette=
r.
> > > > > > >
> > > > > > > IIUC the workflow:
> > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ_PAI=
RS_SET 1
> > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > >
> > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command at th=
is point,
> > > > > > > so it potentially uses the second rx queue. But, by the stand=
ard:
> > > > > > >
> > > > > > > The device MUST NOT queue packets on receive queues greater t=
han
> > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ_VQ_=
PAIRS_SET
> > > > > > > command in a used buffer.
> > > > > > >
> > > > > > > So the driver does not expect rx buffers on that queue at all=
. From
> > > > > > > the driver's POV, the device is invalid, and it could mark it=
 as
> > > > > > > broken.
> > > > > >
> > > > > > ok intresting. Note that if userspace processes vqs it should p=
rocess
> > > > > > cvq too. I don't know what to do in this case yet, I'm going on
> > > > > > vacation, let me ponder this a bit.
> > > > > >
> > > > >
> > > > > Sure.
> > > >
> > > > So let me ask you this, how are you going to handle device reset?
> > > > Same issue, it seems to me.
> > > >
> > >
> > > Well my proposal is to mark it as broken so it needs to be reset
> > > manually.
> >
> >
> > Heh but guest assumes after reset device does not poke at guest
> > memory, and will free up and reuse that memory.
> > If userspace still pokes at it -> plus plus ungood.
> >
>
> I don't get this part. Once the device is reset, the device should not
> poke at guest memory (unless it is malicious or similar). Why would it
> do it?

Friendly ping.

