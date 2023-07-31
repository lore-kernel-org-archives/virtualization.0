Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF728C001DE
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 09:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6904C81638;
	Mon, 31 Jul 2023 09:55:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6904C81638
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WyaUHIzC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t_l0T5INDWyt; Mon, 31 Jul 2023 09:55:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 05806814AB;
	Mon, 31 Jul 2023 09:55:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05806814AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6236C0071;
	Mon, 31 Jul 2023 09:55:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5CA8C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78AFE40975
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78AFE40975
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WyaUHIzC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPnEmgR-WgiZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:55:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 379C540974
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:55:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 379C540974
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690797315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQoMCvoY9z85LfglEVQlQxX/qlev/LvzY9LJJJIP4QE=;
 b=WyaUHIzCDiUAPdMTDzPcWfidMzyn8+8vh4CsiMBP5sbaZXl+3bG0fo5iu5Zz2tRceOGM7v
 wnn6q5LonwsClOG1XzEKQAplJmcoCORuvWGKSCY0PAtxHfyOdYE12/WepCCDPkg/4uLlNX
 cNYPND85hnIAPoKogfFMrJqgiloapZ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-5WikDSVwNDipE2zncbIXvg-1; Mon, 31 Jul 2023 05:55:13 -0400
X-MC-Unique: 5WikDSVwNDipE2zncbIXvg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-522aa493673so1543999a12.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 02:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690797312; x=1691402112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQoMCvoY9z85LfglEVQlQxX/qlev/LvzY9LJJJIP4QE=;
 b=hToaTg2SUrEWh0tD6RK4XWmozpAhDtn5r7eoFCFBgjxAClNeVsqrCnb06fykqYRxXj
 UCF8cxWTNgQalyOsz/b45SWy8hzgwu1mLFdPVDpq0CzZyxFBiHqq74CpVWKWbV+bro2f
 ClxePoHZ4AM7Ht17bpknumbQgBtH1hz0lAqJNbevqjkKbX68OpdNZVXGuNx54wEXN3U6
 UnXlCpsBL7k9ELUI9MgqPzCrDpPvNInYgCgFKi8xmFRyVB4i3klvhzz6NCnZTJsHTh8u
 C/9sqiOPSLQM3bJ4NWz0gq6UnciFzja0l6hBkxdfCJIZuNyC6W+poL2wglBgiCGGe47K
 wWxw==
X-Gm-Message-State: ABy/qLYIhPwpKZLOW9yewFuJhfV8AN1+nWmM5YWgbQtTXiIhIvAEetbh
 ajXyNQFKUUN+zqNl6bhV1CK+fkIZ4NqVT7JljFZTy1rkbVOsQIPV2CJkn5bn4fyy2PUogQZvX4g
 dPnq9V4L6Lo/y36o7AqX+SQjYUlWmXbiHeqaG6WsVcQ==
X-Received: by 2002:aa7:c443:0:b0:522:55bf:21af with SMTP id
 n3-20020aa7c443000000b0052255bf21afmr7246381edr.7.1690797311991; 
 Mon, 31 Jul 2023 02:55:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE58TsNYsn/mQvr3qBZ6RLFnKbCrKdzPm+vWtUuE+xxgcoyQK4b4Cl5YZ1mF+9BK4pUUO0zZg==
X-Received: by 2002:aa7:c443:0:b0:522:55bf:21af with SMTP id
 n3-20020aa7c443000000b0052255bf21afmr7246363edr.7.1690797311630; 
 Mon, 31 Jul 2023 02:55:11 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-29.business.telecomitalia.it.
 [87.12.25.29]) by smtp.gmail.com with ESMTPSA id
 i23-20020aa7c717000000b0051bed21a635sm5234603edq.74.2023.07.31.02.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 02:55:10 -0700 (PDT)
Date: Mon, 31 Jul 2023 11:55:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yue Haibing <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] vsock: Remove unused function declarations
Message-ID: <ftvs2ivhynszqi3ib3w4uccfx5ren5dgkjagoeuyasbjdd76ac@4rbyljp2xnof>
References: <20230729122036.32988-1-yuehaibing@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230729122036.32988-1-yuehaibing@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: vdasa@vmware.com, pv-drivers@vmware.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bryantan@vmware.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Jul 29, 2023 at 08:20:36PM +0800, Yue Haibing wrote:
>These are never implemented since introduction in
>commit d021c344051a ("VSOCK: Introduce VM Sockets")
>
>Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>---
> net/vmw_vsock/vmci_transport.h | 3 ---
> 1 file changed, 3 deletions(-)

Good catch ;-)

I'd used "vsock/vmci:" as a prefix in the title.

With or without:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.h b/net/vmw_vsock/vmci_transport.h
>index b7b072194282..dbda3ababa14 100644
>--- a/net/vmw_vsock/vmci_transport.h
>+++ b/net/vmw_vsock/vmci_transport.h
>@@ -116,9 +116,6 @@ struct vmci_transport {
> 	spinlock_t lock; /* protects sk. */
> };
>
>-int vmci_transport_register(void);
>-void vmci_transport_unregister(void);
>-
> int vmci_transport_send_wrote_bh(struct sockaddr_vm *dst,
> 				 struct sockaddr_vm *src);
> int vmci_transport_send_read_bh(struct sockaddr_vm *dst,
>-- 
>2.34.1
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
