Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793F6C433ED
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 11:28:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084DF6137D
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 11:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084DF6137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C12D541465;
	Thu, 15 Apr 2021 11:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WST02ITxIzSC; Thu, 15 Apr 2021 11:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3537D414D8;
	Thu, 15 Apr 2021 11:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 055EFC000B;
	Thu, 15 Apr 2021 11:28:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B47C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 600BE401F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=opensynergy.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_YMCKYsboXP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.opensynergy.com (mx1.opensynergy.com [217.66.60.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39929401CE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 11:28:26 +0000 (UTC)
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain
 [127.0.0.1])
 by mx1.opensynergy.com (Proxmox) with ESMTP id 28873A1BD7;
 Thu, 15 Apr 2021 13:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=srmailgate02; bh=81cfrwKyk1g4
 YvKpu+6SDuRsAjmGLhY0/Dw8H276Oys=; b=taWd7haYyNaObn8OcPAQl5IKK4PR
 JGYiK21bgYczqSr/5ZfIRTXbyNFiSpUcxWxXcxIP+kFLMigUKzxIz3iDVUlCJT2/
 RsYznnc20WhhFG/G3K/L3vPeBX0px+mnxPZAkAzAt3uqbQ1yVf3NrJf6GmYMFaOj
 MGuDAxpg33TKiWZkjLdreyPN/wBFhd2bJaIq+yApxQGwEk+3BHoeKgCXgBD0LFYe
 NY3VJ5ozWwfNWWj6wdo9vu2OCUPQa8muBFK4jHu5U67ae4nuvSDLO3/wS+Ct4ySx
 VBhzeCoNNL6qik4cHfFLs08YJW8lJGYcu5JHQLSEXZweKhSXYwsGxurjMw==
Subject: Re: [PATCH] sound: virtio: correct the function name in kernel-doc
 comment
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210415052645.14465-1-rdunlap@infradead.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <f63f2698-991f-409a-0d00-009059f0588d@opensynergy.com>
Date: Thu, 15 Apr 2021 13:28:23 +0200
MIME-Version: 1.0
In-Reply-To: <20210415052645.14465-1-rdunlap@infradead.org>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Cc: alsa-devel@alsa-project.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On 15.04.2021 07:26, Randy Dunlap wrote:
> 
> Fix kernel-doc warning that the wrong function name is used in a
> kernel-doc comment:
> 
> ../sound/virtio/virtio_ctl_msg.c:70: warning: expecting prototype for virtsnd_ctl_msg_request(). Prototype was for virtsnd_ctl_msg_response() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: alsa-devel@alsa-project.org

Thanks for fixing the copy/paste mistake. :)

Reviewed-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>

> ---
>   sound/virtio/virtio_ctl_msg.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20210414.orig/sound/virtio/virtio_ctl_msg.c
> +++ linux-next-20210414/sound/virtio/virtio_ctl_msg.c
> @@ -61,7 +61,7 @@ void *virtsnd_ctl_msg_request(struct vir
>   }
> 
>   /**
> - * virtsnd_ctl_msg_request() - Get a pointer to the response header.
> + * virtsnd_ctl_msg_response() - Get a pointer to the response header.
>    * @msg: Control message.
>    *
>    * Context: Any context.
> 

-- 
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
