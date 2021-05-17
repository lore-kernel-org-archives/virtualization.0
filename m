Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C6C433B4
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 10:02:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCF3610C9
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 10:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCF3610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD0C783C03;
	Mon, 17 May 2021 10:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AncxKfLqsOSN; Mon, 17 May 2021 10:02:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4D6683BE1;
	Mon, 17 May 2021 10:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F422C000D;
	Mon, 17 May 2021 10:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3343C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 10:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 845C64031A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 10:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=codewreck.org header.b="THvcf4nE";
 dkim=pass (2048-bit key) header.d=codewreck.org header.b="4kmQtAPf"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J-nfl7EE-z1h
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 10:02:34 +0000 (UTC)
X-Greylist: delayed 00:08:27 by SQLgrey-1.8.0
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E6404040E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 10:02:34 +0000 (UTC)
Received: by nautica.notk.org (Postfix, from userid 108)
 id 9BCB8C020; Mon, 17 May 2021 11:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
 t=1621245243; bh=hQ3FIc3FP39hQ5sinVKlpsPMQdlr7pQOzU9Lg3Kuuuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=THvcf4nEk20zx43KQ4LuIpoZy/4f04nE7K3wdJIUyHn93AEJ/Qd6PVjvLf30BEQ9A
 yQsa4HQILtkj07srQrxej3oRVG4EgZeUtlsyX2DnosEI1CtH0iKYukDUXXPY6IVbxY
 ZXYvC0RhiiuCn/qTVwET+ZYWJl46FTkaOXClh//Zt6gswNPHQPHoKT/FL/2ewvpvOD
 QvS9aq3YTz71mOF3Xl4uioBqbEGDKEvf7efSXPWJtzzr82a/r1V4IDtvmRNMBGHzHd
 HNY6k8IKx6tKEuDlk/hyt5nsYT12qAnmlsuPOBPO4X7CDpQWKLhbBjzasM6cx5y9TN
 liJdD+Tj8t16Q==
Received: from odin.codewreck.org (localhost [127.0.0.1])
 by nautica.notk.org (Postfix) with ESMTPS id 10DD3C009;
 Mon, 17 May 2021 11:53:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
 t=1621245242; bh=hQ3FIc3FP39hQ5sinVKlpsPMQdlr7pQOzU9Lg3Kuuuk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=4kmQtAPfPpp5uxDjwZJVSDRtBlkdcMvHGcC7EqjXyJnNXCvgheRE9z7yBRmPjWogE
 XPnL+vWpTZi7A9LL0SBl1i4VisYN+2IYeqgf5OI35lpD7+2DhjAH6HQSU0/u3mdh7k
 lEItSYNyetultBuJuCnsbzlR2V6vOW/H1zhie1TGQyXfL94evvDHe/uj1wjNhKf9OA
 XbrX262RhR9feraS4tXciTmMAw9djTAUj13+RLNw6FsjmqroVEcICPbT69TCUeNQFa
 FKnWeBfxKuGqNUYyAMOV4by40oQijgsnWWOyCUNicHz8IQs1dFf10MDn2oyzuOT5BS
 bc39PXNegUN5g==
Received: from localhost (odin.codewreck.org [local])
 by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6f2eecd4;
 Mon, 17 May 2021 09:53:54 +0000 (UTC)
Date: Mon, 17 May 2021 18:53:39 +0900
From: asmadeus@codewreck.org
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC PATCH 15/15] 9p/trans_virtio: Handle virtio_device_ready()
 failure
Message-ID: <YKI9I9qg2iISlz65@codewreck.org>
References: <20210517093428.670-1-xieyongji@bytedance.com>
 <20210517093428.670-16-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517093428.670-16-xieyongji@bytedance.com>
Cc: ohad@wizery.com, jean-philippe@linaro.org, amit@kernel.org,
 airlied@linux.ie, mst@redhat.com, linux-kernel@vger.kernel.org,
 bjorn.andersson@linaro.org, miklos@szeredi.hu, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org, vgoyal@redhat.com
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

Xie Yongji wrote on Mon, May 17, 2021 at 05:34:28PM +0800:
> Now virtio_device_ready() will return error if we get
> invalid status. Let's handle this case on probe.

The change itself looks good to me

It's going to be a pain to apply though because it depends on
https://lkml.kernel.org/r/20210517083557.172-1-xieyongji@bytedance.com
you just sent, so this won't apply to virtio maintainers on one hand,
and I can't take just this patch because it depends on the first patch
in the patchset (well if it weren't RFC)...

I guess sending the other patch to Linus fast-ish so it can go in virtio
tree would be the best way forward? other maintainers please advise, I'm
bad at this.


> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
