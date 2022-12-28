Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625EBC4332F
	for <virtualization@archiver.kernel.org>; Wed, 28 Dec 2022 06:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E769F408F7;
	Wed, 28 Dec 2022 06:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E769F408F7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIubAxbO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mN-aZDZ4Slyf; Wed, 28 Dec 2022 06:58:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0B73C408B0;
	Wed, 28 Dec 2022 06:58:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0B73C408B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBADBC0032;
	Wed, 28 Dec 2022 06:58:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75FFDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CF1D81428
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3CF1D81428
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIubAxbO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iCcQ8UNU4fp1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:58:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88FD5813F0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88FD5813F0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672210699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukjbzX1vWQFr/xva/9x/ei7X/FajccvHf2yreViP6fM=;
 b=jIubAxbO83zhOSGSayH6j/N7yP/Sa8hLkosilJXlYb0ra9RgDYQ8TAiIfYvS4ORBlaXwj5
 pXckr+jkytmjsCKwheLusH+UbzPrfflqlaNnofYywoU9yW8a3QN/LkbzU1r0+KMnqgtPWG
 mZB9HT8JdzJSunQoNdCjl5/dYrmXGiI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-434-0lkCtNX3MjKjl74bGh8NbA-1; Wed, 28 Dec 2022 01:58:17 -0500
X-MC-Unique: 0lkCtNX3MjKjl74bGh8NbA-1
Received: by mail-ot1-f72.google.com with SMTP id
 98-20020a9d086b000000b00683e3114760so4163937oty.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 22:58:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ukjbzX1vWQFr/xva/9x/ei7X/FajccvHf2yreViP6fM=;
 b=AFej5aZjp/Q3hf0exOsKWvqz+CRdoqlUUrNB+zBeGFFnTnMSw90bu/oAGy5etlzWIq
 AXIBDeQAgThWJXcpE8bh8YL2f03EPioeVmE1Z9u23AsV8ERZRMTPoNeK/hN9YObI6EDD
 D81Tsdll7zrxUACv9T9K3NeHIr7RzjvdS7RQtcVwFwBc+N8VGUX2gu2o6Eu0jp+09YcF
 NRGi99cUgoxOaJZwwL70dQBaR2ZXq9/jQpC0Fxt0+Q3zihpA2KKtc5aiF04kIQKR+mdc
 beU8uNZqLsU2Tzm4q6qjIEYOvgLBdDd+XORnoEajs53yJkOrCrD5DBTVSRORUGPNdJdn
 FCug==
X-Gm-Message-State: AFqh2kpAUrdNm2g7CZwAfXwQ7mEZhJBI3WraWXpcjDNjxyaW1VeX0+lo
 pmh61UAZE798RR9B2JoBNatpnxfhzBCChA5RB4K4T34ejv9s6sszgYvp8JYpDgQ8D91r+yYKUl/
 jj3BhMCItvHZmxoc4fnUoSKg+LacHnXaXyhZD4aCt7RvmOWNJ9RxSb+5/Kg==
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1272504oir.280.1672210697056; 
 Tue, 27 Dec 2022 22:58:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtjRbcQngd3WQAoRBjABhHvQ5RUh+TMP7hoxIr4vy5ZF1s2o95GeaaGcuy+JWUIMNYFZckDvLXdwke+sLrojFc=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr1272499oir.280.1672210696800; Tue, 27
 Dec 2022 22:58:16 -0800 (PST)
MIME-Version: 1.0
References: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
In-Reply-To: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Dec 2022 14:58:05 +0800
Message-ID: <CACGkMEv-DradKs+k7AT50jTxO7S3DX-hJf0EQpsUp7WZii49nw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
To: Tanmay Bhushan <007047221b@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Dec 28, 2022 at 5:15 AM Tanmay Bhushan <007047221b@gmail.com> wrote:
>
> From 7eae04667ddaac8baa4812d48ef2c942cedef946 Mon Sep 17 00:00:00 2001
> From: Tanmay Bhushan <007047221b@gmail.com>
> Date: Tue, 27 Dec 2022 22:02:16 +0100
> Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
>
> ifcvf_mgmt_dev leaks memory if it is not freed before
> returning. Call is made to correct return statement
> so memory does not leak. ifcvf_init_hw does not take
> care of this so it is needed to do it here.
>
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
> b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f9c0044c6442..44b29289aa19 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
>         ret = ifcvf_init_hw(vf, pdev);
>         if (ret) {
>                 IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
> -               return ret;
> +               goto err;
>         }
>
>         for (i = 0; i < vf->nr_vring; i++)
> --
> 2.34.1
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
