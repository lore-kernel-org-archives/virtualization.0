Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59C5678C1
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962463; cv=none; b=GvGew9wlrrTWA09cZhbj42OR+j7aeClSNlETYzqaauFp99i5hkl0whftV0/bZNQyXyMCSnSOeXRzUzomyXFq0YfxCAuH30r9yfJp+C8gcdYhP94fJcqdgN5WxcNdvVB5pyxgXpRu+i+ZQJ7ojRZfMwH9sMlyAin4pn0+nc/sgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962463; c=relaxed/simple;
	bh=J338iAYD5OY7i6vYPDRhok2mNQ7xwBaw7ncAdRgjewg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gfvs50ZfJskJreOYhosfmcyHfEZ3kxMjSd7bHL3RHw9yUh4hMZHbbkh61/glmsJm32i63L8bC6tOTb4E/kk3lX3W/edMXhitvWbS8d1NmyiWuZ6maA61Hn5cum0p5knzBU1poLyAF6e6k75sSoNKq7OUhgjTNw5H/axJhw4TFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNbEO866; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNbEO866"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642F21F00A3E;
	Wed,  9 Sep 2026 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962462;
	bh=J338iAYD5OY7i6vYPDRhok2mNQ7xwBaw7ncAdRgjewg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kNbEO866w5d3mWdrCaOlEFzeeRp9hRRGxvREKEDrGaOxBeWuD/rhsPUR3wmal3e40
	 9gJ0/xYDjZ3BTRr8C/KLlMKY8AHAEAbxvxLABHuQkA1BAjca50zK21yxWZIZAcAvs7
	 od3ShV0xkwa70g59hkuYt9ydtpX/6HrcmgvWuF96c85T/Fn3kp7ktYSzgEWKBy5bJr
	 rS434HE8cZy/HClFL4yd1TC5XAk0Dno4GJYp/GncFVMFiewUIEEtn9SvErZgqQbJ3c
	 IfXTl6lJqbN6U3OBebef5tSFioxtmvBqM8AZNUmQvfDBbu1yHjg9Y2aCI452U8h/0W
	 SukoV3rGzjsSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/13] sched/docs: Document cpu_preferred_mask and
 Preferred CPU concept
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909135617.871006-4-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-4-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:01:01 +0000
Message-Id: <20260909140102.642F21F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add documentation for new CPU state called preferred CPU state and
> corresponding cpumask called cpu_preferred_mask.
> This could help users in understanding what it is and how to use it.
>=20
> Document the role of scheduler and driver for this feature to work.
> Details regarding the driver documentation will be added in
> later patches under Documentation/driver-api/steal-governor.rst.
>=20
> Newly added file could be used for other paravirt usecase documentation.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D3

