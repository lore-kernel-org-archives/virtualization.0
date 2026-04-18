Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB552D7DF1
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776532697; cv=none; b=pfgDREwaQRr+/fuPFU73MKgSWKtEUAyAniSaArC5tqV3ndHpLut+sr+jgn1MkehbU/mqlJHajcnPlvgiZbEA0ZBkokszNTxInVHgTEcwGHyynE1WYxhNzJhLC4m9dnuKtjL8RSnI8KX6z9C4svi3m34Svqy0NPuPKW+a2vOxJgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776532697; c=relaxed/simple;
	bh=Gu8eeLkTFWApFqN/pJd9fwrbx7MTr5fi31lrqj7DrzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=enpzKHtLRWJJtZfgWuL67zG8RihH1/hDWAftI6MPVazjUQDlQvbTnW1a/eFqzuJadpvMWj8NGLyGGGNwmomPgPTb2DOqnXxfONMiLSbHVICJJvq99s/BS9bgY7jX3zBjzFF+dH6yx6El9jy7SjUiAUGboxH63tlaLsBjWVTsH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpUOmx3A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpUOmx3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776532694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg1X2HhPqDML25PLvODz8bdExDJw0JHd2gmFAwXJGFI=;
	b=bpUOmx3AGLgCBTkSiVmfE/wBdqIVjgX05Q6REY+VMK1/hCxuu3Bf7I1PNUiHK1O2VDYnK3
	piIatKR1ulrEl+18+iLuuLfAUegkV85VbRdkOh9ZgGwC46/AoKdLSL/s0Ritg8RdsoXDOT
	zhYp+Mtw42nyH1iG6f/Xyh0cSnywBsc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-sHYIDU-bOz2QT0IVy1UCRQ-1; Sat, 18 Apr 2026 13:18:12 -0400
X-MC-Unique: sHYIDU-bOz2QT0IVy1UCRQ-1
X-Mimecast-MFC-AGG-ID: sHYIDU-bOz2QT0IVy1UCRQ_1776532692
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488c16958e9so12089245e9.1
        for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 10:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776532691; x=1777137491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lg1X2HhPqDML25PLvODz8bdExDJw0JHd2gmFAwXJGFI=;
        b=GfRAHn5OpMPM2vpY3WUi2v4+8if/zrAu/dF/u+myb7bohjZmacRsJEGWzcwpbB/TH9
         jWkes11lzDq3Hw09fMX9gISzr17+lx3+bCmtUowICxeTh+uCP/zcInctsNTnyKLN5wA0
         LC1eNGxgQTuWV1w0ZNXpCqykLuo9zVLwsAhuHDeWKzSKLAGA977PtjBR3WG7IHXLWc3c
         YBE9poqPJ1vHpA5EGa34ZB1AYuVdYjsOsdSZwinCc/tYrykvFhOmjx3ImGX+1MNcHQeZ
         bTO29xYbLpOPPj8ynKGF++N7hV8TTcGQfHnNe8q1Ez+VJfq84JUvj9MsQXJYn6h9gPnD
         bgqg==
X-Forwarded-Encrypted: i=1; AFNElJ/KZuMdDKklW1YmpFyeDR5rXhGm+Q2crz2LGJadf4UKwc9WfxzhqJ7uw8+YildRx+oY+Iws6mU0MxY/uabM3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk3pUPWCaiJPQ0xexZn/fRN/jNALGqh1kmS4z7FEFjIvMu5ibe
	kbDYYvbyOi17+S3VedzKIQGhiDO541jAIz6L7eB6DeXyZ6r1115ta5uxokJCoCi7OXnMzH/s5YA
	vQK9J2zsO7OEsjDsWSfrSbxChwU64vPUBJ3chDesmXXDUb5UWh7hk5wdIgHg9wynKWuZQfYc4mN
	hC
X-Gm-Gg: AeBDiesBj6JDmR0sLhn4deO0+KOlORgjDMaAiXOtxlxDGn/v3CVEjQ5Azql8v4jd6CJ
	mLCTq35ftAwfymJiDjANgrO7+BK2nWYFhB8Re8al292xSKePAnnm2IFxxrBSx5HD/0qJXYYcUdE
	XxyYcW9P9tS1EspbCV2If0LOFhRO7mFqLD93X3/+luc2ykuiEvHNvSzujT5y0AE/vvIVDRW5kou
	Tpmcy4VjboDxY9+KofyCaspdlG9cRI5zUrIR9Epu8VsIeHx9U0By9MkT2fMOnwGXImRBj3/jrsC
	UyXXZ40U2oJaL0HCh7HjwRCnJvnK6V9kleuV+vqUh76G814MG4m6/ZOdsa/z2vzqMvZqV9YHbO3
	htjR0C3tbTbMXQe/1aHgDNFfKnzd4K+oVXCIJIyJmXY+Wg3xF1RvS9w==
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488fb6e815amr111086655e9.0.1776532691217;
        Sat, 18 Apr 2026 10:18:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488fb6e815amr111085965e9.0.1776532690536;
        Sat, 18 Apr 2026 10:18:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c0354sm129158345e9.11.2026.04.18.10.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 10:18:09 -0700 (PDT)
Date: Sat, 18 Apr 2026 13:18:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwrng: virtio: clamp device-reported used.len at
 copy_data()
