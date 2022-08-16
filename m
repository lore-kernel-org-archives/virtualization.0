Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC135C2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 10:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E4B781C04;
	Tue, 16 Aug 2022 10:45:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E4B781C04
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ied1E8Jj;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=MA+d1Q78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-lW88OSxdko; Tue, 16 Aug 2022 10:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0C67E81C11;
	Tue, 16 Aug 2022 10:45:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C67E81C11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6ACEC0033;
	Tue, 16 Aug 2022 10:45:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 664BAC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 10:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F3A2408A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 10:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F3A2408A3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=ied1E8Jj; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=MA+d1Q78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xE79bVEH9LGa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 10:45:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A29254089C
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A29254089C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 10:45:31 +0000 (UTC)
Date: Tue, 16 Aug 2022 12:45:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1660646728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTfZWFjuy/CJkPZjYoik1o/F1RfVmTymcNpGxiKl/v0=;
 b=ied1E8JjFjic+y0P8J340i/tMp9Eb9ykMxrRsYc8Bti4YFvP7KJtPRMLC4P0L7upmOv2fX
 4xTiS+lZndgpVAJ4aFwtGc76K6R7zfjv7XTSXsxXK/VcYlVU07WHkZd6PDVEsqra0oDEr9
 XgJapWWMREpegJMQQn9LPC3qJFQdVssOoRVEAdLl/t/rMRmk1R2jdKQq7roXQTabVBW7tr
 EUb3cZ/8H/INpQ/ic++vJfBLeRX2Dsa3kOZlEhkgs6G0WGG9DMIaT/Y9S83wxMsZtBFwmS
 IYi1IPXhZEN8F/FGKMQIlqiquLre0ElDXojx4YxDdRC39O0DSH57q/8dMXsGtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1660646728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTfZWFjuy/CJkPZjYoik1o/F1RfVmTymcNpGxiKl/v0=;
 b=MA+d1Q78GbacRxe2Hd7pM1M1Rm7Ismq/TjHg9fDsx58SRzH5MuQCg6kImfbBx21bI4zKMy
 9NHdui3VfbvYcuCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vduse:  Remove include of rwlock.h
Message-ID: <Yvt1R37f9QCLV0/F@linutronix.de>
References: <20220816074816.173227-1-bigeasy@linutronix.de>
 <20220816042557-mutt-send-email-mst@kernel.org>
 <YvtWdVtH4Y0MuG7k@linutronix.de>
 <20220816043636-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220816043636-mutt-send-email-mst@kernel.org>
Cc: Xie Yongji <xieyongji@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On 2022-08-16 04:39:29 [-0400], Michael S. Tsirkin wrote:
> rwlock: detect use outside of spinlock.h
> 
> current ifndef does not really prevent including rwlock.h
> directly.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Actually, yes, this should do the job and render the checkpatch.pl
patch, I sent earlier, obsolete.

Sebastian
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
