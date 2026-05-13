Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280136AB5B
	for <virtualization@lists.linux.dev>; Wed, 13 May 2026 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637354; cv=pass; b=GQOVHqqKugfnMcguXZPM0OWW28PkuF6EsB19KKhQXdlK9MmXz5yOpVlwkPjUT8W+n6mdskmjKfQvFilnTUXmDCWM2tDuqDgsPothuUsqpUApc1B2w5Y3oDQVDWQHZWDJYS7NkhanqkO4Y7R2pMkcuUAxRrksUX9DW89fmQBJZd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637354; c=relaxed/simple;
	bh=9tiV4ZhfIE1AVrGBMXro5/HVKMSjT0yIr89kHRQQJAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKxCZcsBWSdhLNSa2H6/iDOzDukC6EwlMrQJOqamk+dAa9Zxt3NXfCzs3UGeOQrkOBRp1qhcO532WS+2pyQrwg7Qzfq869Z2afbTXo3vzCAq6J+e0mTIb2XdvKnZcn4sFE55c9Kgd6A+1Syw1u8W1GCe4Wz2aUPYWc3djKy6A3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5E9o7xm; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5E9o7xm"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bd6f65c781so56785147b3.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 18:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778637349; cv=none;
        d=google.com; s=arc-20240605;
        b=GyahrC0JzE9YSpJ6X5xlvYVSAU/ey8fIJkxFTo++B1SrJG8SDm4SAUs389FavSjt5I
         4o/MxNoG7i/3gKU1bH3CNuK3XgPYyrDF3Bhbm7JcHFSzJz05pSHtLl9Kx92M8J+wC/Z4
         vtdAJwVo5EbO6T5yuh0Uy3wyujghH7hxv/q0/JESsUSXBwN9EagCKClDcOjYs+XNtdJo
         Rw5sih7eZXtcIkD3K4nbP72yP6AtFz8Tuvg288LCfj12lfvXMjnaiNrgy4DRjEepf0p9
         7mYCU93Tvj4hSs0CJ6fsUgiV+XihkEUgQ7ycG9DhSefbOxJ74tGRRsC6splckfZfPG5F
         Eg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
        fh=i55YglpqlavY6/lM0zk/IjhCa4DrqJiQ64HX+YofpeY=;
        b=cmlPbiakNIuAzzHqYehAVfB9UyN/sIAs8GUDmzEFxy+6fcVAsBYrtXPGDJhfBlRkWp
         KEbLId9on9k5pS+bwcrftvbodrxnNCAiabUqPypoVPK0tl1niXwMPWrXyG6zEoGsIJO/
         I6XZzzOjUsU+s9qnzxijRb+AVa0Lw2M8ymTO5G+Dh7W3+4kRZs7JfmabtycbC8HPfrWl
         eNRCZkR30HihK0nRJ94pr9kg+01j6+sszHGbblcp8vISaXh8dcIbeb2NRtFYpBfndr80
         32ivUSS8niq2U6Cw3ymFKil+pA3W8oKgbEmCwPFmXTEVR2AhMIfnDap5ra+NrdLV2FX5
         bSWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778637349; x=1779242149; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
        b=q5E9o7xm0KxTboJ7yP04jwtEK3mFZVFNhpzZg29BT1lje9KcX4oHVR/hCfxvX4+pS5
         f/LNU22Fn6E22CzurOz9ZiMArg+3QsKq6LvSPWORSJPchQsTzN/JSpclz2Yk4EVw6LYH
         TnvRacQT+u3WDIh5W2jqRPtKGvcX69BXHCxIzl3z6/B5giyfbMj+POQEfjnTTRayDsaO
         SmCmmP96/qupEGarijh7PSNHzs7q3vn5dgJalLVE+mkD9KEGHtR4JVRWJex2hjCO1Pi0
         lhQvJ5EMUtNM/AWRExxVemGQv47HmrfnETRcl9eKPkNY/pT3xb0kS5+tVjxbHwfMxvq6
         tpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778637349; x=1779242149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5xRhLCcP3JBRN1MwY6Q9q9IhNYwNr7l9QAT6ZuSm7sQ=;
        b=QmjxoUaR4JSOR59Fjs+ZaI3d21/sKIlDjVDun7T764ZmI83FjvOEwB9WRITWfngRrD
         PpSHdVm5fAJe8+5aaBbBsHp5B7IcDcbYfXKlvTh/K2CCJu363hHIV73rZCZ0Qhg2uqnR
         V1NyCbNkkzNHUQdTXldbh5FRCpSk2p4PMjtoLR4kDqXHjgOoBZZJ65QW84EFh3BKi42q
         TwkFKBI0pPARim8lhc0SEHbqaTemU4uEFuMfazGOoZ6bwL4xZpnLKViQbY59s5rDXFnO
         k1DMpnylqe0blWkcJ0B5qhOYBu1q4lHMsTkXPnTgfjjubohgVfgzaz6YK67WcHj66/Vo
         RGHA==
