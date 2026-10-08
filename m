Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E13E557E
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444627; cv=none; b=VoGHOwRNTf6iAaxB/QAWaIdwhIp1BSepBvG3WFXctnnWJIskERiOw4xvFrrWTmc4WvzG/vR+AShLNaVo0i9wPBgxansqBKqv92pBl9LmW1Zuiw/DWZBIRSNnPqWZSB0RjnhoqXsfDWHaXi2V4dajeU7YFTC/tcDe8p98FWP6IpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444627; c=relaxed/simple;
	bh=/cZu2LuFkJxgjkCOzX5RqOrXyEUSvPDx6jcwlEXGQzE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cq3ahmB7bzAHmtCxh0aLdWiiZxwrUxC/fUatWF/TNsIaIpGRv9KXcj6M0Tn/1WKBYodfM4Qjt7GoN4tvyT+zMSOD4lFKosiJU4p60V/NBE/8p1eFfXq8i94zx5GF36KQoLf81lu4sJTiiVZ7VE5JPL8cPUKJRnQJOsyCOKaBXlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQiaxMGW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQiaxMGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A041F00899;
	Thu,  8 Oct 2026 07:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791444621;
	bh=/cZu2LuFkJxgjkCOzX5RqOrXyEUSvPDx6jcwlEXGQzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQiaxMGWe/b3xO0w5sDZNs74rQ8nCgdb7bPj4Cvg6YpnCcQkSYOSCUpOHXHRsJFsl
	 i+A3rSwJtP0IKp6IqIVl1ciUuWPIppkhzBg1BLypx71DkxVELzV+6YZyANKVBloXQf
	 j1JPIQG31AkpfvFPoN1XfsKKDvlCfvpRZXnBAMTQtYu0m1cn0kCxhAn/MWSZhYnNNT
	 dBBROqBbwF1msfHwANxDr4D803oV2TthZ74aOPz4KN3qL3yXTa032+8kJOr2pAAdEr
	 nuqTnZg9sbEHKrut6wUJxQV7AigFNUqtzrrAA2aeoHH2byLpgNEHC41I9X2cUhWfow
	 ZMEc/XZrCFhbg==
Message-ID: <sashiko-outbox-163761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] x86/msr: Remove wrmsr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20261008071839.2247074-11-jgross@suse.com>
References: <20261008071839.2247074-1-jgross@suse.com>
 <20261008071839.2247074-11-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:30:20 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> wrmsr() has no users left. Delete it.
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008071839.2247=
074-1-jgross@suse.com?part=3D10

