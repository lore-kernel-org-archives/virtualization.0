Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176205;
	b=TZyzZBiWCXyXPzWj27ypFmhRkCW9mwbi3yw6lC6+dj/5WfoajWNHZsygbMp67LtuCW9B
	 Wga4qepCIG8Wror9Tczrip1BE+qHjh0cw9PpWWYSm1x7kn2fTPpxbSdnw46aeGz6IAej/
	 gV4Z3IenFJnXwZrAACVJcX30u1C5GdFTtOmq/WMfLgYEkTwHqjncVnIopItrPjL59Fy2t
	 HbFoNp2UIk3siLG74x/8PeA0mnOeWq9K8gK9MdsKNRn+Vu6IIoToRurIYQzY2loy4d2Oi
	 br4tRkDyKIcNu9KpKhwDzrdPN0v1x367mWeOnWu5WYKyx390MosX480uCC00YhlCzwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176205;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HnR3u3Wi29OzUMxe0Bk8y2yIn7/VHOzruPgbUNrwlm4=;
	b=ln1/ai2sDeClfcGk1gQUNoAYteZJLd+mx/IUFwT55Y9inv70wfVQeZUaWnJhqlhhdbwg
	 50xOsOIF9dVuIwiHKW14tSzNoUqTXSQ4Y+GUSD4Zi12IkFUdEbgaz+ZjbF+ga2KUBwWiZ
	 MbjD5PZOKXkAy5swEfHYLKSQ6U3i8dX5tZeSsMXgCcPgc8ftN3KGCyeersJHTZVYVghyx
	 dyoRHS0KpjlkGS9dZGlErCv2yIOF1PNCHJ7NrKHGkLD+eI6c7rRv9rsu+jh2mlUMzMbQh
	 JKECJr0BZ7g3Y2l1pZTAC/HDQ22+J/P2nK1timD9/+xbOcZFy9yj210COnnuL28XZ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oY72tg4/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D0606A332
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY72tg4/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD42B1F000C6;
	Fri, 20 Nov 2026 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176204;
	bh=HnR3u3Wi29OzUMxe0Bk8y2yIn7/VHOzruPgbUNrwlm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oY72tg4/nCtE7BXtmT0fW/xNgTxeaBSmzb0ZGR1oNG6wI+E1I4Oo93PnSIWiWQmfY
	 E9QXJMt19BJvOiKIYiz6gWMKSfp/7xshOVLVpL8kPbP09atWsvAVdNB+RVEJVcjkIu
	 imXq99UEhpvqYm8hvIP0Ky4AM+w4O/hu0b+YaZDAAbAjoYou7HumEqqt2AbXlCVAxs
	 D9ZRKsSnY5uGq8+frF13rhiWe1HxBLU5DYBuBcW6xR6egWJb4Vt7i+TQiyEMQetlZr
	 QTNmUOdvPPC1q7J68QTN/PFFPGpARocYtDRbWrF1nUnGbynJtR9eMSNOBHtHVWu//Q
	 nhoDMpi0zYgAg==
Message-ID: <sashiko-outbox-225111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/7] mm: page_reporting: support host-zeroed
 reported pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <2ec112cbdde76a60ab235a0df7734a23387f1c86.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
 <2ec112cbdde76a60ab235a0df7734a23387f1c86.1795089715.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:03:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add a host_zeroes_pages flag to page_reporting_dev_info, allowing
> page reporting devices to declare that their host zeros reported pages
> on reclaim.
>=20
> On successful reporting by such a device that guarantees zero contents, s=
et
> PG_zeroed.
>=20
> Note, that hosts zero the pages for guests, safely, even on
> architectures with aliasing data caches, and even without knowing the
> guest user virtual addresses.
>=20
> Specifically, ARM64 data caches behave as PIPT; KVM handles cache mainten=
ance
> around stage-2 mappings and invalidates the whole I-cache when it aliases.
> On aliasing MIPS, host unmapping flushes the whole D-cache, and slow GUP
> flushes the host aliases of replacement backing pages before KVM maps
> them.
>=20
> Any host that can't handle this, will simply not set the flag in its
> page reporting device.
>=20
> No driver sets host_zeroes_pages yet.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795089715.gi=
t.mst@redhat.com?part=3D2

