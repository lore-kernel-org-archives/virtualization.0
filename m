Return-Path: <SRS0=8RH8=MR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BF3C4320A
	for <virtualization@archiver.kernel.org>; Sun, 25 Jul 2021 09:53:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE6B60F36
	for <virtualization@archiver.kernel.org>; Sun, 25 Jul 2021 09:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBE6B60F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92E2F82F4A;
	Sun, 25 Jul 2021 09:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yIyMlAZo59Ew; Sun, 25 Jul 2021 09:53:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4DFF782EFC;
	Sun, 25 Jul 2021 09:53:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E61AC0010;
	Sun, 25 Jul 2021 09:53:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8024CC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 09:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 611C882F4A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 09:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EgbxpKh4qw0m
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 09:53:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B66BB82EFC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 25 Jul 2021 09:53:30 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 775FA60EB4;
 Sun, 25 Jul 2021 09:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627206810;
 bh=0S5mWKS0YE49dox05634DpEBe3LWGbAlibIkWC4I1Gg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lR/dgZDaAzJhrlzuBwuNvpeBE4nL0O7SwDDAu6rs0nTpn1qZEYJXmDzGlXiIJkSPi
 DEUw9XRrshACWRfm2NN+eObQOA1mI0yECh4j6vL0g937TVrxPAFKz0YkzaLvaT0fp3
 pnIqeT+ksyE4lvJlxwsLHrxLLdA2l6EPkdDNpw4OXahbwQ98vViyQuxeoQkxQaHLjy
 Q6sRvkKKrCT1QTL/rg+jvL0VggyW1G9mMEZssChTBjfJd94JWLFGqNM5/b81t0nwFu
 6VaUZIPmQfH5aIPeZe+giBPVpRNS6YwCRbQw4XZdNAmlpPurDgUKZjsxssLoV6BW+C
 gWfE2It+7QmQA==
Date: Sun, 25 Jul 2021 12:53:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH v2] MAINTAINERS: Update for VMCI driver
Message-ID: <YP00lgKjIJ6tO0tw@unreal>
References: <1626861766-11115-1-git-send-email-jhansen@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1626861766-11115-1-git-send-email-jhansen@vmware.com>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Jul 21, 2021 at 03:02:46AM -0700, Jorgen Hansen wrote:
> Add maintainer info for the VMware VMCI driver.
> 
> v2: moved pv-drivers to L: as private list

Please put changelog under "---".
There is no value to see vXXX in the final commit in the repo.

Thanks

> 
> Acked-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a61f4f3..969a67a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19792,6 +19792,14 @@ L:	netdev@vger.kernel.org
>  S:	Supported
>  F:	drivers/ptp/ptp_vmw.c
>  
> +VMWARE VMCI DRIVER
> +M:	Jorgen Hansen <jhansen@vmware.com>
> +M:	Vishnu Dasa <vdasa@vmware.com>
> +L:	linux-kernel@vger.kernel.org
> +L:	pv-drivers@vmware.com (private)
> +S:	Maintained
> +F:	drivers/misc/vmw_vmci/
> +
>  VMWARE VMMOUSE SUBDRIVER
>  M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
>  M:	"VMware, Inc." <pv-drivers@vmware.com>
> -- 
> 2.6.2
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
