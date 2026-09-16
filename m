Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC04A8FCF;
	Wed, 16 Sep 2026 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596249; cv=none; b=f6csIsIH3Ior5kK+OPHnzevD68rdr/KcnJ/E1BVCMc4mfJHPveXadQF9HA1DOF2s4e/Es1aijE318VqTlsXI7kOOJYHr4Dhu77sSewXTlTxmvkUeKr/JwGjcYeQsCotbvHd4iRAvn+lSzPlopmc9ObCyrikxrwZxfPLkbbJCwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596249; c=relaxed/simple;
	bh=A2IqMc7blthHQdK1/k3C8DnNeTGzBdUooFyYNjEeS8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dX7qvjduZoID53o2PbHI/UHmJhO9uJLEQgZ8jpYVR9ps22DYbUb5eFXkO76OH1r95HlCU9PfuphJNfGBtcni6EY7oKysyBdrXB4qf6lfVaHgiJQrdrqlapC2NEMjrJ1nrFK/V6SchRbPqs+95MYjx5ZZ+yR2dp2POi8YYFtmlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSPWfb6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSPWfb6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62A11F000FF;
	Wed, 16 Sep 2026 22:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596236;
	bh=1r8bf5AADhRRMKhLYOJAz5G2HufNAXA5HKmS4R9R/uo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RSPWfb6psas/9YwP26YF+St3plWv9fKIcY6NOGFPOrDDol4d3bcj+rfVGe/lJAPZF
	 hVFux4gwx9BZLZERFDoSSTb4NETAbOa6BTTd5o6zG+rETcnjr/NOP1uLU3KaqZ1EVs
	 CIGIab3m00cAZEwB16UwUEZPlnCdi00iNGxN1as1bnZ4iWXR61M3rx9HIv8iHL0F9D
	 zMElAhZ4qk0PLIsDWuJFLnfIQDi+SDVxB5uEi0OeQNBCZjKahhtouA7fKTQA/Cbel3
	 hF9cyMVzxP8zw7B/f53KMyLy3tLvVErNTPk4zru7h6bHbzj5o1O2tJMnJqw6Xm/G2m
	 SCT3lIyextaXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/12] remoteproc: virtio: add bounce buffering for
 data buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:03:55 +0000
Message-Id: <20260916220355.B62A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] remoteproc: virtio: OOB write on 0-sized map_records array whe=
n missing coherent pool
- [High] remoteproc: virtio: sleeping in atomic context due to GFP_KERNEL i=
n map_page
- [High] remoteproc: virtio: map_records collision for sub-page coherent bu=
ffers
- [High] remoteproc: virtio: address space confusion between phys_addr_t an=
d dma_addr_t
- [High] remoteproc: virtio: kernel crash using page_to_virt() on highmem p=
ages
- [High] remoteproc: virtio: unconditional bounce copy leaks memory and ove=
rwrites data
- [High] remoteproc: virtio: missing bounce buffer memcpy in dma_sync_singl=
e ops
--

commit 06acb1256e6bddbbb1f690528dd368f5e38dcbd7
Author: Francesco Valla <francesco@valla.it>
Subject: remoteproc: virtio: add bounce buffering for data buffers

This commit adds bounce buffering for virtio data buffers when
VIRTIO_F_ACCESS_PLATFORM is enabled. It allocates coherent memory and
uses bounce buffering on map operations if the original buffer isn't
from the coherent pool.

> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/=
remoteproc_virtio.c
> index cfd66d9d1c9e5..d21b3b8044df9 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
[ ... ]
> @@ -337,6 +344,151 @@ static const struct virtio_config_ops rproc_virtio_=
config_ops =3D {
>  	.set		=3D rproc_virtio_set,
>  };
> =20
> +static inline unsigned int rproc_virtio_bounce_slot(struct device *dma_d=
ev,
> +						    dma_addr_t dma_handle)
> +{
> +	const dma_addr_t dma_base =3D dma_dev_coherent_base(dma_dev);
> +
> +	return (dma_handle - dma_base) >> PAGE_SHIFT;
> +}

