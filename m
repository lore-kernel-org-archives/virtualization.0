Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E5FC433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 00:17:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B981664DB1
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 00:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B981664DB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 24CF7214E6;
	Tue,  2 Feb 2021 00:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fn4zVNwbPtEX; Tue,  2 Feb 2021 00:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6ACD220000;
	Tue,  2 Feb 2021 00:17:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50892C0174;
	Tue,  2 Feb 2021 00:17:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4E83C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D369B86770
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:17:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mdi+M07ooCCy
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:17:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A4C8D8676E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 00:17:30 +0000 (UTC)
IronPort-SDR: qgMyALQwVoQm7Tio5w5W0e0ejbcMmRRTFQhVhkZcYncO2W1FNOSXVrE1sr3kAmR+e/i2Y9tIQR
 aOm+hMfLpORw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180849863"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="180849863"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2021 16:17:27 -0800
IronPort-SDR: smJdJiwMkzc9P/YXfcVcQpJa5/hZsncrUzC9L0s2AN13YyJCbQn+2oRBjeBlu8gorWgnxRVw7Z
 /Rk+43L3AWag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; d="scan'208";a="356034831"
Received: from unknown (HELO coxu-arch-shz) ([10.239.160.26])
 by orsmga003.jf.intel.com with ESMTP; 01 Feb 2021 16:17:25 -0800
Date: Tue, 2 Feb 2021 08:17:24 +0800 (CST)
From: Colin Xu <colin.xu@intel.com>
X-X-Sender: coxu_arch@coxu-arch-shz
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RESEND v3] virtio-input: add multi-touch support
In-Reply-To: <20210129102647-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.LNX.2.22.419.2102020815440.5024@coxu-arch-shz>
References: <20210115002623.8576-1-vasyl.vavrychuk@opensynergy.com>
 <20210129120654.16180-1-vasyl.vavrychuk@opensynergy.com>
 <20210129102647-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.22 (LNX 419 2020-04-12)
MIME-Version: 1.0
Cc: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>, rydberg@bitmath.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mathias.crombez@faurecia.com, linux-input@vger.kernel.org
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


I second the support of MT with this one or other alternative.
This patch has been tested work in one of our POC project.
--
Best Regards,
Colin Xu

On Fri, 29 Jan 2021, Michael S. Tsirkin wrote:

> On Fri, Jan 29, 2021 at 02:06:54PM +0200, Vasyl Vavrychuk wrote:
>> Hi, All,
>>
>> There has been no reply to this patch.
>>
>> Is there anything I can do?
>>
>> Thanks,
>> Vasyl
>
> Gerd any input on this?
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
