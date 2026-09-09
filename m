Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAD153FD2B
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962840; cv=none; b=jq3zidqit9VNJ+k9+tpwmWkPqFLvLTo1KQnO2caGShMseAZ+36V7lqnb7xQhmsznasa6vJy4NEmGN0WKTNAZkOiS2eCxOM5gNDDg/gp0287nRNoSq5bbyz7CUQGODy1gbqKuvkgP87TbdQMFbpcaH1DT3qt1wjSUTmmpnCtH8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962840; c=relaxed/simple;
	bh=7HEPrM9bV8G5uyLPQhLeF9Gx4HhQNwkiHFR/w3NIvDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JjPm4RyJXVx33oKIe7oNEHDOBdjsJwvEQHQIcSSWSiahrPA7Q8mxqxW4eoLvQX+hPnhsSKmFMAyjPhPtnnZlkFxml5eg07rwUEaqJqZG3Y2d8s5/+fZNh7jwWYkL0oL93z9+gRtmz7iCnQJCgExaPUEk+dbKXcu6aXlfe+gqDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5kMmGtf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5kMmGtf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BCD1F00A3D;
	Wed,  9 Sep 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962839;
	bh=+5O4FtE45JOycbtBAYMC+mW2Ul7O3T8gAh/3TY4pIaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5kMmGtfqL+GL6svu41pUxK+UUZcDsZvd0OH57O6+BkqFZzpOxWui74/SPSvWe8/c
	 Jd005B/ozrnz/AV5MBCb+XyEiq1BIusZuiiqek9Cl4uPp8ZroVwuW66u/RsXgW53ii
	 +G5Qj3PcxdOit5CnyfSJBcdLotvYT31Vs6EHOjA8LOApw+HpX2VryKpW68QMdsqvmc
	 KWo611xbMO3bximj1mf8cEcCXVEtoyaQ/XnwIvmkzsPOibl486XowsIMi7IesHvU3S
	 df4+jl45lb7VsuaGo/Ljcw3O4767QhaGNLtinkd2by/z9s/xm2Xa+la4nYbGxDysBz
	 CXOr6oSE44wpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909135617.871006-10-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-10-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:07:18 +0000
Message-Id: <20260909140719.32BCD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add a new stat,
> - nr_migrations_cpu_non_preferred: number of migrations happened since
>   a CPU was marked as non preferred due to high steal time.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D9

