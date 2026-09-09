Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A91492E2A
	for <virtualization@lists.linux.dev>; Wed,  9 Sep 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962560; cv=none; b=OJJv1r3/q+U4Ue/cphYwX32PmEGXjmPYQk+MjhFVxNgFDqBlpVc7JQ8TNU8tgBYEsauQgU8kZHtqVVrrB4ZSDTZO7SQuPX0NuSLXhpUh7eTINsBCwXOU+1olOtc9eIRbkNT60FdRDnHZQWMJBuxQaQwGwskZe7q7itSg1w1GHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962560; c=relaxed/simple;
	bh=Y0qKBN8rRLGTwWS1tk672td2ffN6HMQCnJw0gAACbq8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YzQcxaf10OiE1DXbzjB2YTg8Vh6WdswgDN4ntCorEQlbdlFHQVwGeWBmQzE7MK3JdB22Y4agUXuBCvKLkKCHkt4WNZcul+WNceSpmLXh7HZ937PWLAo16Ej0jmTOiC05Xvk7aS+rwPtj2xwWAqix+dT0Ycv8CeIvAvg2atMu4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyj8nmCz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyj8nmCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC6B1F00A3D;
	Wed,  9 Sep 2026 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962558;
	bh=Y0qKBN8rRLGTwWS1tk672td2ffN6HMQCnJw0gAACbq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vyj8nmCzDFsCa4A//wS6p6qQ+zGWtB3XKrSNNLWNEgWGkOliGADLrNEOabY1T5Wra
	 vkuAvqzeLLe/oJR+ULbeyzbZQFnR0Eini5mDliOBprpP+K93H+tTxFFJjft/tbm7a1
	 JOHaDAWvlKKz9TQOGC8o9d3EC8PpG5amaHdQHd0HBXfFHb4UY71epflBJtMStpys/6
	 6p++RUfFTH1swx1dXdyMuGQQCWomHYQR9aVePLrSeYG8k6VlX1TJYt/FaGHtHr8564
	 v/2uMBL+J7q6FfDzGLw+/OdzATImEKJpR/Jm7ZiNhNjZGpMkytI4SKW5yCj3g+pCph
	 8BESQEt9o5Cig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/13] cpumask: Introduce cpumask_intersects_and
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260909135617.871006-3-sshegde@linux.ibm.com>
References: <20260909135617.871006-1-sshegde@linux.ibm.com>
 <20260909135617.871006-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:02:38 +0000
Message-Id: <20260909140238.8AC6B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> Introduce bitmap_intersects_and() to determine whether the intersection
> of three bitmaps is non-empty. Unlike cpumask_first_and_and(), this
> returns immediately when an intersecting word is found and does not
> calculate the first matching bit.
>=20
> Add cpumask_intersects_and() as the corresponding cpumask wrapper.
>=20
> A subsequent patch uses the helper to determine whether a task
> has a CPU that is present in its affinity mask, the preferred CPU mask,
> and task possible CPU mask.
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909135617.8710=
06-1-sshegde@linux.ibm.com?part=3D2

