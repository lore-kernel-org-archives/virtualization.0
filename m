Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E89EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 02:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BF9B81322;
	Tue, 10 May 2022 02:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5CFQ1AXBwYhF; Tue, 10 May 2022 02:41:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2376813E1;
	Tue, 10 May 2022 02:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95901C0039;
	Tue, 10 May 2022 02:41:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF713C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9BC740288
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G1Yhxnn1NTOI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:40:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF16040280
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652150458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=btuSt+eTiboN9EpYdhYjr//P8XlvonQ50rzV3e6NBaU=;
 b=TO1hx16UrxNuTF9+7/yp8CLSgdweQ7od1U6ld1WcSQifyBN6pkzb+0CzjKXQDnyLQIHkQV
 GLWW/+hdzOXs1Vs+M0MvYWh1LQsG6h7/8cy/4a8npCwLqINVvqcVr13NttE7fOCJp3Tpd+
 XZqqhXMnTvpKKv41fZw9xXyVohUVz9g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-aLqcekx0O-y-Qk5toGwSfw-1; Mon, 09 May 2022 22:40:57 -0400
X-MC-Unique: aLqcekx0O-y-Qk5toGwSfw-1
Received: by mail-lj1-f197.google.com with SMTP id
 a9-20020a2e88c9000000b0024f37c179d3so4661520ljk.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 May 2022 19:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=btuSt+eTiboN9EpYdhYjr//P8XlvonQ50rzV3e6NBaU=;
 b=qghRrjdDnGxVm0hsxwS9kIGpcm/MUYsTSB4ZMU6yWNd57sVdjX23zL9tix/DTHoYWl
 3O4D0foa8Lu2rAaOxXagKHfO+mR8CZyXoCkSCnCXLeRD7SH1K8sOwPSBMxLBwbY+OKpV
 nSolgYtHxwNya397HI/k/aW4OaLHi7c7L5eeoX7MDOq3pcUYiFIoPal6e/oBdDJIezwP
 PT1WljXugDsTs9mIxQW2wumU5QppAa3klzgvBv1Md7pUjXLDUoMOTJEZ2cXr5/wONJVd
 751sOThQ/2SDp53fuPN/pqJd01pz0nNSOt0g/ziVQ5OK3xKlsTGbY9G6jIZo1iijpT9i
 yhdw==
X-Gm-Message-State: AOAM532It41aJM+lNqpg4pbTvP6L+yU94p//hD9vIfmjuKlqhS90WLp0
 csiiJY53bX13UTxmjJLAbJtd1sOrvCWRqWOBzuLXKT6j644D3adX6rU97cnrCO4G0eR7B3oKMVV
 ZxdB9tgzCjVAEhsTvYCwsArRTYgSJqELSRi/esXr144j1h2WVdRTHljDehg==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr14762568lfj.587.1652150455984; 
 Mon, 09 May 2022 19:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx466G++VqLk0Dv1De6DAfZjSjfHh3BKVNXytAvyofCCuDsxodfSwD1fVt/PLRyuQ58RkwsIcxETi0sYcfjero=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr14762559lfj.587.1652150455802; Mon, 09
 May 2022 19:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220508163317.204673-1-elic@nvidia.com>
 <20220508163317.204673-2-elic@nvidia.com>
In-Reply-To: <20220508163317.204673-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 May 2022 10:40:44 +0800
Message-ID: <CACGkMEs35nLewkMzP0p4mBHtiYb0DQaMmnG_EEpUad18ygnqxg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Si-Wei Liu <si-wei.liu@oracle.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, May 9, 2022 at 12:33 AM Eli Cohen <elic@nvidia.com> wrote:
>
> In vdpa_nl_cmd_dev_get_doit(), ff the call to genlmsg_reply() fails we

I guess you mean "if" here?

> must not call nlmsg_free() since this is done inside genlmsg_reply().
>
> Fix it.
>
> Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Other than the above typo.

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2b75c00b1005..fac89a0d8178 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -756,14 +756,19 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
>                 goto mdev_err;
>         }
>         err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
> -       if (!err)
> -               err = genlmsg_reply(msg, info);
> +       if (err)
> +               goto mdev_err;
> +
> +       err = genlmsg_reply(msg, info);
> +       put_device(dev);
> +       mutex_unlock(&vdpa_dev_mutex);
> +       return err;
> +
>  mdev_err:
>         put_device(dev);
>  err:
>         mutex_unlock(&vdpa_dev_mutex);
> -       if (err)
> -               nlmsg_free(msg);
> +       nlmsg_free(msg);
>         return err;
>  }
>
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
