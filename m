Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0653A5446
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576387; cv=none; b=ETKvlFGhJ+SBvaWjfBlS3vbi5uULIuHtA1fBflidUAeDoHnyoMeS1mrNDp3EuUrcqt1/h53PmTXy+B3glL3SgGbGfcXl8YRcQauu+gPGWdVGV7UjsI5RW3agVfRnZBRVTOoAC5W1fg272YtZ2lghJLfp43xp3F1qn2ZB1B0vIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576387; c=relaxed/simple;
	bh=mC2H8311T9z0HVrvQ2u6/GOTyu0FotAU/zxDl3dYgGQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ZuFn6FPqQ9SoneBq/CEis+F/jT89uSVq0N8wvLoLqhNQ9nyIZcrAv1Q5vo5ZlmBjxoZw+2w8R4AZMIjgcxlR9veZY3j1LNtwKzIJEdAKdrOB+FczOeoq+/rCjFN0pC6LCM4QTS+mFh0MRRDJAgXVRGyjwJts/o9NkpzHXJuBrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e0632c733aso10819960a34.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 01:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576377; x=1779181177;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qry07HiLRpI4moE29vwWP3imXR+DsmNoqtYT3jSQb00=;
        b=pWlBIJXNkgE6kp7m9bgdCIp4S3DBwoXz3nniS975Y4xjVW5hwxzPZtrIUcjjfTDV/v
         PXOLrXhSvp8dLvHli77AjC5Tp1iGG5YpFb6o7X4Fjubv22opxp3EGs3WfrrpPtuIUm7Q
         328os8rovAMWmaQnd14F+4gPWuxXIrSxT3q7xx80tvZBCV+YV7SqpbtTvU8DpecQjqOh
         gB6ATlcONbg7VJDt9RHa4Zpl0w2jqmHTR9RwS1vZByO4t9Qssl1IOkmELjux8iORLlEo
         1KB1sQy3rYhtTi1jm+S70gwfqB5oBvATgdgkNkFo4+K009iP1/iEHHk4jfIAJZn9+EsK
         4zog==
X-Forwarded-Encrypted: i=1; AFNElJ/ohQPPRtiRMC9DKUPo3djEoWZeyNAPZ/Y4SKXEh9eyo6g5s2KgJeyRNQkI5LyuhSejqRacflEN6DRh+lYLeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxeJjOp1GtyvtEQg3iFRe6N9TQ4IiiPlqBOg7vWRawYwSRC0wq
	n9b1tBmldEMYdYYBWMypiyceubpwb7T3Frhq3fHlKAfikm85DA6dETbFXBZYDLC1lP6kvCRrNxH
	1zk/fw5non1cxF9MMcOHl0Q9TB/s4L3sjJpB2ONfcjp0m3q0xlAoV8uDsfsc=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:220d:b0:686:d107:2856 with SMTP id
 006d021491bc7-69998d5251dmr16156255eaf.51.1778576377421; Tue, 12 May 2026
 01:59:37 -0700 (PDT)
Date: Tue, 12 May 2026 01:59:37 -0700
In-Reply-To: <20260512-virtio-gpu_wait_event-v1-1-207eb4c1a69a@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a02ebf9.050a0220.14e4b1.0008.GAE@google.com>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung task
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: ryasuoka@redhat.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	ryasuoka@redhat.com, simona@ffwll.ch, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
> wait_event() without timeout when waiting for virtqueue space. If the
> host device stops processing commands, these waits block indefinitely.
> Since callers may hold DRM locks, this can make the entire system
> unresponsive.
>
> Replace wait_event() with wait_event_timeout() using a 5-second timeout,
> consistent with the existing timeout pattern in the driver. On timeout,
> clean up and return -ENODEV, following the same error path as
> drm_dev_enter() failure.
>
> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 67865810a2e7..05e816a0ae0b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -396,7 +396,16 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  	if (vq->num_free < elemcnt) {
>  		spin_unlock(&vgdev->ctrlq.qlock);
>  		virtio_gpu_notify(vgdev);
> -		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
> +		if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
> +					vq->num_free >= elemcnt,
> +					5 * HZ)) {
> +			/* The device did not respond */
> +			if (fence && vbuf->objs)
> +				virtio_gpu_array_unlock_resv(vbuf->objs);
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return -ENODEV;
> +		}
>  		goto again;
>  	}
>  
> @@ -566,7 +575,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
>  	if (ret == -ENOSPC) {
>  		spin_unlock(&vgdev->cursorq.qlock);
> -		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
> +		if (!wait_event_timeout(vgdev->cursorq.ack_queue,
> +					vq->num_free >= outcnt,
> +					5 * HZ)) {
> +			/* The device did not respond */
> +			free_vbuf(vgdev, vbuf);
> +			drm_dev_exit(idx);
> +			return;
> +		}
>  		spin_lock(&vgdev->cursorq.qlock);
>  		goto retry;
>  	} else {
>
> ---
> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
> change-id: 20260512-virtio-gpu_wait_event-e0cdf8675b7c
>
> Best regards,
> -- 
> Ryosuke Yasuoka <ryasuoka@redhat.com>
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

