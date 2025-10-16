Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81C2D3A86
	for <virtualization@lists.linux.dev>; Thu, 16 Oct 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760595973; cv=none; b=VjSs4NlxmPznt898XNUQlnx30474VDXhmtwa4AEO2w0UrWFt+wUpX36BH5eHGFygdeTKTy4hjuz78+lLAzrWOqrdcz8ieCJw2bdKcACSBgAM69gQjS9r7PsnpaOXVLRBr1q9mK1PlXOtRP3UU+HgRta/+oOYRusESqr0pf3tdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760595973; c=relaxed/simple;
	bh=tBqeuunpv84uc8GThElbM0HDnAKxIfwceg7sAyWNTkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcjCgmbizDV2eeQph67ZSdCSUkvnFmuZDCVEhBSlsMxC5KE4kNnCKB+GPPt04r+DJtN7rpwv470Cf9730/a3BUdasOyUMf9nE8gKKdJan5VjNdHIFS9ezD0369QEA6LAyOxr0p7m1zBticpKwr0szB1E9WbgIcE3FQnKgq/Q8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=St6SA3Nz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="St6SA3Nz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760595970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVdo2zgwDSl/oM36KlT5XNFPETliwAnYnfpD1yjprKs=;
	b=St6SA3NzVuN8FU3uuxmMzGFJLZKcJjDtgufIHFGTUpetmTysGBtuup4gSQfjzNZud/Zic2
	SIeaU4/oUD/vAmyQQSFGMXwJCpR1C9wjfw8wiKWrhfY2s8329HSu59Zsyk7RMGbhZR6tma
	xbE1trsOmVhB3YAln/eSnoAlb1dvZ4U=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-oPnHcIiyOfOGCtQaT9QkiA-1; Thu, 16 Oct 2025 02:26:09 -0400
X-MC-Unique: oPnHcIiyOfOGCtQaT9QkiA-1
X-Mimecast-MFC-AGG-ID: oPnHcIiyOfOGCtQaT9QkiA_1760595968
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6352a642093so375417d50.3
        for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 23:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595968; x=1761200768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVdo2zgwDSl/oM36KlT5XNFPETliwAnYnfpD1yjprKs=;
        b=ngEfwxYS4zNh3u5N5KT7+2BHywfYHh0jdGq20+VEEKh6wSUQL/zegM35u8fQSQmKu/
         7yXenRjsuCo71P8oLL5GeVBUDqpEPh6Tar3gx/1BxBG9jaWoZvUSfjprNoB4oFVWbLfv
         THNpIVGTLQYWiWt1KT1GF6Hvy/fVukHwQY2ZcN2rqkqiZpEpVrIDD73CKPTQdZ0Eep/Y
         UuPPJub4quskg9Ma5Mu0ndLaMaM1mW0Iy5wMARzc5fMj7+OLOJc65x6V+55+hk+tAC9T
         BY070A/4HTWqirDkYASPyU96/9Mn7NXtl5Iu8sIZ5EMi71VHB0jxAsw/EUlgK3W6vsY5
         i++w==
X-Forwarded-Encrypted: i=1; AJvYcCVmkHaXQLs3FQdYXW3TXlHfyTbxeneoPYqL9baobxBHy+bW3GvglPrzCbbvLbwskZrPrXx1wo8xHnFcilrQGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUb0ORojjsU7+A/HO9afsOd+j6f0X85BnyDWpmE3isboAQw16M
	ibKfN5LrYZ2dyQQLsktXcPxJxE/BKWw0NEsHGyhNYeiZ9ULBSh50VtzjT/t1amNQDXAvESJKreV
	W1bSqn0uGXSRe7yyHuy8JVdt9ftDdVf5IoTtTodxJ6Qa8/gk9XqQo2bQ9aHT8KEUwbSqJ/nBv79
	ei90cufH79Lx9nhdXyHzKBPAZ5m/Kf/MnVy4jJ0uMMK8A=
X-Gm-Gg: ASbGncug4msdgVZ13GHvzZDoiqFC5d9X27VPlKYXkkbWgGVohxuHxBfgXu6RbfiGxUO
	y31SvECI8sSpB+23jAcseLv6ifEf+FC+8Km+m5GMbyeSROsM8Ckw43T+4qPBbQoTFHPOQ3BBE2c
	KUD5hHp1zyqkmLbHoAxwvOQX1BaXTI91MPuFRClsCOPJ2tux5gsVMgxWX9dtzfgMQ/DmwzXcghd
	THnEXglac4+AbyuDjUV4Vjvcp9gCAZG4jOoeLv8DSs=
