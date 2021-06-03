Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3732DC47096
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 17:33:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D4C613DC
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 17:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D4C613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACD5B405E3;
	Thu,  3 Jun 2021 17:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7cpE3iGoQN5n; Thu,  3 Jun 2021 17:33:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36D54405FC;
	Thu,  3 Jun 2021 17:33:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B00EFC0001;
	Thu,  3 Jun 2021 17:33:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E568BC0001;
 Thu,  3 Jun 2021 17:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1CDB83EF6;
 Thu,  3 Jun 2021 17:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4EqNSspSO_Ka; Thu,  3 Jun 2021 17:33:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5826683EF0;
 Thu,  3 Jun 2021 17:33:41 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D919600EF;
 Thu,  3 Jun 2021 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622741621;
 bh=/UCRcRzeBqTtEan+hKQQytxiVuqK6B0k/wsPUAzHz04=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=MFTkiPeD9pCOCOqPoN5+CzEhXI99TCb/39pyxVHmsIu2k1fk8H/SddDyBYcnAZjdS
 xdHSwL+7enafUpzCDPPWhuip9DqrJ3fgknH6swTLZGTiCVZtJ3H91+7Jf4luWtvAsM
 t4nClvFCW1FHgSSW6qB2ZrbsTKofuoGjV47JEPaSNXeuxOGPapBCUc9lFVQruBLTTW
 2Ws3Gqt1g/sEt2+i9gvAEBowH0WoN7WHRtG++WdSXO3iwwOv55pJU+p4KiINspejbD
 vefQqFY64InbySwuXs6s50UHsk9hQWmicWTdvP4UZup7oMXGa2YBPm9L/nb8oaeS9g
 ITvifMb0XbFfw==
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
Date: Thu, 3 Jun 2021 10:33:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-2-ak@linux.intel.com>
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, jpoimboe@redhat.com, robin.murphy@arm.com,
 hch@lst.de, m.szyprowski@samsung.com
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

On 6/2/21 5:41 PM, Andi Kleen wrote:
> Only allow split mode when in a protected guest. Followon
> patches harden the split mode code paths, and we don't want
> an malicious host to force anything else. Also disallow
> indirect mode for similar reasons.

I read this as "the virtio driver is buggy.  Let's disable most of the
buggy code in one special case in which we need a driver without bugs.
In all the other cases (e.g. hardware virtio device connected over
USB-C), driver bugs are still allowed."

Can we just fix the driver without special cases?

--Andy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
