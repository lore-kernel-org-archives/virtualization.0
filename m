Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3071D0B82
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799497; cv=none; b=jSd4U3VYYEpxMZX8Ki0wXGmsDnBri8rjFQpfZ46Yts9D1BLOZSBbPNna5yqp93W9LwVTfhsEQWGhq2Kny2ZL7biMCNztlLb0UB+9Y4aksPQLQNjgCQoRWA81fXe5ibuMnisoWO8uLe9X7D7nrHVvJ8ZZoaKn8x+S1kskLRb6fXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799497; c=relaxed/simple;
	bh=4p4VWrO8uF1H+WyvXfit2++bNDgDMcVv1cZ3lUw+ww4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+iodlHteuOKlAhE/9aY9mklQCqewvpG8wa8MI4DymgAmD9CfXYQJEFNrev/2dO05MSqw3TwVqi1pjtEYl5wkO0Wpc19LnaHMPYPAdpwWY1z8AH9rO5ZBYwGENktJQeAbli4FUHWJeNwNBzKQRn5AMRruCoVEIBjbjY2FJ17ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ah4fEv1r; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah4fEv1r"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8764405FD
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:38:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFMnbruAQ0Pq for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 09:38:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BAE3F4060E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAE3F4060E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ah4fEv1r
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BAE3F4060E
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jt6NevPgsvI0U19HJM+9OIG7cBpWuW+de+wvjLoj4rw=;
	b=Ah4fEv1rc1QYDJaVjqBTxabdLvmlLdB9akincqbaE9kgucGFtnh8Zu5a3B0btHthCeAb2Q
	zNDIrWsoDMzpA6gO3f2UYbz6B2JZ2p8Gl32zaJv3YYZdVU6Jqm45SVf6t6J1Vb+ZRbjXwE
	wSzbNpI3OZ8zOEg93vgGT7Meacx4PqE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-231u8-E-OA-GwtrgtVkG2A-1; Tue, 05 Nov 2024 04:38:10 -0500
X-MC-Unique: 231u8-E-OA-GwtrgtVkG2A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e5bd595374so4402053a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 05 Nov 2024 01:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799489; x=1731404289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt6NevPgsvI0U19HJM+9OIG7cBpWuW+de+wvjLoj4rw=;
        b=E5HdxFo3DVO5zK6JLiDYwVVKiBfjk8KRzk8AEicPs6rHLNzXjsIrN8VpsFcmGW4/iz
         uvSngfhrNjC81W89xrflV3ICVolcfGNe1dz8qbgHBI1WwTSd0kOAv9T9zSx9hyucQ79E
         aBp+gGvWkCou7t5CCs902Vw+YjeCxt7zL+gp5MZ6yYH74a9S2OUuHj6mBcwRVckMUUH4
         LAJSZpdF1RoU0c4H9BCHoAmUeC/R2lKhNRBNKi8UeWWZ2ouZssMlaIGS/BQ8TR3/6rC3
         pSFWFS8hYn+seuTC9uPl/FHtFlQo18jI/kbW1vbaWZFkFdyEOFUstxfSp+DMqmJ5L71P
         x7vg==
X-Forwarded-Encrypted: i=1; AJvYcCWWqvDm+MWDU/7NX4nFlDwBtfswxMIOmlF4jtguiAKpR872zBkrxb3At/VAy+nqIMN2YR/rfoZFVmVah2oWuQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx3+Exhi4qIDv7GFMYpk7WbgJy5XhEFBu3XywZlo7d+fNwp9XDy
	arCAN8HbfDIAx2kt4fP5Clv27/KCN/fb5o33G2UHuNPIfqJuDFuPCxI0OVJFd6iTNmfrSiVZ3dP
	KZa44ruv1lntCF771wn9KZc5gggCYLiG7oUSnvQC54tyrX/Ojs9MDJDtwf0NJvERs+1KT+HZjN6
	W+C7xxSW4JqMHCM5MMbxW8z7ZKYRFkocF5UVLTGi9gKioh8seDO/aN9A==
X-Received: by 2002:a17:90b:17c6:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e93e0ac496mr28583114a91.11.1730799489145;
        Tue, 05 Nov 2024 01:38:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfBptF6b+UYP/PMKuCsLN5l+Hz/l7bBxZshwZZZaQhmYBx4WQ2HXBLxNHL7GTxTu95PAoJg9Ii6581pMoCwkU=
X-Received: by 2002:a17:90b:17c6:b0:2e0:89f2:f60c with SMTP id
 98e67ed59e1d1-2e93e0ac496mr28583022a91.11.1730799487601; Tue, 05 Nov 2024
 01:38:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-6-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-6-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:37:55 +0800
Message-ID: <CACGkMEt8XO6AvGp4i6PEoCyL=S5QrGvXhZnBdzjr6CvuxdQpYw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The function vhost_worker_queue() uses vhost_task_fn and
> selects the different mode based on the value of inherit_owner.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 603b146fccc1..8b7ddfb33c61 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -238,13 +238,18 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
>  static void vhost_worker_queue(struct vhost_worker *worker,
>                                struct vhost_work *work)
>  {
> +       if (!worker && !worker->fn)
> +               return;
> +
>         if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>                 /* We can only add the work to the list after we're
>                  * sure it was not in the list.
>                  * test_and_set_bit() implies a memory barrier.
>                  */
>                 llist_add(&work->node, &worker->work_list);
> -               vhost_task_wake(worker->vtsk);
> +               worker->fn->wakeup(worker->dev->inherit_owner ?
> +                                          (void *)worker->vtsk :
> +                                          (void *)worker->task);

Logically, it looks better to introduce the ops before introducing
back the kthread behaviour?

Thanks

>         }
>  }
>
> --
> 2.45.0
>

