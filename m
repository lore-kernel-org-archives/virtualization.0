Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5986129ACCE;
	Sat, 16 Aug 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755342345; cv=none; b=tGj/9/MOpi2b4jjsCIkYArRRpf+XlxFHqG1E8pW+P5dG5R+TFiB+MTENTS0kBOU85OAE/9TqHsf9WhukPkrDfCyVhZVN/DL0d0zgCgKhem2AEVXCLtqu+lM20hIiEygUlDoyyulDRHJp/h640bR/cGqO3b44WXH9ZHVcTMXuK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755342345; c=relaxed/simple;
	bh=/Xr/7+XDj+4rgaBJNMQKcJXTzT1LWyASSqvqAtphER8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SkvKrHRTqD4L1k679wr/A7LKeWN0gCVriJTCEPsjrNQpTzRoJVa57TZvsOdSMsHCIR7hVUeC7v+sgL3xABi3A+cNPxLr3VZejEyWCSvFNCq8DchJVLTvGodudizFfL0alFB3UOArXxYr+26YhmPA5ktYRXksAYpSYMT1vAZ/sfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=FQJRsQkq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cP/EA5be; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="FQJRsQkq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cP/EA5be"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 4F3F8EC00BE;
	Sat, 16 Aug 2025 07:05:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 16 Aug 2025 07:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755342341; x=1755428741; bh=eoQIGU9yvG
	8i+AvNZIEoFY+QHKc+7oPWWb3n/JwcGJQ=; b=FQJRsQkqF+1nnUajQYxRH7lYp0
	PlO9qi6iJwhoEspfyt8iE84Tgaj1A94qZe4+B2S9i1grYfrwhlJa3gdjDOze/HhP
	O3k35gxGwgFfm/Hc5OSEijg/nB3fDDRTxf+2Bt2IbgTUG83AYB3NGjnx7eg3YLOg
	4NIofvJexoEL0KMRKyOomrzlOnlGo8gvXJ5f2bBsEBzUG8T7M74QhFWDdpbvD1nM
	9ZukORhLzP4D1wEPOHDrt3Yfb5HMhfTfF3PAx6mwAGEVvNBCJFYmwBtKO63kuZ3V
	VQGfTrCbOqjwlaV9kM7BFjFUN9YpSUXjbLWMdxcOg7Plsz2ZnD3X99GONIGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755342341; x=1755428741; bh=eoQIGU9yvG8i+AvNZIEoFY+QHKc+7oPWWb3
	n/JwcGJQ=; b=cP/EA5be/9ehUZx7r0APnfatWtPuu/PmJCdQxWOGHzjo5H3KNq6
	2TVS7SyT2cpm07RjsXhMLj6NGHOyhmSmoiApQgnp78fFkFrsesV20gCXiocBqf6O
	9Z97rfRKh5QK1CNAx5PZ6NeUPJ9GNfJlq8FhxXmATG8eaOm6ceC1g+jyl5beha2/
	39kuoR7jz/it/nmIe284U+IpPtjV6/Cs7C/mTijgpyhqHFDGYzkx+S9Uq+WC8Qnb
	rC06mSZ3pIrkS5G+zMYcdyKg21Vz1TU12C8nx5Y1ND4X4KGlKu98hinH+7QPwZnr
	EFhyBcUHLX9hrG69ObxVoTplqFYNk+GgpwQ==
X-ME-Sender: <xms:BGagaOC46lm7hgrYXOSBmW8fWyV6CVFyBzo5sarcOC8UC5LjUMgV0A>
    <xme:BGagaEMwME03leEk1ldyN-sa2521H3kTGWbTtX9l00iCgmD6-1vBpUN2NuUAPp4m2
    gi9zfVSWAkcp4C_eQ>
X-ME-Received: <xmr:BGagaOC_GfEC9mCDmyzAXwCc7W8dqgiCp8OeMIXxLIRdHgU1CZO7aeTWDqJ_SeoJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeiieelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BGagaF7K90hJoxwyYV-pOM4y4H-wEHH1aZ57SDqhk1LINdTTpG5YWg>
    <xmx:BGagaI4V_JxLB52z_asyXklSoFv2_czc7f0nJaXK17aUj2ckEZWkSA>
    <xmx:BGagaHQqW-mV8-rMPObgfQb3OSFcKaWDOukxBGeHdDGYAErWdwJj5A>
    <xmx:BGagaA9cV8GXkE7rj1PSl1JNXY4-S-U-FOzMnDYY65xkZPKut74DyA>
    <xmx:BWagaBlHvLeVUNaFZgiDjjA_3O0ysPa-aMUiy9_DEKod5LjXtHNESbu0>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Aug 2025 07:05:40 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id E4A6414025C2; Sat, 16 Aug 2025 13:05:33 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: SamiUddinsami.md.ko@gmail.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Sami Uddin
 <sami.md.ko@gmail.com>, regressions@lists.linux.dev
