Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD1AEE4993
	for <virtualization@archiver.kernel.org>; Wed, 23 Aug 2023 09:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B2A061247;
	Wed, 23 Aug 2023 09:08:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B2A061247
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XAA2JrXx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yA6ma0n68mxg; Wed, 23 Aug 2023 09:08:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F1B106107F;
	Wed, 23 Aug 2023 09:08:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1B106107F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDC50C0071;
	Wed, 23 Aug 2023 09:08:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2910C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 09:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F99861240
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 09:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F99861240
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oTpu-rGEQCL6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 09:08:10 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0351D6107F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Aug 2023 09:08:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0351D6107F
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DF744617A0;
 Wed, 23 Aug 2023 09:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F3CC433C7;
 Wed, 23 Aug 2023 09:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1692781688;
 bh=io4Q0PxusKKtCDplWhMVdna1pz9TzX1YUrlW8pFjO1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XAA2JrXx6qAAt+nZq1vahQ+uXOCJ1xlcmx538cqtPSkgfM9aaoHDFrV5McTfaba+x
 CM20rqIIJEXxfCH5pGV8PZS/PwKcnRSImWu5BPjBARP75nnyoDPFwhYhue8KiQhZgK
 ei+3vUUWk1gKp9TlE80sWmmW0qv/JNHNV+1+PVvY=
Date: Wed, 23 Aug 2023 11:08:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Babis Chalios <bchalios@amazon.es>
Subject: Re: [RFC PATCH 1/2] random: emit reseed notifications for PRNGs
Message-ID: <2023082322-semester-heave-e5bc@gregkh>
References: <20230823090107.65749-1-bchalios@amazon.es>
 <20230823090107.65749-2-bchalios@amazon.es>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230823090107.65749-2-bchalios@amazon.es>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, graf@amazon.de,
 Theodore Ts'o <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, xmarcalx@amazon.co.uk,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
 aams@amazon.de, dwmw@amazon.co.uk
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

On Wed, Aug 23, 2023 at 11:01:05AM +0200, Babis Chalios wrote:
> Sometimes, PRNGs need to reseed. For example, on a regular timer
> interval, to ensure nothing consumes a random value for longer than e.g.
> 5 minutes, or when VMs get cloned, to ensure seeds don't leak in to
> clones.
> 
> The notification happens through a 32bit epoch value that changes every
> time cached entropy is no longer valid, hence PRNGs need to reseed. User
> space applications can get hold of a pointer to this value through
> /dev/(u)random. We introduce a new ioctl() that returns an anonymous
> file descriptor. From this file descriptor we can mmap() a single page
> which includes the epoch at offset 0.
> 
> random.c maintains the epoch value in a global shared page. It exposes
> a registration API for kernel subsystems that are able to notify when
> reseeding is needed. Notifiers register with random.c and receive a
> unique 8bit ID and a pointer to the epoch. When they need to report a
> reseeding event they write a new epoch value which includes the
> notifier ID in the first 8 bits and an increasing counter value in the
> remaining 24 bits:
> 
>               RNG epoch
> *-------------*---------------------*
> | notifier id | epoch counter value |
> *-------------*---------------------*
>      8 bits           24 bits

Why not just use 32/32 for a full 64bit value, or better yet, 2
different variables?  Why is 32bits and packing things together here
somehow simpler?

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
