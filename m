Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA73101D0
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776533148; cv=pass; b=rZ1rmgrmfQDTmxNxyp1DTYQirCAyrLhiQC1mlxNHQW0hrDDYtgzF4uSO+l3IualZyxBCtK0RuhMRMer8LG2hrvlH32qX8TsJP4DAezqzJ/cvB1ZbCeQcwgBnaKN+uiQvtjORuilrG8yM4xQUBsZf0XMRbioTiiHF3gi7gUVrifo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776533148; c=relaxed/simple;
	bh=PXs6wNz75xIBGdCbRKGTDNq3jTK8HB4Mt+I/IXfIlfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBf9SGWmyDCPwURcf61bYB6sJclp+KYSYuYSJkO/2fCUtbEu3pJQrail082MsWJ4PGqpQigvf+FKyUaHJcc8ljCFrnpYzWqzePdnk5xFipxL5Bpt0j+96eR8N8hWw/Zyjv8p5qZAflbCw/NCwlxlE6QK0Im5y1vsoU5RnACDA04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVZL58Ni; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVZL58Ni"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a535e7c00so17670557b3.3
        for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 10:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776533146; cv=none;
        d=google.com; s=arc-20240605;
        b=QcwV5pfq7rPcJLjFYWAVzd2be7UbYI8rwFmp8mqGaClDGysjv0Yb+LLLP84KvL6H4H
         JrxRRxil9knwSjHMIJuHAJ6Gm3sYPIdEQwmr0cxhHvt/p5LWNi2lNCNKgn91B5TzTzrj
         UUrnSBMLUX2BAHJ4uNLIHgVIXpZY7y1rTRCm4fByBbVtFj2vbo385pvHIP0ZE7n0dEbb
         VIDOwKXCxX/m8l32qv8VLzwKse/6C0LoOn9qj4KKJ3fr1EK2qojbhc3/qGMQrFxAZ5fh
         +6Kv9Todu6FnhboX5n9q3QUWjkXutRjMrpi8ho9GWcpqOtbZF81VSrbDG1RxMNqNBw2c
         NPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSTI/WkTQ8ZEaBBDiJFn9nk0Gv0pkdWzZ/x/WhPv15g=;
        fh=woaEFzfdxW+PPmsHak5jukFn5hxCENYTFh71suy+1Ts=;
        b=ijGY6qO1UK0+qvFc2tvIpECw+n+/nJEMuwvwUiefAHMS6vKuLtUuGwl5rACFPXGvdT
         2xazfUdOVHB//7nxha5hSwsgS+CxAQA6RcK4FMAW4byjMPBUHSyT6MFOicJaQ35hzJvE
         IrCSsuqWaAw4uSbtJgCLt2LrTyN3q5tYVvJK3cwAo1CDEkcSC98K62Vks82RO7o1fS+j
         HekpxUNEQ6zEL/YQMYeFamHi0jxmoC28LAvY2F52x12jqN3eHL2RRejn2AqQF8Sopgh0
         vGv30xfH9Oqozl4EThAlazjkHxcNP33sFFzvP+VsW/t6je3O0IZtC9HrJulSHRDbw0Cq
         SXrQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776533146; x=1777137946; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSTI/WkTQ8ZEaBBDiJFn9nk0Gv0pkdWzZ/x/WhPv15g=;
        b=sVZL58Ni87W2LoilzQy1wWxZhIiOyyxQAcaRudgnMItVfUSTAvoDfFOIwfeD/XE+lv
         jZa7SFqUGn9P6VmpAVQ5SZW9LfExafDl7M4+nkgYFqigy00C1nVDms0huKMnoFdX4BRL
         YhYTYI5X0iiUBM8K//CF/AJB9+wDxo9WnPylpE3seOw4/hu5JhXjZr7IFIxOGd3Q9Ypi
         HCK0OjizctgGVEtIz+peWDT+lc5GTyjB4EzJGLz20neMH+uLYTqBs8kp3R9eMomznuZT
         SyHIkol/WGqSoU3pAYyXNYLDbXyECFDXCYTms8M6NVXxwthfwEhAMUGHy2nuvFNZmHHJ
         DdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776533146; x=1777137946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSTI/WkTQ8ZEaBBDiJFn9nk0Gv0pkdWzZ/x/WhPv15g=;
        b=YjikVu25Wq+/yCWOZfMpLflwLntEjdX1wkuPya+di32MNux4N1PkLYfRNd3CqrcUdV
         WyQ/MAqSfrgEFHkn+EbTh7X7Qg/jK5sXqsJVWAs51yxtOvpO62/yiYTyeKkIRbEzas0B
         JoEiARBQ3nm/A1lKCOtq1QyDXgeMj3XN4igd/KK+of8QZ/zBoja2Fmhvjan0G3e4OWZr
         RuDN12e3Jp/alNcBOQWW0BQ6fwDEyz0eDByYL5RNG8Lr2QAmXf0QMNgY1J0nkRhLpaPl
         fZywKZFI4/iS1yywgAJ3Kx4Et9ZGJxq7IRcuswBcr5BXke0a09zJ3GtZmsah42elTxxE
         Ljkg==
