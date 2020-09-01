Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16669C433E2
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 22:35:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A58206EF
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 22:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A58206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B0E9085FEF;
	Tue,  1 Sep 2020 22:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQgADIXyReN3; Tue,  1 Sep 2020 22:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F1A985FE6;
	Tue,  1 Sep 2020 22:35:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CD77C0052;
	Tue,  1 Sep 2020 22:35:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B27D2C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 22:35:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 997A885693
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 22:35:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f9IiAF8WbEe7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 22:35:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA590855D8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 22:35:05 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 9F5F11365945A;
 Tue,  1 Sep 2020 15:18:16 -0700 (PDT)
Date: Tue, 01 Sep 2020 15:35:02 -0700 (PDT)
Message-Id: <20200901.153502.139998033973412039.davem@davemloft.net>
To: linyunsheng@huawei.com
Subject: Re: [PATCH net-next] vhost: fix typo in error message
From: David Miller <davem@davemloft.net>
In-Reply-To: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
References: <1598927949-201997-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [2620:137:e000::1:9]);
 Tue, 01 Sep 2020 15:18:16 -0700 (PDT)
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org,
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

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Tue, 1 Sep 2020 10:39:09 +0800

> "enable" should be "disable" when the function name is
> vhost_disable_notify(), which does the disabling work.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

Applied to 'net'.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
