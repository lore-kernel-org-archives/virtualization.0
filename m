Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3220CCE6;
	Mon,  3 Mar 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002860; cv=none; b=NGP2qCJjl2C8JvrNAKP3sTKANne46NqJ+flgooEvKiYQ0JVSh4t7v3YqmsEsKotmP2gzpm2xUr0q0C5wnr/clueJT24x6WMjJQvkmB+n474pch7V23GKnCTTH44HTvcdrrVrOQZb4uqp1ISAUGOEgGGKeKM2fa6FbXdbOC/YoB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002860; c=relaxed/simple;
	bh=oQAhDNZZHIdM8IkJONvRddVJgR3R9DzHAQ1ARr50o4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZBzZZsXNX/g6ZRfh/b5W4Bp4KlvYCZEKVrngxipYIRgddsGyMDIadT7Q7ZvdhsPpZp/cdbV2db2yPzZ0elmyivcoXL/kPXZHINcZb8ayLo6zNoCWfwHCtJLJFN9rfXVc6e3Rir5l8ExPU1tvne0gF8i94/+G18LjssB85zwW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHt35s6t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHt35s6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505B4C4CEE8;
	Mon,  3 Mar 2025 11:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741002860;
	bh=oQAhDNZZHIdM8IkJONvRddVJgR3R9DzHAQ1ARr50o4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YHt35s6t01Ze5P7mJ3/0Qr824U8rW/eB3bCnSoYVjbseNMmDzgtsKkKlK26uYT3ib
	 TItoFMKSD+C98d4zTtNDgaYFEZOAsNeCnE3UZwi1Mns9O4bMEPFjJOtUeAD056oXBM
	 NobX724F5a/rAmOcUCWa7FwrliPpSnk8RSRSmvQnjqWA/tzD/iv9susiJnNjFF98Qe
	 nr6ybnyOfDWXGMyAmFMd7+YBQrmc+fm0PChhtHZD5tY8j1ViMUBbNPB0WWOKCXND8C
	 9ykLjojN6i03Bf4cBGCt3mhQZHo2S8J48GvvETucW/trH9vVNmGTO/HfyufhfJdwo3
	 gPAkVdCeLnC0Q==
Message-ID: <f5ab160dadc2219b9576e50588dce88f22e9bcb1.camel@kernel.org>
Subject: Re: [PATCH] virtio: console: Make resizing compliant with virtio
 spec
From: Amit Shah <amit@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, brueckner@linux.ibm.com, 
	schnelle@linux.ibm.com, pasic@linux.ibm.com
Date: Mon, 03 Mar 2025 12:54:16 +0100
In-Reply-To: <20250225092135.1200551-1-maxbr@linux.ibm.com>
References: <20250225092135.1200551-1-maxbr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Tue, 2025-02-25 at 10:21 +0100, Maximilian Immanuel Brandtner wrote:
> According to the virtio spec[0] the virtio console resize struct
> defines
> cols before rows. In the kernel implementation it is the other way
> around
> resulting in the two properties being switched.

Not true, see below.

> While QEMU doesn't currently support resizing consoles, TinyEMU

QEMU does support console resizing - just that it uses the classical
way of doing it: via the config space, and not via a control message
(yet).

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/char/virtio_console.c#n1787

https://lists.nongnu.org/archive/html/qemu-devel/2010-05/msg00031.html

> diff --git a/drivers/char/virtio_console.c
> b/drivers/char/virtio_console.c
> index 24442485e73e..9668e89873cf 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1579,8 +1579,8 @@ static void handle_control_message(struct
> virtio_device *vdev,
> =C2=A0		break;
> =C2=A0	case VIRTIO_CONSOLE_RESIZE: {
> =C2=A0		struct {
> -			__u16 rows;
> =C2=A0			__u16 cols;
> +			__u16 rows;
> =C2=A0		} size;
> =C2=A0
> =C2=A0		if (!is_console_port(port))

This VIRTIO_CONSOLE_RESIZE message is a control message, as opposed to
the config space row/col values that is documented in the spec.

Maybe more context will be helpful:

Initially, virtio_console was just a way to create one hvc console port
over the virtio transport.  The size of that console port could be
changed by changing the size parameters in the virtio device's
configuration space.  Those are the values documented in the spec.=20
These are read via virtio_cread(), and do not have a struct
representation.

When the MULTIPORT feature was added to the virtio_console.c driver,
more than one console port could be associated with the single device.
Eg. we could have hvc0, hvc1, hvc2 all as part of the same device.=20
With this, the single config space value for row/col could not be used
for the "extra" hvc1/hvc2 devices -- so a new VIRTIO_CONSOLE_RESIZE
control message was added that conveys each console's dimensions.

Your patch is trying to change the control message, and not the config
space.

Now - the lack of the 'struct size' definition for the control message
in the spec is unfortunate, but that can be easily added -- and I
prefer we add it based on this Linux implementation (ie. first rows,
then cols).

But note that all this only affects devices that implement multiport
support, and have multiple console ports on a single device.  I don't
recall there are any implementations using such a configuration.

... which all leads me to ask if you've actually seen a
misconfiguration happen when trying to resize consoles which led to
this patch.

		Amit
