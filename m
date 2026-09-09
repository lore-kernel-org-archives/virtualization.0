Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D2560AD1
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962686; cv=none; b=qViEwL6u1DyLSlsBMtYY343oAEBe+LxI+RJa5yM0VmILivLUNjvFZdyR0vJIYgrOBm/7LjAgaOqDIh4U1ZNg2n2wkWCw85aFFS70ESCtBEcQj56FZ9uuwbqeHDyLaAJGd5WUAfeK96hGWSDzvLHmvjIJHaUjwPK0ov94Dix18Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962686; c=relaxed/simple;
	bh=ACLhYI/uvfqrWqgik+7/i7+ERQzw2GVKpRi0zD3xt/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X8yAz6um80Hu8QZsItIMISCtwEXuyu5nL92nuboL+TveRK8Sw24PsnCbgEXlZp3ySUTT5iMlEvHwOKxFXLMANGCrHGGRobAD6ZCKi2V9WasXqnro3023nXgNEKPp2WY3VhYXYvj1ziHyNn4OPFWhqtqKRnjUmtQSPo2CK1o96C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJZaM6+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJZaM6+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8E11F00A3E;
	Wed,  9 Sep 2026 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962685;
	bh=AxS4maVVUXmJrVSdXwHNxCyEe/6wiZ/Ko5/Y6c57zig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SJZaM6+O9MXvmtjviioS74WrjdZfwOLqWRQx+KI+y5piBqqi+bZvNp+wSnrtI2gdG
	 HlEcPOgJmhe40UdkIJx+bAGOa2ZjZtt6OOwlneRS6GsjiM9v3l1btgZfFa8Dq3e4P/
	 p544tRTkk42oDj8HyDTqnOQvoSLRfmdzIbPV8M5JyOTRQHDFSZGNDT3J2XbjpnCcyy
	 LMNQjYneVqMSSvgQYG5+6HCC8/gwBiphGP47B5sTzFiwvh2rKJi4oJ8jcR7trpkhRs
	 A1qDjzlNMGPEscIkbKPBT0BwFYEXpo9RuGzhzeNgMOGQoJ2fjGZpIS/HJofMopQAhq
	 qWLnPjTaRRXMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/13] sysfs: Add preferred CPU file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260909135617.871006-6-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:04:44 +0000
Message-Id: <20260909140445.1B8E11F00A3E@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D5

