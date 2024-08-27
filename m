Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BFD51C
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724726195; cv=none; b=YHKFrbiLtifbI0iMkZB8qoLdeg1882qx2MekhA/kVuuZQ2ivEDnzsqDBSpsznh6ULGrCkLcFaoN3NbKE+AotppVo28WNa0dpGgP/pWv3iK4p2yuLrKoc5776aLsiGSSVRmdRoiZmujp57PMI9QazV0iXc/NomWBrF7ITzbLaR58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724726195; c=relaxed/simple;
	bh=7ddS/d4k9G7fIIVMSSKcG/CFyccl7w4CLYXz60LhSL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mk1UfJlPJm1QDGROKnII09Xyw6eEJvdZfvSRX1f9Waz121k7vvXyYhAHQ5lBS0v9MvgjDPLrAtRB2HqSJQPmZwDN0jN+bLmllW//RN5lBweh1wp5mG5QBiAnyTQ/x8j/cOLeSmoBKjo9j7SyJAkpDs8MIS/PKBj8j/VC00xjvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqUirjam; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqUirjam"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 76EAA40261
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8U9_Gu5Ac4Ta for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Aug 2024 02:36:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5A7C840151
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A7C840151
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XqUirjam
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5A7C840151
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Aug 2024 02:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724726190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU3u8Ft1rxly7qkOmUJIntRTHvbC1QrMgAzfkIxaRHI=;
	b=XqUirjampnejje1wDVrtFuxOfL32/gYnlekxl/Ist2tFn8j2fYPUwkziZBB455A+5Eteb8
	waCIWYK7wGb0j7E7F5T1deaAweMIbZEM25HIrNNsHbhw/wj98bCJdyBTpYS1giPZwBOiyj
	+FzCTEuBzsHve78fANvAOwajUEAWxQ8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-UJX6rIvfMKyX_fNV1MTqYQ-1; Mon, 26 Aug 2024 22:36:28 -0400
X-MC-Unique: UJX6rIvfMKyX_fNV1MTqYQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d699beb78dso2540858a91.0
        for <virtualization@lists.linux-foundation.org>; Mon, 26 Aug 2024 19:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724726187; x=1725330987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU3u8Ft1rxly7qkOmUJIntRTHvbC1QrMgAzfkIxaRHI=;
        b=UfRHqPDOAlKc5lYR+neuoAwJnvu4LV5TY1IvR81DkBcYBPzlv+cMMBdzSVBcpphXvd
         5CRpCsgvkAi6t7oUpo5rC8pw7Fj1RzcFFIinjR9iGNJtSZtM5Mz55/HUpj8Toaed7q0o
         88ClWXBrQFoWtTbiTkw7tPil86mSzZ4lKukv0RduO1rr2Z/QKdbm+tzpv85PwYt5cz+u
         fFC/16YLGegAG7O0nTE4AvTpSVqxSVnztXTkSjFM1O2To3G/0kTaRxt8f4p6Ft9zhngc
         fg5jGK8U/zLWEIDfTh1atbt1jU5JiIiiKa/LHZu6Xl9ywNE9cLDYa3D5mMS5XoPveoKB
         x8yw==
X-Forwarded-Encrypted: i=1; AJvYcCVchHurCjtiimFuRLHkT3JspDeQcU/tzgC3aEww7jVxhzkkkkrseEvAaDxw7T3MqkLS1jtIIuJKTHy8vujHkA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzOvIhxNzsTWJcd4UbpUBNziA4eHC/+ECRjPAyg+CHzQ1NrrX9T
	0hEn8YdvISra36Oiez0wdrmfzz9d1I2pVVlgaYZyW17qDdwdwLOMT4AYYuCP6MGJtU0SI7Ii57e
	F/cN+upTnvQa9Twf+bROuE8EiIfFIUJJb+qMqMYoqE3eV6sEuC3uzf/kMK3N3vC1WPjmtOJA1nA
	d8ZuNLDRijEwueR+pY/BesDVTeWi40xkhq706XNN8/P5qw12+Z24cYsvKPbb5xK1bnkYo=
X-Received: by 2002:a17:90a:5108:b0:2cf:28c1:4cc2 with SMTP id 98e67ed59e1d1-2d8257c4727mr1924671a91.3.1724726187021;
        Mon, 26 Aug 2024 19:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3adO54WTlhNtTNU0aZk27uMQbtk5OcBZNZSjU+LPEYCH81ylxQtc+elyvOSocFRRguXTJm5rf4p50RQ7tM3Y=
X-Received: by 2002:a17:90a:5108:b0:2cf:28c1:4cc2 with SMTP id
 98e67ed59e1d1-2d8257c4727mr1924651a91.3.1724726186522; Mon, 26 Aug 2024
 19:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-3-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:36:13 +0800
Message-ID: <CACGkMEtQaJ+o2WXnWw8iCF=9q7kx+CyVnn_YUgbNEo-ontHRqA@mail.gmail.com>
Subject: Re: [RFC 2/7] vhost: Add kthread support in function vhost_worker_queue()
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Added back the previously removed function vhost_worker_queue() and
> renamed it to vhost_worker_queue_khtread(). The new vhost_worker_queue()
> will select the different mode based on the value of the parameter.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>

It looks like a partial revert of some previous commit, please mention
the commit id in the change log as least.

So did for the following 3 or 4 patches.

Thanks

> ---
>  drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++--
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index da701f6b3f2c..6261c9df468e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -236,8 +236,8 @@ void vhost_poll_stop(struct vhost_poll *poll)
>  }
>  EXPORT_SYMBOL_GPL(vhost_poll_stop);
>
> -static void vhost_worker_queue(struct vhost_worker *worker,
> -                              struct vhost_work *work)
> +static void vhost_worker_queue_task(struct vhost_worker *worker,
> +                                   struct vhost_work *work)
>  {
>         if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>                 /* We can only add the work to the list after we're
> @@ -249,6 +249,32 @@ static void vhost_worker_queue(struct vhost_worker *=
worker,
>         }
>  }
>
> +static void vhost_work_queue_kthread(struct vhost_worker *worker,
> +                                    struct vhost_work *work)
> +{
> +       if (!worker)
> +               return;
> +
> +       if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> +               /* We can only add the work to the list after we're
> +                * sure it was not in the list.
> +                * test_and_set_bit() implies a memory barrier.
> +                */
> +               llist_add(&work->node, &worker->work_list);
> +
> +               wake_up_process(worker->task);
> +       }
> +}
> +
> +static void vhost_worker_queue(struct vhost_worker *worker,
> +                              struct vhost_work *work)
> +{
> +       if (use_kthread) {
> +               vhost_work_queue_kthread(worker, work);
> +       } else {
> +               vhost_worker_queue_task(worker, work);
> +       }
> +}
>  bool vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *=
work)
>  {
>         struct vhost_worker *worker;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index bb75a292d50c..c7f126fd09e8 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -27,6 +27,7 @@ struct vhost_work {
>  };
>
>  struct vhost_worker {
> +       struct task_struct      *task;
>         struct vhost_task       *vtsk;
>         struct vhost_dev        *dev;
>         /* Used to serialize device wide flushing with worker swapping. *=
/
> --
> 2.45.0
>