X-Forwarded-Encrypted: i=1; AFNElJ9f8qTb2LL7VoYu0xeD4FiXkbZgPyios5oQ9r14JfsMbY+vnJd8s32ZUVIvavVt4C8L7XYQJqBPpsQbFV2jhw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx27Y12F1aBY69OhjdLDBJeRi6PGnEId04SaOagUMpeqQMFUvfa
	RSeMaMxwxfUVg3NZOCup6q3C6qn+9HWQJhPZU/gNfsRdytTAQ6R3QTF+sCyjk572FT+XlEHX2aQ
	MrG+AZS4UhgGgbqpaXeF5T1RHYKezjzo=
X-Gm-Gg: Acq92OEdTI6lG5QUsXjgDVCYa/A9uqB2httgMaALzgquH7XgDn8E94sFkk758iEa4gO
	SZSOb/AWXpS0KxcHummLbgsSYYacDvqwODGzIaCAFuSnDxa7XKN66ig4waw7HrLTSlBG8p5LNNq
	XpYv3ITAjrs4it2yGA4Fg8brF4MPCVHkSK9TGEzyCWfAmBjXyavTfRUSU2Y6cr5Ajlqkp2brIpN
	B5ElmFx1d2dOhx8qWum6vgkxMC3GZyVQX39Doyy/JW/6IfvWyEOeJcGsHdX39SLFKoYvdmZF9Sl
	FRJ0Hf6dJ11g9oYaDnDyHDDKw3YpZMU7nWPyGvpyypwMah6vOKoXtTWWb0M3D5FCKdoFZmXa
X-Received: by 2002:a05:690c:e28d:20b0:7ba:ded4:df69 with SMTP id
 00721157ae682-7c6985e165dmr12151727b3.1.1778637348672; Tue, 12 May 2026
 18:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260512020718.108044-1-kartikey406@gmail.com> <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
In-Reply-To: <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 13 May 2026 07:25:36 +0530
X-Gm-Features: AVHnY4LCDlccPve3ZLzzDvN9woFw3uS561jxG504DrY4p0Whnei59B3Wu16XydA
Message-ID: <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to prepare_fb
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:04=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> I'm getting lockup with this patch applied and now see that
> virtio_gpu_resource_flush() also locks BO.
>
> Easiest option might be to add uninterruptible variant of
> virtio_gpu_array_lock_resv(). Could you please try it for v3?
>
> --
> Best regards,
> Dmitry

Hi Dmitry,

Thanks for testing and catching the lockup. Before I send v3, want
to confirm the approach:

  1. Revert v2's prepare_fb / cleanup_fb / plane_state changes;
     keep the lock acquisition inside cursor_plane_update like
     the original code.

  2. Add virtio_gpu_array_lock_resv_uninterruptible() in
     virtgpu_gem.c, mirroring the existing helper but using
     dma_resv_lock() instead of dma_resv_lock_interruptible() on
     the nents=3D=3D1 path. Declare it in virtgpu_drv.h.

  3. In cursor_plane_update, call the new helper and check its
     return. The signal path is closed; -ENOMEM from
     dma_resv_reserve_fences() remains and is handled by freeing
     objs and skipping the cursor update for that frame.

A skipped cursor frame on ENOMEM is the remaining failure mode in
.atomic_update; this avoids the lockup with virtio_gpu_resource_flush()
that v2's broader lock scope caused.

Does that match what you had in mind?

Thanks,
Deepanshu
