Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AB8F5B
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735787992; cv=none; b=EOq44q20IydDWwI9RKPHnbAlz0o6YIVdR9RZlarpO32PKaIkOXX4ZDIaJzXPr1aulxlM/zvV8BfpzCxoDqIdCGCW51/EDXNfzcC2a8SzopTMNcqc7ZgJgRv2K8Axp1h3PqsFIkkMFsL7W7QAvuSzW+c5jMDY3pWUxOWtPiOXxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735787992; c=relaxed/simple;
	bh=3txRQoi5B8Te3HvxcxTp/mam15GzErL1GLMNrJqkTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8hfc/BjWgTrXI+smLjzNitGW6OIHYcOjKcIHSFGybQuTSkHz2MiRt4NMgK/MvoWOp1nd+3Qq/oHqXvyamZz5kAKVz+z3/nubrF7JPbUJ2W3usG3l9c9TmHflJm/UzR8bXLGwBFPpLgR271CtgZvezymKcdJRSfqlNscehPYOro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1y594Y+; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1y594Y+"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DACFB80CE0
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 474wbz1_8_k6 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jan 2025 03:19:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F046080CD3
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F046080CD3
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J1y594Y+
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F046080CD3
	for <virtualization@lists.linux-foundation.org>; Thu,  2 Jan 2025 03:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735787988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/DoRCQMoCvL0YhMS7oyxFy6iN1qrB1b7j/dmge1dCs=;
	b=J1y594Y+lSHJIwBZanlY9JBnpN79Y/MKlT2tehJQM3+NFWE8TkN16rfUpcvtmn6bVJMZ70
	id6wMyz+3Qv2+D2GhfL1FA4QjUe6ROjgariTmn1lWnBHgP15ny64zjNoY03prdB6ySxIz1
	HGVliH4ti30X+zdgChztzoUykVvUjyk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-2cO7TEgdO1yx6PrxX1h8fQ-1; Wed, 01 Jan 2025 22:19:46 -0500
X-MC-Unique: 2cO7TEgdO1yx6PrxX1h8fQ-1
X-Mimecast-MFC-AGG-ID: 2cO7TEgdO1yx6PrxX1h8fQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef6ef9ba3fso15405170a91.2
        for <virtualization@lists.linux-foundation.org>; Wed, 01 Jan 2025 19:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735787986; x=1736392786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/DoRCQMoCvL0YhMS7oyxFy6iN1qrB1b7j/dmge1dCs=;
        b=qp/gtHwN/nYnULx04mhJvkWWlCt7clB09Rt585+3nXIFfmYfpzrGzPc62t7OrWpd3b
         JYZWHB8Ks1UPN8pHrXCGP9R8O5mI8a6cP6vmD4bI6BbTlUt0Tz5HeY192wzogH3jnGh1
         AtnpUCO46t62SXluKeTk0ty74unvErP9CfgZauoCGqBcWUXGJTa0b9OmflemdcC/OJE9
         2pwtwkjSwKvAoAzd4cHOkQR9mB1P1R5yGJc3s6NsqVFrq/xy0l06qHtF6WLC3wxNFLtu
         wULar3rLWKdpfBNBfRXH0xgcgUNTXC4ycSAd8R2RGrB5OUVqNQBaHK6K5YXkZsiBkZKm
         klEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZg2XFTvfTLkFGCelHDYysWU7+zEZRdrpWHJB4qUpTXxkdXqqimbH2QkB3yaw8MNpvTmHQudRwkveM7NUJKw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzh3rhyauR3WOHkM0FI4FKO1NloX52vUGJG1lcnzViJR1/mNY/z
	Q8ivDoOKfqLncxCm6NgFPeYJKPAx/kDIxWsiqSlnpY0b/XU+rCj32PVB0XvWP67keTeOGv8simG
	JNoDXwk4j6tuB/VbIFECv+4+KgLmQJtozRRaJweFVoYk3g+QBMPBJMv6yDNl6AK9bV9wWUukz6k
	yw65oFGyiSvAZi7pwKZ0g8BA5w02AoZVJ1S9bmMA6UKXzs790etGCxkQ==
X-Gm-Gg: ASbGncvyxfSqPa4MMjVZ4JKPcJi71+K0uY29lknhIqmryYErci1Ht2P1eK6/aufXsls
	LE1XH/WWUSp04W9p+lh0afPC7BB7sMd2MP6xQ2xM=
X-Received: by 2002:a05:6a00:4090:b0:727:3cd0:1167 with SMTP id d2e1a72fcca58-72abdebbdc0mr65315630b3a.21.1735787985829;
        Wed, 01 Jan 2025 19:19:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2171JpQ46+MxTGlz4zxRUIpsAvCuxG2nbGnlOfZhQxL1sDicIzSkAmy7KNxeYz1rotHsWKMAbsdwlqtLYru0=
X-Received: by 2002:a05:6a00:4090:b0:727:3cd0:1167 with SMTP id
 d2e1a72fcca58-72abdebbdc0mr65315612b3a.21.1735787985497; Wed, 01 Jan 2025
 19:19:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241230124445.1850997-1-lulu@redhat.com> <20241230124445.1850997-3-lulu@redhat.com>
In-Reply-To: <20241230124445.1850997-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jan 2025 11:19:34 +0800
Message-ID: <CACGkMEuA_O5bgwLNz47sWJTQGqqOvq==_vNnhqrH-eGtbg-Fuw@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] vhost: Add the vhost_worker to support kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x91TSxHhLf87Ta5yRQo_6DxQayAQ7dWh1MMXgVYUZYE_1735787986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 8:45=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the previously removed function vhost_worker() back to support the
> kthread and rename it to vhost_run_work_kthread_list.
>
> The old function vhost_worker() was changed to support tasks in
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> and to support multiple workers per device using xarray in
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray").
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I think we need to tweak the title as this patch just brings back the
kthread worker?

Other than that,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index eaddbd39c29b..1feba29abf95 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>         __vhost_vq_meta_reset(vq);
>  }
>
> +static int vhost_run_work_kthread_list(void *data)
> +{
> +       struct vhost_worker *worker =3D data;
> +       struct vhost_work *work, *work_next;
> +       struct vhost_dev *dev =3D worker->dev;
> +       struct llist_node *node;
> +
> +       kthread_use_mm(dev->mm);
> +
> +       for (;;) {
> +               /* mb paired w/ kthread_stop */
> +               set_current_state(TASK_INTERRUPTIBLE);
> +
> +               if (kthread_should_stop()) {
> +                       __set_current_state(TASK_RUNNING);
> +                       break;
> +               }
> +               node =3D llist_del_all(&worker->work_list);
> +               if (!node)
> +                       schedule();
> +
> +               node =3D llist_reverse_order(node);
> +               /* make sure flag is seen after deletion */
> +               smp_wmb();
> +               llist_for_each_entry_safe(work, work_next, node, node) {
> +                       clear_bit(VHOST_WORK_QUEUED, &work->flags);
> +                       __set_current_state(TASK_RUNNING);
> +                       kcov_remote_start_common(worker->kcov_handle);
> +                       work->fn(work);
> +                       kcov_remote_stop();
> +                       cond_resched();
> +               }
> +       }
> +       kthread_unuse_mm(dev->mm);
> +
> +       return 0;
> +}
> +
>  static bool vhost_run_work_list(void *data)
>  {
>         struct vhost_worker *worker =3D data;
> --
> 2.45.0
>

