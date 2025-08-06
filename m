Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451721B4244
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505303; cv=pass; b=E5Lb2JcEnLipSV2mMuranWLhU7lbbFHcUyaF8yATO83kmAvWPeSscFDdNl4gYkMKui1G7JvRJOgSrIqVeGqr+jJwDKWETJg5fTs1YTrkQRRsndpX3aJy+eCDHuxlHE/xitRQzGK69B4A3oMNvoS9yrIzJNlQTsm4bPplwW9TWI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505303; c=relaxed/simple;
	bh=ApGGw07Tk5+K2psyK3cfN5bkdbaO8qEaf1xuxquGV38=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=JN6cNZnWpSD1ryw4IBZwiZ5r9JNJgEjc73TcqfwjaBVSxRu6FLwOxxiHNR3cubVkY5rSA2+tztqBEZh85HFQG1PJm7X9QX6p8iyMskZvXXwjIzYVZtRrVJkzUciUELMRmnkQ0SMqVyg59FuvTfMpI2txqigWW+vQjFWaRHbQHB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b=CdV6leQy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=igor.torrente@collabora.com header.b="CdV6leQy"
ARC-Seal: i=1; a=rsa-sha256; t=1754505298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DDYABNKcgFbbp5vahCMn7w2XAjHfX9MOSQcb7kNTjFznJTp88y4aFMTNHKCOvmbA7H9hlvoPOAWnStFDAFFbmz6/4Y3A1+D1KVNjnC6WGfUv2SxOArSGdB6DfwFhShN74ZdMLeSKjgofLw6rvL3Ho0ZnGyfDajbn3dd7JC+7Muc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754505298; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EvHP9h/MgRBE9mtAThygnI94QYfiiZspf7nOA/93jQk=; 
	b=HdZ7bP160El6isQgiv8edMz9PWh5yAXPKvcQxaOUfQ+f20alL3rbgnTyPEITy7Fa8W1OTtcPFIJf/DIEPtesnNIx/qhBFO0HqJBx7d8acE5CzGRwQrHrKasTMPkMAcIfXdiEubKjaHqwW+ULz60Rd+lKxlgkYVHNrBmm95bGdrQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=igor.torrente@collabora.com;
	dmarc=pass header.from=<igor.torrente@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754505298;
	s=zohomail; d=collabora.com; i=igor.torrente@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EvHP9h/MgRBE9mtAThygnI94QYfiiZspf7nOA/93jQk=;
	b=CdV6leQyctVsVlKrL8KLB08LPXePDJ6l8r7duuB+7gee4aIJu1jIqhdFOzbY8lhQ
	4x9+BigVyjAk5SmtgHXgCXakGVdp0c470qNSZTv1bOV17k4TOXNvJOCwOs46V1I2+/f
	nOOviQYTWhREOoMkfcmYWqKG0fdfp10gLdtOoDJA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1754505295940349.21112286126174; Wed, 6 Aug 2025 11:34:55 -0700 (PDT)
Date: Wed, 06 Aug 2025 15:34:55 -0300
From: Igor Torrente <igor.torrente@collabora.com>
To: "mst" <mst@redhat.com>, "samimdko" <sami.md.ko@gmail.com>
Cc: "virtualization" <virtualization@lists.linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"eperezma" <eperezma@redhat.com>,
	"xuanzhuo" <xuanzhuo@linux.alibaba.com>,
	"jasowang" <jasowang@redhat.com>,
	"Dmitrii Osipenko" <dmitry.osipenko@collabora.com>
Message-ID: <19880aa3804.3aa8c0311540629.5527706858754550702@collabora.com>
In-Reply-To: 
Subject: `virtio: reject shm region if length is zero` breaks virtio-gpu
 host_visible feature
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hello,

The commit `206cc44588f7 virtio: reject shm region if length is zero` breaks the Virtio-gpu `host_visible` feature.

As you can see in the snippet below, host_visible_region is zero because of the `kzalloc`. 
It's using the `vm_get_shm_region` (drivers/virtio/virtio_mmio.c:536) to read the `addr` and `len` from qemu/crosvm.

```
drivers/gpu/drm/virtio/virtgpu_kms.c
132         vgdev = drmm_kzalloc(dev, sizeof(struct virtio_gpu_device), GFP_KERNEL);
[...]
177         if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region, 
178                                   VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
```
Now it always fails.

I don't know exactly what issue this patch is trying to solve, but right now Virtio-gpu relies upon the previous behavior. 
Can we just revert it?

BR,
----
Igor Torrente

