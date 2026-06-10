Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF63148DD
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110638; cv=none; b=N/41xw6wd7H+g8/TN2jgLj0eBqqV+zKtFG1XEL4N6SKdr50aC65dMiqxscfgErrEWWGTDYbKp+8jfLHaEDqpMngK0GqiSpKi7s3obbLeQlt/U4+QG1TMf9iZ0BWJTbOutBi7CS4+kKzwtBKdTqrE8FkGnSjSsj2i2FR4cXNnBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110638; c=relaxed/simple;
	bh=ZKc/9gHD6AG7EiLzZfBoaV//voVPGhzjPMsLXJoxjhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKYEJrWn4WLfF7E430MigAAisv40eNToJN3Wh9mMLtt11J+i5+qFZg85MqO/AodwbtBIiEPkPuFzYWLzeTnBWliFMIgc/wjNK5aaTf39Tp54tZjiJRD0Pv1d8inpfmLT/Pf5q6mB0qHyFOhjoP9w6ZVG9pv9/AplyaGBB1rdLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=J3dlYdkr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="J3dlYdkr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so58086175e9.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781110636; x=1781715436; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKc/9gHD6AG7EiLzZfBoaV//voVPGhzjPMsLXJoxjhg=;
        b=J3dlYdkrsfpb3v+uepi/MPaw8o8iaOCZdG2n5D3wSqjc7OTXgsF2CkyumUEkaiAnAq
         cSaNRDTL+Vxhm74GybSt2OJGQBEz6TRczSF5pU7iCtK2qhbvr11SK53sqE0UpBit4ZK4
         DN/xEi7z5NQeW5PiWJigJbQR+wWbJsjNNSk7M3rAaIUDYUQQquhwnKgvJk6j52KrLh8X
         BI3kaFNC5RY73C9izg3z5ed4sRXjRp6GZs1igxjW/NRmy6Octih353ZO3nAVASX8bTtH
         llv3smUdIjNDdsHZF0uHUhuoXWXgrKD8heDjr/am4PocqVAVAt0HpfacOSGmNcqRCB0j
         fUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781110636; x=1781715436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKc/9gHD6AG7EiLzZfBoaV//voVPGhzjPMsLXJoxjhg=;
        b=PvgntLjhpqqNRalyE2YDvaJTKjrClpAadli/5r13ocG4hRtsYphL0HcpnSgZyoXJOd
         f6Ey5KFApr5CvjtYM5kCp+KOoYmbnXGp3Q5JUY6uGJciENSmXI0ijsFLgeET+4L3NDP6
         ra7b+t9PA1AavifbLYIIQnNPLPeto5SKPvCnw7zHIlgIP1Ptdxa0Oab/M9FXFT79aS3c
         loQOFoZ+OJk22I95HcibVoW8ysCuzRv3w2ccfLrCoBroNWK/+zgBXayjTl+iVbeyd0Ue
         zAjWzBjWm8LDltIPt6B1GLae1MvEYnuNWk2pYrcNx7FilnIy5Y7gr2LSJ5+uktRegXZ0
         WkXg==
X-Forwarded-Encrypted: i=1; AFNElJ9LEkRQkdEWMOioVIA9oXnCyEgqsu6W0IaW5OdghV0JS+jLmVDLysfQADL2PLwWAWJas+8ziZozHCy1vF7ANg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1BB8cpiKtmIbtS77rctz+0gWpCILtPR349z67CkqmsvTuiyjW
	R2W95NsxjgbwqYO+cWLs6ZAYxdHn4GKSDjVZ+V3zFhEajgQJFtWXBD78rq8sxrUzsPg=
X-Gm-Gg: Acq92OHldbuT7GBckqx03f+Ki2EuTqHCChpQBwX0dPs/FzBqdVVH7L/7EJJ4D0akfWu
	Ol/OrWOMQPkWOfGQ5iuyWfqJRDGgZesaux1wSltz7wSJxl8Zch6h1WYck4TBcq7iMHU+v8ph5mE
	n6mZQawk+6W3YD60rz4/Wfk4ivAbHX01Xkr5zIkqsCa331MRBe5uxpP7d7iWbRNtDqI6oiDEXeq
	quMaL3j5FdPHw4F4jvx318tRBgfSXakROtBQQzt2Op/hQ+aSkpioX0OsWozCT9oQcM4NDH6fv42
	rIG1cm0TlAhAMFdfg5IJ+FpKd7mqy9uiQydU8gtvVX5KPhf99k/4eOMrsSStk2Z/mqACOFn9rWs
	tJUjsTFn42xk7uFWk1NniM7U1Vd6Ra0TMrucjZG9E/byXHnWDuaMfBfmRl/3oXfnurg/x/+YrvH
	5CCZwXCOAIKhE/Y45yo9oAnmS7m2SEVIFOKfbi3YQLheZNmAmE6kSWb4SntDIIXSXr8B0I+4dhC
	kJu2IP6Ei33IORhkvitsiMYRA==
X-Received: by 2002:a05:600c:5246:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-490c25ff39amr412376905e9.27.1781110636075;
        Wed, 10 Jun 2026 09:57:16 -0700 (PDT)
Received: from localhost (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490e2b2353bsm472115e9.10.2026.06.10.09.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:57:14 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:57:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Jianmin Lv <lvjianmin@loongson.cn>, 
	Qianhai Wu <wuqianhai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Mingcong Bai <jeffbai@aosc.io>, Xi Ruoyao <xry111@xry111.site>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>, Dave Airlie <airlied@redhat.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
Message-ID: <aimXS-lR_Qpf0a5X@monoceros>
References: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2s72lnhithaooffd"
Content-Disposition: inline
In-Reply-To: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>


--2s72lnhithaooffd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

On Mon, May 04, 2026 at 05:05:37PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using the PCI_DEVICE macro and named initializers is more
> explicit and thus easier to parse. Also skip explicit assignments of 0
> (which the compiler then takes care of).
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Does someone feel responsible to pick up this patch? (Or give review
feedback?)

Best regards
Uwe

--2s72lnhithaooffd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopl2YACgkQj4D7WH0S
/k7mfwf/cI81prOW+yctb6KBDLo0GNXT+8e6M1DzvwtBjMUFyQkiO9E69Nj0fVip
jdfsHsFCbqoY9j/mPFG3LTQ/einC1A6UCiUftmuS+yd1RZkrobVsEGZNnvFD9EfB
U3IcQdTSV5Ek1pK6SGLhe5559INii1x4VFGtwBGm2kNEcpRkVlorH9KVXQMIYEAP
2NfPETMFdSDMvpILe/YuOu4fwjYSktGk84F8d51PLhuB93+n670Iq4004AYFBR7C
lnUZ9g8BaXK8Y4B/PmAn48Fom3SQaDu1lgYg/IKLel2s4z0poNpBipOjcqTNrw/t
52NdBnb1zyPcgvcMAhVzvDfkV9xHDA==
=3wRg
-----END PGP SIGNATURE-----

--2s72lnhithaooffd--
