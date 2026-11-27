Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765827;
	b=yTXF8JwL4GM99ql+Refu6e7D20Mj5XM5ZrtGHMw1sTPej+s0zRXR59joJoVDqCX89Xfk
	 Q8NIaFQ9koeipa4ClL+QSFzzm6A+SmxJT8Hp1QeoxO/0X9W/JyC2bQDd8WMBUriKqyUKA
	 S1RSiccGZhcODj6wFMABnjWkTbhJsJqrYKIQg7NSgYg0gem4Pzs9dpJIlkWS8Wp5L0/UC
	 z2rzFMTzVMZBaVEQQTnl6q+iGF8MGoAax9tCpJa+rfg6YH3yzvsW2vG1iA6IbVEFZpAMp
	 uVT08Hu2PtQtKxSobIh9df/Y6MsLgSmXAFF16grcMb6Uy3OLu/QUOdNWDMReE+VdbKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765827;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XubRjePTKkAZVM+M7FvQkqheYOVTfh6ZrC81N7Ugdjs=;
	b=Ns+UdjXptGbd52Dh+CC0joEfR+3hGdgiM2wBHh0ASH75/WhR+4se+ucOCvP/daWGoAT2
	 3PD74YRxXl8AVBbZlAuY7vYY7u6poxBW1zzsdx1nl4+uOvULrW4YlubeysU2y3FzEMeKw
	 Ha2lSUzptYvVrZZ308ecuHyVWp0yquVwWVlQOGSowoVIFumxKEmkSWa2/W4DiyHwQiDF3
	 Zb/IsfURGV9YesbM3K5fkRSqiafH9MMFV8v1AI5FqSsnRm7W9UiN+LHLg8bw/t92NfnA0
	 NnO2nJf7zt5HLk+/OXZYwnDa29tGcx8FqKerGtKSlC697Y5NAtiOIBzBnNJmV0suceg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3e4Uhx4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA0606A31C;
	Fri, 27 Nov 2026 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3e4Uhx4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D41F00898;
	Fri, 27 Nov 2026 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795765827;
	bh=XubRjePTKkAZVM+M7FvQkqheYOVTfh6ZrC81N7Ugdjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3e4Uhx4Gjg7M5LhbWUabvFv1xr/3KZgiZUHgIZuVRyZ0UaeKTC/c+CXboqekiC6m
	 LpMAnfgxWnFOseRinnIpXO2ZeRTIyi9leU9rFDMLVvgHv/EkrI9augaD4gpowhr4Do
	 ixHDq8N6QI4gwBlwPLeg75yLnyPfXb8Hb+1UJHIsk3uMK8RNy080bmPi/E9H//WFoy
	 UuD5DmTfn+Z54iDhNwE8JELsLV2EhxQwjrc8L2VlQKi3LfaOopJlnRoJ1z3hkRIswk
	 8D402eoakGbeAB1buklJR+pRPXDY3cPINgFVXfYk4y/2K8ov8OcXXe5sBtOEvoiYaY
	 UHYHgcsWZS8dw==
Message-ID: <sashiko-outbox-236832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cpu/hotplug: Rename cpuhp_remove_multi_state to be
 symmetric with setup
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3JpdmF0c2EgUy4gQmhhdCAoTWljcm9zb2Z0KQ==?= <srivatsa@csail.mit.edu>
Cc: virtualization@lists.linux.dev, linux-perf-users@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261127-fix-rename_cpuhp_remove_multi_state-v1-1-097db4564cbd@csail.mit.edu>
References: <20261127-fix-rename_cpuhp_remove_multi_state-v1-1-097db4564cbd@csail.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:50:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The multi-instance CPU hotplug state setup API is named as
> cpuhp_setup_state_multi(), whereas the corresponding remove API is
> currently named as cpuhp_remove_multi_state(). Rename the latter as
> cpuhp_remove_state_multi() to fix the asymmetry. This also helps
> maintain consistency in the API names by letting them share a common
> prefix, i.e., cpuhp_setup/remove_state_*() across all the variants
> [none|nocalls|nocalls_cpuslocked].
>=20
> Signed-off-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-fix-rename=
_cpuhp_remove_multi_state-v1-1-097db4564cbd@csail.mit.edu?part=3D1
