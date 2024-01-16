Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282A1BC30
	for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQZYFBzm"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-203fb334415so6981900fac.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 05:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705410191; x=1706014991; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4QQOhcOxcHjrsKEhSRn9wdD7VWLozw48zKxCYRXjRUc=;
        b=YQZYFBzmGcCKWqK6kBTAL/KtsscYTBgSR71vqPy8fr9DarMve50Pc7bzeRZaNRxzPZ
         qhOgMRbAQ9GK4o3ZwjKbTV9pYrwZKbO2eHM1uTYG4GkakZd7Z1RgSOTrQAnRr5ANoXjJ
         DKOsmiWM3vVYCEwhd6dhqYk0SApASjZBtK1D/E/rU7kN4Qadh1IGqjuUDwG8+lJPwKa8
         Jl/UQSkWDY3rgrG1Nl3VpQjSHC0fzqMDI0Dl4/y4IPocss2isK9fNdq64/pqLQltDX4s
         9M/kc0cv757xgexFydYqhakatz9wniFN5iNCi6KZ0B7rl3wgtj1VNFDX5dtUxsVGWKb8
         4L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410191; x=1706014991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4QQOhcOxcHjrsKEhSRn9wdD7VWLozw48zKxCYRXjRUc=;
        b=BAu2M7Uakda/EZqMLbm08Xx/iDBE8cGgVWO4wRWcIvbt0mCkRNJdlf2w1JQ8Vp7RUJ
         Xh/qijdVXNIt8JyPgCBnwSM+E3u2TFVTgP0hnN1OIBNKH/OLFHC9xwrC/omaTWLMK34d
         pRTYCdLpZKSLSOU1ngVC3pDB1DjmRCDAM5nt06tld9PbpToyFYnmtE9QTK9VMbQD4fft
         SS/e6Pq63/AMp5YyAG4gxzYkAlYUcnZsQxjDwe443she/al5C7N/1C412TUAsS21n1FX
         n6QhmNU/PD44Cfcr2BLM1UDKpLWOTNuPEWyFT9G5D/W/0pmxo/ouKmKLvXVhButFTCHA
         mgjw==
X-Gm-Message-State: AOJu0YwinSQZQdZ1+aPUtYBViw6W66K3maSRSjVttwbFfyrCYkRAubOw
	RTCsTK/KST6ySsPY2nyAqPCK7hVPuQI9nas4COs=
X-Google-Smtp-Source: AGHT+IEHc8iWJOABWb8fxWWKi1I7C0y5nyBYocs11//L/21/CMkE8JCF7CFkbjKQLWYfmDj4McbiFoPeIgaenKNGk9Y=
X-Received: by 2002:a05:6871:48f:b0:206:bbc9:be01 with SMTP id
 f15-20020a056871048f00b00206bbc9be01mr9750039oaj.41.1705410190989; Tue, 16
 Jan 2024 05:03:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240116045836.12475-1-lirongqing@baidu.com>
In-Reply-To: <20240116045836.12475-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 16 Jan 2024 08:02:58 -0500
Message-ID: <CAJSP0QWgn9PPTH=Hc=Znt8eWrVbdjwzPb_iOsmRTYKEdMSqzVA@mail.gmail.com>
Subject: Re: [PATCH] virtio_scsi: remove duplicate check if queue is broken
To: Li RongQing <lirongqing@baidu.com>
Cc: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
	stefanha@redhat.com, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 00:07, Li RongQing <lirongqing@baidu.com> wrote:
>
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/scsi/virtio_scsi.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 9d1bdcd..e15b380 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -182,8 +182,6 @@ static void virtscsi_vq_done(struct virtio_scsi *vscsi,
>                 while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
>                         fn(vscsi, buf);
>
> -               if (unlikely(virtqueue_is_broken(vq)))
> -                       break;
>         } while (!virtqueue_enable_cb(vq));
>         spin_unlock_irqrestore(&virtscsi_vq->vq_lock, flags);
>  }
> --
> 2.9.4
>
>
