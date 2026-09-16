Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E464A689C;
	Wed, 16 Sep 2026 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789596262; cv=none; b=T4+iXI9OnalOnu5qEEXLAFB44I8J2nz4GrGd0t2WuUAWBxGpioxNZ8M3LiOM12Bd4B4y62CotN8H/f3+lLkNofcQwC8Z5hazp+z7rjAC+Na3ONwGyC9aD9rYp+noD6LYr9ktVUgQXkXpmji2MNyNNOuVWaKT4BdoxuGV/wWnr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789596262; c=relaxed/simple;
	bh=EtvbuklPTPVXZnxPZXWEklfU5Vq3uW4LB+72UMXB6wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N6n5FAyoOB6K7+w3d/2MKUSlZQGGQmaFBzO/RBIVm/VpFRAkgul9yRYiF9iJqSe7+v7sRlAj80AijnandHTgQK8Q7d05Dq84XZkv/faMAT8ImrNWdBDMbDgxytR6ooc51p3j4qFbigtMNgUT1dWhGpg/dpNKew62joeTwjpqXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T534NpDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T534NpDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33731F000FF;
	Wed, 16 Sep 2026 22:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789596252;
	bh=d50bke8M6hJYG40XNpBeWs6P8+3tukrXfK7gW02ekrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T534NpDSrcmre+JuwpLely9OL+Jn+GFvmO2rQNs8vkt+zz6u3P0zmOuEV42s4iAWw
	 Hxg72SOO8bnCyC23N/QrSBnQ8wYsIYN8ukwmCddF+KbmRsbEgjQvNRVeQ3d0hpqibN
	 tF4ddgPv9xW98R9U9hlkyp6EaCeTa3NYSwfHrZFLjH7gk/g5sBeE8KS9Ye0PRpKr6P
	 wBH3uhMvAYCMkRbjOzNult3g1wA1FEN91cw93XgaWA3B2kjTe9XkAwo3UNxXiUAGOb
	 yQxQ99znG7gD3QJ66N5aBHnzBouULo38LG7XiXj3rKP+Ph7VRWaQvJT0kYoxC/HhAb
	 +INmgX4bSwGbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/12] dt-bindings: remoteproc: imx-rproc: support
 virtio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: robh@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, conor+dt@kernel.org, Frank.Li@kernel.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-11-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-11-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:04:11 +0000
Message-Id: <20260916220411.B33731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] remoteproc: out-of-bounds access in rproc_virtio_bounce_slot() fal=
lback
- [High] remoteproc: map_records state corruption for sub-page buffers
- [Medium] remoteproc: fwnode reference leak in rproc_handle_vdev()
- [Low] dt-bindings: spi-virtio.yaml has incorrect $id path
- [Low] dt-bindings: remoteproc-virtio uses maxItems on object
--

commit f36ec8f81fd31468ec48cdde83e92aca3916fcb9
Author: Francesco Valla <francesco@valla.it>

dt-bindings: remoteproc: imx-rproc: support virtio

Add support for virtio devices description.

> diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-virt=
io.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.ya=
ml
> new file mode 100644
> index 0000000000000..c4a0d84b14600
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.yaml

[ ... ]

> +    patternProperties:
> +      "^vdev@[0-9a-f]+$":
> +        type: object
> +
> +        properties:
> +          reg:
> +            description: Virtio device index inside the resource table.
> +            maxItems: 1
> +
> +        additionalProperties:
> +          type: object
> +          $ref: /schemas/virtio/virtio-device.yaml
> +          maxItems: 1

[Severity: Low]
Does this maxItems: 1 have any effect?

maxItems is a JSON schema keyword that strictly applies only to arrays. Sin=
ce
the child node is declared as type: object, maxItems: 1 is completely ignor=
ed
by the schema validator. Should maxProperties be used on the parent node in=
stead
if the goal was to limit the node to a single child?

> diff --git a/Documentation/devicetree/bindings/spi/spi-virtio.yaml b/Docu=
mentation/devicetree/bindings/spi/spi-virtio.yaml
> new file mode 100644
> index 0000000000000..1a0a0763bd2fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-virtio.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/i2c-virtio.yaml#

[Severity: Low]
Is the $id path correct?

DT schema subsystem guidelines strictly require the $id property path to ex=
actly
match the file's location relative to Documentation/devicetree/bindings/. T=
his
newly introduced file has its $id incorrectly declared as
http://devicetree.org/schemas/i2c/i2c-virtio.yaml# due to a copy-paste erro=
r.
This mismatch breaks the schema cross-referencing system during
dt_binding_check.

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/re=
moteproc_core.c
> index 1ed4067148491..e3ecc61cc1def 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c

