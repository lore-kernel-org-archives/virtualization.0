Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88A572674
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962986; cv=none; b=fLopAUewVYk3pXvTZedu674421i7XcOAvjOh/y27V0GedRhTxP9llYcEvq9o3aogOyDpatW9hIwmLkWvpRb2MQTMwSaaE/vC/4CWRDm2rcp93AeiCCPnECwQXP255+it8Jyh8V/tEhfxsWQaFDHXVVJQYTdKwK0YRY0bvK5kW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962986; c=relaxed/simple;
	bh=jjZV7JrhZ4nAazw6loafBsq4OUlHgruZHEKljeek5pY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jvERyrTimPyciL77sPqYAf8pcYVeUdaKEBi4FXUyoECT6P7VSXNsJstxbYWdns3H+mAht7/a3toeP/pk0Qj8bDfJjdjVUIy7YkV6asCykX5oVF4uKSioKHOdpzuXrbG/PY4P9vf5cDa4iKQePHOpwbJ2ngOhLJog4qmLwDeQ5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqy3pJGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqy3pJGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4362D1F00A3A;
	Wed,  9 Sep 2026 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962985;
	bh=zfApFfcUyEwvCBJ2AUhM/2N2d87FJFU8YuKU9WgvWuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqy3pJGVKXRd3h1g7hBXaGFTHto0OUm2m9Xz2/tl8LsKilf0c0aoPQ3X6RWUKRqTm
	 vwb4fDlAgxE6JY8Dnngf/X2IUQ6IA4m2twH/eYQWAv3wzefEsixavjdGi9i5BMp65K
	 5IqjBMwK6K8a4MaPnGjWJ8UNvCEFo9zT9neFj7atKyDm050n1zIZkr9wf15K5+377D
	 XWKr3tRSeq+WoeY7rTCc00hdpcpDYtsNp4s958dayfeM2LixSnRhSw9u9R96NZoAD1
	 twqSP9GfDIez9x6ArVMqlK3GgWxndEAs7yU/4ZoYVw9e59BDzujhram155gFIszBAG
	 9joAYBl/M04KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/13] virt: Introduce steal governor driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260909135617.871006-11-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-11-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:09:44 +0000
Message-Id: <20260909140945.4362D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Introduce a new driver in virt named steal_governor. This driver
> will compute the steal time and drive the policy decisions regarding the
> preferred CPU state.
>=20
> Note that this driver is strictly intended for actual guests. Hence
> block it on Xen dom0.
> More details can be found in Documentation/driver-api/steal-governor.rst.
>=20
> A new kconfig called STEAL_GOVERNOR is introduced in subsequent patches,
> which enables this driver. This driver will select CONFIG_PREFERRED_CPU.
> This makes configs driven by user preference/configuration.
> When the driver is disabled, preferred CPUs remain the same as active CPU=
s.
>=20
> The file layout of the driver is kept simple for now. The code is in
> drivers/virt/steal_governor.c, and the configs are part of
> drivers/virt/Kconfig.
>=20
> The main structure of the steal governor contains:
> - work, delay: Deferred periodic work function variables.
> - steal, time: Used to calculate deltas during periodic work.
> - interval_ms, high_threshold, low_threshold: Tuning knobs for the
>   steal governor.
>=20
> While there, add MAINTAINERS entry for this new driver.
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D10

