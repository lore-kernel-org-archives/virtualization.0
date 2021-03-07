Return-Path: <SRS0=QaqO=IF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A173C433E0
	for <virtualization@archiver.kernel.org>; Sun,  7 Mar 2021 09:01:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F276165138
	for <virtualization@archiver.kernel.org>; Sun,  7 Mar 2021 09:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F276165138
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B988A4B739;
	Sun,  7 Mar 2021 09:01:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ctmqnVcBh8P; Sun,  7 Mar 2021 09:01:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41F504B59B;
	Sun,  7 Mar 2021 09:01:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15D61C000A;
	Sun,  7 Mar 2021 09:01:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39276C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Mar 2021 09:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27461605DF
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Mar 2021 09:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nd6SjAh-cpkn
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Mar 2021 09:01:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 791686006A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Mar 2021 09:01:31 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58F7F65135;
 Sun,  7 Mar 2021 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615107691;
 bh=abXeTeaXxmOHy8DJsqq2BXjgblFyPZwhgbDWIQERDoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p/TyveCmSOwGkLJUNk1316yo1ByvCPSsLEjPaDvz+YRqLp34PGudsBfIktybVupk4
 afm0rOnM892gt5BE0jMWnCf0CcA17uDlIH2Yg05bQCNJjaHEFt9cPIEfuVKHEQKXBO
 yiBuyTXP4jhoeqPhX2gj8HtHznup8sqkeapWIclVhRm9XPOVcLHLbiEcu2TBt0s4op
 HCVGXW1QHbBnJnb4uO1bl+dryCA33Hq5noHwOm4xTiSIliG0W5AD3myVVmivCh6FkP
 306Xpagy+8IK062+OsI+86fy+xM9Dz5HZjf7Bu03zYFNec7RkxbEz0S5NsA2uMDtIj
 uB2qUxkaYuY+A==
Date: Sun, 7 Mar 2021 11:01:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 3/3] vDPA/ifcvf: bump version string to 1.0
Message-ID: <YESWZ0Sjj1YMKETG@unreal>
References: <20210305142000.18521-1-lingshan.zhu@intel.com>
 <20210305142000.18521-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210305142000.18521-4-lingshan.zhu@intel.com>
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Mar 05, 2021 at 10:20:00PM +0800, Zhu Lingshan wrote:
> This commit bumps ifcvf driver version string to 1.0
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index fd5befc5cbcc..56a0974cf93c 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -14,7 +14,7 @@
>  #include <linux/sysfs.h>
>  #include "ifcvf_base.h"
>
> -#define VERSION_STRING  "0.1"
> +#define VERSION_STRING  "1.0"

Please delete it instead of bumping it.
We are not supposed to use in-kernel version for years already.
https://lore.kernel.org/ksummit-discuss/20170625072423.GR1248@mtr-leonro.local/

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
