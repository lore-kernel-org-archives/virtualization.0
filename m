Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBB548EE
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471501; cv=pass; b=FPZcDTOC5FU4LHl7zXbNWoj1DMLIOe72tFG9S7FtRC5iAzjTPYByk29LBP3D59cVYZGOeKFLsxZpAgM/X45at12JE0IGXEezOL369X2OHQeS2F6M6ggPgCn6H4458YRalLr/lG4G3XYIq/T7U4MzeVDvPIZy3LIGXOauX170bGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471501; c=relaxed/simple;
	bh=0fq/k62J2WECMkmRL3KK0O5hTskGzbaTBYw8XK34SYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEDsGhEl/OLSpVfNKOvHX8ar+wboFm3+ILs/6WY7IMWcaHMi4Cdm0iEJGRSho4+pRWRVTYTCcYQ3ARteVX+ro+xvhTwbg//m/YQhMwQsF4T3/6GFUgtgKiy455/hGCvRMeV21P+/3C8FZx0BVaTFGHblt8BaNg6DXdkva65gznk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/qTRHC3; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/qTRHC3"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65318dafbcbso1025881d50.2
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 17:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776471499; cv=none;
        d=google.com; s=arc-20240605;
        b=Q9Swu33YUBrLLLumuxotdpv/IugtMG4hnJIQh1eECA5MEJzIrw3oGhNIkQa8L27/U5
         r2SgOxi+zuFFVfP2FsBwma/hQH8NSM0VDQIdCFwiqVELX+ArJru4Gs+ciJfJ1CAtjp08
         IRis2wb3ErtfB8o7LVbsx4JPRmyQTPWXHmbrGBZQiSxouCGiobEIm5ImOviEFygwFXOM
         kPoJnoFMSPYqfZeY46KrmT0AmUgkAMKpJu1lQRPbG6SMLgJg3QdZEUirwDqTtURFtZIy
         3vd3CMnpRpLBOT/Z1T9cKLDhSo37LkzLaTBRqmkwPe0+/g7dRA2u26Tf6Hrr4xk6/OUU
         JvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufMLHX9gMotUEb7868YGJnmPO3wMbpT/JQ4gCvmvG0E=;
        fh=WhasW8zZuE8ycprrXjyZ17tIkhJrN+zks2iJpNwt1Ik=;
        b=SnqK0wqUTTXjcXBKMzVkECKaRgiME7pchQwSCZwb42IBmwwNfeDeHqo1ADo46odzNU
         p9ZWvSBrbgL2EAz7F8QG+G6YtcvcqPkFwFPfaGc4OSRlaHqiQabwUME3IgGSo2Z1z9Au
         ERtW3qQkQES+fbmEavzkXSg7pPSgp3QnIwi/vqVI8to8LuI3LRzwCsXJr1Y45sym6xhl
         lK/DFJG84JFx3Yd1BVRIf3ZkgmQsb9Buzadqu6Me/NsRZ5gQpzZNje/6NSoDLY6bmBsU
         7l3iVGa+O1c65dQrMcWmUD40Y101jPMeK0JEVMaHLDyN+RpFj4OljnAhM4sMNGmp0rDO
         bP6g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776471499; x=1777076299; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufMLHX9gMotUEb7868YGJnmPO3wMbpT/JQ4gCvmvG0E=;
        b=o/qTRHC328FVLqVo30ne9ADabRHpL7NtRaLbwOKG0phfZHta2l+AZ/7xl2//c5VlJb
         zzxQYZz7ZzFKYp30YdNsIfUbYO8wcLoNDmLKJTgHL4e3POrTr84ab2f1IyveXVUntbBz
         OENwJdiN8ynK2/vj0HC/HbwMHpfysR/2/O7NNeyPnt8ooKyDmrbqEmG311KEBYR0ayiu
         Q288/1lQ60LP6BFhvgOLK3MU6l7g+OeXoWyWeEi2RyNO6sXhlLVGpFH0A03NOgzqYCaI
         e7jLvTne9ayE0n78HfHglBm/Feegj/+gAKek+quVi3M4JlOSCLRLDHoAch2MUQwaB0UU
         egLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776471499; x=1777076299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ufMLHX9gMotUEb7868YGJnmPO3wMbpT/JQ4gCvmvG0E=;
        b=O7Iif4LFmXudUkWGt0WQIzHcAhpWD3J51bhQgFwBQd5xUSud35JvWQcYwrzFhztByI
         vBh56zni7Zs4gF/O7DLCq6AlKZJbDLb2MspPemxcfUIwS55wpA4jBHTHCwCHqJB9Yfd3
         nN5nKV19E1JoHhhQdZFTlrr7WRQHDoCC0t/nKaStb1zq1DQdgn8QX7y3sn9rx1qtYNX9
         OLBPStkaDOSWUsfLNFziBGCP8+4MVoTMTpg7pSwjo6r9BOnaS/4hNLIokBI5eXFn6Lav
         WxhYeQsnwIlVZtfTz/HWczOGD8HibMtRgTK3fWfOWIqh3B7sPP1scJCAb4aV17N7/ENG
         UmPw==
