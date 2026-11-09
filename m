Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203709;
	b=TyD8mxoKfLWUED9boNCWsOsX809HuVXStjg6PUKRotI9Kh/X5/WLHGIQMvUVQ3BWARZq
	 AJG+XvI/n5Z/5NG+PoN8iey9aNUe2Y34sMDlRAoHMfTRHHRz0ZBLzvlSlDxTvKArNx6uk
	 SpmTrkHNqDTsrTWME+n1I5u8qGEPUm8602Io1LMxpVXzZWKns43TI8lw6NP34N2FlDML3
	 +uQ+8iXOBdkyReQkBifvC2Y+bl6VTbJX+EiSxKo1VVzt9UsQURq8wLIkdHEo/xhRz0a0R
	 VVGNo+yJDgsdcBjAnuecap1QbcYjBwybH5+oRjVqsQAejco8zjSrFcEocuMuikAIVrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203709;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MLCVQipA4Q51nEPYebVa2UVEhR7m3/Zxk/h1UgiI7/A=;
	b=cRXSsARzaRy0i/iE5DtMbisSk8ggIW/xzZyQ8Cp2PQCtgjUtaZzbgAHC4mP9Ggf9dT3Z
	 PtSgS+TAuJQJXnae7wQl3CdPDwtAdlChRJ1BBioOnuV2z3N3Z13fI7WYocoHRvdL5bRsD
	 xzeuuvhjXcQ9s4Z/5K+MSLABA8jUEe0dLxgKZdRF+IsJn8g2MPhbF6c37TMHOe2vi4wS7
	 bjhhcnYroY6MBMgmQKdlMygXThjszHRso2NuPQZgbhONLdJNHYlI4FeBvIswtCH+zT/73
	 jATFFkOMSWJ6B9otgE2aOaVpnCjovsAjYNQ6M0t9/6S+EFF9f8kw3Ji0H8DN8Sz8ncg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ngmpksV/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC14F606A32A
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ngmpksV/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488CB1F008A3;
	Mon,  9 Nov 2026 05:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203708;
	bh=MLCVQipA4Q51nEPYebVa2UVEhR7m3/Zxk/h1UgiI7/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngmpksV/quRsyPLoSZMlswSi2ELbcPXzWc1TmAdTxshzkrS7tfO+6xNPMfoRhYjaB
	 HuJANxIKKJQFojwJcc72T+0LrnrIE5HzCd74AKg30xpcdOj7+/E1V+rnBWmn2RyXKl
	 o2VhZyu9LIU9oaeNfOKrGPUcy0Ao17Dk57dKGJtPOslhQ4DTpSMVl45JYNeUJ69Nc7
	 BuTGMN7HbUY0kI8w6CWMaFV6FXWhKKvWIWJNj7I0OoXDLWWfcahERu7uU8mIHMgbB1
	 4KW+NRYS3lIfWp9azzfj+tdEkPBYtD7oGaotlSIu2KKXME/a1CZSh8++TnMzWVjOaD
	 K/biHa8e/vzzA==
Message-ID: <sashiko-outbox-204465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] x86/vmware: Add the vmware_record_panic_msg
 sysctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Petr
 Mladek" <pmladek@suse.com>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Dave Young" <ruirui.yang@linux.dev>
Cc: "Borislav Petkov" <bp@alien8.de>, "Ajay Kaher" <ajay.kaher@broadcom.com>, "Alexey
 Makhalov" <alexey.makhalov@broadcom.com>, x86@kernel.org, "Joel Granados" <joel.granados@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Dave Hansen" <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, "John
 Ogness" <john.ogness@linutronix.de>, "Steven Rostedt" <rostedt@goodmis.org>, "Sergey
 Senozhatsky" <senozhatsky@chromium.org>, "Kees Cook" <kees@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Bo Gan" <bo.gan@broadcom.com>, "Brennan
 Lamoreaux" <brennan.lamoreaux@broadcom.com>, kexec@lists.infradead.org, "Guilherme
 G. Piccoli" <gpiccoli@igalia.com>, "Maaz Mombasawala" <maaz.mombasawala@broadcom.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Stephen
 Brennan" <stephen.s.brennan@oracle.com>, "Michael Kelley" <mhklinux@outlook.com>, "Ian
 Forbes" <ian.forbes@broadcom.com>, "Bradley Morgan" <brads@mainlining.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <abaa78b64a6f975bae42d8ef523062e55554a28e.1794201807.git.zack.rusin@broadcom.com>
References: <cover.1794201807.git.zack.rusin@broadcom.com>
 <abaa78b64a6f975bae42d8ef523062e55554a28e.1794201807.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:55:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow administrators to disable host log transfer on ordinary guests or
> opt in on encrypted guests. Expose the boolean recording policy through
> kernel.vmware_record_panic_msg using proc_dobool(), as Joel suggested.
> Zero disables recording, nonzero integers enable it, and reads return
> 0 or 1.
>=20
> Register the sysctl only after the logger is ready. A registration failure
> leaves the internal default in force. Document that the log is sent
> before kdump, and that disable_panic_notifiers_platform_list also skips
> it.
>=20
> Link: https://lore.kernel.org/r/4e73yd2ofpdzl6rptzvd74no3hnyfblknoq7wzxlw=
7f3zjbz7c@srfabx6lsusj
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794201807.gi=
t.zack.rusin@broadcom.com?part=3D3

