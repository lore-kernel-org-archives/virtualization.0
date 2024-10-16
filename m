Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1E206E9C
	for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077400; cv=none; b=W6OPeXTT2g61kcEFkNj2iIMOg+ybum0iD3LVZBeB7Cps6WBy49gD4rEUcyP1Fz8juxJdopcYolUSmC7z+Y8oD+QZVI4vhT0BGoGfLcn1W5FfdCWiTN62YBm2oZtD1CgsILrlv6AGb7DsxUd1VSk7va6y4z57FUtHycdIZXlf9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077400; c=relaxed/simple;
	bh=ionG4jDjTyVSCbBxsm9pbenqEucVFWILHnagSxWDumc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKPfrat3k4v5kggqsUXd4ZjkCz8+O3n/tT8tE03Jilh9d/VMH4+YjtFqFAnype1xFP1U9Jc0pDQmpGehHYyHBOar0BYa7FCdYaPe2NbrfkWU6D2TIiTrwP8xCmUpkuhdKReiliZM7g4OcHpRielvoJ2gb/nM/JZFUK9cokLED60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGT6X885; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGT6X885"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729077398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ionG4jDjTyVSCbBxsm9pbenqEucVFWILHnagSxWDumc=;
	b=KGT6X885vlCqgee41XjZJ2iLt0jLu6lkA35RzH5hoHlqW4ObkIMA8TT2LeaEpEWeBrtIZd
	JcGi3HHRBlAwA3rWAyqaRKPyrRlGLnNOBqa7rDrfmcKX7IlEvwp2K7oP30Inp+5SKG5XbX
	y5V2adVOBsAkpXPuyYTk8/wCBxZ58u4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-H3an3q3FP2Gjtq411cj4Tw-1; Wed, 16 Oct 2024 07:16:35 -0400
X-MC-Unique: H3an3q3FP2Gjtq411cj4Tw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43152cd2843so3408575e9.3
        for <virtualization@lists.linux.dev>; Wed, 16 Oct 2024 04:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729077394; x=1729682194;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ionG4jDjTyVSCbBxsm9pbenqEucVFWILHnagSxWDumc=;
        b=B6QPED6JFgJQDAkOw5BO7ZjsnzyZ9j6ffmaUJrTfLkR0E1LBRyicq8anvgdK+udMRn
         +zmFOwC7MHAAlGT67lY/1YiOa4c9WyIdQEPnRzq+2SfPEY+t4OWsCwk1aTlNuY91OQvj
         f1QJUuL1Nz3wLBW3l0mnSa9qqxunkEoPA8HWV7UELSDqD7Zc1a9IsxJeLvV004iBn+JG
         3NPEQVEbfBsN9YYFhPLXu1ADOEO1o3o0EiJpn7NuM8xVBLEPLi403XTrpTDxYfBRVBYi
         dX1Q2fjvzck7zMET2HRnt0aKy1wi69HEz2aXITn9DejFXyCPE6Fx8B/6AHIx01TJtD6j
         aGog==
X-Forwarded-Encrypted: i=1; AJvYcCUS1yrcllGb+wDaV222+B8s+xQgxjtM232g54rOl2DO5EaGHqvWzLsL0QHNgXuhC7qa3n+ke6tNe5ZRTYLaog==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZxTWYAXb/152OOysij7iHlAiJkfP4TQeHsl7raXpG2KNCnY3L
	MeF1I0B9PRTbJ3rrngs74sclaAJ4noVOiZvSxTOfx+D6kHwvvMpEzOE8FFxJYcCHgMstgGq/wew
	S1LKPbmoW3UsBgFnExQhoqOoRfoVg7v1yoFgZB7bQrTMQ8rWYZjNqncfGCHPb5D03
X-Received: by 2002:a05:600c:c0d:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-4311ddffb8dmr160143275e9.0.1729077393818;
        Wed, 16 Oct 2024 04:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF6mlruAq+rlftht0xklUty2+K9bi4n84O7QB16BRpDQ0gUnzdPdf71NDf6zOxbjqpZa7ZqQ==
X-Received: by 2002:a05:600c:c0d:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-4311ddffb8dmr160143025e9.0.1729077393411;
        Wed, 16 Oct 2024 04:16:33 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4314f5e2258sm22567745e9.10.2024.10.16.04.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:16:33 -0700 (PDT)
Message-ID: <482d0c45ea2121484a85ed9be6a1863b6d39ac1e.camel@redhat.com>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>, Alvaro Karsz
 <alvaro.karsz@solid-run.com>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Wed, 16 Oct 2024 13:16:32 +0200
In-Reply-To: <2024101627-tacking-foothill-cdf9@gregkh>
References: <20241016072553.8891-2-pstanner@redhat.com>
	 <Zw-CqayFcWzOwci_@smile.fi.intel.com>
	 <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
	 <2024101627-tacking-foothill-cdf9@gregkh>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-10-16 at 12:51 +0200, Greg KH wrote:
> On Wed, Oct 16, 2024 at 11:22:48AM +0200, Philipp Stanner wrote:
> > On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> > > On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
> > > > In psnet_open_pf_bar() and snet_open_vf_bar() a string later
> > > > passed
> > > > to
> > > > pcim_iomap_regions() is placed on the stack. Neither
> > > > pcim_iomap_regions() nor the functions it calls copy that
> > > > string.
> > > >=20
> > > > Should the string later ever be used, this, consequently,
> > > > causes
> > > > undefined behavior since the stack frame will by then have
> > > > disappeared.
> > > >=20
> > > > Fix the bug by allocating the strings on the heap through
> > > > devm_kasprintf().
> > >=20
> > > > ---
> > >=20
> > > I haven't found the reason for resending. Can you elaborate here?
> >=20
> > Impatience ;p
> >=20
> > This is not a v2.
> >=20
> > I mean, it's a bug, easy to fix and merge [and it's blocking my
> > other
> > PCI work, *cough*]. Should contributors wait longer than 8 days
> > until
> > resending in your opinion?
>=20
> 2 weeks is normally the expected response time, but each subsystem
> might
> have other time limites, the documentation should show those that do.

Where do we document that?

Regarding resend intervals, the official guide line is contradictory:
"You should receive comments within a few weeks (typically 2-3)" <->
"Wait for a minimum of one week before resubmitting or pinging
reviewers" <--> "It=E2=80=99s also ok to resend the patch or the patch seri=
es
after a couple of weeks"

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#don-=
t-get-discouraged-or-impatient


We could make the docu more consistent and specify 2 weeks as the
minimum time.

P.


>=20
> While you wait, take the time to review other pending patches for
> that
> maintainer, that will ensure that your patches move to the top as
> they
> will be the only ones remaining.
>=20
> thanks,
>=20
> greg k-h
>=20

