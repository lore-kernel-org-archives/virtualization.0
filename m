Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011741B0F0E
	for <virtualization@lists.linux.dev>; Thu,  5 Dec 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733386796; cv=none; b=UwtSgkwdZV8nkVXAhCsu9Fkp+Uh3VKxxvAMean65/NAnKKNdgYvcvCE4XE8+9aKMZ8v0X5aSySVV1ieGAWXCnzB/IjXiwicnULnkJ74ggKYdDWsCqmDzSvNRnGdZqmrgFztehpnbLy38ii0YDWtXukYDkAuQg3DZWlnaLBlQ7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733386796; c=relaxed/simple;
	bh=COhD/ZuT8JkF6n26GGTr6qS/cP5RQaIaZ/y4LaELE08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5zvZDacyqvmYDQ78qZU9ilrOjbm9ZJp9/kP25sI6nr6VXmgTpqUzfSj48gmDJRBDvo3DSRshQTMAmNZXGttB25cCpf9i6qrq0IWx28rmY4L6lD7GHPmXNxsnDuigJUsRlTkOtS54cm79ktwaxmqIofvFA3X7pUAkMLyuyIaUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecgY+qcD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecgY+qcD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733386793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COhD/ZuT8JkF6n26GGTr6qS/cP5RQaIaZ/y4LaELE08=;
	b=ecgY+qcDyRnvYIb7oi0mRmrPmTCHP4Qdkkd8YQpQkvjxFp9RfrJ0naCPLIaFcAFy4dgNLI
	9ZC+sMeTSDgoXWkiicirMH9bUQv3yYpxa6mZNZY4XAf1KXy5ZCI8gye26dntkwS7B/TGnX
	fWOTNp/sP60TDHtak8M4V2YpDwM65tQ=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-ZSGQfUZvOlauNtreu8E6CA-1; Thu, 05 Dec 2024 03:19:52 -0500
X-MC-Unique: ZSGQfUZvOlauNtreu8E6CA-1
X-Mimecast-MFC-AGG-ID: ZSGQfUZvOlauNtreu8E6CA
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-515e42ed4d4so428799e0c.1
        for <virtualization@lists.linux.dev>; Thu, 05 Dec 2024 00:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733386791; x=1733991591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COhD/ZuT8JkF6n26GGTr6qS/cP5RQaIaZ/y4LaELE08=;
        b=KuNbQaATH5iBdEM5H9bs+BlK6Z8aTHJTnCHIvujO/qqVYZ4fsaJ2eqkrn2svCLeFBc
         qU2DoUEN3La5+vJO/GHoXrxTB3q5JOcPhF4sxWXThtRBAi2k3bTRcoPRurSIFUuEFstf
         DqjEUoI79+h5lWSjZe9wFxsaacgGiuv0bK1EDU5f0X6iErEhGnsM3YBLfyxBVVlII+7D
         zm0uP1XnpDaiODyFoPgevr6yd8l0GO8ywFQ0CM6NmZgeAh2GwdTPOGw1P4nwQmixeYBY
         rl0X6s4/EsMh7rZp9BbfRKKYyt7Vz/jO67Y0CRBbQVczhVl7I2Sv+w9eBjqsM7WeVmIE
         QGtw==
X-Forwarded-Encrypted: i=1; AJvYcCUSS3yH3x46Ey1K8xBA0X01gzNJ2gqVwvlBwePImj13OLYAEL0iilVfbHY8iLAzghIxZBvwXZNvXu8b4Y2zQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGGs1MJJz/dowIEROmrhXbHndnb1qhygycSB5jrhPnxsJp3np1
	rvsCtrdXsgy8Lz44k7k58oGVcPLiunOtdMDZiJSmmpuUkdxANYQ1eMJeV223Mx9mesjGpZv/9O9
	OQPv0rlHeGx9lTfDPFKP+6ilL/HTnv32VhN1HWQzICGPi7MP1ogsLmkRZYYS9XT526Y1DP8vCBk
	O+8Y+JObOUk8+a5QaulKw6N6Dk/rzHMkpZSv+CjgM=
