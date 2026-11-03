Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691224;
	b=EwApJoSDXgrqQqmgTiXnHE2weDIKqqAAIc5KkIeIaIMdmmbeb3KDyY6KEGAreweRuW1o
	 UwKATmKqs69ZtKv7hVndIOcnlt7Jiq1+3OCYeklrZOlr2Nembt94pzPcFhlYjvltld1/W
	 PnHLL+61qTEpSdqiILIz+PI7WIsUzXDo0HKHRSRftsVoAA4nWutEKG/PmYLT3IviMbzMx
	 qUFRHfdgIskUCwMYPokLsDQpH0RHaZInlKn1qlITISeSqaE1QWugL3HZELte4PPuTATYC
	 O8tTsh4IVEGW+kb3newyp/wgQI8dSChsWKXDd4xbJN73ZQrqgiUj2CHZPDo9Qi0vZMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GLCz6iFAlokfhUBI1kktWtuY6FWmULageAtCDGR5o4A=;
	b=KVFd3TJIzzAWjb/V52DV2bDglPHnMuQH8gkmY8LVyfuE9OSsQMRR/GuLAzqoqvyFQD6F
	 nLC0SdToeJRSBQTD8YWINCLwfr+KyZIVOvQgOJcD3PsAlDboC85nlnkUSUJWb0FghwD2z
	 pj+/KJxI3/lsti5LK2F8gaWFgmFlPehvqXe9O6HW0UBgjoFCEmS2z2jbr4n94DYxgTsbt
	 5gF15pLksYP/1oM8dtr8qjQJhKN5I/yDLQPHyuDpydEx4gHRGgt5je35zJuJ27VE5jq0z
	 WL9XznxF20UnhmAGybpmL2BBaaHTN46n5kXb5SOfuAFVak22oIfnD9Z+we+A9ezZULg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QT5mKWo1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330A606A32E
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QT5mKWo1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A7C1F000C1;
	Tue,  3 Nov 2026 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793691223;
	bh=GLCz6iFAlokfhUBI1kktWtuY6FWmULageAtCDGR5o4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QT5mKWo1F+cZRVVJ7QWLKO9aWwtH0hg0+6TQXdAgzs7TlfeNVuziGJQSvQTDnU2kW
	 BSh+gp8Nt/IDOA/+HUPqcB41RdnrTAqs2ecL83ZqxZnScvvQLx1h8LslkBTNdh2p69
	 wGOvJmOAhkkCI0UeYFuTwxFu7jnQfN4JoXVjRMOBSBEHnCck8bz6QQJ7X8HcewwQzz
	 i9p+rR39reH43KLxjzlauBRpK+JlBjX2z8Tc0qofmgc2bi+1yS68vOQv6/JZ+OvLGO
	 c2Qug/A/1VQ1M8lqF96PhGKKNjvHfZTD7nA6TALpoVoAJIALYBX777SG2/lqzk1OlI
	 ku1Mu0O2d9JXw==
Message-ID: <sashiko-outbox-194716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] x86/vmware: Move high-bandwidth hypercalls out
 of line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zack Rusin" <zack.rusin@broadcom.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <5c509e51a3e04b95a6447fabc9db20d72152a8f3.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
 <5c509e51a3e04b95a6447fabc9db20d72152a8f3.1793685318.git.zack.rusin@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:33:43 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The high-bandwidth helpers contain inline assembly which temporarily uses
> %bp as a VMware ABI register. Keeping that assembly in vmware.h duplicates
> it in callers.
>=20
> Move both helpers to vmware.c and export them for the vmwgfx module.
> Preserve their unwind hints and remove the redundant caller-wide objtool
> annotations from vmwgfx.
>=20
> Preserve the argument sequence from commit e0e022004bbe ("x86/vmware:
> Fix i386 high-bandwidth hypercall arguments").
>=20
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793685318.gi=
t.zack.rusin@broadcom.com?part=3D1

