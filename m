Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B076A31BC8B
	for <virtualization@lists.linux.dev>; Wed, 17 Sep 2025 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108024; cv=none; b=eqOHI+wST2J8tjKLiduX1rYNDpsphVEKm/obtlqoIiRTRPKO/VApxsHcYkRCxzuXbiKNkaLYCFHE1F06zAtuKqW7udbbQHHXIo5AL2gk5sJocg9A6wLUXVk7Bn99yu92AlHnhlmXNyihfEjuULbRnOii+8Ru9I1U3kXXml4f7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108024; c=relaxed/simple;
	bh=h0VcysCMgnBCuK8CgfVaGpw/EFpSY/+neDu8Uq3XuZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RHgEJW8Q/5MeHxIvYB0FGbfi71F5W2m2aXoY5tAKxvdw+y4q4RBkWHaDu2FuJcEFLsefYo7OvZbsLTh3QzA8DAKmkLVChwBOhsqK8Qt103k4QCdLU4aSEGTf8VMuyVbGPxTQumnnSfnUxUmRyktYxw33Jiq9+CN46BXySEhiT/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=Q/TY3Yk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NtwjHzuC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="Q/TY3Yk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NtwjHzuC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AE696EC02C0;
	Wed, 17 Sep 2025 07:20:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 17 Sep 2025 07:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758108019; x=1758194419; bh=h0VcysCMgn
	BCuK8CgfVaGpw/EFpSY/+neDu8Uq3XuZ8=; b=Q/TY3Yk7Ts4L85oP6wfdXFIqAW
	2J/qVn2gB0HltjK3Q4X3zJY3DRPwvT1sp9if6+g5TrbZ2U0pTs8dWWgn/ZhW7GZn
	oss9TsupI+fY8r9qkQJ7ySwA53+KfdN/hq9jf2gNUCW2fs0OJPM4NdgISxFp9sJy
	xECHovwIS5Ami87LRS4ZmT5ur17TLnmbJHq+uv6GHPf8ab2pDsU2Nf/LYMdtn301
	6kV+MCpYw1fKsZ4S9coevslyYpJa/Gfl34YA2BCPpERLi432inSScSFCNTNW8sY0
	QAlJLb0dgx7xdCFYl1+/8riyR09aCYIGv7lOEu08CRXv/yCBXuZd8CFCN8aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758108019; x=1758194419; bh=h0VcysCMgnBCuK8CgfVaGpw/EFpSY/+neDu
	8Uq3XuZ8=; b=NtwjHzuCCnr74vSYwW2r8TUBmZx6YWXBtjDyxLLzfhBLznGt0tr
	QkBBs971Q9UTI4hYQNHlkotz5yvsh3D0y91QOR3Rz128idqpGYeuXpeMCjEBAOyS
	iIAVgzRPNB9mdhSMNRIPOsq6BYhzny876aZlfFeVBbCuZDaGXA2gPujBwws34hI4
	sNPER2rEIYFyoBZVNVnpqKuBnN8FbQc9lvWpxAvDBRHu/iw1ocOJOA0ZMiedMKkQ
	slj2PSXacjGfRxS2u5+IB8RkGLQm0W9fd6HTjVcwBiQSF2zYMQpnVvqYFfEFCQRw
	NUtdLI17SkugHRej1zUr3D79YACBP7TWH8A==
X-ME-Sender: <xms:c5nKaC68kbeoCHKuiUNsyVBBTAQQoKhmAbgd59G5nstPsXW9GYoFKQ>
    <xme:c5nKaHYGmRndCcsDJPvDYGJwxCgsy5-KLzY7fdrfflncBH03I0oErgm1GD9NrgN6h
    wdRCWOitPVAa65iwQ>
X-ME-Received: <xmr:c5nKaH7uXjBC0wXeqve0xfcSDwWwGQmjbxt308kdKEMxURCBzTvTn6yv8Ytvvtoi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihsshgrucft
    ohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepieehtdfgve
    euieffteelkeeivdetjeegueefieefvdeghfdugfdujeekkeekjeefnecuffhomhgrihhn
    pehqvghmuhdrohhrghdpghhithhlrggsrdgtohhmpdhlfihnrdhnvghtnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdr
    ihhspdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsthgvfhgrnhhhrgesghhmrghilhdrtghomhdprhgtphhtthhopehvihhrthhurghlihii
    rghtihhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehsghgrrhiirg
    hrvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhfrghnvghllhhisehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehjghhrohhsshesshhushgvrdgtohhm
