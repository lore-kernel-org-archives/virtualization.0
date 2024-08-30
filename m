Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBE41C69
	for <virtualization@lists.linux-foundation.org>; Fri, 30 Aug 2024 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724999971; cv=none; b=Qt2ZP4PMzPg8ZbhXROUtAhhLALfnwhuUGQw98L3TSVz3m6mb5TD/G9TumQ9d+Gt9YSf+6f7UBep4qZcNfkcr99lCMkuVrPpSWVbQ7moUDXZ6ZbgY6UGAayfRlSMDr7aDYXKNRXTux1kcSDgq2J0cRD26NuoIanwYvuY3IRHvN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724999971; c=relaxed/simple;
	bh=lPbDnoIYYT+OPMoFM9FRA/Gip0DGARusSAmuTjihBlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6Scy72oIpOan3MUX63CtUMVcC/TcBMKIutodtiKYalHnc40HoTrGB40x0MXJql53ABx9icVHClNFlcsbzsfOSFDVZ3LK7rYX2rLOlAwZgAAJli6vQxTfoahQboxnDVRYVWZMhYXKfVUbDtYClLJ6s32fuJHxnbmrm0tqYcivuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D608981E99
	for <virtualization@lists.linux-foundation.org>; Fri, 30 Aug 2024 06:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -6.042
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oTNqCKzkuiHl for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Aug 2024 06:39:27 +0000 (UTC)
X-Greylist: delayed 559 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 30 Aug 2024 06:39:26 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 018A281E2E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=wunner.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 018A281E2E
Received-SPF: Pass (sender SPF authorized) identity=helo; client-ip=83.223.95.100; helo=bmailout1.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=<UNKNOWN> 
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 018A281E2E
	for <virtualization@lists.linux-foundation.org>; Fri, 30 Aug 2024 06:39:26 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9989B3000C785;
	Fri, 30 Aug 2024 08:30:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 92D6D357A40; Fri, 30 Aug 2024 08:30:03 +0200 (CEST)
Date: Fri, 30 Aug 2024 08:30:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Gonglei <arei.gonglei@huawei.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Baolin Wang <baolin.wang@linaro.org>, longpeng2@huawei.com,
	wu.wubin@huawei.com
Subject: Re: [PATCH] virtio-crypto: support crypto engine framework
Message-ID: <ZtFm60YSk9BsAjYV@wunner.de>
References: <1482821347-47664-1-git-send-email-arei.gonglei@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482821347-47664-1-git-send-email-arei.gonglei@huawei.com>

On Tue, Dec 27, 2016 at 02:49:07PM +0800, Gonglei wrote:
> crypto engine was introduced since 'commit 735d37b5424b ("crypto: engine
> - Introduce the block request crypto engine framework")' which uses work
> queue to realize the asynchronous processing for ablk_cipher and ahash.
> 
> For virtio-crypto device, I register an engine for each
> data virtqueue so that we can use the capability of
> multiple data queues in future.

The above got applied as d79b5d0bbf2e.

What's the benefit of this change?

virtio has its own queue for requests.  Adding a crypto_engine puts
a queue in front of that.  So now there's a queue feeding a queue.
That seems to be a roundabout way of doing things, so I'm wondering
why this change was made?  It seems to introduce complexity and
overhead with no apparent benefit.

The reason I'm asking is that I'm splitting sign/verify out of
virtio_crypto_akcipher_algs.c:

https://lore.kernel.org/all/ZscuLueUKl9rcCGr@wunner.de/

Nowadays sign/verify is no longer asynchronous.  However the
crypto_engine indirection forces me to introduce a sig_request
struct which stores the input/output parameters for a sign/verify
operation, so that the crypto_engine can consume it asynchronously.

I'm tempted to instead remove crypto_engine support from
virtio_crypto_core.c to ease migration to synchronous sign/verify.

Thanks,

Lukas
