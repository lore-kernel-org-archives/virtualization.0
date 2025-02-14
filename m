Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B45267700;
	Fri, 14 Feb 2025 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552144; cv=none; b=aaVLlpdEnXA3SSBYjreccMGZCIn9UfOK4kjcQljh+3TwJnPkXzXqPei4YhAoG9kBde9tKK7MHZuoH6WNIFY1GCFeJXqc4iyzeZRCcYOj9Wge2rsEVWTzjs0JqpKz8YMstRytZ1HRdm831r6PtaU2loL0XLyFHFsDqasc6z2h2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552144; c=relaxed/simple;
	bh=VAjnJKsH78yNOyUdTaah0rZDzzTfTb0qzpH9n4vpm+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddavVd1IwUZr+R+8RiPPKW6pwC438EcgygmHJi2q6tfKPT4E/G9Dkc+jtnSwqJSBLsNhmo8FEqwkaEgCYUHOzgQlvhQ1Qg6UEHpYHar1h0imRrIlRMyPmNqZfskp7Metun/C3Yk+fe4pAZFAiclXWajKlrPVN7BVEYs6PCKc1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRAEUDGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRAEUDGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263A5C4CED1;
	Fri, 14 Feb 2025 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739552144;
	bh=VAjnJKsH78yNOyUdTaah0rZDzzTfTb0qzpH9n4vpm+k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nRAEUDGMx0dcWj6jvJx2JeHzcERTLWVczHJfSaLlz7OVZ6KcXnbASrnBf0PZy6cKs
	 a6Rd2a7MxctHXAOG3+O2jhLl3CY3QzuSwt0em+qfT2kIMeAnAhWeuzm7ryUFE1ixYN
	 EF469VokPMMTTURY+dqhazQL4f/yMo6074Q34E67duR6IMgBdZObVTRlMtP/4gJALO
	 Q+GAJmuG+Ju5dzCxfyFZ4Bi2Air8cCubZEQEQiXtKF6taTrt0Ggn0mN00u5BfZKQGF
	 LEV3/5xuPcPmgk1VsubVsgbg8iXqoDS2ZzKGTrr67cObXiuwvFvpt4n46BCHrK4Mpg
	 2264TsTl9JXfQ==
Message-ID: <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
From: Amit Shah <amit@kernel.org>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 17:55:41 +0100
In-Reply-To: <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
	 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
	 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
	 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
	 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
	 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
	 <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2025-02-14 at 17:52 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Amit,
>=20
> On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> > I'm thinking of the two combinations of interest: REMOTEPROC=3Dm,
> > VIRTIO_CONSOLE can be y or m.=C2=A0 Say virtcons_probe() happens when
> > the
> > remoteproc module isn't yet loaded.=C2=A0 Even after later loading
> > remoteproc, virtio console won't do anything interesting with
> > remoteproc.
>=20
> Where does the interesting thing happen if remoteproc is already
> loaded
> at that time? I'm not seeing anything interesting in that case either
> ...

The code I pointed to,

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/char/virtio_console.c#n1993

either enables remoteproc if the module is present; or it enables
multiport, but not both at the same time.  If remoteproc isn't present
when this probe routine is executed, multiport might get enabled.  And
then there's no chance for remoteproc to get enabled.

		Amit