X-ME-Proxy: <xmx:c5nKaKB87jf5A50NM4Q8Lh6gEAETXCtLvIoa3iiwyMATGMKg-qKdAQ>
    <xmx:c5nKaNcp_7sNEugwl2KZIfTGKyHM11w_LlYtOrI7yRO6gV1snL_mGg>
    <xmx:c5nKaJJCqaWHnUwJwPt8qaas5i7VFTVepovBHKCiX9DSNGQKDkxniw>
    <xmx:c5nKaI3F6Yx4ZKT9vuGc0OfDGwLrVpwmvW2OA84XZkpOqFvDwOH6hg>
    <xmx:c5nKaIt95TW2Tf1kby17JmzhkwxqeeL1L1AIx0c4hKgXPyPP28gJ7vAc>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 07:20:19 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id EE0171F50C5E; Wed, 17 Sep 2025 13:20:02 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>
Cc: virtualization@lists.linux.dev, Stefano Garzarella
 <sgarzare@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>
Subject: Re: virtio backends in guests
In-Reply-To: <CAJSP0QWV+=+v9Z0wU9qJcdToDKBnWiGKzOVvAsdyTOtES=oFsw@mail.gmail.com>
References: <ff2b81b0-04ba-49b7-8a4e-089f1c875744@suse.com>
 <CAJSP0QWV+=+v9Z0wU9qJcdToDKBnWiGKzOVvAsdyTOtES=oFsw@mail.gmail.com>
Date: Wed, 17 Sep 2025 13:19:57 +0200
Message-ID: <877bxxz5pe.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Sep 16, 2025 at 2:01=E2=80=AFAM J=C3=BCrgen Gro=C3=9F <jgross@sus=
e.com> wrote:
>>
>> Today virtio backends are mostly living on the host. At KVM-Forum 2025
>> Stefano did a presentation [1] in which he mentioned the idea to have
>> virtio devices between a Coco guest and the associated SVSM. One problem
>> is to have a simple way to connect the virtio devices' frontends and
>> backends in a simple way.
>>
>> A similar problem is existing when using virtio in a Xen environment:
>> Xen allows to use driver domains, so the backends can live in a mostly
>> unprivileged guest (this guest will probably need access to a physical
>> device like network, though).
>>
>> With Xen it is possible to use Xenstore to communicate the configuration
>> of the virtio device: The Xen toolstack will write the configuration
>> related data to the backend- and frontend-specific paths in Xenstore for
>> the affected guests to pick them up.
>>
>> With SVSM it would be possible to communicate the configuration via
>> SVSM-calls, but I believe we can do better.
>>
>> I believe it would be interesting to add the concept of driver guests
>> to KVM, similar to the driver domains of Xen. This would add another
>> scenario where virtio parameters need to be communicated to guests. Here
>> hotplug (both sides, frontend and backend) needs to be considered, too.
>>
>> With the introduction of a virtio config device most requirements could
>> be satisfied: it could enumerate available virtio devices, return config
>> parameters of a device (backend and frontend side), signal hotplugging of
>> new devices.
>>
>> For the concept of driver guests those guests would need a way to access
>> I/O-buffers of the frontend side. Xen has the concept of grants for this
>> purpose, which is similar to a pv-IOMMU. It would be natural to use the
>> virtio IOMMU device for this purpose under KVM, probably with some exten=
sions
>> for non-static use cases.
>>
>> This is only a rough outline of the general idea. I'd be interested in a=
ny
>> feedback. If there is some interest of this concept, I'd be happy to sta=
rt
>> working on a prototype for driver guests.
>
> Hi J=C3=BCrgen,
> virtio-vhost-user extends vhost-user into the guest, allowing a guest
> to act as a VIRTIO device:
> https://wiki.qemu.org/Features/VirtioVhostUser
>
> I think this solves what you are describing, although vhost-user
> doesn't have an enforcing IOMMU. The device can access any memory that
> was given to it (typically all of guest RAM).

I caught up with Tyler recently, who has done some preliminary work on
limiting which memory is exposed to vhost-user backends, but hasn't had
a chance to take it further so far:

https://gitlab.com/tylerfanelli/qemu/-/tree/vu-mem-isolation
https://wiki.qemu.org/Internships/ProjectIdeas/VhostUserMemoryIsolation

> virtio-vhost-user is not part of the VIRTIO spec or merged in QEMU
> because no one has needed this functionality enough to spend time
> getting it upstream.
>
> Alyssa mentioned a similar use case recently and that the VIRTIO
> message transport that's under development could be part of an
> alternative solution:
> https://lwn.net/ml/all/cover.1753865268.git.viresh.kumar@linaro.org/

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaMqZYAAKCRBbRZGEIw/w
ooQxAQCl9ZofGBnAhX0S8ipYamxvWbC/UtnEVY46ErmGlk6iPAEAqZpaU/O+EaYU
K9HcTnabtLNucdixsKz2RyWQRCcu7Qw=
=c3tW
-----END PGP SIGNATURE-----
--=-=-=--
