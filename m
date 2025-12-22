Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6181E9B37
	for <virtualization@lists.linux.dev>; Mon, 22 Dec 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393209; cv=none; b=h+6Ekq0nMoWExJ1LFBXa9rVo7Fe+UothayN8iwaqyuGdm8swi3VGsralLIQRPvjBiWcQaspCPVgbQQ01q/5KNHclu/QMxh9mcjtm9DgBCrl4GKmcsAsWzQ+K2+zEIVmHuL9mZ83IkAzgETyeCnCH8fCMy9BapJxxvYvU1OnFapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393209; c=relaxed/simple;
	bh=Io8tBEpGdKSz6svy7jm/kVI4KXjLhnL84ZEb9zsaAa0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Vhl+JEjP4wLdVlqmBcsLBf+7f3ek9sScLXCZcS05Dw0d/393kAuYt5E/4xic+j+fj4oebf0QcZFZPT8ZXDf0nRR6bdj2awaskfVl+nd34KxYx4SHT4UYqdViilcY/Uoo3/xHUCBaFNxXDTxa0RVn2w9JFuofdc68Hi4nV6pyFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LzkqZZzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tHPAD+Ez; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LzkqZZzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tHPAD+Ez"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4013A7A009F;
	Mon, 22 Dec 2025 03:46:46 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 03:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766393206;
	 x=1766479606; bh=Io8tBEpGdKSz6svy7jm/kVI4KXjLhnL84ZEb9zsaAa0=; b=
	LzkqZZzjjTkns+PNoxtxe1nRdBV1aplZEpbTua6x1GbFwzAIdCm8yRm3j7kGJxyt
	ZSr4cYXz3u0cK4D5Ur2hArMVvJFywNn/iHSftVjZOsGSCG7Uyak29ekIl4ZwEwH3
	BTVPSNc4ZZyGLlo/CUG9UkgnBEZqrDxMqqvL42JjSUQT3ae7GHhx5UEGSCjcaxrc
	8nlIxcCnUP7L3j6AANd0KxSPpKNXLauCdkAQCbDjppbwUNtV/JxJnBUENfsoI7zv
	dS/sDekSn/rOXDAlJvm3+rkvQXzelqGPCfisxRysld/X4nSMC+2fBEhR9n6zrOVg
	cdr+wepUsAsY1dDoqcW9Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766393206; x=
	1766479606; bh=Io8tBEpGdKSz6svy7jm/kVI4KXjLhnL84ZEb9zsaAa0=; b=t
	HPAD+EzRt0X0JWRLhNqgI8onRyvUQnj5QEUuZJpIrfEPmYEeeHkbUh5/+m0zxw1c
	iVviDrq3RQHXJoGOry07Q26mbOw+8EDm8wIubt8/i9/h4xS5/b0dmFdRgXMIaDSK
	U6c421ebNsPFI2p/sDkIphIZ+uwiCezgwEplZc3VnJ8syMvHKzmKCyPRzms8A7uJ
	ycRp8CwhGP8vWQOUKV+gVPOv7Pm6/VkpE/mDd/ClJq5RZ9GMIq8qQlgmmfSqrh20
	1gfSbIId5V5uBIPJHkAERLIOA2WQkeq/neXi/gfulucgr7szpL9APkiGjdn1Xeqc
	hPWr8tLeiuwW2HTH7EIUQ==
X-ME-Sender: <xms:dQVJaepdwbxuHgVUfVjPVk7RMVgPiiS9w1sZ6dPvv24N6C11icF1ow>
    <xme:dQVJaXcM_HPN11vZx9Hu9j6mmiQ6EkXEB7UXpqT_YOHaGHk3MuIKnGivd0DWYDaEa
    330_r2Q6uTHjFv4XQ9v8RxaiE3yF1hx2AFoFYdxHAcLJNKgbnkTCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtohepgihurghniihhuhhosehlihhnuhigrdgrlhhisggrsggrrdgt
    ohhmpdhrtghpthhtohepvhhirhhtuhgrlhhiiigrthhiohhnsehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepvghpvghrvgiimhgrsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhsth
    esrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dQVJaZsVDSP9IBBx1Icj_3IZyQeG59ICxwPEkITlUJT4ExaKkaEpFw>
    <xmx:dQVJaRhwSJG4LIEQJ8bJgn4Jup6xOSC_cnRF1DWljpXwQbuWaGJFFg>
    <xmx:dQVJaS8IOqpVeEQca2GMKkORP4kZii9zlqRaUeJagHDrx84kZhQ6kA>
    <xmx:dQVJacvTTGCatFEKwyiX_M1j-lHL_z9NizIFqnTYgvr9pGLuoGvKBQ>
    <xmx:dgVJaZtmM1OK1SZBvuXtvUL4-AkIE4gxRl78qDz8zgqrp7zxMOVLvznW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3C53EC40054; Mon, 22 Dec 2025 03:46:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A5qS1Z43B0Sg
Date: Mon, 22 Dec 2025 09:46:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <24d6eb84-acce-4316-a650-52e30cb3f5f1@app.fastmail.com>
In-Reply-To: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
References: <20251222-uapi-virtio-v1-1-29390f87bcad@linutronix.de>
Subject: Re: [PATCH] virtio: uapi: avoid usage of libc types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025, at 09:00, Thomas Wei=C3=9Fschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
>
> On Linux 'unsigned long' works as a replacement for 'uintptr_t' and do=
es
> not depend on libc.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
