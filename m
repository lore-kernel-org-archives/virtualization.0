Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B2BECAAD5
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 00:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2845140A9B;
	Mon, 29 Aug 2022 00:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2845140A9B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iVDj6C3d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rZQ6FaT5Wiv; Mon, 29 Aug 2022 00:44:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9853B401DF;
	Mon, 29 Aug 2022 00:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9853B401DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE73C0033;
	Mon, 29 Aug 2022 00:44:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22DACC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB2A4818CA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB2A4818CA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iVDj6C3d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CHRjzFOWC-or
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:44:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AA6F81776
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AA6F81776
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 00:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661733871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TykdAivd2LEYHVOXlU8fC3DRzq2oxD33Z0Ct9UAkNAo=;
 b=iVDj6C3dBNdHNDojWQAwBFievRU0scpys2cZ5q/v6vGDS/x/VI+L1H00nm6auBh3XHyQLC
 DRnM7BK3uY6cxWNcplvnfxCUn/Wktr/RwVBwL3pXNnNyFIx0m9A1FWRaOQv42oXTgdSZf2
 ofSytRmWZ4CcFNmq7COJXdCpXcldv30=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-k6x5Vc1jMfaJocE6BG7lAg-1; Sun, 28 Aug 2022 20:44:30 -0400
X-MC-Unique: k6x5Vc1jMfaJocE6BG7lAg-1
Received: by mail-lf1-f71.google.com with SMTP id
 f9-20020ac24989000000b0049306244df2so1562082lfl.14
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Aug 2022 17:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=TykdAivd2LEYHVOXlU8fC3DRzq2oxD33Z0Ct9UAkNAo=;
 b=l5BZ/xR/4V1b7PK9K0C6Bs6Y4wNjpimLiVDVVoDtF9TO9h51S7/1xRwv08MI9eo1HN
 z2z50Opy4EFIdl00zGOuH1pWMJ8d/IJlE4Qt2tqrsL8leqHpbWKdQfitf/QuW4LVOvIu
 Vc9Lze35Cn/fZROnlmUbTvcp9T6dXWS+hCxo52Iay3lSkoc8ifvZxbNWZdENdVlbkzss
 9ps3CdQ0gt5X5+F/NNzm+cPp0geJeNUQK3IkO8xYW6tS8wObHE+C5k9JGrZ2Bi9R08HU
 NQ3wNt/q9sd2MIjlkcrywRVNSMwFrh/IEB6lw0sJ6JiEHGkpU///ifCzBEJtQQHZNb3A
 Lz/A==
X-Gm-Message-State: ACgBeo2swJ/zqQ2srXPUWVTahMo/7DdAmgjJj3uIJ2q9jlgpKRn3rDvd
 xBhyKVNkGAXij5gMBg9Y6wdJsOj+jMsLWbsfvRm6YRBJCLPfd5ZD/yGsxpHnjWo6uEZ2AVZKh/I
 WuebP4aBU4rOmpPpyntbG4vx41szPMVIKh+eSllnaP2AgVnOnl0FMKg/wWA==
X-Received: by 2002:a05:6512:1518:b0:492:d08a:a360 with SMTP id
 bq24-20020a056512151800b00492d08aa360mr6380632lfb.238.1661733868733; 
 Sun, 28 Aug 2022 17:44:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR70MD0oSJ0ZjSxYT1B9kZV5EV7+PMpjfUUNkjfv1EXfC/HPAEVqQZExv5RBjzwBAQ4co6mpfUo0DzpgdNaciTM=
X-Received: by 2002:a05:6512:1518:b0:492:d08a:a360 with SMTP id
 bq24-20020a056512151800b00492d08aa360mr6380627lfb.238.1661733868575; Sun, 28
 Aug 2022 17:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220826161605.559317-1-maxime.coquelin@redhat.com>
In-Reply-To: <20220826161605.559317-1-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Aug 2022 08:44:17 +0800
Message-ID: <CACGkMEt=WOBuF0M7PyY_y4pdpANW96_ku78cRuCKTR4-v+_q_Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: prevent uninitialized memory accesses
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Guanjun <guanjun@linux.alibaba.com>, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, Gautam Dawar <gautam.dawar@xilinx.com>,
 Eli Cohen <elic@nvidia.com>, Dan Carpenter <dan.carpenter@oracle.com>
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

On Sat, Aug 27, 2022 at 12:16 AM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> If the VDUSE application provides a smaller config space
> than the driver expects, the driver may use uninitialized
> memory from the stack.
>
> This patch prevents it by initializing the buffer passed by
> the driver to store the config value.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 41c0b29739f1..35dceee3ed56 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -673,10 +673,15 @@ static void vduse_vdpa_get_config(struct vdpa_device *vdpa, unsigned int offset,
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>
> -       if (offset > dev->config_size ||
> -           len > dev->config_size - offset)
> +       /* Initialize the buffer in case of partial copy. */
> +       memset(buf, 0, len);
> +
> +       if (offset > dev->config_size)
>                 return;
>
> +       if (len > dev->config_size - offset)
> +               len = dev->config_size - offset;
> +
>         memcpy(buf, dev->config + offset, len);
>  }
>
> --
> 2.37.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
