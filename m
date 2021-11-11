Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9193BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6BB61037
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B6BB61037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3890160B20;
	Thu, 11 Nov 2021 06:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YRUaeMYWG5Ih; Thu, 11 Nov 2021 06:50:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1E8A60799;
	Thu, 11 Nov 2021 06:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCE21C0020;
	Thu, 11 Nov 2021 06:50:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EBC4C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6161281A9C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CAg_WPJx7KKc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E58EA81A81
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:43 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2B7B61269;
 Thu, 11 Nov 2021 06:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1636613443;
 bh=Za0ha/KPKidU0hYxA5XAAbicjwBHXdy/AC08WuITH28=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F32G7/zmqv/2mKQ5T7WLd2z4yJ+2qtratvgoirAEAsOtx3whvUDoFA4x0vogRG4FE
 36BYXMbaPGpCcpfKuZgbgGNYS6ZxFjBWtpEjp8f8ln6fp51P2OWC83DaEUKnITN1wd
 0mqaNYouBa1RHjBBwN6kigPkiPgVvxsMUXtFF1fU=
Date: Thu, 11 Nov 2021 07:50:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v3 1/3] MAINTAINERS: Update maintainers for paravirt ops
 and VMware hypervisor interface
Message-ID: <YYy9P7Rjg9hntmm3@kroah.com>
References: <163657479269.84207.13658789048079672839.stgit@srivatsa-dev>
 <163657487268.84207.5604596767569015608.stgit@srivatsa-dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <163657487268.84207.5604596767569015608.stgit@srivatsa-dev>
Cc: jgross@suse.com, anishs@vmware.com, pv-drivers@vmware.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, keerthanak@vmware.com,
 namit@vmware.com, rostedt@goodmis.org, Alexey Makhalov <amakhalov@vmware.com>,
 joe@perches.com, kuba@kernel.org
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

On Wed, Nov 10, 2021 at 12:08:16PM -0800, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> 
> Deep has decided to transfer maintainership of the VMware hypervisor
> interface to Srivatsa, and the joint-maintainership of paravirt ops in
> the Linux kernel to Srivatsa and Alexey. Update the MAINTAINERS file
> to reflect this change.
> 
> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Acked-by: Alexey Makhalov <amakhalov@vmware.com>
> Acked-by: Deep Shah <sdeep@vmware.com>
> Acked-by: Juergen Gross <jgross@suse.com>
> Cc: stable@vger.kernel.org

Why are MAINTAINERS updates needed for stable?  That's not normal :(
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
