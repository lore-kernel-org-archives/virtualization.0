Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11B221FDC;
	Fri, 15 Aug 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285587; cv=none; b=EZyWvHJFoGLpqb67zrPSjYAyUOlCem0QkFyRORfF5UK4LxOewlGb1LZ2tGIwQSHnimC3RGlyIfrAZP/KzF+bS3QTAoXkMGSIbntdPL0aALG4SOqABeu+KOUs5P8J5wqNMytutY5DA3h4aOq+ojc36iq+TmVYSjg371Aj3MUBOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285587; c=relaxed/simple;
	bh=pXiCzm+cGkXx+xKqrpKYJnHDYNdWeTijnoIkYdYhQrI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bCtPd740FcITMHCxFrQmLPVfz+wP7eRTVDOEuNEigvacvE30GrnAWI3yRyOvVRq8nb0w8NZorEhjASKWn7ZcR+bukQEgMEDI/2xYjgKAKcCW1cgR6ia7LHOygkhMZvwEz8jYIeZ4GEKGiOOJKWicDpmG9PTMRpCcSlCu3DIpVk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=rKas7gaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L1kbUgvz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="rKas7gaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1kbUgvz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F29EF1D00049;
	Fri, 15 Aug 2025 15:19:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 15 Aug 2025 15:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755285584; x=1755371984; bh=d8/wfl64Gq
	soN8QqgVp5ZIQ/AKX+zHKfs+JIayxrK8w=; b=rKas7gaERS/Fk7wQhH99gKIaWY
	5QuGEcwRTG29Ae+d2VfPCB6cEl4+BhTbuTLj57QxOUxPYPdn63cC3CzYR9b37KGx
	CA7dia0p/vvMNziu9bBe99NNbpPGWaBqx2oDCZd3qb0Zbg9DBD2IunC6X1km7lhc
	3juVmysE7gFSPf9RC7PxBG6oEoq333253HEGkCb5v/I2QmZxEwIKUJNGEJVBRFqj
	fT9SruVHN0pyQDtv6VUp6vWG3Uhsx2Z4FKwMqXzBZOJruZwnDM1/D9xTvPPKkFK+
	ecurTnpDaj3xirzaj5NxH+7S6vu50wG7xse+gheDoujXeJFUC/ZRo74zUOTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755285584; x=1755371984; bh=d8/wfl64GqsoN8QqgVp5ZIQ/AKX+zHKfs+J
	IayxrK8w=; b=L1kbUgvzV1s8dDr0a89bZRpkII9xJvo3UjRjCxN/Vq/cxuR6n/6
	yfr5v4Wel313U78mSwXk+pP7fNVP96G6S0XYI3I77ktDLVooiQC17CObhJaTiuaN
	eyiET3MBOSVQVryQb06UtCF0lU1tFy9kB6VuqEn1qhX8c1deDinRyPhhOyb7va85
	Q8Zp7aQLiypODu/+UNnPo7hskxAywoFCBGI9CUphuURbl9iDxZBK9cDkZLIMvMBW
	yoX96dIL0NQXXnx5kpLoA+7v2m9qCXldy6yHCHNNyRPxupXYAPkiEDayqwb+Ib2B
	tOKbPQcuiWy78MHnvf9at7iKujEazQbphqA==
X-ME-Sender: <xms:T4ifaF3XK4L3LjexqRcCiUlWUIWe59Kc9QoLY-hAz4xpsa0Ygp_2hg>
    <xme:T4ifaHx5inMNXHW3hIP2gNKpbPWNAoQvwIcWjv4z4u-EEV72UkmV_X_2bitdCs5dj
    GhnxgbCfSz78uEHUg>
