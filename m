Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096E32C60
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927230; cv=none; b=sfaAs6lbG4tg+vz1USU1JV6a773NF0IyPJoxVMuzoD35CkOL3BlzRURat2YUVghhJWKYLI+15iH7nxZiidNhsyo59i3LHB1AcKDehYspkEIiunq3aNfHIi/RQJEw9P1kXkTYdA1lY7blK9Co+miumtjgx0S/FYS7P2JiEkzp54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927230; c=relaxed/simple;
	bh=rIvSI2QztdyNfnCwDgEYDf6HC5lzN4Ss9otJr05cGgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjqQs6gQNsoG1mqYGM8IQjmOsF9LwdDKI0ICSeZ4VrJAET6sQ82RLJiBAwrX/h7mcL/4IUHoIGp7xn9ZNp8z4bDEvQOVDbjRpwfiHT5eyp6GwzXrHP36HgzvB4ijHAD4CHAOGQQxtkM8MuF6NgM+Tzq2KmpSpeiuYJ0v0AuaOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2xZeWhj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2xZeWhj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710927227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t0kBDUeIU2tU7V7hAw2d2cR8ZW6aMG/rZwr9VASxfRY=;
	b=M2xZeWhj6HWRB15zdZdXYddNB7/tfzWyr1AWRlYfpcFDeTJ5Pzzjfhv0zsu7p1hr0qa2TJ
	+JcCFCdtSSu9jKp86fxicgN+6s+BRUTRmjrV+9NUz1Jj3pC5MmAsMLURWcxcMMODx9AL/w
	SgvwSRD3uHKlCWsF363U/dky7g+sZig=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-6MrY1etwPiusA10cOjY1ZA-1; Wed, 20 Mar 2024 05:33:45 -0400
X-MC-Unique: 6MrY1etwPiusA10cOjY1ZA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29dfc072e95so3644218a91.3
        for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 02:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710927225; x=1711532025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0kBDUeIU2tU7V7hAw2d2cR8ZW6aMG/rZwr9VASxfRY=;
        b=M4ox7jmMilwlsK5E11BKDUicV6jIcx+55lPEyp2VfmGCYksBVLeSlGnyo5oB8KTCfM
         P627+zM3EabZ9ztwv3ZJ3mL/vqHm5nG5UP/WiodpP2HjM4FtaXNWylWeEcvBVL0RxQ/L
         0u/fZCEygTuSL0RNKL2NpG8p5euwkK/Ec26gKcrZBh+04GR70/kQ/ZFMGuIY/etymIWZ
         tPqAY5q9IY8iSfr5BymKzX6UjAV4NHNwrU5MPiimB3yGzn/K1IQm21r+6jS0+7rCIEJk
         Ca6QioDkdm+opnE80ousQY9YcoDtw1hfHb1ZKOgWaWgKxkwdfmyKEVWVxtSYIZQLmkBY
         mGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/6bHweIkZ/M+5ywuoIZbthO/sWJgulyu+tufGSKUcSw6/zQfrCTgP3QEnjSOwkGCPzZOhrA4aSrqzocl9nyMY3uhtCMc2gNoaB4pC4+M=
X-Gm-Message-State: AOJu0YydwHoiDmax0pLLkMSeN5+ohVzijwGxHjvWwMsSvfFkWDSI4ZPD
	V6I9Af5mQJsi4R7DLa23c2CRC9gBqWo0giPmG4WuIKWX92nbgcdyh6EHX1AdfSyQdIERlDal6tm
	9D0aJzxqCwiGBHOMsSW/kWyve1hLV/fIvlfGJu6NbFM5EHqaqS9NbYZ1DwzB4428QyeJmdIC3JD
	jtrQntit9AnbOYgktHBJBwLiYlGeCC+CsOvCBUIIw=
X-Received: by 2002:a17:90a:8c94:b0:29b:22d2:9dd5 with SMTP id b20-20020a17090a8c9400b0029b22d29dd5mr1349911pjo.38.1710927224742;
        Wed, 20 Mar 2024 02:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIZm4NI4PcqMeB2pAm+rJi2GQMkk6TxHsP6dGGnFR/lCMDpHSQWV3a2utJ8oOtHZLuA9Xc8El1pKEXKRCf56I=
X-Received: by 2002:a17:90a:8c94:b0:29b:22d2:9dd5 with SMTP id
 b20-20020a17090a8c9400b0029b22d29dd5mr1349896pjo.38.1710927224416; Wed, 20
 Mar 2024 02:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+9S74hbTMxckB=HgRiqL6b8ChZMQfJ6-K9y_GQ0ZDiWkev_vA@mail.gmail.com>
 <20240319131207.GB1096131@fedora> <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
In-Reply-To: <CA+9S74jMBbgrxaH2Nit50uDQsHES+e+VHnOXkxnq2TrUFtAQRA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 17:33:33 +0800
Message-ID: <CACGkMEvX2R+wKcH5V45Yd6CkgGhADVbpvfmWsHducN2zCS=OKw@mail.gmail.com>
Subject: Re: REGRESSION: RIP: 0010:skb_release_data+0xb8/0x1e0 in vhost/tun
To: Igor Raits <igor@gooddata.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Stefano Garzarella <sgarzare@redhat.com>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:15=E2=80=AFPM Igor Raits <igor@gooddata.com> wrot=
e:
>
> Hello Stefan,
>
> On Tue, Mar 19, 2024 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Tue, Mar 19, 2024 at 10:00:08AM +0100, Igor Raits wrote:
> > > Hello,
> > >
> > > We have started to observe kernel crashes on 6.7.y kernels (atm we
> > > have hit the issue 5 times on 6.7.5 and 6.7.10). On 6.6.9 where we
> > > have nodes of cluster it looks stable. Please see stacktrace below. I=
f
> > > you need more information please let me know.
> > >
> > > We do not have a consistent reproducer but when we put some bigger
> > > network load on a VM, the hypervisor's kernel crashes.
> > >
> > > Help is much appreciated! We are happy to test any patches.
> >
> > CCing Michael Tsirkin and Jason Wang for vhost_net.
> >
> > >
> > > [62254.167584] stack segment: 0000 [#1] PREEMPT SMP NOPTI
> > > [62254.173450] CPU: 63 PID: 11939 Comm: vhost-11890 Tainted: G
> > >    E      6.7.10-1.gdc.el9.x86_64 #1
> >
> > Are there any patches in this kernel?
>
> Only one, unrelated to this part. Removal of pr_err("EEVDF scheduling
> fail, picking leftmost\n"); line (reported somewhere few months ago
> and it was suggested workaround until proper solution comes).

Btw, a bisection would help as well.

Thanks

