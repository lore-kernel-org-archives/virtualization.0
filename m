Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0726C433EF
	for <virtualization@archiver.kernel.org>; Thu, 27 Jan 2022 08:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4967D40B72;
	Thu, 27 Jan 2022 08:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UlCScxnm-lXg; Thu, 27 Jan 2022 08:32:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 71601400BA;
	Thu, 27 Jan 2022 08:32:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A50BC0011;
	Thu, 27 Jan 2022 08:32:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 577D4C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3875061094
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:32:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJyTj9HUNjzp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:32:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60C1F6108F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643272335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hzsSfEt812B+qp8pLaEKXZY4iqaixHPcS2PC/AJjRY=;
 b=SdJUQe+5avRSuhb/uGW/ffa9RxO5UhrheQXErKecWNfHgDIfBUmw84QidYFNS2xxO2ePYH
 KbFy8HyDNW1wc7iR8GVfRzI/7YVEd0jWLFwby0EYjPDydOEaJHyRD/AcGmuD9LqiWKeWJl
 rOcucDzSP8u5HTpEwCOPQE5S1EeA1V8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-k8-EWH04MKuX9ZltJvOpEA-1; Thu, 27 Jan 2022 03:32:11 -0500
X-MC-Unique: k8-EWH04MKuX9ZltJvOpEA-1
Received: by mail-lf1-f70.google.com with SMTP id
 d1-20020ac244c1000000b0043626a5df76so796397lfm.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 00:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+hzsSfEt812B+qp8pLaEKXZY4iqaixHPcS2PC/AJjRY=;
 b=p1rkkWnvrUhltaidgFn99iSJE7C91dnXs3osWOCXfc/QA4AeFtULkS4UZAT4r2FWkr
 eHZKUoRWXmH4B9X6Joj5efHfMKK4Xj7rIUQnKO7IYcU4yzOlEaJ86zXeAZb2OgxkZtlO
 MmYN5qk232ZNLursXS7aGtNsPZqiIkw6wk1nyqYnw78IRCZg/NtVaPvQP/740Tdh/Bw3
 dRrtYrpRsnss0R566vq8uiSdKDOHpzdg8hMyx24nhTkV6nBAJNvzjg3WMmORfQ81R84e
 JratUvB6wBh4V7G8akLxPI+StNfZUAFoaekPMmoFszVp5zWfHWVxEEXaOn4PPGgzJgJ+
 EiKQ==
X-Gm-Message-State: AOAM531m0qG5Z7HvWvKWavMXIey46kut92n6fgq3SHwBgr4koxZ35dmy
 5pw/yjmePMWoWXh/PGbnY3hVWF6iZUol1dgtrrNRjoEo+LhIrkVEM8hWFS4D9V/TzJfFX1az3um
 gPICQQ0RHOLR28OH4vt32rbumaONXO6h3jcWVYAp2wTKYeilMJmdUNyRrkA==
X-Received: by 2002:a19:6a12:: with SMTP id u18mr2163148lfu.348.1643272330164; 
 Thu, 27 Jan 2022 00:32:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn9eSiGGfhLO0zjsI1+u0gJevThcq9mgdnntxuPkuBy9qCRRpx6z8S1fE44dsCdfLi8ZxWyEDp9ctCVdi+w8s=
X-Received: by 2002:a19:6a12:: with SMTP id u18mr2163143lfu.348.1643272329966; 
 Thu, 27 Jan 2022 00:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
In-Reply-To: <20220127020807.844630-1-yinxiujiang@kylinos.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Jan 2022 16:31:58 +0800
Message-ID: <CACGkMEtEYmVNWqaaEhLZgiv9HZGUAP6zwqXfpdDA_CM2_tav0Q@mail.gmail.com>
Subject: Re: [PATCH] vhost: Make use of the helper macro kthread_run()
To: Yin Xiujiang <yinxiujiang@kylinos.cn>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
 mst <mst@redhat.com>
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

On Thu, Jan 27, 2022 at 10:08 AM Yin Xiujiang <yinxiujiang@kylinos.cn> wrote:
>
> Repalce kthread_create/wake_up_process() with kthread_run()
> to simplify the code.
>
> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
> ---
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..19e9eda9fc71 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -595,7 +595,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>
>         dev->kcov_handle = kcov_common_handle();
>         if (dev->use_worker) {
> -               worker = kthread_create(vhost_worker, dev,
> +               worker = kthread_run(vhost_worker, dev,
>                                         "vhost-%d", current->pid);

Mike plans to introduce user_worker_create() to allow rlimit check[1].
So this is probably not needed.

Thanks

[1] https://www.spinics.net/lists/kernel/msg4161030.html (I'm not sure
this is the recent version, please check the list)


>                 if (IS_ERR(worker)) {
>                         err = PTR_ERR(worker);
> @@ -603,7 +603,6 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>                 }
>
>                 dev->worker = worker;
> -               wake_up_process(worker); /* avoid contributing to loadavg */
>
>                 err = vhost_attach_cgroups(dev);
>                 if (err)
> --
> 2.30.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
