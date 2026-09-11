Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E0F3DA7D4
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093356; cv=pass; b=AkN21chld4AVCTISMuW2sCwYRK5YuOga0dqdib4FN6FfqexH1EIkLrQMawclkEqQYYv1RsGZJQxwMVlq1Jn6xBm8zibmf+Yk09M6Mqji0H7STABruCh7xScCAp0mb/M5SEBXkFdb/AdPsZ//6FS1T73KLDI/oPA+28gN1ZVgrec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093356; c=relaxed/simple;
	bh=Bz0sCgcCcFvltEMwQaua+/B5cZV1CmGcPPxBoEWouf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKGm0vyi2V7hwFZNuHfG2529xe1ug3Vra+6o6YCJrHHeIvQ+nU6bG981UQf7CamNFWmBXWKFFo8G8j1yK3ieNHsCpVG9zOTVhbhKkst/QsIN7q7U51wFRV4I4/Ypv0B6Ll6zUHUNbDWe8o+wM4tRGim95ioAw2g3Z2YgmGudeww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRVL0nTn; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRVL0nTn"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so790038a12.1
        for <virtualization@lists.linux.dev>; Thu, 10 Sep 2026 19:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789093353; cv=none;
        d=google.com; s=arc-20260327;
        b=locOeeNDi3zpxuz8BWVIo2SVUUT7oy8cd3JeJxNxl7l+IBxbg5JYOQEhRsE8WC3PdA
         jjXBDbsrs7h04tumEdkQ3W+NrMf9DjWItU+mrjbirpx5O23tb45pespA69tHMluOYFN7
         njUxgxfslGpIJO23D/tiwuMFADdsqyVaMDx6vkO2OvehXQqSt/HkZBAB4mS2RH1evoxF
         Zwx+NqWdsg+EJCgvNleT20x+r7tKnkxMGUb95L/hefnPMxnaPVjXX/mJcvKu80NACf3S
         wsVaVHJNU8J1hAFtEtta/S86DxvBCrFMiWOQUhbli4AXHee7l4qEyVQhhf/ERDm0RI30
         XZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzI+H0AYETX+xpgB1CN8oegHDhglD5FDUHZp3f5RBM0=;
        fh=7ogEeZ0dYaDlrgQHlYnq3K14ukFu21KWaKPQmuyYg1s=;
        b=mkoCIG770zA/KY8LFnweyzt0NzSYv+TbLZJfzCSVgO8kw37H2URRPjP6TJ48ZwznG5
         VdzuElsYOtm+AlTgftMEGS3MIKrMyP4YzoanRfz8Y3ZvAgvnUMcLPOoEHzxjKCOJZZ+R
         WNvhsXxvDHCjR7XtW1a77z5UWR2+IVR2eY5XllGZLnhx+oj/fIwMkuGDyRGJ5gO1d0Uk
         EO8GJdak2qhjCu1S/BlybOQR8tieMuLxuxxUxphPhec8GP985tAy6yR/2SF5Fq+BnHGI
         TJxPsHWF9GRuaQqKFV5eoquNziGDHJ35d0jYkzploSUfN96nIdOoygKpZ8apk6kdT3MG
         8k1w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789093353; x=1789698153; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zzI+H0AYETX+xpgB1CN8oegHDhglD5FDUHZp3f5RBM0=;
        b=GRVL0nTn+UOK2hq/Zz8H7E/h+0Ui0xoUOOc83kJxuLvYg7Z+YeSTG2FS1FKTSmh175
         RnmRJ0i5v+TlTLzb1kl605yrLjW5mr2dWPa3jJHncloO9YO7tyHw/LvArk2ljOduUSSM
         U2BSD3vmKmthmMleL3BqLserqAyyO3FGU7sRXFF0VqevkSyGY640W5GaS24H2xh3ON14
         iprB2MleevpQ7ixqVVTCwUoGk6puBX1ESyTWVvTsuwboA3oN66GfcadV5Cjpe+1Ss8ji
         jKvoaZE93PRD3IdaqTawMUVPVOwm5SDweHqhagOPaSTl6y79canTUS9iPZ+DHSJtaobT
         gPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789093353; x=1789698153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzI+H0AYETX+xpgB1CN8oegHDhglD5FDUHZp3f5RBM0=;
        b=cNxqvbdAlxLcYutdVLxfS/AOuT5FUkbtmTiJjyhbKOqxe9ZDv2565sueCcg9maUYkk
         vYtES7Q1if/02F4vV9nOdk0HTZeq7ytrsRFmjMd9fs2x9xOUpSzIGCjrgfWKLuNGzQsf
         kdNwt0DI0nmQjOn1cSzFNWmTGVszzSxAQsnZ6YT4M+NxnFPne0LMm0nUJ00768EQXkXu
         UU9YsxelzVqFDA9NGHi+/YV+0TbpnWuX1jdN27VAJ+lGe5e2xHtDlTZ0vQaELs9nyp+T
         68C34YMfZp3qG+4WBxWo2DHiJGyGZUuzM4kjcf5cBRxhJaqJy4ZY4s+GhzXb3JG3Mwb1
         9y1Q==
