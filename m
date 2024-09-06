Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB44594D
	for <virtualization@lists.linux-foundation.org>; Fri,  6 Sep 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608386; cv=none; b=jKHq9H56BH/i+Bu+AjEU4wIt16JI0W9o6SLPFsXuLqtZVN8FJ2CNVW06DMdxeHJlyI/PNMcqpKqUqZwVmiub1T+qqQ9FTELzC14KuiOY/2quEfaoeC5sR7ZUdybJx/YoK7IBGXjD22xLOBem8BwwVHbAtNL8cPTEqDap8f6sw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608386; c=relaxed/simple;
	bh=miLOIj3hlzbYQI8mE8L9Ts/s13zX8KLgSUIsm6b9614=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVlN6QoHnUoBi426PiiRf0YdLAujSkpP6FZVguXHJ4b4KoOWmVJKovE9kv0kY/uJzHGQ3PkAbiH5K5o5AOnB2jBQgy3ip7yvMJL9u8gVq5x3DGCnn6QvIn176cslcabNzmQ4Ij3psj9FhQU9T6inuHojfh/PB2kcqJ+M6gXjI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Hr1Pkfqy; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Hr1Pkfqy"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5C2F4089D
	for <virtualization@lists.linux-foundation.org>; Fri,  6 Sep 2024 07:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.591
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rV4sKayxY_zM for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Sep 2024 07:39:43 +0000 (UTC)
X-Greylist: delayed 1824 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 06 Sep 2024 07:39:42 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E2014407A5
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2014407A5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=hmeau.com header.i=@hmeau.com header.a=rsa-sha256 header.s=formenos header.b=Hr1Pkfqy
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=144.6.53.87; helo=abb.hmeau.com; envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN> 
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E2014407A5
	for <virtualization@lists.linux-foundation.org>; Fri,  6 Sep 2024 07:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+mNZr39It15m+/NdJgL39QrNoCnMyK81/Rg9+WyFqA4=; b=Hr1Pkfqy/wI81H7F4cJdQjsIRh
	xNtkTK6ylYXqClpcnXVBdmdewHsu6j7yikt4shRxcoZ6fKaAKsiVbABv7QfVA+p+WBmUBmaSYpiTR
	HRYuJe1mhAbRtTObwLX+ag26mgJ/2HQ8eu1SfK+2thxBOvr8iifOXj0u9MH1e5REizL7jojcsmpMB
	RwRV/qDYv6tQtV1OOHFXUhZiMw8ODbesn+vzxU8JBZGVBRXw1C9gmRTwHCwdP1tgAw6G9TUinXuBw
	q+s1AcCHzSXDDSz3N95os01X7OIJ2Y97U6vJVd5cYpkGOHyM2jmvw7iGtPSt5QpYmJEPU/hY4q77S
	EIJ/M4iw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1smSvp-000WWB-20;
	Fri, 06 Sep 2024 15:09:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Sep 2024 15:09:11 +0800
Date: Fri, 6 Sep 2024 15:09:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lukas Wunner <lukas@wunner.de>
Cc: Gonglei <arei.gonglei@huawei.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-crypto@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Baolin Wang <baolin.wang@linaro.org>, longpeng2@huawei.com,
	wu.wubin@huawei.com
Subject: Re: [PATCH] virtio-crypto: support crypto engine framework
Message-ID: <Ztqql_gqgZiMW8zz@gondor.apana.org.au>
References: <1482821347-47664-1-git-send-email-arei.gonglei@huawei.com>
 <ZtFm60YSk9BsAjYV@wunner.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtFm60YSk9BsAjYV@wunner.de>

On Fri, Aug 30, 2024 at 08:30:03AM +0200, Lukas Wunner wrote:
>
> I'm tempted to instead remove crypto_engine support from
> virtio_crypto_core.c to ease migration to synchronous sign/verify.

I would remove virtio akcipher support in its entirety.  This API
was never meant to be exposed outside of the kernel.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