X-Received: by 2002:a05:690c:6c01:b0:737:523a:f7fe with SMTP id 00721157ae682-780e16d5df4mr512147757b3.39.1760595968371;
        Wed, 15 Oct 2025 23:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER2Eg9LZlod/14LY7qz9zEQBt8M239Y70sk1hqZh80LpdNcsYsRxbbCv2GZVkAJvkmUqEJkzVY8fAYBXKrjck=
X-Received: by 2002:a05:690c:6c01:b0:737:523a:f7fe with SMTP id
 00721157ae682-780e16d5df4mr512147467b3.39.1760595968039; Wed, 15 Oct 2025
 23:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251015023020-mutt-send-email-mst@kernel.org>
 <CAJaqyWeiX1Tc77NcYoBbeVfKTeuKHK6hw=n_9Mk4y52k7Djr-g@mail.gmail.com>
 <20251015030313-mutt-send-email-mst@kernel.org> <CAJaqyWfRmhXM8eV+=wMVKgrc8SJ98OTtBCtNDJj8ZRUM5Y9Nmg@mail.gmail.com>
 <CAO55csx2rbjxEZk5K3aKcZ501KY3Zfs8ThEQHFqQ1ZB9RSXECA@mail.gmail.com>
 <20251015040722-mutt-send-email-mst@kernel.org> <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <CACGkMEuPPFLH1YqTx03fV9N=Rx3aYXK0HMUDpZu-CvO1NYRRQA@mail.gmail.com>
 <20251016014328-mutt-send-email-mst@kernel.org> <CACGkMEtXWLicmszjkzOhX8Ta=LdGgsDahRUKDEVzBVG8am5vgg@mail.gmail.com>
 <20251016022131-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251016022131-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Oct 2025 08:25:31 +0200
X-Gm-Features: AS18NWDpoxxEeX_RbTSotXQqwNmYlmaB24Mg7SGk1YWLyaDDf6vzF8g0cVP2pFk
Message-ID: <CAJaqyWe--Hho9EdweqkC-h9=t5vhY0cbAN9uAw=hATpkSMbsEg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Dragos Tatulea DE <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9XG2u1r7DvD76Dis-7-rqmm-VEJ8--bOoJ1QHw0fG6k_1760595968
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > >
> > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > have no effect.
> > > >
> > > > Note that there's a case that multiple commands need to be sent, e.=
g
> > > > set rx mode. And assuming not all the commands are the best effort,
> > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > while.
> > >
> > > Not wait, record. Generate 1st command, after userspace consumed it -
> > > generate and send second command and so on.
> >
> > Right, that's what I asked in another thread, we still need a timeout
> > here.
>
> we do not need a timeout.
>
> > Then I think it would not be too much difference whether it is
> > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > can only advertise NEEDS_RESET since it's a device implementation.
> > VDUSE can not simply break the device as it requires synchronization
> > which is not easy.
> >
> > > But for each bit of data, at most one command has to be sent,
> > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > the latest state.
> >
> > Yes, but I want to know what's best when VDUSE meets userspace timeout.
> >
> > Thanks
>
>
> userspace should manage its own timeouts.
>

Can we just apply the patch 2/2 of this RFC directly and apply the
VDUSE CVQ on top then? What are we missing to do it?

On Thu, Oct 16, 2025 at 8:22=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Oct 16, 2025 at 02:03:57PM +0800, Jason Wang wrote:
> > On Thu, Oct 16, 2025 at 1:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Oct 16, 2025 at 01:39:58PM +0800, Jason Wang wrote:
> > > > > >
> > > > > > Not exactly bufferize, record.  E.g. we do not need to send
> > > > > > 100 messages to enable/disable promisc mode - together they
> > > > > > have no effect.
> > > >
> > > > Note that there's a case that multiple commands need to be sent, e.=
g
> > > > set rx mode. And assuming not all the commands are the best effort,
> > > > kernel VDUSE still needs to wait for the usersapce at least for a
> > > > while.
> > >
> > > Not wait, record. Generate 1st command, after userspace consumed it -
> > > generate and send second command and so on.
> >
> > Right, that's what I asked in another thread, we still need a timeout
> > here.
>
> we do not need a timeout.
>
> > Then I think it would not be too much difference whether it is
> > VDUSE or CVQ that will fail or break the device. Conceptually, VDUSE
> > can only advertise NEEDS_RESET since it's a device implementation.
> > VDUSE can not simply break the device as it requires synchronization
> > which is not easy.
> >
> > > But for each bit of data, at most one command has to be sent,
> > > we do not care if guest tweaked rx mode 3 times, we only care about
> > > the latest state.
> >
> > Yes, but I want to know what's best when VDUSE meets userspace timeout.
> >
> > Thanks
>
>
> userspace should manage its own timeouts.
>
> > >
> > > --
> > > MST
> > >
>