Message-ID: <20260418131110-mutt-send-email-mst@kernel.org>
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
 <20260418150613.3522589-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260418150613.3522589-1-michael.bommarito@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4JV0BgtbKz6Z-xdUgQ9fUvbRS5qmSBYuKhncVl2L74s_1776532692
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 18, 2026 at 11:06:13AM -0400, Michael Bommarito wrote:
> random_recv_done() stores the device-reported used.len directly into
> vi->data_avail.  copy_data() then indexes vi->data[] using
> vi->data_idx (advanced by previous copy_data() calls) and issues a
> memcpy() without re-validating either value against the posted
> buffer size sizeof(vi->data) (SMP_CACHE_BYTES bytes, typically 32
> or 64).
> 
> A malicious or buggy virtio-rng backend can set used.len beyond
> sizeof(vi->data), steering the memcpy() past the end of the inline
> array into adjacent kmalloc-1k slab bytes.  hwrng_fillfn() mixes
> those bytes into the guest RNG, and guest root can also observe
> them directly via /dev/hwrng.
> 
> Concrete impact is inside the guest:
> 
>  - Memory-safety / hardening: any virtio-rng backend that
>    over-reports used.len causes the driver to read past vi->data
>    into unrelated slab contents.  hwrng_fillfn() is a kernel thread
>    that runs as soon as the device is probed; no guest userspace
>    interaction is required to first-trigger the OOB.
> 
>  - Cross-boundary leak (confidential-compute threat model): a
>    malicious hypervisor cooperating with a malicious or compromised
>    guest root userspace can use /dev/hwrng as a leak channel for
>    guest-kernel heap data.  The host sets a large used.len, guest
>    root reads /dev/hwrng, and the returned bytes contain guest
>    kernel slab contents that were adjacent to vi->data.  In
>    practice, confidential-compute guests (SEV-SNP, TDX) usually
>    disable virtio-rng entirely, so this path is narrow, but the
>    fix is still worth carrying because the underlying
>    memory-safety bug contaminates the guest RNG on any host.
> 
> KASAN confirms the OOB on a guest booted under a QEMU 9.0 whose
> virtio-rng backend has been patched to report used.len = 0x10000:
> 
>   BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
>   Read of size 64 at addr ffff8880089c2220 by task hwrng/52
>   Call Trace:
>    __asan_memcpy
>    virtio_read+0x394/0x5d0
>    hwrng_fillfn+0xb2/0x470
>    kthread
>   Allocated by task 1:
>    probe_common+0xa5/0x660
>    virtio_dev_probe+0x549/0xbc0
>   The buggy address belongs to the object at ffff8880089c2000
>    which belongs to the cache kmalloc-1k of size 1024
>   The buggy address is located 0 bytes to the right of
>    allocated 544-byte region [ffff8880089c2000, ffff8880089c2220)
> 
> Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
> overflow in USB transport layer"), which hardened
> usb9pfs_rx_complete() against unchecked device-reported length in
> the USB 9p transport.
> 
> With the clamp at point of use and array_index_nospec() in place,
> the same harness boots cleanly: copy_data() returns zero for the
> bogus report, the device-supplied bytes after data_idx are
> discarded, and the driver issues a fresh request.
> 
> Changes in v2 (per Michael S. Tsirkin review):
> - move the bound check from random_recv_done() into copy_data(),
>   so the clamp sits immediately next to the memcpy it protects
> - clamp to sizeof(vi->data) rather than substituting len = 0, so a
>   previously-working but buggy device that occasionally over-reports
>   used.len does not start returning zero-length reads
> - add array_index_nospec() on vi->data_idx to defeat a speculative
>   out-of-bounds read given the malicious-backend threat model
> - expand the commit message to describe the /dev/hwrng observation
>   path and the hypervisor + guest-root cooperation scenario
> 
> Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
> Cc: stable@vger.kernel.org
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  drivers/char/hw_random/virtio-rng.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 0ce02d7e5048..5e83ffa105e4 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -7,6 +7,7 @@
>  #include <asm/barrier.h>
>  #include <linux/err.h>
>  #include <linux/hw_random.h>
> +#include <linux/nospec.h>
>  #include <linux/scatterlist.h>
>  #include <linux/spinlock.h>
>  #include <linux/virtio.h>
> @@ -69,8 +70,26 @@ static void request_entropy(struct virtrng_info *vi)
>  static unsigned int copy_data(struct virtrng_info *vi, void *buf,
>  			      unsigned int size)
>  {
> -	size = min_t(unsigned int, size, vi->data_avail);
> -	memcpy(buf, vi->data + vi->data_idx, size);
> +	unsigned int idx, avail;
> +
> +	/*
> +	 * vi->data_avail was set from the device-reported used.len and
> +	 * vi->data_idx was advanced by previous copy_data() calls.  A
> +	 * malicious or buggy virtio-rng backend can drive either past
> +	 * sizeof(vi->data).  Clamp at point of use and harden the index
> +	 * with array_index_nospec() so the memcpy() below cannot be
> +	 * steered into adjacent slab memory, including under
> +	 * speculation.
> +	 */
> +	avail = min_t(unsigned int, vi->data_avail, sizeof(vi->data));
> +	if (vi->data_idx >= avail) {
> +		vi->data_avail = 0;
> +		request_entropy(vi);
> +		return 0;
> +	}
> +	size = min_t(unsigned int, size, avail - vi->data_idx);
> +	idx = array_index_nospec(vi->data_idx, sizeof(vi->data));
> +	memcpy(buf, vi->data + idx, size);
>  	vi->data_idx += size;
>  	vi->data_avail -= size;
>  	if (vi->data_avail == 0)
> -- 


This came out quite complex.
Tell me, will the following do the trick?


diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 0ce02d7e5048..e887a68cc151 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -47,6 +47,8 @@ static void random_recv_done(struct virtqueue *vq)
 	if (!virtqueue_get_buf(vi->vq, &len))
 		return;
 
+	len = array_index_nospec(len, sizeof(vi->data));
+
 	smp_store_release(&vi->data_avail, len);
 	complete(&vi->have_data);
 }



> 2.53.0

