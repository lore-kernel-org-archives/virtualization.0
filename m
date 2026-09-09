Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922956E060
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962808; cv=none; b=T43qOJDSsBhN0gLHxrUd/KqIm6BMq7ksV8N6bxnhSzJXLkIQQ3AfH6QLQJ+fjFDcMMdCDMvM6r4wLsPXt7Dfv/oeLrCt7aJMIX52u4BUOXYOmS5o0RpxBJFyFN206L9dNhnjF8OwSWRbeIM+uc3X7qmzNm8OtMGrPwGhu+EveWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962808; c=relaxed/simple;
	bh=l/rAHjZOoLbd2IxEtsvQ81Q+v0dfH9xqB3UGBSx8MnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JqSgoNQoiehwmSCnL4BHj7KXz0ChLkvEV8nPVMfvrkHZ2soReJ5EcReNHHr2WdJn8VMS/eNBQNr0fpObQhUSwvuFURHyL9G8DDP5fu87ZuolAm3nE1Bvi0LOfqKA9tDvLuiPBPZ3wILs0gkGVHhh8dczzFnhJj75EfmZLuSpS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkZgRJrm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkZgRJrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7DC1F00A3E;
	Wed,  9 Sep 2026 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962807;
	bh=l/rAHjZOoLbd2IxEtsvQ81Q+v0dfH9xqB3UGBSx8MnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BkZgRJrmhrH5kfyznvonjpyXvOXR5t5JSjGf4pUHDwUxyYYJuI5Gq4z4P8NKrPGOR
	 Cq/IiKbFcLr3y/S5OcGswTz43XxGcinFDm3w96iLtVTN4xT/aF5IzHqyeZB+MdYaTc
	 ssJuXLKpzoUrXn6lZX7sh8MJdXrbTZLzD7Bhn6Nrn5DMsK6GS7H5vEBCKH0NlVZnIh
	 as+J5H+QNSSJC1zh3uZKaZ3BPVcbT1NSZvJ9lnHlRgQjVP7uXJJiMNvq9ZYVs10ALO
	 eTP23+3P9+HUfD96okTYL1cD+/pgotJQ1AwzTiXy5WKnqnEJLkEfZbUItbk/b5Z/LT
	 +3j6UsyUkaanA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/13] virt/steal_governor: Add control knobs for
 handling steal values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909135617.871006-12-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-12-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:06:46 +0000
Message-Id: <20260909140647.3F7DC1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> These are the knobs to control the steal_governor.
>=20
> interval_ms:
> How often steal governor checks for steal time.
> (Default: 1000 i.e 1 second)
> This controls how fast steal governor driver reacts to changes to
> the contention of physical CPUs.
> Can be set between 100 to 100000. i.e. 100ms to 100seconds.
> 100ms is kept as minimum to ensure few meaningful steal values
> accumulate even with HZ=3D100.
>=20
> low_threshold:
> lower threshold value in percentage * 100.
> (Default: 200, i.e 2% steal is considered as low threshold)
> This determines what values should be considered as nil/no steal values.
> [ ... ]
>=20
> Documentation is available at: Documentation/driver-api/steal-governor.rst
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D11