X-Forwarded-Encrypted: i=1; AFNElJ8R6/3dDTyKBwMHPG5+lH0M/H4uc4HyKiZGjfuoM+cQ245PtQ5hL6RoikXYet9vuDOM71JGOj/zcbA5EqCpqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgG3CwpV5ggBXZ9jmNLIPK8hQjnUgbU2G+NDSv9nGcf0hYRO0V
	8X+8oNuKh6rjxaimB3iQj8CukgCkFdspVH+dt/VYDasuz8UIkDuz2hBrXOQ0zD94iokE5RUGVO8
	/1nluT3BFfb+TCVxsiN5ucOZsjr1IgHs=
X-Gm-Gg: AeBDies0ObX8LTcUn2OZv/YH1OmacqADDchcpOk0idOYdvOduv7fAB7OXbu1fS6kuqL
	S7duRl9bp7ev9RRs7PbSWHbKvH19J/IUMVb+Jv0ulcy3XOg0YMbXBf2o9w4ezh6IedEgQ+tXKiZ
	b96PwOzoeZ667ItKT7NWMIMUQ0y8bYIub9fv8LPd+DKWkxqS+WE7R3SMiJX10Tq6of4dqN98U3m
	TQDpv+Iip79Ytt6GrvJTUOj4hJJJ8eccvI3NFYZM+a66n6degHR3EtyXxgplYl25VN7lOYopD8c
	gpi03OnQiZjFnSqRKziEIqwa5+6ymLOXOPYO1uWCm5Ee9NI=
X-Received: by 2002:a05:690c:6287:b0:7b7:c5a2:fa49 with SMTP id
 00721157ae682-7b9eced6930mr77017957b3.18.1776533146371; Sat, 18 Apr 2026
 10:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
 <20260418150613.3522589-1-michael.bommarito@gmail.com> <20260418131110-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260418131110-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Apr 2026 13:25:35 -0400
X-Gm-Features: AQROBzDT3kYQN6FTEB39CbF7ifYRqJlh98jShRI2O0kpza3_E2SMt54ZBVdorkI
Message-ID: <CAJJ9bXzgpAR3Gm+mZu=mZJyUrc6bpd+_crOGa7HLxteKxw1DzA@mail.gmail.com>
Subject: Re: [PATCH v2] hwrng: virtio: clamp device-reported used.len at copy_data()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think the difference comes back to how much you care about the
threat model and something like Spectre on the memcpy later in
copy_data.  The more verbose patch would keep the barrier at the cost
of the code complexity and a few extra cycles, but then we're back to
same tradeoffs that have haunted just about everyone.

Will obviously defer to you on which path is really preferred, so let
me know if you want v3 with the simple nospec clamp.

Thanks,
Michael Bommarito

