Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD74C433DF
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133072231B
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="onmhHVt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133072231B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6BC6A2045C;
	Mon, 19 Oct 2020 15:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7eK3ocoSFzwM; Mon, 19 Oct 2020 15:24:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E96C4274AA;
	Mon, 19 Oct 2020 15:24:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC7FCC0052;
	Mon, 19 Oct 2020 15:24:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 222C0C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 11545875D3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VqLXKs+J2lmY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:24:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5432A8741C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=lhuOmZGRCWQ3uUaYnSYsRiIP1dh7UtW+kvCqIlBjXoE=; b=onmhHVt8/XZdf0bdW/5VJQnn8h
 SGjBnMpvuxDPqq/Hk8YBHNsFTjWrWEj1iTX3ZdjvqahSsk/Zgo7wfSmJk1liZ1G6WhI6481/VUol3
 p7LI0Rhx2yYMIT2p9WCwBnh94OG9Drs0aoOGKNfLit80KskLQ2O4S8kMy0psWgZqpd3czqMbyBG57
 TCzKISgmNZ/ph8uXYusZD1kPLh7S1mWjqQcpR6ayjXXe9vN7WjrmQ0KWZn+7GqY/tIz1wLXc45jvo
 umQ5wkQVHDbn5X1YvDxZHUGmFTsvskB30rMni8tzQPljrMy43KaY40HtCU3X3j6jpxp4NQggGdQZc
 V85YS7xw==;
Received: from [2601:1c0:6280:3f0::507c]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUX1K-0002zL-Fm; Mon, 19 Oct 2020 15:24:22 +0000
Subject: Re: [RFC 2/4] vduse: Introduce VDUSE - vDPA Device in Userspace
To: "Michael S. Tsirkin" <mst@redhat.com>, Xie Yongji <xieyongji@bytedance.com>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <20201019145623.671-3-xieyongji@bytedance.com>
 <20201019110740-mutt-send-email-mst@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8e39a845-3013-53a6-5d2c-eb54cb7974a3@infradead.org>
Date: Mon, 19 Oct 2020 08:24:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201019110740-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
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

On 10/19/20 8:08 AM, Michael S. Tsirkin wrote:
> On Mon, Oct 19, 2020 at 10:56:21PM +0800, Xie Yongji wrote:
>> diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h

>> +#define VDUSE_BASE	'V'
>> +
> 
> Could we see some documentation about the user interface of this module please?
> 

Also, the VDUSE_BASE value should be documented in
Documentation/userspace-api/ioctl/ioctl-number.rst.

thanks.
-- 
~Randy

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