X-ME-Received: <xmr:T4ifaCUj4FHMpk7vwrpizMF7LuOPG7eATPIXDCgmF55zf0w1W9vXvgcUt4FWp-Yj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfggtgesghdtreertd
    dtjeenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheq
    necuggftrfgrthhtvghrnhepjeetudegvefhvdehgeevffffledvgeelhfeggeegleeije
    fhuddttdeiieetuedvnecuffhomhgrihhnpegtrhhoshhvmhdruggvvhdpghhithhhuhgs
    rdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrmhhiuhguughinhhsrghmih
    drmhgurdhkohesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmihdrmhgurdhkohes
    ghhmrghilhdrtghomhdprhgtphhtthhopeiguhgrnhiihhhuoheslhhinhhugidrrghlih
    gsrggsrgdrtghomhdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhl
    ihhnuhigrdguvghvpdhrtghpthhtohepvhhirhhtuhgrlhhiiigrthhiohhnsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepvghpvghrvgiimhgrsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T4ifaL8MPBQ_djeNgoH6NJyP3KjbStWgNsnmol89WYS9n5-RVNXADw>
    <xmx:T4ifaNt-G8yUXfqGZSouuREgv9S0Y8aNE-ZoPwja54bet5t5rqkK6A>
    <xmx:T4ifaD0uUgu_CN6c5REVryemK9CIg5oToUst-VL6Ig2D41RZJc-K2w>
    <xmx:T4ifaKSONvBbkeFVqvMr5AYesC_Ahx3m96ZEA5B2U9-R1B6_y4J08Q>
    <xmx:UIifaOrKn1AIeNqGr5B3CtHT9lI33N8eTnfaB4r9KRtGKLzacjRe9vns>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 15:19:43 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 9568E13E3209; Fri, 15 Aug 2025 21:19:37 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: SamiUddinsami.md.ko@gmail.com
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Sami Uddin <sami.md.ko@gmail.com>,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION] virtio: reject shm region if length is zero
In-Reply-To: <kgasjsq2s4pshravsinycfihdfjhdts5iz2fox42aejs4xqhce@frurksambnk3>
References: <20250511222153.2332-1-sami.md.ko@gmail.com>
 <kgasjsq2s4pshravsinycfihdfjhdts5iz2fox42aejs4xqhce@frurksambnk3>
Date: Fri, 15 Aug 2025 21:19:34 +0200
Message-ID: <87y0rkie9l.fsf@alyssa.is>
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

Alyssa Ross <hi@alyssa.is> writes:

> On Mon, May 12, 2025 at 07:51:53AM +0930, SamiUddinsami.md.ko@gmail.com w=
rote:
>> From: Sami Uddin <sami.md.ko@gmail.com>
>>
>> Prevent usage of shared memory regions where the length is zero,
>> as such configurations are not valid and may lead to unexpected behavior.
>>
>> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
>> ---
>> v3:
>> - Use idiomatic 'if (!region->len)' as suggested by reviewer
>> v2:
>> - Fixed coding style issue: added space after 'if' statement
>>
>>  include/linux/virtio_config.h | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Hi, I'm sorry to be the bearer of bad news, but since this patch my VM
> no longer works.  The system is running wayland-proxy-virtwl[1] inside
> a crosvm[2] VM, using crosvm's virtio-gpu device to do cross-domain
> Wayland forwarding.
>
> Since this change, wayland-proxy-virtwl crashes with the following log
> message:
>
> 	wl-proxy [WARNING]: Error handling client: Unix.Unix_error(Unix.EINVAL, =
"DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB", "")
>
> I'm pretty confused by what this change was supposed to do in the first
> place=E2=80=A6  Looking at how virtio_get_shm_region() is used in
> virtio_gpu_init(), it's called with a pointer to zeroed memory, and then
> the get_shm_region() implementation is supposed to write to the region,
> without ever reading from it as far as I can tell.  Why is the initial
> value of an out parameter being checked at all?  How does this prevent
> using zero-length shared memory regions?
>
> [1]: https://crosvm.dev/
> [2]: https://github.com/talex5/wayland-proxy-virtwl
>
> #regzbot introduced: 206cc44588f72b49ad4d7e21a7472ab2a72a83df

Okay, just found that it's already been reverted:
https://lore.kernel.org/all/20250808072533-mutt-send-email-mst@kernel.org/

Still, I'm confused how this was supposed to fix anything=E2=80=A6

#regzbot fix: Revert "virtio: reject shm region if length is zero"

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaJ+IRgAKCRBbRZGEIw/w
oh9pAQDPCk6HWzF8I2fNk9zUcXGeVxvvqmvCKqW5TYL+3A8VEAD+PXUWJhogMRIS
6vj43WuiwWWcSmD5tWKnr3LuJVszpAA=
=kd4M
-----END PGP SIGNATURE-----
--=-=-=--
