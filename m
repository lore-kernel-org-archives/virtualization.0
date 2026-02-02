Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192C36405A
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033567; cv=none; b=BFT50m+Yy182SnbY2l1AeAocYp2Do3wJWtvfzLTI23FyEkLJNNc17vleU3xo7Fr0LWBcc5Y0hBGwAMrST6yfjFg4ybV6cqwnDSaOdJL/MOWW6UkjpFQfXKSiXJKu8eewBD0IcenoTtMERMrudkjHkbQV/vKXTEAFklJtKMo5PG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033567; c=relaxed/simple;
	bh=vxYNRipBxaKwtbFmhkj+mekbUmi1WEmQVZRyUoYVdxk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FJDywUJRjJhC1l/Kq3fFSTnqumVt24Wdu30eGMVSg6iQuWKLUlx0Z+ZTQ17c/4MiLn16gkmf11K9X98eysj/AKJvKyXQHNo2/HTuS7Ak0r4ScotFZ1qiI6YOewBtO8MlFvy73MJjepFk3XhilNoWOtZ8C3sZC8JAxrRWpElSLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WxcCwLED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MjF3HaRs; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WxcCwLED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MjF3HaRs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8B8D7A0050;
	Mon,  2 Feb 2026 06:59:24 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 06:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770033564;
	 x=1770119964; bh=+8/aPPa8ckR/dm4aXjAGrPuaGuLKvM8Lr0Fvv7oJ2aA=; b=
	WxcCwLEDMbYtyGiUCzJwkbYSDCxJUh8rXV34q8JpW8FPja+PV7DjFugr0CKITJNo
	SVrDKzPrVheBLyF2VUTa1Rte5koY5Rk9H2CE/KEGQvVFFoGdURSKBuHJferYV0MW
	P2nh489fWlaFNwkv+XUVWHAodpm3vq4Jmzx9XfwLQyawqRyrYUIyJDMp4hhnrKv6
	o9RoVGFSSdd3x4oIzTMNGPLQHox3bMHAL862D68DKDNIH1IapX+lu8ULN9QebR1A
	klIlaNXe2XyDa7GYrNUzOGwTYkPe9gt5+oP5Bvrhtz1wKDR8HInEuDm43ybx3Dc3
	8cK47x6NqegdxHtx0y/j8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770033564; x=
	1770119964; bh=+8/aPPa8ckR/dm4aXjAGrPuaGuLKvM8Lr0Fvv7oJ2aA=; b=M
	jF3HaRsYVJzQ1DeAM1OGCnyNre080TjvZj6lFovRlsYVEntGWZBh3qzXsk8kEOFb
	4M2qsItss7bVmwHmqJmVStzjY6N7qeWLFmXVeFSFnCJwgew+RBKit5/Xm6SOy3mO
	3kxrSqVN9h8ndAlDQkVaYu3xHnWEKCttk8nFLU+c/PAoO5dM/Elb8DA+WSlxJ/1V
	ilupUyUtky8E9vz/koU8NXs5/GA7UFz6gLH6KZur3tvgZhqdcjqO6/qFyFsHxqlD
	iZXoTmpRo64XY/Z3SupJkYKjVgxpLLTEA2Uqt2I1mgo1O0Yt5k8cOsN4y9rY71In
	5uGTrswfnPGXi9O/oy2Yg==
X-ME-Sender: <xms:m5GAaWPcY9JGRsxK1iWUXNo-g6xYjXGsPkH_iEuHQHIH4WNng41vzg>
    <xme:m5GAafybWC1VR55l6KpXX3n6y6VHVOKoXYxd6wW4rQHEJRUgjk_udtcFutxy1oElx
    ejptfjJ4D_-AziZD4eX2oc5r30RN4UbUuZweyijvbXUubr7kC-AhdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeigihgvhihonhhgjhhisegshihtvggurghntggvrdgtohhmpdhrtg
    hpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdr
    rhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopeiguhgrnhiihhhuoheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehvihhrthhurghlihiirght
    ihhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegvphgvrhgviihmrg
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrg
    hrtghordgtrhhivhgvlhhlrghrihesshhushgvrdgtohhm
X-ME-Proxy: <xmx:m5GAacxqYCZOFEbZn90XlId4qpyjwxUIoEeuJA-JF9v_HAHskbu7KQ>
    <xmx:m5GAaYfRghVETS93GfJYbxjZ5ap6fT2pgfxAYAjlcbjgerM8a2sqiA>
    <xmx:m5GAaZ5C4XSaSZiyZQsPjfOBVzA117xPyjyo27_OjWUTfnZ4S32_mQ>
    <xmx:m5GAaVLX4_W0rOS9k4N1hk7ZiGCTVNMX3Mf8h5jmSIapIrAq9MUsag>
    <xmx:nJGAaWPBIUyLR6KMG6dUlHoDZk-3bhimoBRD2djlQb0PmBlZ7R2ZwMMt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CCFEB700065; Mon,  2 Feb 2026 06:59:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Ae52e6Y4Oh4g
Date: Mon, 02 Feb 2026 12:59:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>,
 "Xie Yongji" <xieyongji@bytedance.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com>
In-Reply-To: 
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
References: <20260202095940.1358613-1-arnd@kernel.org>
 <20260202095940.1358613-2-arnd@kernel.org>
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026, at 12:34, Eugenio Perez Martin wrote:
> On Mon, Feb 2, 2026 at 11:07=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> These two ioctls are incompatible on 32-bit x86 userspace, because
>> the data structures are shorter than they are on 64-bit.
>>
>> Add compad handling to the regular ioctl handler to just handle
>> them the same way and ignore the extra padding. This could be
>> done in a separate .compat_ioctl handler, but the main one already
>> handles two versions of VDUSE_IOTLB_GET_FD, so adding a third one
>> fits in rather well.
>>
>
> I'm just learning about the COMPAT_ stuff but does this mean the
> userland app need to call a different ioctl depending if it is
> compiled for 32 bits or 64 bits? I guess it is not the case, but how
> is that handled?

In a definition like

#define VDUSE_IOTLB_GET_FD      _IOWR(VDUSE_BASE, 0x10, struct vduse_iot=
lb_entry)

The resulting integer value encodes sizeof(struct vduse_iotlb_entry)
in some of the bits. Since x86-32 and x86-64 have different
sizes for this particular structure, the command codes are
different for the same macro. The recommendation from=20
Documentation/driver-api/ioctl.rst is to use structures with
a consistent layout across all architectures to avoid that.

The normal way to handle this once it has gone wrong is to split
out the actual handler into a function that takes the kernel
structure, and a .compat_ioctl() handler that copies the
32-bit structure to the stack in the correct format.

Since the v1 structures here are /almost/ compatible aside from
the padding at the end, my patch here takes a shortcut and does
not add a custom .compat_ioctl handler but instead changes
the native version on x86-64 to deal with both layouts.
This does mean that the kernel driver now also accepts the
64-bit layout coming from compat tasks, and the compat layout
coming from 64-bit tasks.

Nothing in userspace changes, as it still just uses the existing
VDUSE_IOTLB_GET_FD macro, and the kernel continues to handle
the native layout as before.

    Arnd
