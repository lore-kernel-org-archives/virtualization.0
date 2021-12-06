Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9202C433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Dec 2021 08:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF600404B7;
	Mon,  6 Dec 2021 08:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jHALJlZUyD2U; Mon,  6 Dec 2021 08:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A99D40426;
	Mon,  6 Dec 2021 08:01:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03D07C002F;
	Mon,  6 Dec 2021 08:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0E2BC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE091400EF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Do98IQTcdx6A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:01:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61228400BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638777672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wH8kwnz+ewHmU1AaRG71G1mumKaBP21RSNN+TDzU+jU=;
 b=dXxf7mTbYVQ8CcSLqPjNYqopnRKtcBV8BN4uVKSacA4wxjzxyiL9CrlaMpfj7J1LOH6VIf
 PVo0Hld2PdP81nUejlaB+dlxaPy2gM0H/BhqOe7Yiv6wLBWkRXG+iTfCWH8DQPg6Mcm0G3
 eQxOevs3b+ycdtKsovw9rM1a0FF/tHA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-6a-5GSt_PfCB_yqjRYdjAg-1; Mon, 06 Dec 2021 03:01:10 -0500
X-MC-Unique: 6a-5GSt_PfCB_yqjRYdjAg-1
Received: by mail-lf1-f71.google.com with SMTP id
 f15-20020a056512228f00b004037c0ab223so3531868lfu.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Dec 2021 00:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wH8kwnz+ewHmU1AaRG71G1mumKaBP21RSNN+TDzU+jU=;
 b=KoCLfmAsZd0yLLZh7cl7yWSCnzIVuGwdCnn5IdLjdnLibhKRVTH6BFR8nHnS2O2tYg
 3toS4fjuqEpQ0ClszLk54276yFJb6A8utwqzOyCD7yjGIs2tEEgPK6uQERHIoVsQYwJ4
 vNvHyLMuZUNkXzEKxnqY44uL7QagYNnN9FEamvrMFS99zkhOi3/jgXLsd6qKdPe/TzRs
 mxW9hV069u2ydtql1v8ac3QyalhyP3t76zfj1NnqpyQrkNkkT5jczDdd/cYEGr0YLf1Y
 frxYDfFInQ+WoT4RYjVyFnFOkbcdT4wclP2CeQijhX4kwob5UJCfGm0RMW04Vjomk2eO
 1wFQ==
X-Gm-Message-State: AOAM532adqTUxZeN+dgIL6L2bEvhGNGYPSnyknRf7Z8+Wsihgz7VXuUB
 ow/qubwDOvLpmCo4Hd79mylX+wuhNGFnH+1eswM6cG9iPr8eF1rQG7dE3E7WcTq87e0138crDYD
 QkshJbPPKMi91ih5JkeW0VkWbvrRJtVhCu73jYrK2Ge8C+sKPXpyq2qiMdA==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr34211645ljp.362.1638777668625; 
 Mon, 06 Dec 2021 00:01:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYfODCzAWEqMnMLn2tkI2pq1dE/G0Dew/Pmcpji5W/rXtHJLqZjo3c5XqwSdykVkg+nYS0G8Z980ScmvpQAlI=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr34211635ljp.362.1638777668440; 
 Mon, 06 Dec 2021 00:01:08 -0800 (PST)
MIME-Version: 1.0
References: <1638776941-34156-1-git-send-email-guanjun@linux.alibaba.com>
In-Reply-To: <1638776941-34156-1-git-send-email-guanjun@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 6 Dec 2021 16:00:57 +0800
Message-ID: <CACGkMEtNj_CyqV01MCKn6xa01d4FHscCZ9dgt3JCqrQYWaHpMA@mail.gmail.com>
Subject: Re: [PATCH 1/1] vduse: moving kvfree into caller
To: Guanjun <guanjun@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 kernel-janitors@vger.kernel.org, mst <mst@redhat.com>
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

On Mon, Dec 6, 2021 at 3:54 PM Guanjun <guanjun@linux.alibaba.com> wrote:
>
> From: Guanjun <guanjun@linux.alibaba.com>
>
> This free action should be moved into caller 'vduse_ioctl' in
> concert with the allocation.
>
> No functional change.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")

Does this fix a real problem? If not, let's try not using fixes tags here.

Thanks

> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index c9204c62f339..477a5a592002 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1355,7 +1355,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  err_str:
>         vduse_dev_destroy(dev);
>  err:
> -       kvfree(config_buf);
>         return ret;
>  }
>
> @@ -1406,6 +1405,8 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
>                 }
>                 config.name[VDUSE_NAME_MAX - 1] = '\0';
>                 ret = vduse_create_dev(&config, buf, control->api_version);
> +               if (ret)
> +                       kvfree(buf);
>                 break;
>         }
>         case VDUSE_DESTROY_DEV: {
> --
> 2.27.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
