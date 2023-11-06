Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA4AC4167B
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 10:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 449228235F;
	Mon,  6 Nov 2023 10:52:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 449228235F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 39OKtN3LCzWo; Mon,  6 Nov 2023 10:52:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B539681258;
	Mon,  6 Nov 2023 10:52:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B539681258
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EFFAC0039;
	Mon,  6 Nov 2023 10:52:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01895C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D10C361130
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:52:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D10C361130
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qYdSqmD93EKm
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:52:23 +0000 (UTC)
X-Greylist: delayed 2615 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 06 Nov 2023 10:52:23 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B4056111C
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B4056111C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:52:23 +0000 (UTC)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
 id 1qzwX7-00EXgv-7O; Mon, 06 Nov 2023 18:08:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Mon, 06 Nov 2023 18:08:44 +0800
Date: Mon, 6 Nov 2023 18:08:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
Message-ID: <ZUi7LNhFFAumgRZ2@gondor.apana.org.au>
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
 <adb0c5f790dc408887f9d98548373919@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adb0c5f790dc408887f9d98548373919@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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

On Thu, Nov 02, 2023 at 01:01:09PM +0000, Gonglei (Arei) wrote:
>
> > So I think the core of this question is: Can we call crypto_finalize_request() in
> > the upper half of the interrupt?

The finalize path originates from the network stack.  So the conditions
are the same as that of the network stack receive side.  That means
hard IRQ paths are unacceptable but softirq is OK.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