[Severity: High]
Does this code strip the sub-page offset, causing all addresses in the same
page to alias to a single slot?

If virtio drivers like rpmsg map multiple small buffers (e.g., 512 bytes)
that reside in the same physical page, will these mappings silently overwri=
te
each other's state in map_records since they resolve to the exact same
array slot?

> +
> +static dma_addr_t rproc_virtio_map_page(union virtio_map map, struct pag=
e *page,
> +					unsigned long offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{
> +	struct device *dev =3D map.dma_dev;
> +	struct rproc_vdev *rvdev =3D dev_get_drvdata(dev);
> +	dma_addr_t dma_base =3D dma_dev_coherent_base(dev);
> +	size_t dma_size =3D dma_dev_coherent_size(dev);
> +	phys_addr_t paddr =3D page_to_phys(page) + offset;
> +	void *vaddr =3D page_to_virt(page) + offset;

[Severity: High]
Will page_to_virt() yield a bogus virtual address if a highmem page is
passed in?

Since the DMA mapping API can be supplied with highmem pages (e.g., from
scatterlists in block or networking drivers), could the subsequent memcpy
dereference this garbage pointer and lead to a kernel crash?

> +	struct rproc_map_record *record;
> +	dma_addr_t map_handle;
> +	void *bounce;
> +
> +	// No need to allocate a bounce buffer if the memory to map is already
> +	// part of the device's coherent pool.
> +	if (paddr >=3D dma_base && paddr < (dma_base + dma_size)) {
> +		// The allocation details will be recorded also in this case,
> +		// indicating that no bounce buffer was allocated.
> +		map_handle =3D (dma_addr_t)paddr;

[Severity: High]
Is there an address space confusion here between phys_addr_t and dma_addr_t?

paddr is a CPU physical address, whereas dma_base defines the device's
DMA address space. On platforms with an IOMMU or DMA offsets, these are
entirely separate address spaces.

If they overlap numerically by chance, could the physical address be
incorrectly cast to a DMA address, bypassing necessary DMA translations?

> +		bounce =3D NULL;
> +	} else {
> +		// Allocate bounce buffer from device coherent memory
> +		bounce =3D dma_alloc_coherent(dev, size, &map_handle, GFP_KERNEL | __G=
FP_ZERO);

[Severity: High]
Can this allocation sleep in atomic context?

virtio_map_ops->map_page() is frequently called inside atomic contexts,
such as inside virtqueue_add_outbuf() while holding a spinlock. Does using
GFP_KERNEL here allow blocking operations like direct reclaim, causing a
deadlock or bug?

> +		if (!bounce)
> +			return DMA_MAPPING_ERROR;
> +
> +		// Copy data to bounce buffer
> +		memcpy(bounce, vaddr, size);

[Severity: High]
Should this copy be conditional on the DMA direction?

For DMA_FROM_DEVICE, the host buffer is typically uninitialized. Does
unconditionally copying to the bounce buffer leak uninitialized kernel memo=
ry
to the remote processor?

> +	}
> +
> +	// Save bounce details
> +	record =3D &rvdev->map_records[rproc_virtio_bounce_slot(dev, map_handle=
)];

[Severity: Critical]
Could this write to a 0-sized map_records array using an out-of-bounds inde=
x?

If dma_dev_coherent_size(dev) returns 0 (which happens when the device uses
the global DMA pool), rvdev->map_records will be allocated as ZERO_SIZE_PTR.

When bounce buffering uses the global DMA pool, it returns a valid handle.
rproc_virtio_bounce_slot() will compute an arbitrary, large slot index
from this handle by subtracting DMA_MAPPING_ERROR. Does this cause a severe
out-of-bounds write off ZERO_SIZE_PTR and crash the kernel?

> +
> +	record->original =3D vaddr;
> +	record->size =3D size;
> +	record->bounce =3D bounce;
> +
> +	return map_handle;
> +}
> +
> +static void rproc_virtio_unmap_page(union virtio_map map, dma_addr_t map=
_handle,
> +				    size_t size, enum dma_data_direction dir,
> +				    unsigned long attrs)
> +{
> +	struct device *dev =3D map.dma_dev;
> +	struct rproc_vdev *rvdev =3D dev_get_drvdata(dev);
> +	unsigned int slot =3D rproc_virtio_bounce_slot(dev, map_handle);
> +	struct rproc_map_record *record =3D &rvdev->map_records[slot];
> +
> +	WARN_ON(size !=3D record->size);
> +
> +	// If a bounce buffer was used, copy data back to original one
> +	if (record->bounce) {
> +		memcpy(record->original, record->bounce, record->size);

[Severity: High]
Does this unconditionally overwrite the original buffer regardless of DMA
direction?

For DMA_TO_DEVICE, this copies the bounce buffer back to the host buffer.
Could this overwrite the original host buffer with potentially tampered
device data and corrupt memory if the original buffer was read-only?

> +
> +		dma_free_coherent(dev, record->size, record->bounce, map_handle);
> +	}
> +
> +	record->original =3D NULL;
> +	record->size =3D 0;
> +	record->bounce =3D NULL;
> +}
> +
> +static void rproc_virtio_sync_single_for_cpu(union virtio_map map,
> +					     dma_addr_t map_handle,
> +					     size_t size,
> +					     enum dma_data_direction dir)
> +{
> +	struct device *dev =3D map.dma_dev;
> +
> +	dma_sync_single_range_for_cpu(dev, (map_handle & PAGE_MASK),
> +				      offset_in_page(map_handle), size, dir);
> +}
> +
> +static void rproc_virtio_sync_single_for_device(union virtio_map map,
> +						dma_addr_t map_handle,
> +						size_t size,
> +						enum dma_data_direction dir)
> +{
> +	struct device *dev =3D map.dma_dev;
> +
> +	dma_sync_single_range_for_device(dev, (map_handle & PAGE_MASK),
> +					 offset_in_page(map_handle), size, dir);
> +}

[Severity: High]
Are these dma_sync_single operations missing the bounce buffer memory copy?

When bounce buffering is active, streaming DMA sync operations must physica=
lly
mirror data updates between the original host buffer and the bounce buffer,
since the device only sees the bounce buffer.

Since these functions only execute cache maintenance on the coherent map_ha=
ndle
without copying the data to or from record->bounce and record->original, wi=
ll
the CPU or device read unsynchronized data?

[ ... ]
> @@ -429,13 +583,29 @@ static int rproc_add_virtio_dev(struct rproc_vdev *=
rvdev, int id)
[ ... ]
>  		of_reserved_mem_device_init_by_idx(dev, np, 0);
>  	}
> =20
> +	/* Allocate one tracking record for each page of the device reserved
> +	 * memory. Contiguous memory is not required for this array, which can
> +	 * also be quite big (depending on the size of the coherent memory), so
> +	 * let's use vmalloc for this allocation.
> +	 */
> +	rvdev->map_records =3D kvcalloc(dma_dev_coherent_size(dev) >> PAGE_SHIF=
T,
> +				      sizeof(*rvdev->map_records),
> +				      GFP_KERNEL);

[Severity: Critical]
Does this allocate a 0-sized array when there is no coherent memory pool?

dma_dev_coherent_size(dev) returns 0 when the device uses the global DMA
pool, which is the expected fallback behavior when
of_reserved_mem_device_init_by_idx() fails. kvcalloc(0, ...) will return a
ZERO_SIZE_PTR for rvdev->map_records, setting up the out-of-bounds write in
rproc_virtio_map_page().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D6
