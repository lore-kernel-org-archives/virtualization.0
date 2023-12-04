Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0229DF56
	for <virtualization@lists.linux.dev>; Mon,  4 Dec 2023 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFePe9Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6551C433C7;
	Mon,  4 Dec 2023 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701679454;
	bh=xpgPzulNevCUlsiFp2dMGa9+E23juK/4xiRXU8jbrZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFePe9RdWDFr3EKCrhfUl0e058tQhYJziFpa8yaN3dgBfmjplJZ9qi0/Tc+rwjCLP
	 rEMOyKPmOgH8KFEs2421n+fT4vOuF41M7oRIU8vr6XFrytPfdiLcZ3YKhgTePVfkvG
	 m7vl5fPtC7j9bqtyHRTQjPJhegtSoLtfVpIucaZO9K6cwPvZD0VT6/b3P13SnH3pfs
	 Hs6S4AHl1bumAZBkKWc4nelEpqMCgoqkdVxZGoMQBw90+d1KPfFGT1BpTzNUBwWEs2
	 WgoRgUNI9F/fMMuzLJ7dzaS/PDFiPMwqCcpKxHOoRLjvpkD37lYNIoNGhB44JA1ku3
	 nr8tAJJzWi+UA==
Date: Mon, 4 Dec 2023 09:44:11 +0100
From: mripard <mripard@kernel.org>
To: =?utf-8?B?5L2V5pWP57qi?= <heminhong@kylinos.cn>
Cc: airlied <airlied@redhat.com>, kraxel <kraxel@redhat.com>, 
	"maarten.lankhorst" <maarten.lankhorst@linux.intel.com>, tzimmermann <tzimmermann@suse.de>, airlied <airlied@gmail.com>, 
	daniel <daniel@ffwll.ch>, virtualization <virtualization@lists.linux.dev>, 
	spice-devel <spice-devel@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Friendly ping. I think this patch was =?utf-8?Q?forgotten=2E?=
 =?utf-8?B?Ly/lm57lpI06?= [PATCH] drm/qxl: remove unused declaration
Message-ID: <kk4xtz2zxe37ner7cl5qvlk6jhciu7hgvpltf7gddphepnxqwg@noe3lrmff3ax>
References: <1290mcwo8vf-129368jicj0@nsmail7.0.0--kylin--1>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mrjqp5qcdvleulqp"
Content-Disposition: inline
In-Reply-To: <1290mcwo8vf-129368jicj0@nsmail7.0.0--kylin--1>


--mrjqp5qcdvleulqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks for the reminder

--mrjqp5qcdvleulqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZW2RWwAKCRDj7w1vZxhR
xTKFAQClXxO9sDpuh6JQFW2Xg1PnWk1Pz9aynBWEXekfGLIqLgEAh0s5I+A5LU+X
+S+NsqIYz+28V3nfD/itBaG2c2ON8ws=
=wUoA
-----END PGP SIGNATURE-----

--mrjqp5qcdvleulqp--
