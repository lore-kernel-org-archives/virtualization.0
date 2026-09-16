Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF14A4F14;
	Wed, 16 Sep 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595820; cv=none; b=i3y7GT5Gp+aj9Xz1Dyil/0ZpgXmAWP/agbrRCx320V8OSuLXRd/0RD1WxTOOxpHewOcYvECJxFDJGZA0bUl0eGlEa76XEyuaDHVdV++aItvX4xS77ZQpkVFsRDiG7CBVdu9C5PAXut2a4ynze+2ZLjHErttZruQleL80RgYk+Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595820; c=relaxed/simple;
	bh=zINLQ6gVzieFbNnGdWtBIl6QziLWoNX/jyuWioTzYmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H1P3Gknw4UnpcjdqX9UJM1xY8BFoPNFFuju8ojcMzEUH2b3z54AGw/gpPpFdKlYpYMzg0nGR2BfBgS12F8FHyOVB4RDmXsyR8CDHuVGD3so9GbsxIuIOWgCp++P3Wc2x9goSBF04mHccFDqFxfFAkDDIJdno+FnPaewbASiFmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC/wTYYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC/wTYYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976961F00893;
	Wed, 16 Sep 2026 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595809;
	bh=C/6ebuiiFp26Wu0sov8CP5Lw4+3ZrJoP//qnfiRvPBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WC/wTYYUGS5Y5GwEkqO3HrEu4/iX5rQo/VnyRD2Q2WAGGc/O+cC+dLXV7IuVTS1gs
	 uESIVWdoYucgAnj0T50lM/pr1HuU3imgHsO3An3GCtQio8KGu/y1/hS9j+uAZmW8Uw
	 /U6Fr1SZaQiak4DgOM9nBQZY2hKRBF2t7L4EAL89swU9T3VdtRyvAh1a/LwI9xcWow
	 zMtCnEhImsbdovlkbcbUaVSvrvXFEYA9DfKq5cx4qlsKEBe2tpM9aYMaXwdTC+p81i
	 QeXA28ixxI5E96eFylpcnV08goh/+bfyRlF0yXmltZ7H4ibDx3LNMDupbchbPOHYjU
	 Ez2vyFuwIiX2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/12] dt-bindings: remoteproc: add
 remoteproc-virtio
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-8-dac8c5eb4aa9@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:56:48 +0000
Message-Id: <20260916215648.976961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: invalid additionalProperties schema rejects standar=
d DT properties
- [Medium] dt-bindings: missing '#' suffix in schema cross-reference
--

commit a056caa69d11bba9e66b2d1ad31564837edf4b61
Author: Francesco Valla <francesco@valla.it>

dt-bindings: remoteproc: add remoteproc-virtio

This commit adds a new devicetree binding to describe remoteproc-provided
virtio devices. It introduces a virtio group node with child vdev nodes to
describe undiscoverable hardware or connect consumers and providers.

> diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-virt=
io.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-virtio.ya=
ml
> new file mode 100644
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

[Severity: Medium]
Does this additionalProperties block correctly handle standard devicetree
properties? Enforcing "type: object" for all unlisted properties means that
adding standard scalar or array devicetree properties (like "status",
"dma-coherent", or "phandle") to a vdev node will cause dt_binding_check to
fail validation.

> +          $ref: /schemas/virtio/virtio-device.yaml

[Severity: Medium]
Will this schema cross-reference resolve correctly during dt_binding_check?
The $ref path lacks the canonical trailing "#" suffix. According to standard
dt-bindings resolution logic, the $ref path must exactly match the target
schema's $id (which includes the "#"). Omitting it can break the cross
reference system and cause the validation of child nodes to be silently
skipped.

> +          maxItems: 1

[Severity: Medium]
Is the "maxItems: 1" constraint valid here? This JSON schema keyword is val=
id
only for arrays. Applying it to an object type will silently fail to restri=
ct
the number of child device nodes, rendering the constraint ineffective.

> +
> +        required:
> +          - reg
> +
> +    additionalProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-remoteproc=
_virtio_map-v1-0-dac8c5eb4aa9@valla.it?part=3D8