Subject: Re: [REGRESSION] virtio: reject shm region if length is zero
In-Reply-To: <20250816063522-mutt-send-email-mst@kernel.org>
References: <20250511222153.2332-1-sami.md.ko@gmail.com>
 <kgasjsq2s4pshravsinycfihdfjhdts5iz2fox42aejs4xqhce@frurksambnk3>
 <87y0rkie9l.fsf@alyssa.is> <20250816063522-mutt-send-email-mst@kernel.org>
Date: Sat, 16 Aug 2025 13:05:21 +0200
Message-ID: <878qjj8r2m.fsf@alyssa.is>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Fri, Aug 15, 2025 at 09:19:34PM +0200, Alyssa Ross wrote:
>> Alyssa Ross <hi@alyssa.is> writes:
>>=20
>> > On Mon, May 12, 2025 at 07:51:53AM +0930, SamiUddinsami.md.ko@gmail.co=
m wrote:
>> >> From: Sami Uddin <sami.md.ko@gmail.com>
>> >>
>> >> Prevent usage of shared memory regions where the length is zero,
>> >> as such configurations are not valid and may lead to unexpected behav=
ior.
>> >>
>> >> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
>> >> ---
>> >> v3:
>> >> - Use idiomatic 'if (!region->len)' as suggested by reviewer
>> >> v2:
>> >> - Fixed coding style issue: added space after 'if' statement
>> >>
>> >>  include/linux/virtio_config.h | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >
>> > Hi, I'm sorry to be the bearer of bad news, but since this patch my VM
>> > no longer works.  The system is running wayland-proxy-virtwl[1] inside
>> > a crosvm[2] VM, using crosvm's virtio-gpu device to do cross-domain
>> > Wayland forwarding.
>> >
>> > Since this change, wayland-proxy-virtwl crashes with the following log
>> > message:
>> >
>> > 	wl-proxy [WARNING]: Error handling client: Unix.Unix_error(Unix.EINVA=
L, "DRM_IOCTL_VIRTGPU_RESOURCE_CREATE_BLOB", "")
>> >
>> > I'm pretty confused by what this change was supposed to do in the first
>> > place=E2=80=A6  Looking at how virtio_get_shm_region() is used in
>> > virtio_gpu_init(), it's called with a pointer to zeroed memory, and th=
en
>> > the get_shm_region() implementation is supposed to write to the region,
>> > without ever reading from it as far as I can tell.  Why is the initial
>> > value of an out parameter being checked at all?  How does this prevent
>> > using zero-length shared memory regions?
>> >
>> > [1]: https://crosvm.dev/
>> > [2]: https://github.com/talex5/wayland-proxy-virtwl
>> >
>> > #regzbot introduced: 206cc44588f72b49ad4d7e21a7472ab2a72a83df
>>=20
>> Okay, just found that it's already been reverted:
>> https://lore.kernel.org/all/20250808072533-mutt-send-email-mst@kernel.or=
g/
>>=20
>> Still, I'm confused how this was supposed to fix anything=E2=80=A6
>>=20
>> #regzbot fix: Revert "virtio: reject shm region if length is zero"
>
>
>
> Are you asking why was the patch applied in the 1st place?
> It seemed like an invalid behaviour to me, and I thought it's
> not too late to block it so we don't need to support it
> down the road.

So you just weren't aware during the review that it's an output
parameter rather than an input?  Should the parameter maybe be renamed
or something to make that more obvious?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRV/neXydHjZma5XLJbRZGEIw/wogUCaKBl8QAKCRBbRZGEIw/w
onvaAP46XV37Gzix67SqACor2g971Hpr2vz0/OP+0qpre+cGDQD/cgQQxms1GDD1
rBMc+tC4sKjF8OuS1+aR1BKBa/MCyAg=
=UddE
-----END PGP SIGNATURE-----
--=-=-=--