[ ... ]

> @@ -511,8 +528,16 @@ static int rproc_handle_vdev(struct rproc *rproc, vo=
id *ptr,
>  	 * as device id, then we get duplication in sysfs, so need to use
>  	 * PLATFORM_DEVID_AUTO to auto select device id.
>  	 */
> -	pdev =3D platform_device_register_data(dev, "rproc-virtio", PLATFORM_DE=
VID_AUTO, &rvdev_data,
> -					     sizeof(rvdev_data));
> +	memset(&pdev_info, 0, sizeof(pdev_info));
> +	pdev_info.parent =3D dev;
> +	pdev_info.fwnode =3D rproc_get_vdev_fwnode(dev->parent, rvdev_data.inde=
x);
> +	pdev_info.of_node_reused =3D true;
> +	pdev_info.name =3D "rproc-virtio";
> +	pdev_info.id =3D PLATFORM_DEVID_AUTO;
> +	pdev_info.data =3D &rvdev_data;
> +	pdev_info.size_data =3D sizeof(rvdev_data);
> +
> +	pdev =3D platform_device_register_full(&pdev_info);

[Severity: Medium]
Does this code leak the fwnode reference in rproc_handle_vdev()?

rproc_get_vdev_fwnode() iterates over child nodes and returns a fwnode hand=
le
with an incremented reference count via fwnode_get_next_child_node(). This
returned fwnode is assigned to pdev_info.fwnode.

platform_device_register_full() internally passes this to device_set_node(),
which explicitly takes its own reference to the fwnode by calling
fwnode_handle_get(). After platform_device_register_full() returns,
rproc_handle_vdev() exits without ever dropping its original reference acqu=
ired
by rproc_get_vdev_fwnode(), causing a permanent fwnode resource reference l=
eak.

> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/=
remoteproc_virtio.c
> index d5e9ff045a28a..d21b3b8044df9 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c

[ ... ]

> +static inline unsigned int rproc_virtio_bounce_slot(struct device *dma_d=
ev,
> +						    dma_addr_t dma_handle)
> +{
> +	const dma_addr_t dma_base =3D dma_dev_coherent_base(dma_dev);
> +
> +	return (dma_handle - dma_base) >> PAGE_SHIFT;
> +}
> +
> +static dma_addr_t rproc_virtio_map_page(union virtio_map map, struct pag=
e *page,
> +					unsigned long offset, size_t size,
> +					enum dma_data_direction dir,
> +					unsigned long attrs)
> +{

[ ... ]

> +	if (paddr >=3D dma_base && paddr < (dma_base + dma_size)) {
> +		// The allocation details will be recorded also in this case,
> +		// indicating that no bounce buffer was allocated.
> +		map_handle =3D (dma_addr_t)paddr;
> +		bounce =3D NULL;
> +	} else {
> +		// Allocate bounce buffer from device coherent memory
> +		bounce =3D dma_alloc_coherent(dev, size, &map_handle, GFP_KERNEL | __G=
FP_ZERO);
> +		if (!bounce)
> +			return DMA_MAPPING_ERROR;
> +
> +		// Copy data to bounce buffer
> +		memcpy(bounce, vaddr, size);
> +	}
> +
> +	// Save bounce details
> +	record =3D &rvdev->map_records[rproc_virtio_bounce_slot(dev, map_handle=
)];
> +
> +	record->original =3D vaddr;
> +	record->size =3D size;
> +	record->bounce =3D bounce;

[Severity: High]
Can this write out-of-bounds in rproc_virtio_map_page() if the device lacks=
 a
dedicated coherent memory pool, or if the pool is exhausted?

When a bounce buffer is needed, it calls dma_alloc_coherent(). If the device
pool is exhausted or non-existent, it transparently falls back to generic s=
ystem
memory. The returned map_handle will not be based at dma_base.

rproc_virtio_bounce_slot() will then compute a completely uncontrolled slot
index using (map_handle - dma_base) >> PAGE_SHIFT. The function then writes=
 to
rvdev->map_records[slot], causing an immediate out-of-bounds array write and
corrupting adjacent kernel memory.

[Severity: High]
Can this corrupt the map_records state for sub-page buffers?

If virtio drivers map multiple sub-page buffers (e.g., headers or small
requests) that happen to fall within the same physical page in the coherent
pool, they will compute the exact same slot index because the shift operati=
on
in rproc_virtio_bounce_slot() discards the offset.

The second mapping will overwrite the map_records entry of the first mapping
(record->original and record->size). During rproc_virtio_unmap_page(), this
leads to a WARN_ON(size !=3D record->size) trigger and incorrectly clears t=
he
shared state, corrupting subsequent unmaps for that page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D11