X-Forwarded-Encrypted: i=1; AKwUvByKBS3IHxHw9ADp4bVFpSP0Cm0j6cewmkveK4x+EvSxqG7LHGqDO1R2kRiJnDgakTm0kqA/6D550ArA+alWNw==@lists.linux.dev
X-Gm-Message-State: AFuF++nHGRih25QkmYVQVevbO/I0eYGmuILCj2hFa6D2+XJr5lNTsDWK
	u4ej+ZsyfYqI11kay3l5bY1x86nXDVPkadhYBVAic9c9rePWeoaA0yX3vJZpGHoriJqVi/vjg97
	rQR+WTBCFZM43UUFFtE3O/OkAlOKvz3s=
X-Gm-Gg: AYBFou3fA0Ku6FwDDWhVuUHVJIXnqIGAABRfIi2mh7uTp8a/tj7LyyVDsAwztks/BeW
	j/7I0qstLkr8qnet6eVJ7GLHe1yAVyzGlx2nWhnrIhRZIGJY3xT3DNWUT/bDeqRalMEiGabNp9T
	/r8FIeDs3/ieFk5hXdsoogBIY3Ut6Z6WnVEgZhiUUowOcdzmRTOvMBzPKPT456KGkgi9ka5dxt6
	HfY5nzwNt08jlwZ1gzb7+VEroQrJ8Lpt/wCGQ1j6QF+s6vNrTlPZTHduqVgs5GRUGvnQJLju83J
	8HCVHBCm+Kxs3QAmD2mCe53gZ66MySeO8wERi4pXc6R1GzRCAmgFtTtAtpuQfuuy8BMxJB/d+4m
	F9TRY+A4qWGU=
X-Received: by 2002:a05:6402:50cd:b0:6a8:d72a:3b23 with SMTP id
 4fb4d7f45d1cf-6a9b56f9fccmr842660a12.43.1789093353125; Thu, 10 Sep 2026
 19:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
In-Reply-To: <20260911-virtblk_sync_quiesce-v1-1-a883f8f31258@oss.qualcomm.com>
From: Jason Wang <jasowangio@gmail.com>
Date: Fri, 11 Sep 2026 10:22:21 +0800
X-Gm-Features: AcwNN1Uzpxn8BhhthHEzwNinazI3iL-_kocBQlmIkQ9u52465cUbeWR1Pr_TyGY
Message-ID: <CAAf7B_Oi_z7M_A_LwoAs_CAvhuk1NGxvADQssE65_OcTroncXw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: use synchronous quiesce in virtblk_freeze_priv()
To: Cong Zhang <cong.zhang@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:31=E2=80=AFAM Cong Zhang <cong.zhang@oss.qualcom=
m.com> wrote:
>
> Replace blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queue() in
> virtblk_freeze_priv().
>
> Keep the existing freeze and unfreeze order. The synchronous call waits
> for dispatch code that was already running. The queue remains quiesced
> until virtblk_restore_priv() calls blk_mq_unquiesce_queue().
>
> Fixes: 7678abee0867 ("virtio-blk: don't keep queue frozen during system s=
uspend")
>

Do we need this for -stable?

> Signed-off-by: Cong Zhang <cong.zhang@oss.qualcomm.com>
> ---
> blk_mq_run_work_fn() can call blk_mq_sched_dispatch_requests() through
> blk_mq_run_dispatch_ops(). The dispatcher checks QUEUE_FLAG_QUIESCED
> while the flag is clear. It can then be preempted before it gets a
> request. At that time, it has no queue usage reference, so
> blk_mq_freeze_queue() does not wait for it.
>
> virtblk_freeze_priv() then calls blk_mq_quiesce_queue_nowait() and
> blk_mq_unfreeze_queue(). A new request can enter the queue. The old
> dispatcher can run again, use its old flag check, get the new request,
> and call virtio_queue_rq(). At the same time, virtblk_freeze_priv() can
> reset the device, delete the virtqueues, and free vblk->vqs. The old
> dispatcher can then use a deleted virtqueue or a NULL vblk->vqs, and the
> kernel can crash.
> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..7a570591e040 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device=
 *vdev)
>
>         /* Ensure no requests in virtqueues before deleting vqs. */
>         memflags =3D blk_mq_freeze_queue(q);
> -       blk_mq_quiesce_queue_nowait(q);
> +       blk_mq_quiesce_queue(q);
>         blk_mq_unfreeze_queue(q, memflags);
>
>         /* Ensure we don't receive any more interrupts */
>
> ---
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> change-id: 20260910-virtblk_sync_quiesce-9b2c88d45416
>
> Best regards,
> --
> Cong Zhang <cong.zhang@oss.qualcomm.com>
>

Other than this,

Acked-by: Jason Wang <jasowangio@gmail.com>

Thanks
