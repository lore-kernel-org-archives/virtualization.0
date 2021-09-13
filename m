Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B50C433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:20:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1744E606A5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 22:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1744E606A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D865B80EB7;
	Mon, 13 Sep 2021 22:20:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cTozKRshb0ja; Mon, 13 Sep 2021 22:20:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9EB5A80EB4;
	Mon, 13 Sep 2021 22:20:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74ACAC0011;
	Mon, 13 Sep 2021 22:20:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C72E5C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A4B5860681
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="hp/7iXGX";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="tZec57Hz"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XX9y4UVQMDdV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:20:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20CAF60652
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:20:06 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1631571603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lu0+SbfjHiOcgPZXbw0IysSWeG75SaeBouN1PbDBmZI=;
 b=hp/7iXGX7n44dTdyvpJTD0IRHoHq9a0+44UxrvH7sj7uEc2jcTE/sD6W0Born2ch6r7j47
 FRI6TDz373Dh9wuxQj+1o91yGkz29g7gU3+9zEh4wYppwTnU7j0MMS50rmlo3RQaWX6yKS
 lnNRuYyou1nlTflakQKHgiirstJKBCX86Cung2232Q8OSQl0pqY2dbO09LZMRHB5Go6FD2
 JyLjvKTYkX2IOUOBePxsvCUiTVgDPHldpCYVXPPeI7p0hwGfeC2+1kaJ1PR+8XaNZbTmsa
 o+/toszLUWIU8X8FWkgIXcdRmuwY2DfQ9AEvqC44rHJeK0J2jJ5Srd5GCPTtCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1631571603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lu0+SbfjHiOcgPZXbw0IysSWeG75SaeBouN1PbDBmZI=;
 b=tZec57HziKkqsYs+DDwwW/G25gb73z0LPjbB1zxfZg0e57L+3/rV8t3vA1CzHBLx41dMOI
 xDfcyYUDC+ffcnBw==
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 7/9] virtio-pci: harden INTX interrupts
In-Reply-To: <20210913175428-mutt-send-email-mst@kernel.org>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-8-jasowang@redhat.com> <875yv4f99j.ffs@tglx>
 <20210913175428-mutt-send-email-mst@kernel.org>
Date: Tue, 14 Sep 2021 00:20:02 +0200
Message-ID: <87y280dsod.ffs@tglx>
MIME-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@kernel.org>, david.kaplan@amd.com,
 konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>,
 f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
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

On Mon, Sep 13 2021 at 18:01, Michael S. Tsirkin wrote:
> On Mon, Sep 13, 2021 at 11:36:24PM +0200, Thomas Gleixner wrote:
>> >From the interrupt perspective the sequence:
>> 
>>         disable_irq();
>>         vp_dev->intx_soft_enabled = true;
>>         enable_irq();
>> 
>> is perfectly fine as well. Any interrupt arriving during the disabled
>> section will be reraised on enable_irq() in hardware because it's a
>> level interrupt. Any resulting failure is either a hardware or a
>> hypervisor bug.
>
> yes but it's a shared interrupt. what happens if multiple callers do
> this in parallel?

Nothing as each caller is serialized vs. itself and its own interrupt
handler it cares about.

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