On Sat, Apr 18, 2026 at 1:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Apr 18, 2026 at 11:06:13AM -0400, Michael Bommarito wrote:
> > random_recv_done() stores the device-reported used.len directly into
> > vi->data_avail.  copy_data() then indexes vi->data[] using
> > vi->data_idx (advanced by previous copy_data() calls) and issues a
> > memcpy() without re-validating either value against the posted
> > buffer size sizeof(vi->data) (SMP_CACHE_BYTES bytes, typically 32
> > or 64).
> >
> > A malicious or buggy virtio-rng backend can set used.len beyond
> > sizeof(vi->data), steering the memcpy() past the end of the inline
> > array into adjacent kmalloc-1k slab bytes.  hwrng_fillfn() mixes
> > those bytes into the guest RNG, and guest root can also observe
> > them directly via /dev/hwrng.
> >
> > Concrete impact is inside the guest:
> >
> >  - Memory-safety / hardening: any virtio-rng backend that
> >    over-reports used.len causes the driver to read past vi->data
> >    into unrelated slab contents.  hwrng_fillfn() is a kernel thread
> >    that runs as soon as the device is probed; no guest userspace
> >    interaction is required to first-trigger the OOB.
> >
> >  - Cross-boundary leak (confidential-compute threat model): a
> >    malicious hypervisor cooperating with a malicious or compromised
> >    guest root userspace can use /dev/hwrng as a leak channel for
> >    guest-kernel heap data.  The host sets a large used.len, guest
> >    root reads /dev/hwrng, and the returned bytes contain guest
> >    kernel slab contents that were adjacent to vi->data.  In
> >    practice, confidential-compute guests (SEV-SNP, TDX) usually
> >    disable virtio-rng entirely, so this path is narrow, but the
> >    fix is still worth carrying because the underlying
> >    memory-safety bug contaminates the guest RNG on any host.
> >
> > KASAN confirms the OOB on a guest booted under a QEMU 9.0 whose
> > virtio-rng backend has been patched to report used.len =3D 0x10000:
> >
> >   BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
> >   Read of size 64 at addr ffff8880089c2220 by task hwrng/52
> >   Call Trace:
> >    __asan_memcpy
> >    virtio_read+0x394/0x5d0
> >    hwrng_fillfn+0xb2/0x470
> >    kthread
> >   Allocated by task 1:
> >    probe_common+0xa5/0x660
> >    virtio_dev_probe+0x549/0xbc0
> >   The buggy address belongs to the object at ffff8880089c2000
> >    which belongs to the cache kmalloc-1k of size 1024
> >   The buggy address is located 0 bytes to the right of
> >    allocated 544-byte region [ffff8880089c2000, ffff8880089c2220)
> >
> > Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer
> > overflow in USB transport layer"), which hardened
> > usb9pfs_rx_complete() against unchecked device-reported length in
> > the USB 9p transport.
> >
> > With the clamp at point of use and array_index_nospec() in place,
> > the same harness boots cleanly: copy_data() returns zero for the
> > bogus report, the device-supplied bytes after data_idx are
> > discarded, and the driver issues a fresh request.
> >
> > Changes in v2 (per Michael S. Tsirkin review):
> > - move the bound check from random_recv_done() into copy_data(),
> >   so the clamp sits immediately next to the memcpy it protects
> > - clamp to sizeof(vi->data) rather than substituting len =3D 0, so a
> >   previously-working but buggy device that occasionally over-reports
> >   used.len does not start returning zero-length reads
> > - add array_index_nospec() on vi->data_idx to defeat a speculative
> >   out-of-bounds read given the malicious-backend threat model
> > - expand the commit message to describe the /dev/hwrng observation
> >   path and the hypervisor + guest-root cooperation scenario
> >
> > Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > Assisted-by: Claude:claude-opus-4-7
> > ---
> >  drivers/char/hw_random/virtio-rng.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_rand=
om/virtio-rng.c
> > index 0ce02d7e5048..5e83ffa105e4 100644
> > --- a/drivers/char/hw_random/virtio-rng.c
> > +++ b/drivers/char/hw_random/virtio-rng.c
> > @@ -7,6 +7,7 @@
> >  #include <asm/barrier.h>
> >  #include <linux/err.h>
> >  #include <linux/hw_random.h>
> > +#include <linux/nospec.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/virtio.h>
> > @@ -69,8 +70,26 @@ static void request_entropy(struct virtrng_info *vi)
> >  static unsigned int copy_data(struct virtrng_info *vi, void *buf,
> >                             unsigned int size)
> >  {
> > -     size =3D min_t(unsigned int, size, vi->data_avail);
> > -     memcpy(buf, vi->data + vi->data_idx, size);
> > +     unsigned int idx, avail;
> > +
> > +     /*
> > +      * vi->data_avail was set from the device-reported used.len and
> > +      * vi->data_idx was advanced by previous copy_data() calls.  A
> > +      * malicious or buggy virtio-rng backend can drive either past
> > +      * sizeof(vi->data).  Clamp at point of use and harden the index
> > +      * with array_index_nospec() so the memcpy() below cannot be
> > +      * steered into adjacent slab memory, including under
> > +      * speculation.
> > +      */
> > +     avail =3D min_t(unsigned int, vi->data_avail, sizeof(vi->data));
> > +     if (vi->data_idx >=3D avail) {
> > +             vi->data_avail =3D 0;
> > +             request_entropy(vi);
> > +             return 0;
> > +     }
> > +     size =3D min_t(unsigned int, size, avail - vi->data_idx);
> > +     idx =3D array_index_nospec(vi->data_idx, sizeof(vi->data));
> > +     memcpy(buf, vi->data + idx, size);
> >       vi->data_idx +=3D size;
> >       vi->data_avail -=3D size;
> >       if (vi->data_avail =3D=3D 0)
> > --
>
>
> This came out quite complex.
> Tell me, will the following do the trick?
>
>
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random=
/virtio-rng.c
> index 0ce02d7e5048..e887a68cc151 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -47,6 +47,8 @@ static void random_recv_done(struct virtqueue *vq)
>         if (!virtqueue_get_buf(vi->vq, &len))
>                 return;
>
> +       len =3D array_index_nospec(len, sizeof(vi->data));
> +
>         smp_store_release(&vi->data_avail, len);
>         complete(&vi->have_data);
>  }
>
>
>
> > 2.53.0
>
