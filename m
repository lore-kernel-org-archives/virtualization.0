Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338BDC433FE
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 02:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1FD240012;
	Fri, 26 Nov 2021 02:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SrEbo6aDfRjC; Fri, 26 Nov 2021 02:48:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 214DD40335;
	Fri, 26 Nov 2021 02:48:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8800C001C;
	Fri, 26 Nov 2021 02:48:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24134C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12AF0401C4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UwUQqzHh1HSq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:48:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 449B04018D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 02:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637894908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1AXyVs0A0ObEm4/rr2kVWPtvp6eiMo4IEg87ee8zDR4=;
 b=T7tOyBBXZUGkdbvlS5kTSNxfhNLpAAHd3O6ndPNyW0fLz8ih38wESIOv6oBwDdpynvna8d
 6YgyPhDFGGdIEVjW3woyMUWO81qjasrqEBz8EfEefMthUeTy0GZ1alqEqFp70RRLQhbUmq
 CYZhQ8OEulyV4wXv4+mRquYE+7NGCjc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-b8_QcyoYOGqXu1xFO61EZw-1; Thu, 25 Nov 2021 21:48:25 -0500
X-MC-Unique: b8_QcyoYOGqXu1xFO61EZw-1
Received: by mail-lf1-f69.google.com with SMTP id
 y40-20020a0565123f2800b003fded085638so3675151lfa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 18:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1AXyVs0A0ObEm4/rr2kVWPtvp6eiMo4IEg87ee8zDR4=;
 b=GdRZGWDZyERKDjpd9sRTtqa2IpeRkhOi7MqLoacrHltakZ7HZRmaxcy71x2y6Pj09+
 WbbaBLdS73L7UvuqnYSxi/SJZ7MLiEXwaHvnlzvCiQC0NpzZA0qG7eTSVa/6oW21jw4A
 AWUw/YMgCXNbwIj8i4mn6kpkHXEZgEYLhx72hFxy8ryfQeUr7p8thBgDamal8o3vFdcM
 /NfNvGkgtvP2M2Gq9aTff1L9amNo0Vp9LQhdP1TFkOfn5IXLEvsfVC1B9Y00Zn8bWs7L
 YxGfX/XTEq7KWdX+p3E4u8TLjYnkiiLAgTuslZaqoh1Q8PkWfcUGez2XTfLJ0oS1H5cg
 qPeA==
X-Gm-Message-State: AOAM530wJ/ilYiTNzJAsR9tcYiuuQRQnhdlp5jjeerH1Cgj/PiqL85lC
 DENHgls++PO4dmqbQ10wCPnvCAyWSxhwrMJnHPB3duCrm1y/T9GRbJcOfwJ9i+XrXdgCpMOI5Qr
 vaXMgrSQJZrOgmjq8hp8FFjYAGQWOCw6FDGdunt/753vvewv1XbObH/26nQ==
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr27866804lfr.348.1637894903434; 
 Thu, 25 Nov 2021 18:48:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVInrCS+HtbEDB7vGucUYDZpOwiMnoy32RNLDJWoYIg9cnS+c91hBLvgITl8C6V/CWJTqhvv6Iuvzw9kt2LJ8=
X-Received: by 2002:a05:6512:2081:: with SMTP id
 t1mr27866786lfr.348.1637894903264; 
 Thu, 25 Nov 2021 18:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20211125180915.649652-1-parav@nvidia.com>
In-Reply-To: <20211125180915.649652-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Nov 2021 10:48:12 +0800
Message-ID: <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Consider device id larger than 31
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 mst <mst@redhat.com>, kbuild@lists.01.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Eli Cohen <elic@nvidia.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Fri, Nov 26, 2021 at 2:09 AM Parav Pandit <parav@nvidia.com> wrote:
>
> virtio device id value can be more than 31. Hence, use BIT_ULL in
> assignment.
>
> Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..e91c71aeeddf 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>                 goto msg_err;
>
>         while (mdev->id_table[i].device) {
> -               supported_classes |= BIT(mdev->id_table[i].device);
> +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
>                 i++;
>         }
>
> --
> 2.26.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
