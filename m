Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA999C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 06:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72F344176A;
	Tue, 26 Apr 2022 06:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qnwX7kGQ-H3; Tue, 26 Apr 2022 06:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94A384174D;
	Tue, 26 Apr 2022 06:19:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D660C0039;
	Tue, 26 Apr 2022 06:19:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25CCAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F29A541762
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gLc3o0GvgSkY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:19:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FE634174D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650953982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQYMa3DGNKurO3iT3qnt0CypDzkBqPK2CLR0WQxJotg=;
 b=QijAKoFrGTuQD82uTDmA/otrWLWKfzYlNs0FxrO8fF2VgnlfKQNjkq84sSU4ZJq6ML6ORA
 OIvj3C0nWnDL+IK5E8HO9IkNcTXvoSgT6iBRnV2SaSoLyW+kHn4OJsjLh1hmf/DpIoasI0
 b26INy2a9Mxg6PvvmsU/QNSciWlDnW0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-SNM5e7RSNUmxqnzwwBAtNA-1; Tue, 26 Apr 2022 02:19:41 -0400
X-MC-Unique: SNM5e7RSNUmxqnzwwBAtNA-1
Received: by mail-lf1-f70.google.com with SMTP id
 k17-20020a0565123d9100b00471c860aa98so6392998lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 23:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EQYMa3DGNKurO3iT3qnt0CypDzkBqPK2CLR0WQxJotg=;
 b=itOXpLcFBosEgbmqPQz7Wui4vy4yfV1Y7JKkdLhXnM11aNkIeBpXvgIQKdGOk8laqx
 zcK3Qm8J9nvH8GkJUvoQ9sQxbRIHJyPBLRYtWUmX6egmW7fn8cdqm5Jlu3SouaYwZim2
 haR3zJNUOcZ5qnzGnzac2uOFn8TwGSsez/O4+W2v4t+awQQXivL8lznxu6kRJC+ZYCdK
 lPf3mXzloNj5oi+r8SapPvXzci7HqOeQHaTsknhSmr3bMrEJ15TyvF8wV28ORaDNwCbN
 NbYidlbvcW0vOR3J5Chnvk6dV8cbFFSCzEJATSVSaIdzs2KfO3KfXaYl7thnK4MJYJJk
 EtZQ==
X-Gm-Message-State: AOAM533Ph7hzNj5pZRmsys4Z1ftc7PQ1z2/8mxAoM1IGcYsFYnZxAN3d
 AH0DVmgHnACOnGghd/OCg6asb7XdPreOZD2ZhCbFI4jhpKhPzeuZQe4VFO6nJTpy7ioYyDq9OvL
 /WWnFB6LyD/3aipxfUJVXaJJtYu45GO6mXGcOhj8sbLyS9J4k4UfIKm9Aww==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr11541604lfj.587.1650953979508; 
 Mon, 25 Apr 2022 23:19:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHRJZRr25niHsOv0rh5fj62mTbJ/i3zQBf1gJ86LXWrg1e8vSlgtm8gMqVgwq6rAsjLtyPK4eBS6VFQk7xZW4=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr11541597lfj.587.1650953979316; Mon, 25
 Apr 2022 23:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220426060103.104-1-xieyongji@bytedance.com>
In-Reply-To: <20220426060103.104-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Apr 2022 14:19:28 +0800
Message-ID: <CACGkMEued=Pewd-xfLu7nhY0_gvMowAte4084mLWxAkykzJ8gw@mail.gmail.com>
Subject: Re: [PATCH] vduse: Fix NULL pointer dereference on sysfs access
To: Xie Yongji <xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>, mcgrof@kernel.org,
 oliver.sang@intel.com, akpm@linux-foundation.org
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

On Tue, Apr 26, 2022 at 2:01 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> The control device has no drvdata. So we will get a NULL
> NULL pointer dereference when accessing control device's
> msg_timeout via sysfs:
>
> [ 132.841881][ T3644] BUG: kernel NULL pointer dereference, address: 00000000000000f8
> [ 132.850619][ T3644] RIP: 0010:msg_timeout_show (drivers/vdpa/vdpa_user/vduse_dev.c:1271)
> [ 132.869447][ T3644] dev_attr_show (drivers/base/core.c:2094)
> [ 132.870215][ T3644] sysfs_kf_seq_show (fs/sysfs/file.c:59)
> [ 132.871164][ T3644] ? device_remove_bin_file (drivers/base/core.c:2088)
> [ 132.872082][ T3644] kernfs_seq_show (fs/kernfs/file.c:164)
> [ 132.872838][ T3644] seq_read_iter (fs/seq_file.c:230)
> [ 132.873578][ T3644] ? __vmalloc_area_node (mm/vmalloc.c:3041)
> [ 132.874532][ T3644] kernfs_fop_read_iter (fs/kernfs/file.c:238)
> [ 132.875513][ T3644] __kernel_read (fs/read_write.c:440 (discriminator 1))
> [ 132.876319][ T3644] kernel_read (fs/read_write.c:459)
> [ 132.877129][ T3644] kernel_read_file (fs/kernel_read_file.c:94)
> [ 132.877978][ T3644] kernel_read_file_from_fd (include/linux/file.h:45 fs/kernel_read_file.c:186)
> [ 132.879019][ T3644] __do_sys_finit_module (kernel/module.c:4207)
> [ 132.879930][ T3644] __ia32_sys_finit_module (kernel/module.c:4189)
> [ 132.880930][ T3644] do_int80_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:132)
> [ 132.881847][ T3644] entry_INT80_compat (arch/x86/entry/entry_64_compat.S:419)
>
> To fix it, let's add a NULL check in msg_timeout_show() and
> msg_timeout_store().
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index f85d1a08ed87..f1c42f4aabb4 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1268,6 +1268,9 @@ static ssize_t msg_timeout_show(struct device *device,
>  {
>         struct vduse_dev *dev = dev_get_drvdata(device);
>
> +       if (!dev)
> +               return -EPERM;
> +

I wonder if it's possible to not have those attributes for the control device.

Thanks

>         return sysfs_emit(buf, "%u\n", dev->msg_timeout);
>  }
>
> @@ -1278,6 +1281,9 @@ static ssize_t msg_timeout_store(struct device *device,
>         struct vduse_dev *dev = dev_get_drvdata(device);
>         int ret;
>
> +       if (!dev)
> +               return -EPERM;
> +
>         ret = kstrtouint(buf, 10, &dev->msg_timeout);
>         if (ret < 0)
>                 return ret;
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
