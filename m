Return-Path: <SRS0=PU37=FD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7924C3E8C5
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 04:13:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DE520809
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 04:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2U04zY4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DE520809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0443B86FE9;
	Sun, 29 Nov 2020 04:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KqPXUmQ9e7sR; Sun, 29 Nov 2020 04:13:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7038286FAD;
	Sun, 29 Nov 2020 04:13:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58D13C163C;
	Sun, 29 Nov 2020 04:13:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF169C0052
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 04:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A49F720763
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 04:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K+B96wY1B3m6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 04:13:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 34EFB20531
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 04:13:16 +0000 (UTC)
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 667BC20795;
 Sun, 29 Nov 2020 04:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606623195;
 bh=K5FoQFGvvNLIFxwgaGQuC5JCNn9fVGY3KnfGk0sDLXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2U04zY4JE+cbtkq5mlJ8om2ytJ1uTm+UYGdu7RKAeHETNZNSc9gjOeQoL2a2K5IP+
 At+b2lF6KDCSuK4LDS8ZHnl8GzlEpSJWa07e00vFV6rl7G5e3EHGpYO2nBcInatl5V
 SM9vZI+yfGaBkEcNN4c2Q1ZRZdspjxO/7nReLN2s=
Date: Sat, 28 Nov 2020 23:13:14 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
Message-ID: <20201129041314.GO643756@sasha-vm>
References: <20201125153550.810101-1-sashal@kernel.org>
 <20201125153550.810101-22-sashal@kernel.org>
 <25cd0d64-bffc-9506-c148-11583fed897c@redhat.com>
 <20201125180102.GL643756@sasha-vm>
 <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9670064e-793f-561e-b032-75b1ab5c9096@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

On Wed, Nov 25, 2020 at 07:08:54PM +0100, Paolo Bonzini wrote:
>On 25/11/20 19:01, Sasha Levin wrote:
>>On Wed, Nov 25, 2020 at 06:48:21PM +0100, Paolo Bonzini wrote:
>>>On 25/11/20 16:35, Sasha Levin wrote:
>>>>From: Mike Christie <michael.christie@oracle.com>
>>>>
>>>>[ Upstream commit 18f1becb6948cd411fd01968a0a54af63732e73c ]
>>>>
>>>>Move code to parse lun from req's lun_buf to helper, so tmf code
>>>>can use it in the next patch.
>>>>
>>>>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>>>Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>Acked-by: Jason Wang <jasowang@redhat.com>
>>>>Link: https://lore.kernel.org/r/1604986403-4931-5-git-send-email-michael.christie@oracle.com
>>>>
>>>>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>>>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>
>>>This doesn't seem like stable material, does it?
>>
>>It went in as a dependency for efd838fec17b ("vhost scsi: Add support
>>for LUN resets."), which is the next patch.
>
>Which doesn't seem to be suitable for stable either...  Patch 3/5 in 

Why not? It was sent as a fix to Linus.

>the series might be (vhost scsi: fix cmd completion race), so I can 
>understand including 1/5 and 2/5 just in case, but not the rest.  Does 
>the bot not understand diffstats?

Not on their own, no. What's wrong with the diffstats?

-- 
Thanks,
Sasha
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
