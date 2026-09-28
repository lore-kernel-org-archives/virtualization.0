Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD83932CA
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574438; cv=none; b=aam6GWz+s3oG1Bd2MzSrDTC/O45PRc4J1QR7TlSjgwm1j7HSOyFq5xhP1wxgvRM7qpMxQtDR+WW+YjazZOAIx1Cjq93gao74CIZGuKSS601z1uAyz0mHY4+1Y9i/XKY0TD1FW07O+/hpWJeTvW7SIBX4hfIfGacbJDl2B5Put3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574438; c=relaxed/simple;
	bh=Z2AgLgouNvWehqaiy0QOOXTqQp8gQOHjvWLqybKEwPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o83dji7Nv88Ku3Wdo+oGUm5ybyMIkhxWV1kkyBaPS1rZALYuFshEnVrY9CcCb4Lk0/aKzFh9hgOKy+d5o1ExLEW4pfXJHaiiN+/9q+qJ5vd6glLAbcApM0jHR/9RsZ/wyUYkpzb5vjuRAIgYC6pwG84a6eLFjoHWbsbE+ZPa4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtrEJaCC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtrEJaCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B261F00893;
	Mon, 28 Sep 2026 05:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574435;
	bh=W0Apg/STJ7n17lBEIgDEaTUBMe4VEDNkT7JtDtJLh2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UtrEJaCCCOIdzxrtXVb2G6xHJs+7yzFbh8gfzTcRXCBUrS91kBev8KQwgks7w0L0i
	 QnNAX4R9l4fmXAnO96Kcuu89JnTBRjXyFN/J6+BHotP8X9UiNlgL52C7UeQ6vekghY
	 hXBPS4N9RWvHr5hv+AbO6R0qJGP1dBZ420RnpKqZTFhXMOM0XzOOPQjqej8YIi6DPO
	 FKNimKfwreMuUBmibJMUk7YjSMrulRyVzL7tj7HEJUSeCoZEfvM4ZokCZiS7epoffB
	 5tihE4Q5pK1Jvbq0OTRR0ly1SN8+GwoZuyJfyPCJhQC9avjGbQwIgK2aojTA/oirxs
	 4SuB1k+oQojyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/13] sysfs: Add preferred CPU file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260928053728.797539-6-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:47:14 +0000
Message-Id: <20260928054714.D1B261F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add a "preferred" file in /sys/devices/system/cpu/ when kernel is
> built with CONFIG_PREFERRED_CPU=3Dy.
>=20
> This would help
> - Users to quickly check which CPUs are marked as preferred.
> - Userspace daemons such as irqbalance to use this mask to
>   route irqs into preferred CPUs.
>=20
> For example:
> cat /sys/devices/system/cpu/online
> 0-719
> cat /sys/devices/system/cpu/preferred
> 0-599        <<< Implies 0-599 are preferred for workloads and 600-719
>                  should be avoided at this moment.
>=20
> cat /sys/devices/system/cpu/preferred
> 0-719        <<< All CPUs are usable. There is no preference.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D5

