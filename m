Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874E9C77B61
	for <virtualization@archiver.kernel.org>; Fri,  7 Apr 2023 15:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09D5B60F8C;
	Fri,  7 Apr 2023 15:03:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 09D5B60F8C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T4OndUlO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KAtxHUR3Sv9W; Fri,  7 Apr 2023 15:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D75F61634;
	Fri,  7 Apr 2023 15:03:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D75F61634
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60E7EC0037;
	Fri,  7 Apr 2023 15:03:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46862C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 15:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A83161634
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 15:03:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A83161634
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8SEDlq2cWeqX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 15:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E85F260F8C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E85F260F8C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Apr 2023 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680879816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cuQoojtyUSJETR2nd2K1fNz+7Y625dx15WLZe51OqG8=;
 b=T4OndUlOqFns6vhVhk6kmsY5JAWMJ1fsWYUtJWV0ONKx8E6gJR9eievHUtdQxOJnvhqUm8
 1Td/OP/Tc5qfxGHf9yHoyPYMvBn+cenzgZ5kjGwHlXFrMYtShWCXU9L4RjQzvd83uxP1od
 H+cajObIAjr5WxE4yNwtaPwASnMTuk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-521IXlUWMFORVbN-ncDGjg-1; Fri, 07 Apr 2023 11:03:35 -0400
X-MC-Unique: 521IXlUWMFORVbN-ncDGjg-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg33-20020a05600c3ca100b003ef6d684105so17254277wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 08:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680879812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuQoojtyUSJETR2nd2K1fNz+7Y625dx15WLZe51OqG8=;
 b=bhpakQiebXQtigd+1KzfIVEtiKayue3UcEU0OehRbtcmjhPgRyD5OYBohIcZkKH+oB
 Vgvq2eLAY9sTtO89LsXVq3dhoQD0deHbwabEc37mHHTmgXM8fdG9qymYiTBWlSTORogH
 3rh1rACkrRQgcX3Vv/jKfcwXKL6AUXCRMW43J4Irgvyu4fzXEgtx3DPcPmXThh/TBrgm
 pVfcmg+rE36WIR0sVwUmuf9/zc3HiIgbMLkL8zyokji/Lir5rhmDfOxhvwSdw2KmA4pC
 SxP3ZR+ZOLIO88Jh667IlbpErAAa961V0PdaeR9Qs3B+PztXlLe5h2n8AcE7jTCl3ptN
 m7hw==
X-Gm-Message-State: AAQBX9e21edCCeCfEfSctnULMLRZGOpSFJihL+DFAtKuLjr63UdLt2wO
 YkPtzQF68B/tIDyvY2PQShj5FDHu7yPdZek+Jk2mRriEoXoLDbYm73uitO0uTPFmKakgHfvvsCU
 kztxYV7lRR75kYs/gtnbmCvF+Ri5LhqxXq6xsdNSQjQ==
X-Received: by 2002:a1c:f310:0:b0:3ee:282d:1016 with SMTP id
 q16-20020a1cf310000000b003ee282d1016mr1909989wmq.25.1680879812622; 
 Fri, 07 Apr 2023 08:03:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlKD1jBpgyeO97TrwIhBOy+olr/w0iTAY7aZtpV6/1SMgATNnjbyQV6aZgywuB2M7d+lyLKA==
X-Received: by 2002:a1c:f310:0:b0:3ee:282d:1016 with SMTP id
 q16-20020a1cf310000000b003ee282d1016mr1909963wmq.25.1680879812300; 
 Fri, 07 Apr 2023 08:03:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742d:fd00:c847:221d:9254:f7ce])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a05600c511600b003ef5bb63f13sm8759938wms.10.2023.04.07.08.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Apr 2023 08:03:31 -0700 (PDT)
Date: Fri, 7 Apr 2023 11:03:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Message-ID: <20230407110308-mutt-send-email-mst@kernel.org>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Guenter Roeck <linux@roeck-us.net>
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

On Fri, Apr 07, 2023 at 05:01:30PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

sure, merge it as appropriate
Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>  drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> index e695e36ff753..65304354b34a 100644
> --- a/drivers/vdpa/solidrun/snet_hwmon.c
> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
>  	.read_string = snet_hwmon_read_string
>  };
>  
> -static const struct hwmon_channel_info *snet_hwmon_info[] = {
> +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
>  	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
