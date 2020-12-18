Return-Path: <SRS0=st/B=FW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CBDC4361B
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 23:25:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A0923BA7
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 23:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A0923BA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opensynergy.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E765D87ABE;
	Fri, 18 Dec 2020 23:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1D-uiFIvuT1; Fri, 18 Dec 2020 23:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5A84886D20;
	Fri, 18 Dec 2020 23:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D26BC1786;
	Fri, 18 Dec 2020 23:25:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA24BC0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id ABCCF2E34E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lqHQY9PqK+rJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from plasma4.jpberlin.de (plasma4.jpberlin.de [80.241.57.33])
 by silver.osuosl.org (Postfix) with ESMTPS id EA27420110
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 23:25:22 +0000 (UTC)
Received: from spamfilter02.heinlein-hosting.de
 (spamfilter02.heinlein-hosting.de [80.241.56.116])
 by plasma.jpberlin.de (Postfix) with ESMTP id 2F3F7AAB69;
 Sat, 19 Dec 2020 00:25:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
 by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de
 [80.241.56.116]) (amavisd-new, port 10030)
 with ESMTP id zj22D1gFzuNA; Sat, 19 Dec 2020 00:25:18 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (Client CN "*.opensynergy.com",
 Issuer "Starfield Secure Certificate Authority - G2" (not verified))
 (Authenticated sender: opensynergy@jpberlin.de)
 by plasma.jpberlin.de (Postfix) with ESMTPSA id 5F3B3AA60B;
 Sat, 19 Dec 2020 00:25:18 +0100 (CET)
Subject: Re: [PATCH RESEND v2] virtio-input: add multi-touch support
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20201208210150.20001-1-vasyl.vavrychuk@opensynergy.com>
 <20201209030635-mutt-send-email-mst@kernel.org>
From: Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Message-ID: <84310558-729b-d6d0-cf1a-e48febc3f001@opensynergy.com>
Date: Sat, 19 Dec 2020 01:25:15 +0200
MIME-Version: 1.0
In-Reply-To: <20201209030635-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.50 / 15.00 / 15.00
X-Rspamd-Queue-Id: 2F3F7AAB69
X-Rspamd-UID: 9ec262
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Mathias Crombez <mathias.crombez@faurecia.com>, linux-input@vger.kernel.org
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



On 09.12.20 10:28, Michael S. Tsirkin wrote:
> On Tue, Dec 08, 2020 at 11:01:50PM +0200, Vasyl Vavrychuk wrote:
>> From: Mathias Crombez <mathias.crombez@faurecia.com>
>> Cc: stable@vger.kernel.org
> 
> I don't believe this is appropriate for stable, looks like
> a new feature to me.

Agree, removed.

>>
>> +config VIRTIO_INPUT_MULTITOUCH_SLOTS
>> +     depends on VIRTIO_INPUT
>> +     int "Number of multitouch slots"
>> +     range 0 64
>> +     default 10
>> +     help
>> +      Define the number of multitouch slots used. Default to 10.
>> +      This parameter is unused if there is no multitouch capability.
>> +
>> +      0 will disable the feature.
>> +
> 
> Most people won't be using this config so the defaults matter. So why 10? 10 fingers?
> 
> And where does 64 come from?

I have sent v3 version where number of slots it obtained from the host.

>> +     if (is_mt)
>> +             input_mt_init_slots(vi->idev,
>> +                                 CONFIG_VIRTIO_INPUT_MULTITOUCH_SLOTS,
>> +                                 INPUT_MT_DIRECT);
> 
> 
> Do we need the number in config space maybe? And maybe with a feature
> bit so host can find out whether guest supports MT?

I think it is not applicable in v3 which I sent, because number of slots 
is commit from the host. So, now host controls whether guest support MT.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
