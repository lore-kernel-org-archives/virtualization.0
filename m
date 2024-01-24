Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0863115
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100041; cv=none; b=iD/vdYPkQtTiUPgCI2d3XYe/fTcldsBHQYScf3ZuwqsXaGzinvwZ7NBKpklq9ei233NFuXjjMpTHEPXmT3rZac3TmVNG4ogNgVX8uB0GIOov3frZpBy5tkjhPpvCRpJkaWxUqxH7WxD3gDCLUKzD83XfnAikWlFgcIvm8YJmyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100041; c=relaxed/simple;
	bh=FZFP8leP7RAq5kGQxJmipIwDZPPhQviPXOnLVnpMR5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8LPF0TkJD7pn1B2pb4BBJQJ6g2eKsRMDLjfqD4SD/vkUbxmEXV1YPJfkk5nXSiDa0eX86THgMklUrcVlPoEo63U88sLufbH0AkzfkS/QJi1q1Ilm5lMH3tnGc2+WSr0n2WD7Ph1bvfCpMEVof+Wa9aBSR5Ks2OikpkRHJ865H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lAwvDSyl; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAwvDSyl"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595d24ad466so3404973eaf.0
        for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 04:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706100039; x=1706704839; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kWogWcbiiyuJh+FUerTxPBMWB5fr1e6cnL665YmIF/A=;
        b=lAwvDSyl4uvSdcXkc9hP/zZm+P1naW4ERSquwblx8QNQWWFeIcT1JmwztagcDvpWaE
         jiGt3IefVsF7ck/PG9kWRreFoBc/rKpBXaEd4AC7pRgGPyZwHiJxP2RMnOoLMukDo+Jk
         A2JLmWnOTEhWuxBCcPjO0tJ9q6y7ydM/jGQNEby6FbckX1LuoWp0r8ca8ygujDI7BlKG
         W0JtTHKw/elmLdy3cac+vdCkHJ/ENPM0aOBYy07GtyiJkMFXmlxtCk1OyVN1oQaNfcBD
         tjnioGytb5wwWgWxXZB2FpZ0LZl29dZHXbHFgRMGWfNyaVyn5rIev9sDecvvLQgZVqlr
         xpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706100039; x=1706704839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWogWcbiiyuJh+FUerTxPBMWB5fr1e6cnL665YmIF/A=;
        b=WdlSZWmoiQaRPvXd6X4ZFUIx5hpFtD5HqMtw1CZjefwCFbxVk3vwPg5dfd4SuJNu2p
         B5Xx33EKGZ7LqpFAhbC7nBTVBFgMmyD9b4rTqaDG0HwH2sWzYW8nbOaX7/QS06dQUhLM
         AqEbPDkrIRJIW7sHCZdnJNsm2HHggfZSz9gaXuzP7XIL4eodldvFFbNcdTeTmrPkck5N
         PIJaawyGiwDwLv+giOL7VbtYiKivX1uH2zTIEdgP9Jat3+uOLbNj/K4YjICDVgaHRCC4
         aesPma0yuEMY50+AOKNCtgY1SsOSeC/qNxw/K0UfkYNYcdTMdn5CVUDlU5BCTBYFHcPY
         E/WQ==
X-Gm-Message-State: AOJu0YwjWeMWlzPJ/i50S6wNBYotFGXvsS1IYPqC9Zjz3m42xk52g0v3
	TdzF405SjdJeb4prHMA5WmwBrJyBgm94HzrJFAUd/hIyewl9TAXwsGQ4sXjSCAXTaJCehxhi6kp
	rtKSzINVsr/+iSy/ncljb+Qrg+f0=
X-Google-Smtp-Source: AGHT+IHyUNMoe1WPRltarBaK5ChqVz54utp+rmgY1rxh0GGzt82eqUUiuTyYaabcgKvybe1H2CF3w37Gbg8KjnLvC1Y=
X-Received: by 2002:a4a:d00e:0:b0:599:79ce:67e5 with SMTP id
 h14-20020a4ad00e000000b0059979ce67e5mr1167571oor.8.1706100039049; Wed, 24 Jan
 2024 04:40:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240124120834.49410-1-lirongqing@baidu.com>
In-Reply-To: <20240124120834.49410-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 24 Jan 2024 07:40:26 -0500
Message-ID: <CAJSP0QXP9KFSCO9mFkNmms=GKmMi+h4EjrVKf3Ng_BQV-LFiSQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: virtio: remove duplicate check if queue is broken
To: Li RongQing <lirongqing@baidu.com>
Cc: anton.yakovlev@opensynergy.com, mst@redhat.com, perex@perex.cz, 
	tiwai@suse.com, virtualization@lists.linux.dev, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 07:17, Li RongQing <lirongqing@baidu.com> wrote:
>
> virtqueue_enable_cb() will call virtqueue_poll() which will check if
> queue is broken at beginning, so remove the virtqueue_is_broken() call
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  sound/virtio/virtio_card.c    | 2 --
>  sound/virtio/virtio_ctl_msg.c | 2 --
>  sound/virtio/virtio_pcm_msg.c | 2 --
>  3 files changed, 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index e2847c0..b158c3c 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -91,8 +91,6 @@ static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
>                         virtsnd_event_dispatch(snd, event);
>                         virtsnd_event_send(vqueue, event, true, GFP_ATOMIC);
>                 }
> -               if (unlikely(virtqueue_is_broken(vqueue)))
> -                       break;
>         } while (!virtqueue_enable_cb(vqueue));
>         spin_unlock_irqrestore(&queue->lock, flags);
>  }
> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> index 18dc5ac..9dabea0 100644
> --- a/sound/virtio/virtio_ctl_msg.c
> +++ b/sound/virtio/virtio_ctl_msg.c
> @@ -303,8 +303,6 @@ void virtsnd_ctl_notify_cb(struct virtqueue *vqueue)
>                 virtqueue_disable_cb(vqueue);
>                 while ((msg = virtqueue_get_buf(vqueue, &length)))
>                         virtsnd_ctl_msg_complete(msg);
> -               if (unlikely(virtqueue_is_broken(vqueue)))
> -                       break;
>         } while (!virtqueue_enable_cb(vqueue));
>         spin_unlock_irqrestore(&queue->lock, flags);
>  }
> diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> index 542446c..8c32efa 100644
> --- a/sound/virtio/virtio_pcm_msg.c
> +++ b/sound/virtio/virtio_pcm_msg.c
> @@ -358,8 +358,6 @@ static inline void virtsnd_pcm_notify_cb(struct virtio_snd_queue *queue)
>                 virtqueue_disable_cb(queue->vqueue);
>                 while ((msg = virtqueue_get_buf(queue->vqueue, &written_bytes)))
>                         virtsnd_pcm_msg_complete(msg, written_bytes);
> -               if (unlikely(virtqueue_is_broken(queue->vqueue)))
> -                       break;
>         } while (!virtqueue_enable_cb(queue->vqueue));
>         spin_unlock_irqrestore(&queue->lock, flags);
>  }
> --
> 2.9.4
>
>
