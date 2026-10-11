Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com [74.125.230.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FCD42AA9
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 04:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791692663; cv=pass; b=lZAX8ds2WrDYnXkhNHoY1M1nIxA/yc4YbPdaaCr+nOPanYfTlRpLh0/szdLftojT2o744XV1G0EOvZHR1qPdyLqTxIDu/bjksTWwDJBZGd0wscGR70/SfYwuml5jGT57IWokc49WP0KBSgwLS/ouQ1mBm9osjkvJ/SHtPQyAxOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791692663; c=relaxed/simple;
	bh=qdxE0RHmxCdnGtaZYVfxmF/aX520nxo6WdF2env194g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luAk33PmqG+buIQ5fPvT9DrBsoeErEdmaZfueVpucbK43p7DSXxWJoksmYpdjN8BxEkTag2ha/bqw+o0uXUYPNokOnMqg/ycIV7qFHoah5E1BtS3eVdgOB7vuBYNe1DiJR/R+k2FjrL6uAo4qZsUe79XAqEyi1TfaC/3hH5L05M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0VaCyvO; arc=pass smtp.client-ip=74.125.230.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0VaCyvO"
Received: by mail-lr2-f11.google.com with SMTP id 38308e7fff4ca-3a7882fb706so7677761fa.0
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 21:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791692660; cv=none;
        d=google.com; s=arc-20260327;
        b=rxsEJfFigJ/ZynDy0UbQVepz1yqj0L/niy/mXhylhp1fkZKmTetW6QCBWJcn0kxMRq
         qDGzVYTQWjX2RQ0GpydTwni/l4l7zP8aQcK4Kj2Zgh/+xxfumhPclPEsDKzD1o/2Azgp
         j4C208tICRp01QXUaatdhO+Tc8UaAv7+gjlQQ7bOt4Y1vdXionm5dd3gqTSaQj8aTGpp
         dovg4ZvfS3LJwicSW+zmq3zEXQLGH78qgtGP/XxqDCaoeR/WwvpKzL6UBqmpKCOerduV
         kkAcYJBkuV0EMobn5tVyPe+5rPmoEE8GnADKfV686SbSWhVNALF2ZkvRsMXeRZ4V6Z9I
         gUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
        fh=1lMzxU9U9LYiIpGJORgCsb5GaMJvJH5Le2HrBjk4K+w=;
        b=f0xU1ul879UG5dqFJP5JF1+kt9TnUZJJ7VwZ/X5xnyg0Sp9BiPa/Ka6BDW2pcR8cPb
         bXQQmCNYEJVZMIOOBDZkuNtiQl6uG4SbSFOWIVK7uIvkxlBVu1nSlfWRtpPYDok7b0ud
         KNT9Nuqlz95FiWF5LBU++/HeIE6gwI0T+uvdx3J+4OGL/4P/WsUC0GbzFknQVDIUBnRx
         nZ+3pyrv2PhHT47qFDZ+aRcjr2P4FHZQOPaQ0PvQt9xFQaOcUYQgM0yE3ywGxwZRt8ph
         bBkBU7K95NnlQP1u2JveByBSEnO6UjDcEApNuGjGzxHoiA5TgWbgAAG6z9T8m88XGoP6
         fNTw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791692660; x=1792297460; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
        b=n0VaCyvOtH+K47zGUMFk91MPJkKgeX0Qv52TugU1kt0f3mIcrJNceGKbY4lBy1XuLV
         GsD7n0s6/cM7DjzX7VJxw3NF9YP/o62sMnfUiP4c2TlJIkknjFfSCP9UOZlXVzAbkIBT
         L/lJuGZAU74Cg+OLHF+wLhgu8N5f3wF3z4lqB1c21cvnPwiWSDBlyT4/2G5f71tE9dk2
         9fEGGTLSuG2bhbS1WQeNs0wIf+MO4vQ6bRpYu6o71n7sGI73Q24teZZ0phI7x3iXhihG
         Um8uZlvZyn1GuZvf+ebFbyCJVnTj29pkwvHzJtU5bwS2VncLe1haJdJUXa3jlokYAZfc
         96yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791692660; x=1792297460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhZc0ul596MdstjFona8ML1ytD+B6YUHJy1OvUi+4LI=;
        b=zbdY82qhkpMWgaVksoXykBGKUmRNL35iEqYl9MrL38Xz4flaXOWajPRgqwY76+zB47
         vS8eejuytdY+yBMTxEMShnh1FMEYLZaKMS0QpPnlOpBC8Nb5JnVS1w0sciHvK6F69N3Y
         AGDcLErV8jyJD4c2pkrLuDLTIG1eMI//jLeAL3vQ7if1x3PIRX94q+l/5yk/tB78VaH6
         rpzLQgFdIvPyho5Qqz68SK0oSRhTR/Zq+TQA6Nqg8FbIAXmXn2bpbxD3HsCw9LheYCjo
         1BcNd4UwyzeCd+iL1eJ4x+x7EuK6NapdFIMZSSbYxMBR6OHOKFj225GzSN7liDzT5Y48
         ipog==
X-Forwarded-Encrypted: i=1; AKwUvBzqYahCqDzC9MVM+cG8i2gSrTfVFETDU0nxvc46uTQLrpxTIV75yrzEJzUQ1ikvcfYmKk6bwPud+hqTFFCdXA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ+p45SylpCUKbHeGpU0LKiBS5UOZWg8ulLitWJ8i/o2IL1cX4p
	em/fkGz4ur8qUawnUk7W4sBmg0rPedG/dR7fb0wxsiv58pyOHTICbTDADuQqlSQjmpLYBZB+s8S
	fvcRy7olPaFq/7qfdpKKGc02ZMMWdHLw=
X-Gm-Gg: AYBFou1EivFFvFvMlvqvM3qbgvF6eq/hdGf6mQaySlJCzJFXdmSeMIZlWs6AnRZwaTJ
	kpyDOXlbN7evlPnBoXzqrm1551+4gkIdqFochQeqeNVHZPH6Hgld35e59CF5OI5KyCzZoCKXw3F
	N23MkGvUq03c9BEoGYlimLfG8G4xWVkzi/sq/dFiKvvdNPgMH6BZAGgUlW3TDG7w8LoIJTcotj9
	d2zX/aB8T3liUKmZst5VysxnyphzLVtSjj4EoW5pBdC8gNB3J4yhQ5SF0A9tIa0rfP2a49gtTq7
	lEXeb90YnWaAC2jTq0Pcts5o6fxon/OZ8u/WqkD46qTZXSsFEe1zytRT
X-Received: by 2002:a05:651c:b27:b0:3a9:9b0b:b789 with SMTP id
 38308e7fff4ca-3a9c4ebac3bmr15900241fa.3.1791692659381; Sat, 10 Oct 2026
 21:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261010081059.3096312-1-bsdhenrymartin@gmail.com> <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
In-Reply-To: <8393a8a2-2ed5-4d63-b937-5d837c1bb1aa@collabora.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sun, 11 Oct 2026 12:24:10 +0800
X-Gm-Features: AclHuK-BTl_lG-VGVrLo4m7etjeQVOp6O1v4a1N4RBOkp9wdRCffIEeVjuhsxU0
Message-ID: <CAEnQdOovxVfYAyiEZ8nJM-DXe=r6apYkfmpJJUNx6CJbg61_-w@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: reject mappable HOST3D blobs without
 host-visible memory
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Chia-I Wu <olvaffe@gmail.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
	Junrui Luo <moonafterrain@outlook.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

You're right, thanks for catching this.  bo->created is set
synchronously in virtio_gpu_cmd_resource_create_blob(), so the
unmap/unref completion chain (cmd_unref_cb -> cleanup_object)
releases everything once the host acks.  The leak I described does
not exist - please drop the patch.

Sorry for the noise.

Regards,
Henry

Dmitry Osipenko <dmitry.osipenko@collabora.com> =E4=BA=8E2026=E5=B9=B410=E6=
=9C=8811=E6=97=A5=E5=91=A8=E6=97=A5 04:19=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/10/26 11:10, Henry Martin wrote:
> > virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
> > blob flags, memory type, context and alignment, but never checks
> > VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.
> >
> > For blob_mem =3D=3D VIRTGPU_BLOB_MEM_HOST3D the blob is created via
> > virtio_gpu_vram_create(), and on a device without host-visible
> > memory (plain virtio-gpu-pci,blob=3Don with no hostmem) the failure
> > comes too late: the GEM object has been allocated, a host resource
> > id taken and the create_blob command issued when
> > virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
> > virtio_gpu_vram_free(), which is a no-op while bo->created is still
> > false (the host response has not been processed yet).  Every such
>
> virtio_gpu_cmd_resource_create_blob() is invoked before
> virtio_gpu_vram_map() in virtio_gpu_vram_create(), hence bo->created is
> always true, how come it's false?
>
> --
> Best regards,
> Dmitry