X-Forwarded-Encrypted: i=1; AFNElJ/7vXclZpD/TqypgaP5eya/L/sxJLgX9cJNVck+7nv3WXTBt1bkxXotwoGQDRQtbYYs4YM312EzgVHDTW84iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUveXTcx9cY8evmmI2NOxFDKFR5uNzvfcucOMP43cNy7mM3El5
	Ygqm5N8EQX6hhZNaeVj4fH/bl4BbaLeYj0+gLdt+hP+EZY0n20OzUHTejhofCu/rp5JQlbFMyp4
	6mCHHvS7Ynz9KsgiGvcp27b6yilxZdOU=
X-Gm-Gg: AeBDiessphKiBFBL7zQuHULWm4g329TjoAY/jp4euyX3imNXi2p+wSS95KYrrdOwrST
	zxq8+5db1YQm6KFDYBN3Rbi00GRZteyZipwE6mgTHo2+Wcbsbn03Kgyb1h7S23ANJ/YVg8NM9SL
	U6mSQfdsk2uZCnVWoXKo3zsgLzCdm50eFygd2zhUjiWe4M/C02EB6UzYgicMxbIByTIU2SnBp6e
	KQIcOyUvK9hCqRlSA1CBF5hk3OUi8eTqwf8Th+8BTv1pAlv1NwGl4UxmAy3a77Kfp4JhiIOqfUA
	ZATWUASaIZwSpGtCU+2rkMNP6h8Gg3AQojUVjkYGQ8lwtUWZyeuPQ6YYBw==
X-Received: by 2002:a05:690e:1441:b0:64e:7a8c:73b3 with SMTP id
 956f58d0204a3-6531087e139mr4610575d50.27.1776471499015; Fri, 17 Apr 2026
 17:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260418000020.1847122-1-michael.bommarito@gmail.com> <20260417201129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260417201129-mutt-send-email-mst@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 17 Apr 2026 20:18:06 -0400
X-Gm-Features: AQROBzDE4M9mnsEFp1jVk6NfdmxsSKNHM1WT8Y-f3Y3t3kuojWCBO1MST0bLLBE
Message-ID: <CAJJ9bXzhKTBx4m3-SCM+ccGd6ZhTXTAbRxKekCzidnXY6yXbWg@mail.gmail.com>
Subject: Re: [PATCH] hwrng: virtio: reject invalid used.len from the device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Actionable" is probably the better word there, sorry.  If it were
otherwise, I wouldn't have filed publicly

If you end up ACKing the correctness change, I can send v2 with better log

Thanks,
Michael Bommarito

On Fri, Apr 17, 2026 at 8:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Apr 17, 2026 at 08:00:20PM -0400, Michael Bommarito wrote:
> > random_recv_done() stored the device-reported used.len directly into
> > vi->data_avail without validating it against the posted buffer size
> > sizeof(vi->data) (SMP_CACHE_BYTES bytes, typically 32 or 64).  A
> > malicious or buggy virtio-rng backend could set used.len beyond
> > vi->data so that the subsequent copy_data() in virtio_read() issues
> > memcpy() from vi->data + vi->data_idx past the end of the inline
> > array, reading adjacent kmalloc-1k slab bytes into the hwrng core's
> > buffer and from there into /dev/hwrng consumers and the kernel
> > entropy pool.
> >
> > Exploitable most clearly in threat models that do not trust the
> > hypervisor (confidential-compute guests on SEV-SNP or TDX; vhost-user
> > split backends).
>
> Exploitable? I don't get it. How is reading this data into hwrng
> a problem?
>
>
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
> > hwrng_fillfn is a kernel thread that runs as soon as the device is
> > probed; no guest userspace interaction is needed.
> >
> > Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow =
in USB transport layer"),
> > which hardened usb9pfs_rx_complete against unchecked device-reported
> > length in the USB 9p transport.
> >
> > With the added len-vs-sizeof(vi->data) clamp in place the same
> > harness boots cleanly: the driver logs "bogus used.len" once and
> > subsequent reads wait for a honest response.
> >
> > Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > Assisted-by: Claude:claude-opus-4-7
> > ---
> >  drivers/char/hw_random/virtio-rng.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_rand=
om/virtio-rng.c
> > index 0ce02d7e5048..6cff480787ca 100644
> > --- a/drivers/char/hw_random/virtio-rng.c
> > +++ b/drivers/char/hw_random/virtio-rng.c
> > @@ -47,6 +47,18 @@ static void random_recv_done(struct virtqueue *vq)
> >       if (!virtqueue_get_buf(vi->vq, &len))
> >               return;
> >
> > +     /*
> > +      * The device sets used.len; a malicious or buggy backend can
> > +      * report more bytes than we posted.  Clamp before it reaches
> > +      * copy_data() which indexes vi->data[].
> > +      */
> > +     if (len > sizeof(vi->data)) {
> > +             dev_err(&vq->vdev->dev,
> > +                     "bogus used.len %u > buffer size %zu\n",
> > +                     len, sizeof(vi->data));
> > +             len =3D 0;
> > +     }
> > +
> >       smp_store_release(&vi->data_avail, len);
> >       complete(&vi->have_data);
> >  }
> > --
> > 2.53.0
>
