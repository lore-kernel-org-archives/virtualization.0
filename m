Return-Path: <SRS0=p0Ab=DK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A623FC4363C
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 02:06:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A96820663
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 02:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A96820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 982ED86D3E;
	Sat,  3 Oct 2020 02:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnQ7ElVFjrxH; Sat,  3 Oct 2020 02:06:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9BB518694B;
	Sat,  3 Oct 2020 02:06:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A932C0889;
	Sat,  3 Oct 2020 02:06:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD965C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93D49868B5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5bpnvqKJiLQK
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:06:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8473E868A8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:06:43 +0000 (UTC)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 947C91260D092;
 Fri,  2 Oct 2020 18:49:53 -0700 (PDT)
Date: Fri, 02 Oct 2020 19:06:38 -0700 (PDT)
Message-Id: <20201002.190638.1090456279017490485.davem@davemloft.net>
To: anant.thazhemadam@gmail.com
Subject: Re: [Linux-kernel-mentees][PATCH 0/2] reorder members of
 structures in virtio_net for optimization
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200930051722.389587-1-anant.thazhemadam@gmail.com>
References: <20200930051722.389587-1-anant.thazhemadam@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [2620:137:e000::1:9]);
 Fri, 02 Oct 2020 18:49:54 -0700 (PDT)
Cc: hawk@kernel.org, daniel@iogearbox.net, mst@redhat.com,
 netdev@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org
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

From: Anant Thazhemadam <anant.thazhemadam@gmail.com>
Date: Wed, 30 Sep 2020 10:47:20 +0530

> The structures virtnet_info and receive_queue have byte holes in 
> middle, and their members could do with some rearranging 
> (order-of-declaration wise) in order to overcome this.
> 
> Rearranging the members helps in:
>   * elimination the byte holes in the middle of the structures
>   * reduce the size of the structure (virtnet_info)
>   * have more members stored in one cache line (as opposed to 
>     unnecessarily crossing the cacheline boundary and spanning
>     different cachelines)
> 
> The analysis was performed using pahole.
> 
> These patches may be applied in any order.

What effects do these changes have on performance?

The cache locality for various TX and RX paths could be effected.

I'm not applying these patches without some data on the performance
impact.

Thank you.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
