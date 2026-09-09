Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAB56E068
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963502; cv=none; b=pSgGdAz5tk/ViL917yztJGHkUxPoQtEkxZ7oRPtlRmpj6foWDgOTy+gvnAYQynM+dzNdD0qAD7jJO96W9au0O/dw0BIEddt/Fj0xiT0Viw1f3lzZDggpi8nH8Mget+ttM0+RoJ6GJtPKC3xh+KgCoQ9nzcgjvSWuYj344LqrzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963502; c=relaxed/simple;
	bh=G+VkElkQiOlFnlhMWzdLtYz7aRKWyvW7yAMpQ/SfG8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vfcn7We75hcg0vdtPVOzjU4z7Jd1zwfOQXDTVpp9uGdIK2deOpeIVgxv46wPRLcmztBlNCHfYifpulAJArKvSYtpi5/QMFB1DncGx7TV0p6iJ2mqXVF6PswW4Tt42OJ2iW7OO1NCpu/H18H516xHNXgm/m7AGK+1vpdTXTZTnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABmxXmB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABmxXmB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8608E1F00ADB;
	Wed,  9 Sep 2026 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963500;
	bh=G+VkElkQiOlFnlhMWzdLtYz7aRKWyvW7yAMpQ/SfG8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ABmxXmB+2TK6/SaZBQmJt+KOGhysaMTseEU7lD79l/Wo3K9aQMvET7844REVM0jNc
	 imXbsYVKBfFcr/gqkjnDHfILIyk8Op0J9Zc9EhJJaRFhMH9YuhuQr2REdYwJFBPU1M
	 k7uex8lo2xdJvfWHGwcZFFJV8BAVOQzAY0zGDnnKQntbq+pA+p5VglQySQPW3j6kcv
	 uqgfM1KH0d6ZGEaarVpBYDWROXkXIoJe9KXYL0J/K+9D52l3leS94ViSm9yd1VGfgj
	 HuIhfWfALbYAMfB8owYZ5c7IUaw8eb75AKMKtC/ITIac9JyiFV43s9cH8qxJlrCF+w
	 vrOy9L07cEaGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 08/13] sched/core: Push current task from non
 preferred CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260909135617.871006-9-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-9-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:18:20 +0000
Message-Id: <20260909141820.8608E1F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Actively push out the current running task on a non-preferred CPU. Since
> the task is currently running, a stopper thread must be queued to push the
> task out. However, if the task is pinned only to non-preferred CPUs,
> it will continue running there. This helps to maintain userspace
> affinities, unlike CPU hotplug or isolated cpusets.
>=20
> Though the code is similar to __balance_push_cpu_stop and quite close to
> push_cpu_stop, it is kept separate as it provides a cleaner
> implementation specifically for CONFIG_PREFERRED_CPU.
>=20
> Add the npc_push_work_pending flag to protect the work buffer.
>=20
> For now, only the currently running task is pushed out. This keeps the co=
de
> simpler. In the future, an optimization may be added to move all queued
> tasks on the runqueue.
>=20
> This works only for the FAIR scheduling class.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D8

