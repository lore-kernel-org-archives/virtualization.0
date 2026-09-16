Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7B4A013C;
	Wed, 16 Sep 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595566; cv=none; b=n6uGjOyosiUMnOxU7Vr5Z3pbVOtUZr1dCrzW46OHvaloDqWy2W4pU6tphaRLC5m8RYOCoL/X+0hjMXPlYd/iTkwlZkahAJzqSisa925vYkbKejfk0Smfd4wTpY7LzhZtRQ9QJx8LiMRz4te19+BHnNFOyg4YJkpLp6H0S1QoKEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595566; c=relaxed/simple;
	bh=qF63vAghlhoevu3Q0jPQeRpXmC0La9TF4NrPA5p/JKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VDUCJRHbO5ginQFp/S83fRg9UnCl7xqshrmEyxOdv6A47JS2U7EwJ5LDmk+QyEgnwaiPD/0NemOiBvnD2/NJi9vBbdzNWN3AB5TYhUBX3UU8kx0OJ73V5N4/DKpQBHtHqSHivAZ1xafu/OJcvsJflR2YO974yrUdxyNF/yiI17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpUAhBtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpUAhBtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55B61F00893;
	Wed, 16 Sep 2026 21:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595555;
	bh=qF63vAghlhoevu3Q0jPQeRpXmC0La9TF4NrPA5p/JKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpUAhBtqUgagBRWUQAw8wMvaFw3V97C2dLmNP0p0ihR0ImFqfOfVBB5hAZ+TWcY67
	 1DLxzIs4ql3TPheM3lkrgIq+ywUjvexG0VKt6xGA4O24acaP+pTwNWDVgCQ3A4mKW7
	 qahU1TwlO3rrdj7y2IS45W7+LKIWmFzTydM2YfyuIQSGBl1c721pveXF8lAwzi8Vg+
	 OCYvQB9XBUIZ4Vm9HNwwDgNHP+yosn/rXCVZ16aSKtpuZOQ+gFJRkbx4buJHCYxqY3
	 p9ZqBE8lJ5Hh1MLa7MJGfobtPBu8euCck6S/VsQEKAXaLQggW6e4iV5/yYjFjLgahn
	 TGTLJhJhyLQEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/12] dt-bindings: spi: add bindings for spi-virtio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: devicetree@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Frank.Li@kernel.org, robh@kernel.org, virtualization@lists.linux.dev, imx@lists.linux.dev, conor+dt@kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-7-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-7-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:52:34 +0000
Message-Id: <20260916215234.C55B61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: incorrect $id field mismatch with file path
--

commit 99192664ff7285bbce15e5c723c17794d6fd59e0
Author: Francesco Valla <francesco@valla.it>

dt-bindings: spi: add bindings for spi-virtio

Add bindings for spi-virtio, based on virtio-device.

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
Does this $id field mismatch the file path? It appears to reference
http://devicetree.org/schemas/i2c/i2c-virtio.yaml# instead of the expected
http://devicetree.org/schemas/spi/spi-virtio.yaml#.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D7
