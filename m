Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9125DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 06:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20FC540275;
	Fri, 14 Jan 2022 06:12:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CMHurmmVkAhF; Fri, 14 Jan 2022 06:12:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 54798400A9;
	Fri, 14 Jan 2022 06:12:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 360D1C0030;
	Fri, 14 Jan 2022 06:12:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09419C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:12:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D70FB4168B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qTfh1rJzBDEb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:12:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AB43741686
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 06:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642140739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUt20B2ZQKiul9TVzlscr0qYlhPciKBJGV+dQspDLic=;
 b=HPwPZcqxV+giF3lHZNi8E85zrAE2nW+KW2VFGQzyebzYOgeXsOY/qxKua7K3P+HbAfrfaX
 MmThzkHXN5xhV4aSIvVEZ+2xBaPrBF5cgO+waEJW7SQ4Y0f4QGwK8BHHjsM52yefsVvoEE
 PMQhRmiJqyB6uucELpg7TGwiZuKLGng=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-CdKaMc_hO5WlM40hGf2f5g-1; Fri, 14 Jan 2022 01:12:18 -0500
X-MC-Unique: CdKaMc_hO5WlM40hGf2f5g-1
Received: by mail-lf1-f70.google.com with SMTP id
 c7-20020ac24147000000b0042ac92336d1so5528196lfi.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 22:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EUt20B2ZQKiul9TVzlscr0qYlhPciKBJGV+dQspDLic=;
 b=GCuJsjrgfplAicvNV1JtrcihTRBTzl31wrJTT7fHVOJ9Sz2pLaq4iOM0BGa3J8LfmF
 b5NKux48wyggmZ6kVAt9QEP/uCFN31JOd11onM/f3fRvzuLHlcSgwnB6Wwk6cU/vJElx
 VcX9gOg2HYJkUuHMfXwzPlBYeCewqL19fbWY7PPG0wDLaJbM9veWetKDEsENn7jRhcay
 dTqIs6ydd0YVxkK4Qcy1gcu27TO7CmM8HooO3npGCLU2p/aRKKDXon17HL2qyzI1dLYX
 m+uxHTDpikbscPHNyjxZZ5oc0V8valX5ls9AJkDv17mTl9b0QXvXd6REjNoOczJo9ogD
 TTMw==
X-Gm-Message-State: AOAM5306/2owFtHFNVrr5mD44AaZSsdER8gqdNEIbyCVYEiax1I0Vc/d
 3IzjpDlg+Eo0AV+bc8OG28MRJHZj48N6HMP7FKFUimS7EQY3O0H/Idkyw6m+YGOS9iprj2F497h
 WtV4x6rRHw7L4u83skfPWcgQJ2f3g/na02Ps9V10tZWukhQdj3mmcOCw2PQ==
X-Received: by 2002:a05:6512:3d24:: with SMTP id
 d36mr6244857lfv.481.1642140735478; 
 Thu, 13 Jan 2022 22:12:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXfcJ6JMKErK1A1bwY9Z9Ixp5/QcPqABoqPDeUk3JLyw951WqrUnFZxZXBpbXddgs9NIe5WU7RNU0Xu5pWstw=
X-Received: by 2002:a05:6512:3d24:: with SMTP id
 d36mr6244843lfv.481.1642140735248; 
 Thu, 13 Jan 2022 22:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20220113141134.186773-1-sgarzare@redhat.com>
In-Reply-To: <20220113141134.186773-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Jan 2022 14:12:04 +0800
Message-ID: <CACGkMEuFbr+V7qzm=DXKuDUehFH-8Hrw-dojPTDxN3zKOq_kCQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: remove avail_event arg from
 vhost_update_avail_event()
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Jan 13, 2022 at 10:11 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> In vhost_update_avail_event() we never used the `avail_event` argument,
> since its introduction in commit 2723feaa8ec6 ("vhost: set log when
> updating used flags or avail event").
>
> Let's remove it to clean up the code.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vhost.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..ee171e663a18 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1981,7 +1981,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
>         return 0;
>  }
>
> -static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
> +static int vhost_update_avail_event(struct vhost_virtqueue *vq)
>  {
>         if (vhost_put_avail_event(vq))
>                 return -EFAULT;
> @@ -2527,7 +2527,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>                         return false;
>                 }
>         } else {
> -               r = vhost_update_avail_event(vq, vq->avail_idx);
> +               r = vhost_update_avail_event(vq);
>                 if (r) {
>                         vq_err(vq, "Failed to update avail event index at %p: %d\n",
>                                vhost_avail_event(vq), r);
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