X-Gm-Gg: ASbGncuu2nV2pcKSqnDtAp8TdmSRgl3vszqGZqv/Hkhf1aatnNvnYg/4VjqJK46/uN9
	AGlwhOEVg53fmhJGTiuC8L4mLMnYkbg9b
X-Received: by 2002:a05:6122:630c:20b0:515:d032:796b with SMTP id 71dfb90a1353d-515d0327ab4mr5619190e0c.11.1733386791521;
        Thu, 05 Dec 2024 00:19:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8ksPzBgWu3a6xnG+155/veRqbCvUwgbyQ3qZKr/qLixD3BIzie8/LeFpL1C0WS8PH8/VDNnhGKDBDZ3m049o=
X-Received: by 2002:a05:6122:630c:20b0:515:d032:796b with SMTP id
 71dfb90a1353d-515d0327ab4mr5619178e0c.11.1733386791243; Thu, 05 Dec 2024
 00:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241204153811.126028-1-t.ampelikiotis@virtualopensystems.com> <CAJSP0QXbv-fua7si4mDyO3sR=A2UMWMZC1voXWgrQhbd_zicAA@mail.gmail.com>
In-Reply-To: <CAJSP0QXbv-fua7si4mDyO3sR=A2UMWMZC1voXWgrQhbd_zicAA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 16:19:36 +0800
Message-ID: <CACGkMEuy0opDFZ-F+dcf-Qpw63xFxD5BmR69c-pNZBHHT1U8bg@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH 0/1] Virtio-loopback: a virtio based HAL
 for non-virtualized environments
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: t.ampelikiotis@virtualopensystems.com, virtio-dev@lists.oasis-open.org, 
	anna@virtualopensystems.com, a.rigo@virtualopensystems.com, 
	m.paolino@virtualopensystems.com, s.raho@virtualopensystems.com, 
	chou.kensou@jp.panasonic.com, wminer@linuxfoundation.org, 
	jsmoeller@linuxfoundation.org, virtualization@lists.linux.dev, 
	stefanha@redhat.com, xuanzhuo@linux.alibaba.com, sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fUQcnNXGLmwoIpHT5GslhJ4uwHo_EBcFPIWmRAYNjCY_1733386791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 1:19=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Wed, 4 Dec 2024 at 10:38, <t.ampelikiotis@virtualopensystems.com> wrot=
e:
> >
> > From: Timos Ampelikiotis <t.ampelikiotis@virtualopensystems.com>
> >
> > We would like to share with you an RFC for the Virtio-loopback
> > technology which we have been working on at Virtual Open Systems in
> > the context of the Automotive Grade Linux community (Software defined
> > Vehicles expert group)
> >
> > We previously presented this activity (see [1]) and now we come back
> > to you with latest development and updates.
> >
> > We believe that the technology is more mature today and we would like
> > to assess the community interest in the technology itself and in
> > merging the code.
> >
> > Below we provide a brief description of the technology, recent
> > updates and a short comparison with vDUSE that might be seen as a
> > similar technology.
> >
> > 1. Overview:
> > -------
> >
> > Virtio-loopback is a hardware abstraction layer (HAL) designed for
> > non-virtualized environments based on virtio. The main objective is
> > to enable applications communication with vhost-user devices in a
> > non-virtualized environment.
>
> I don't see anything related to vhost-user in the patch. It seems to
> be a virtio-mmio interface between the kernel driver and userspace?

Yes, it works like a kernel virtio transport. So it can only talk to
kernel drivers.

If this approach turns out to be useful, I would rather make it a new
memory model for VDUSE. (VDUSE is flexible to support more than just
the current iova domain). It would be a converged solution and the
management plane would be reused.

Thanks

>
> Stefan
>

