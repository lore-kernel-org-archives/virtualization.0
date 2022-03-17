Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0EFC433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 03:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1D3141780;
	Thu, 17 Mar 2022 03:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b1QYM4blSPPD; Thu, 17 Mar 2022 03:26:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B2034179A;
	Thu, 17 Mar 2022 03:26:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A3C0C0012;
	Thu, 17 Mar 2022 03:26:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33B05C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B8D74179A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NLegFegJy2Uy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:26:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F76A41780
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 03:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647487568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v2SLUI2o5WSRk9a3lKvJBCeORiM/sUU5CpB7omPJTl4=;
 b=AnK5gI8OF/Wbub4qLHzMhUX2C7+Ev013qW94yFvxeULCN/hZOkpVtxAll1BngHb/4aagZ9
 RE0CcSKao7azWofPPwjmpAk2ZYQ3VmrI5G8gzYouQr3bNi3zxjj8m7nfsdVY7vVwRNLlK0
 RfT1ieSRPyrFhJxW0K57dkxvUXJK3Bo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-LBmIWPufM2aCjws25OOo9Q-1; Wed, 16 Mar 2022 23:26:06 -0400
X-MC-Unique: LBmIWPufM2aCjws25OOo9Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 f15-20020a2e6a0f000000b00249609bc9ebso236032ljc.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 20:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v2SLUI2o5WSRk9a3lKvJBCeORiM/sUU5CpB7omPJTl4=;
 b=IK8NHNdoe0yQNSJXJHFKxlvPAz+C+bAO2Nkzt/TPnrQvuKU0PGRF5pUwOzKrSItsq9
 jtx3QsuhMEJpt6atBzlKTBZtwMdoRSFX/2QoOcdGx6GKQNHIosy8BAsJb40jynGnMnlM
 XMqtif8IhyeUEBJ4svUZmbYPAApYwf2KacKEOFLAWBA8yyns62NTaFJNt4Jkz92tyDye
 +ESsFZq7E1LNbTYhmtBDuwxJVcg2o73NRSTXxNvT1qxRQ/6HMpS6WEakaUYYbwWyggpn
 QfBdgfn0zHE+D9ddHnm3Rr8dl0ZQTKCtyipe7WwJIXPKhyvVcde/qA9HReC6OHXxCBcs
 S7HQ==
X-Gm-Message-State: AOAM5315VmzSkNOwE+o8jHDSxmpHFw7u1A1qNQSuL6DWEsd+7+6AgD6T
 ULWYFAIbHVHbci+8Gxrq1rj+LITdihGhD4DoocCXnkifJwS2OJpQmFgfd8T1kKA2/PYsl86AFKX
 4LjorLRlwG3XL79t9auY9MDzZb4CcLfyROe7jfuvDQFcv0YUGAAiyjkYXZA==
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr1484757lfh.471.1647487564807; 
 Wed, 16 Mar 2022 20:26:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXgM3TrKtjE8JRO+JLQ4gZHrItL2DfPkyIFRVyKVrsUjNu6z7Jg/bAU90mtxG6avLG14+uPzJmzqIeygxmack=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr1484712lfh.471.1647487564603; Wed, 16
 Mar 2022 20:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220316192010.19001-1-rdunlap@infradead.org>
 <20220316192010.19001-6-rdunlap@infradead.org>
In-Reply-To: <20220316192010.19001-6-rdunlap@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Mar 2022 11:25:53 +0800
Message-ID: <CACGkMEsX4bS+wmmOE=L5COZxsdFCZmbLTnCe4fZs58MZRx+tQQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] virtio-scsi: eliminate anonymous module_init &
 module_exit
To: Randy Dunlap <rdunlap@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: the arch/x86 maintainers <x86@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, nouveau@lists.freedesktop.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Valentina Manea <valentina.manea.m@gmail.com>,
 Karol Herbst <karolherbst@gmail.com>,
 Krzysztof Opasiak <k.opasiak@samsung.com>, Eli Cohen <eli@mellanox.com>,
 netdev <netdev@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
 RDMA mailing list <linux-rdma@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org,
 Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Joachim Fritschi <jfritschi@freenet.de>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Amit Shah <amit@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
 linux-block@vger.kernel.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jussi Kivilinna <jussi.kivilinna@mbnet.fi>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Florian Westphal <fw@strlen.de>, linux-kernel <linux-kernel@vger.kernel.org>,
 netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
 Igor Kotrasinski <i.kotrasinsk@samsung.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Thu, Mar 17, 2022 at 3:24 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Eliminate anonymous module_init() and module_exit(), which can lead to
> confusion or ambiguity when reading System.map, crashes/oops/bugs,
> or an initcall_debug log.
>
> Give each of these init and exit functions unique driver-specific
> names to eliminate the anonymous names.
>
> Example 1: (System.map)
>  ffffffff832fc78c t init
>  ffffffff832fc79e t init
>  ffffffff832fc8f8 t init
>
> Example 2: (initcall_debug log)
>  calling  init+0x0/0x12 @ 1
>  initcall init+0x0/0x12 returned 0 after 15 usecs
>  calling  init+0x0/0x60 @ 1
>  initcall init+0x0/0x60 returned 0 after 2 usecs
>  calling  init+0x0/0x9a @ 1
>  initcall init+0x0/0x9a returned 0 after 74 usecs
>
> Fixes: 4fe74b1cb051 ("[SCSI] virtio-scsi: SCSI driver for QEMU based virtual machines")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/scsi/virtio_scsi.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> --- lnx-517-rc8.orig/drivers/scsi/virtio_scsi.c
> +++ lnx-517-rc8/drivers/scsi/virtio_scsi.c
> @@ -988,7 +988,7 @@ static struct virtio_driver virtio_scsi_
>         .remove = virtscsi_remove,
>  };
>
> -static int __init init(void)
> +static int __init virtio_scsi_init(void)
>  {
>         int ret = -ENOMEM;
>
> @@ -1020,14 +1020,14 @@ error:
>         return ret;
>  }
>
> -static void __exit fini(void)
> +static void __exit virtio_scsi_fini(void)
>  {
>         unregister_virtio_driver(&virtio_scsi_driver);
>         mempool_destroy(virtscsi_cmd_pool);
>         kmem_cache_destroy(virtscsi_cmd_cache);
>  }
> -module_init(init);
> -module_exit(fini);
> +module_init(virtio_scsi_init);
> +module_exit(virtio_scsi_fini);
>
>  MODULE_DEVICE_TABLE(virtio, id_table);
>  MODULE_DESCRIPTION("Virtio SCSI HBA driver");
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
