Return-Path: <SRS0=F+q/=ND=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93867C4338F
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 11:58:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C268760F91
	for <virtualization@archiver.kernel.org>; Thu, 12 Aug 2021 11:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C268760F91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83E996058D;
	Thu, 12 Aug 2021 11:58:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpmHOOXqej40; Thu, 12 Aug 2021 11:58:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E8C4605AB;
	Thu, 12 Aug 2021 11:58:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C10CC001A;
	Thu, 12 Aug 2021 11:58:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86BDDC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EA5F60017
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eJ2bRsv0_oJb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:58:32 +0000 (UTC)
X-Greylist: delayed 00:21:52 by SQLgrey-1.8.0
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E929E60F4D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 11:58:31 +0000 (UTC)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
 id 1mE90Z-0003LC-0v; Thu, 12 Aug 2021 19:36:23 +0800
Received: from herbert by gondobar with local (Exim 4.92)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1mE90R-00009w-QI; Thu, 12 Aug 2021 19:36:15 +0800
Date: Thu, 12 Aug 2021 19:36:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 12/38] crypto: virtio: Replace deprecated CPU-hotplug
 functions.
Message-ID: <20210812113615.GB561@gondor.apana.org.au>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-13-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-13-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 tglx@linutronix.de, "David S. Miller" <davem@davemloft.net>
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

On Tue, Aug 03, 2021 at 04:15:55PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Gonglei <arei.gonglei@huawei.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
