Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0A283FEF
	for <virtualization@lists.linux.dev>; Fri,  8 Aug 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666489; cv=pass; b=FqoyF428PKCsguDK2dgNJTxA28UQFxR8XI3Z1qIhdY1t2JVorS61LAaS36cCOcxS3OJ6ghWAvxyCP/SiQVdkvkM/om/FgQACUBdieZxk3w5ajDCk+ClbnsCS4tT3YihuJR8vgXRBr51GdxH+K3mPdbdpSRfK0HiPVQWkkG+yX94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666489; c=relaxed/simple;
	bh=mKBzMw8QG8aSq568ciqZDbQ/WAve6Dhv1j4Rn86FiNw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HZ+fmKEQv94NnmbU1fMwztgvjJIfGHslERWpJEHu9TOwRiSFdFRm5UFC8nS8j8QOtOIgQHbSWPIOFA7Cz4Ujg7SUSkwruW6eAIA8uqunKTOkYXfPajdX0lgmBMpEeuGPUTWJFWkBrctwfhQilhsajVg+5XnSr/sDUN8Iu77AZ9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b=QuW5yL7w; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b="QuW5yL7w"
ARC-Seal: i=1; a=rsa-sha256; t=1754666477; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rq8B4awTkKUNJWp2w9fSev6iVg3RmS73AMovuUxfGF/5+dj7GFGKn3GErSHu1bD/XG4xocounqpj0r7rFBWR41B58Wbbp3r/CR5eqr7u803OVys1pOASwhuoOYlj9BdYlnGI5WMMveYowps257qQ2Yi4PZ8PLcl8LJLJ0vtzyZ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754666477; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gCD2y/rarTOAylxNx5TyooRJWxYNgJq4MFQaefgv8GY=; 
	b=PT3sDEdHABXsFelVN0lVxsZt+bE2JBPQVb5t85SQ2qqKmkuv5MhMJMm9358r1ueosnxrDp1hbH4RVj636xjdzUCvUcSM3KD0GOQhI17k41CKlkDG1PZHO2ZCXrSPbPeZ4P8XIP1KfDuaxdbPaF7X5I2mmj9HWCXQdiPrPtM8nik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
	dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754666477;
	s=zohomail; d=collabora.com; i=igor.torrente@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gCD2y/rarTOAylxNx5TyooRJWxYNgJq4MFQaefgv8GY=;
	b=QuW5yL7wR4mHc6TIoqE4HGtOliAOBtCCK2h/3IWD95sOH3Z8ivIeC5Evpt2apfAA
	hVh9qhZF4MHMXdkjYZyu1GO1Dxwlpih34WJ06NgKi0oQqoMipdKg5TMngWJCV11Jhsk
	w9tUu8+wnJPGj5bf1pQBFKBDJV1RbFiqSJ4UJmqk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754666475761185.0698473179949; Fri, 8 Aug 2025 08:21:15 -0700 (PDT)
Date: Fri, 08 Aug 2025 12:21:15 -0300
From: Igor Torrente <igor.torrente@collabora.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "sami.md.ko" <sami.md.ko@gmail.com>,
	"virtualization" <virtualization@lists.linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"eperezma" <eperezma@redhat.com>,
	"xuanzhuo" <xuanzhuo@linux.alibaba.com>,
	"jasowang" <jasowang@redhat.com>,
	"dmitry.osipenko" <dmitry.osipenko@collabora.com>
Message-ID: <1988a45a0a2.802c54fc2698695.3285632374822658409@collabora.com>
In-Reply-To: <20250808072533-mutt-send-email-mst@kernel.org>
References: <20250807130326.82662-4-igor.torrente@collabora.com> <20250808072533-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH v2] Revert "virtio: reject shm region if length is zero"
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

 ---- El vie., 08 ago. 2025 08:26:08 -0300,  Michael S. Tsirkin <mst@redhat=
.com> escribi=C3=B3 ----=20
 > On Thu, Aug 07, 2025 at 10:03:29AM -0300, Igor Torrente wrote:
 > > The commit 206cc44588f7 ("virtio: reject shm region if length is zero"=
)
 > > breaks the Virtio-gpu `host_visible` feature.
 > >=20
 > > Right now in the Virtio-gpu code, `host_visible_region.len` is zero be=
cause
 > > the struct comes directly from the `kzalloc` allocation. And Virtio-gp=
u
 > > is using the `vm_get_shm_region` (drivers/virtio/virtio_mmio.c:536) to=
 read
 > > the `addr` and `len` from Qemu/Crosvm.
 > >=20
 > > ```
 > > drivers/gpu/drm/virtio/virtgpu_kms.c
 > > 132 vgdev =3D drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_=
KERNEL);
 > > [...]
 > > 177 if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region=
,
 > > 178                           VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
 > > ```
 > > Now it always fails.
 > >=20
 > > As the Virtio-gpu relies on the previous behavior, this patch reverts
 > > the offending commit.
 > >=20
 > > Fixes: 206cc44588f7 ("virtio: reject shm region if length is zero` bre=
aks the Virtio-gpu `host_visible")
 > >=20
 > > This reverts commit 206cc44588f72b49ad4d7e21a7472ab2a72a83df.
 > >=20
 > > Signed-off-by: Igor Torrente <igor.torrente@collabora.com>
 >=20
 >=20
 > Fixes has to be adjacent to Signed-off-by.

Ohh, I will pay attention to this next time.=20

 > But anyway, I already included v1 in my tree, pls check it out
 > and tell me if more fixes are needed.

I tested here your branch, and it's working fine.

```
[    0.298365] [drm] pci: virtio-gpu-pci detected at 0000:00:04.0
[    0.298506] [drm] Host memory window: 0x200000000 +0x200000000
[    0.298510] [drm] features: +virgl +edid +resource_blob +host_visible
```
```
Linux debian-arm64-vm-chromebook 6.16.0mst_virt_repo_linux-next+ #159 SMP P=
REEMPT_DYNAMIC Fri Aug  8 11:53:04 -03 2025 aarch64 GNU/Linux
```

Thanks for applying it,
---
Igor Torrente

 >=20
 > > ---
 > > v2: Improve the commit message (Michael S. Tsirkin)
 > >=20
 > >  include/linux/virtio_config.h | 2 --
 > >  1 file changed, 2 deletions(-)
 > >=20
 > > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_conf=
ig.h
 > > index b3e1d30c765b..169c7d367fac 100644
 > > --- a/include/linux/virtio_config.h
 > > +++ b/include/linux/virtio_config.h
 > > @@ -329,8 +329,6 @@ static inline
 > >  bool virtio_get_shm_region(struct virtio_device *vdev,
 > >                 struct virtio_shm_region *region, u8 id)
 > >  {
 > > -    if (!region->len)
 > > -        return false;
 > >      if (!vdev->config->get_shm_region)
 > >          return false;
 > >      return vdev->config->get_shm_region(vdev, region, id);
 > > --=20
 > > 2.49.0
 >=20
 >=20

