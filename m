Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C439FC433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 16:21:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC56233E2
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 16:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC56233E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 133A720117;
	Wed, 20 Jan 2021 16:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JFv0BHOBNxnh; Wed, 20 Jan 2021 16:20:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2073E20108;
	Wed, 20 Jan 2021 16:20:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4ECDC08A1;
	Wed, 20 Jan 2021 16:20:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74450C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A30E20108
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lo5Y4kd4uG3e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:20:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by silver.osuosl.org (Postfix) with ESMTPS id C893E20117
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 16:20:52 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id n8so17949030ljg.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jCuMF59B75JqVZRhUet2Yi3cLtXy0EDEiwxjM9Hz1MA=;
 b=VKJaXqGF5WS+x6qqQVL8towVM+Fs6mOF52cERPGOF256NSc0stzZeiyd+yEIlqipJM
 4aSZwbXPPypgcZ5VnQTX3nknuSIBOevMjlr4FKBbp0+7jtzLVfo+4k5ndliZNMM43lJH
 QljeH0cWV55LcLU8pVK+OZdU5O7WPEnSPsLqBcm1YunALWs3RoeztvB0He7lpF6xXGl7
 imnY6os11BG4kI4Dhq4UVrui3t8Qg05RhQLsJd1ZZwBsbI5QN4NjytDNbHUFHOYznihS
 3hetaM+CVwTavWBJRdAZLvajJ56jUxx7vxZzNB4ecNRMRzt8w8PRE9wH6IrxTmvyAZSb
 oKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jCuMF59B75JqVZRhUet2Yi3cLtXy0EDEiwxjM9Hz1MA=;
 b=H60gKz2IZ4DisTFLN/Jq+yNL7KaRA4ia6j5BCmIF5ZnNrqDV/KNYppFYQr3jTN1e2N
 t5Z26QoXPvll5y8axiROXBq8sAUtqVaKV85gBG8xdcHWfJjde4+4sbF06SqUm710irAm
 KyrdCw+WPEXL2zBVtHvhvTLXRYA7Jmk0VY3iGx4FrpPEjFCYJpLWLqGCLACpUw7t4dOW
 K2th96PfGHzvfM5gKKz7oTkrz+PZBnXmjjrPFL9dRTtTsgsF41QVHg6+eq4FRZgluD/R
 23lAiO5xunDBfNVgrqtktXBq3pYKJqY0FPjA3ungYQMp65v9zaJ0NS4Cge/yGguRyifa
 JQUw==
X-Gm-Message-State: AOAM530Wg3p6SGAyMdgPwWKEeN9feNXfsdkwZ4vetc2TqbF511hqQrhg
 67BFTXUfjNQ7LYJBiGULhi1CW9T+F8rUnNMGqqdsM07T9GhdvQ==
X-Google-Smtp-Source: ABdhPJwX/Q4xQp3XH8ogo8mdjPkIAyaTubhtdUMly2dIrPifA7A3MMAZC5W5GCCC4gFAzCV5TtScoAlTWEg/zN3wit4=
X-Received: by 2002:a05:6402:5246:: with SMTP id
 t6mr7843959edd.62.1611158288805; 
 Wed, 20 Jan 2021 07:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-2-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-2-wei.liu@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 20 Jan 2021 10:57:33 -0500
Message-ID: <CA+CK2bB0pO61=BX89CNycNKEzjHygzNFxCbn6zDD=5by44qijQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] asm-generic/hyperv: change
 HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
To: Wei Liu <wei.liu@kernel.org>
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> This makes the name match Hyper-V TLFS.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  include/asm-generic/hyperv-tlfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e73a11850055..e6903589a82a 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -88,7 +88,7 @@
>  #define HV_CONNECT_PORT                                BIT(7)
>  #define HV_ACCESS_STATS                                BIT(8)
>  #define HV_DEBUGGING                           BIT(11)
> -#define HV_CPU_POWER_MANAGEMENT                        BIT(12)
> +#define HV_CPU_MANAGEMENT                      BIT(12)

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
