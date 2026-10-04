Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A52EEC0
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115491; cv=none; b=mAptLpMOG0AEPltW4WUgEeR86ReAUj8upTfF/U/uFkOVCor7rBroue00yNBJcBqPFVkpjOvQWbX9wfCK3y3jkaZYhWqGnZz7qs8JKSoMDzs6o//axwyEzBkHT+LkfdJoWshL593xTNUKAua6AGsAp0QLteNuWpYIPbuKTWCu0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115491; c=relaxed/simple;
	bh=Q15YdRKss5SIpR8Sbpdely43aUtVD+jN/CYKRK0b+QE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XYymX8FiLIW/4rezNbwr5wVsj41ToLfx/jw+Nc5Wiimp6FwDUogeTeLrGccN7k0S/teD4tr1Ov3C9/ZSVQyuDq/zEsintFu+Suj1eyDBddwsozz/grHWUjzW9abLy/ro2dwPDUnPy+ar2QlBB5DUwihrbgG5ZqMhqQbGYk8PSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkYKoaNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkYKoaNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789251F000FF;
	Sun,  4 Oct 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115489;
	bh=Q15YdRKss5SIpR8Sbpdely43aUtVD+jN/CYKRK0b+QE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkYKoaNJtBV4Lkdx0MHe+vBbnmQvb3TGpHdnCt32VJ6dhtZHvBTZgS5Q7Qk9o+tBw
	 qJ+EsUS0+6ZZJRlA/vOj4nGeebghLA9Mn2TIJXxbUX2qAyM/GFYXZHZ7d81qIXF28Q
	 I60qJIury+HJI9ZlRxZ5F4XOT1YrA8YOqjYq4LeWeO0zqkVAA+FYBbOs5TTBNqL5me
	 +HwIEDndwad1nPtJzP//+4Y6Z12N/zeqhJZ6+WfMUjHDK7gUTBDrIaWfh51h12X8KD
	 gSa2uEIFeUgFBoliORzn3CC/uLYrHzXD0qU7pp8GGk5Fz9gMJmMrAsvfn0OctYLm/B
	 JHtKcN1T8mnbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] iommu/virtio: queue an UNMAP for every removed
 mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <tencent_C11DBB7E9C5985EA4AD5BE569E70336F460A@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
 <tencent_C11DBB7E9C5985EA4AD5BE569E70336F460A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:04:48 +0000
Message-Id: <20261004120449.789251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> viommu_unmap_pages() removed whole mappings from the tree and then, with
> mappings_lock dropped, queued a single UNMAP built from the range the
> caller asked for. Both halves are wrong in the direction the device's
> semantics are strict about: a device must not split a mapping, so the
> driver removes whole mappings - and an UNMAP whose range begins or ends
> inside another mapping invalidates nothing there, leaving the device
> mapping memory the driver has released; and between the removal and the
> queueing a concurrent map_pages() of the same range can put its MAP in
> front of the UNMAP.
>=20
> Queue the UNMAPs in the critical section that removes the mappings, one
> request per contiguous run of removed mappings, covering exactly the
> mappings' own ranges: a run's mappings are removed together and its
> request covers all of them, nothing else. If a request cannot be queued,
> the mapping being examined stays in the tree and the walk stops there,
> and the run whose request could not be queued is not reported as
> unmapped. That is not an atomic rollback: the run's mappings were already
> removed from the tree and freed, and the caller is told the bytes that
> really were unmapped, not that the whole range failed to unmap. The
> request itself is still allocated on the unmap path here; the next patch
> moves that allocation to the map path, where it is allowed to fail.
>=20
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Signed-off-by: Anlai Lu <agicy@qq.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_85AC6E749F6=
A912B7BB9FF360F8ECB3F5C09@qq.com?part=3D2

