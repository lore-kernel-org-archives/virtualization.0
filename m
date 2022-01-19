Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB7C433EF
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 06:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8348A40183;
	Wed, 19 Jan 2022 06:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eixaUyuq9QfP; Wed, 19 Jan 2022 06:01:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3A6340116;
	Wed, 19 Jan 2022 06:00:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2A21C0031;
	Wed, 19 Jan 2022 06:00:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97518C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 710EF826B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BOLtxzOxFiLS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:00:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE66E81B71
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642572053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iCV02P4a/ZhAvAhEH2bi6AaR3srt1Jkog8gmmNxw6js=;
 b=SUARf7cJtj1TZ1ypeFWvI8vK3RcqHFcyxXzFu7sbBX1p3n0XsqHR4UXQFtsaoolM+gtubE
 z6t2HKHOcgaFb6aQZX7dTcZoZCfHTA08xX/LRt6yJHXk5q5c+Kbij3b/0FFVZXysnQzW68
 I+qGKX+6oY5YVoUVODcYPvRX4lJHnIg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-gX84pJH6OGuI17_7nAtIsg-1; Wed, 19 Jan 2022 01:00:48 -0500
X-MC-Unique: gX84pJH6OGuI17_7nAtIsg-1
Received: by mail-lf1-f71.google.com with SMTP id
 x14-20020ac259ce000000b0042ca28e7200so820823lfn.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 22:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iCV02P4a/ZhAvAhEH2bi6AaR3srt1Jkog8gmmNxw6js=;
 b=o7MMRgZBBUGvjW6tSzBZblOsQ9S5TIQ22zeP648xqsAAyFqdyF16GBXEAIsiSFb1td
 GfqAu2KZL3RJhDWUhKBmDACCna+4BUjrWd7AAoVVv4EzPh7NMb9pg84vn9x1JlZuw6Lk
 uWVVH6215MdXl6gH9UCAcco1YR5+BYRPiClu5jPOx2bjAiF3qDVtlaa0smW8VcuqwAAi
 sL2XJx+CGNAY4oWD/K8SAgg6btFZaug/2qeDYVxlyDsf4E5w7eoJymIvrX6VXhE0OqnA
 LC6ful3SUaSG6RDYlYXYSf/y5dxOOcTtbnylv9ietFEAZJlCaV9JMFcKfOU9CpI7yTS2
 Jffw==
X-Gm-Message-State: AOAM533tpvBROUp7pUrI8qF+pq/Lglgf5hkH82OKWKQ31fHXo9zOogVc
 xaOcM7rKkXwEXBGEndgxrLv0AHFriHsVDHqMEgVg6Y/1u6Ti5goFQfhcVlPdmLLF933nWOPaoA7
 koZIvszeSqjZzCfaKto+DWGFKuoElMJCn+vlK1DQCSONGfkRXJLM+m5rFLw==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr22339758ljj.277.1642572046977; 
 Tue, 18 Jan 2022 22:00:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1WkDzG47stMfSjq09dGTyVZcGQ8M2kjXR/V2DPKxbD1GSf6+3sRbBpGdtwVuXf7z4luFXpf1iiVAnoy9Ppp8=
X-Received: by 2002:a2e:9843:: with SMTP id e3mr22339748ljj.277.1642572046777; 
 Tue, 18 Jan 2022 22:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20220119023543.91620-1-xuanzhuo@linux.alibaba.com>
 <20220119023543.91620-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220119023543.91620-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Jan 2022 14:00:35 +0800
Message-ID: <CACGkMEtbfRrUde8-d-yY9fk3CQdK2uCE_mrpO_eEk3JRU1XahA@mail.gmail.com>
Subject: Re: [PATCH 1/6] virtio: pci: struct virtio_pci_common_cfg add
 queue_notify_data
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

On Wed, Jan 19, 2022 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> here https://github.com/oasis-tcs/virtio-spec/issues/89
>
> Since I want to add queue_reset after it, I submitted this patch first.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/uapi/linux/virtio_pci.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 3a86f36d7e3d..492c89f56c6a 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -164,6 +164,7 @@ struct virtio_pci_common_cfg {
>         __le32 queue_avail_hi;          /* read-write */
>         __le32 queue_used_lo;           /* read-write */
>         __le32 queue_used_hi;           /* read-write */
> +       __le16 queue_notify_data;       /* read-write */
>  };

Since it's uAPI, do we need another which embed virtio_pci_common_cfg?

Thanks

>
>  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
