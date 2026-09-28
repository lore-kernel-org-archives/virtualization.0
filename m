Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D123B3BEF
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574496; cv=none; b=J0U99E8yfW2Gqy2Dor59Qo2RAcAGer6AwkRyijKQZrVMnynT0avipjDIzOxBl6w9LSJdcKgTh1keURsUJnZFwELRikYXZnHnerFQc7qgK8zQ5NG32oKt1XJGcYzpbh5DNh4KY8bcdoAWTebXJAin8Wfw6Snh+Z26EWfcK3hal8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574496; c=relaxed/simple;
	bh=WJCAo99fONv7crecjchT3VYi6DNsTao7KSpbpAOgW60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PFSx6n0JSeMdAcp1iZ9l+5QSCq4wR/e4Qaf4+jDgykE+8d7pnZTWSR7QVAm7J9+BZWmhevf8zvnjtpVMtBWEV3+1lnT7z85sO6PhV1yDWxv8TF2H61JDe4nf7KGSfk+W6bLR5Vu9u57EgE0BZ1wsjfkPaupVH4A2JzLh0bCRn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4jWWY+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4jWWY+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1671F00893;
	Mon, 28 Sep 2026 05:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790574492;
	bh=a3GhJdBb9+ihyOOym4tn2cMztvX2UEu+TdEWWk3UizY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4jWWY+iJ72uGkSFeYwL80ST3tJ2CqxZXK8VyGmX/52otIGfC5Me1w8UI4cVHV1VD
	 sMKzwSrZZp1wz4KT7mHaYtI2bcK0vUmJbC6mb6sL+Rr9OUh2JglWzxzdr4mKo8MOGU
	 N45KeLH9eTsAjWN7fTYh0nDZZ5BZAZlrUdI2GnQF6oOuvU2dUBxhM7XYUoodG93cFL
	 x0YhfwgJQARezPnaLGU+BKWesL00ZKjedLu+6MGUPGxgZthYgJBKP8eZ3EHDVUvHAn
	 +Oj/lld61FAneUYyzuJ0VKIfqPSUihAzCh90NAdovRKq10oiUBX3F2oXPqds/TcRS5
	 q1YxkWGNjvoxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 09/13] sched/debug: Add migration stats due to non
 preferred CPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260928053728.797539-10-sshegde@linux.ibm.com>
References: <20260928053728.797539-1-sshegde@linux.ibm.com>
 <20260928053728.797539-10-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:48:12 +0000
Message-Id: <20260928054812.AE1671F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Add a new per-task stat,
> - nr_migrations_cpu_non_preferred: number of push migrations while the
>   CPU is non-preferred.
>=20
> Since this new stat is per-task, it changes only /proc/<pid>/sched.
> It doesn't update /proc/schedstat. Hence increasing the schedstat version
> is not necessary.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928053728.7975=
39-1-sshegde@linux.ibm.com?part=3D9

