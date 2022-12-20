Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF18C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 11:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5543081B52;
	Tue, 20 Dec 2022 11:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5543081B52
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GM2xSucl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wlFfAcI7OwnK; Tue, 20 Dec 2022 11:31:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1AEA6818C4;
	Tue, 20 Dec 2022 11:31:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AEA6818C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA7BFC0032;
	Tue, 20 Dec 2022 11:31:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C99ACC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 900AC81B52
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:31:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 900AC81B52
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4I4sLZ9Dakw7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:31:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5E04818C4
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5E04818C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:31:01 +0000 (UTC)
Received: from [192.168.231.135] (unknown [213.194.155.136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: rcn)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id A8C3A6602C93;
 Tue, 20 Dec 2022 11:30:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1671535860;
 bh=7KC4YI1sDz0S6IQfm/3XQMk26kdbVIwgc8Q3poa1r2o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GM2xSuclMOqT50UvTJT4P5UCtApCtyE+Uqp76bWqvdlkqBgk0LwMbmpvORs0EbilB
 SGP6+2tJd5NV+DiFb7EF2PCxWpf5yryVof1NqWfjJiSurcWM0yPgxB3aePSLafXaPb
 cuYAGHSMSL6EfCrMKgHxsKM1r2bpaADAq0eJofyrz9mzSJEsEMcmH+G2PoosIP7omz
 W0WNtpGIgq1kTtPxbbyneiHnk6Zg4ys5eTHQyQus7YaIpTpGZeOBgrta5LChwTu/aW
 /x+2gb8sbwQKFTpFGgdJ6bVemj2coiuHzhZJf4zgejwiEwDKDWPeFaatqhw1rFl/oa
 9J/x/2XYpMYQw==
Message-ID: <c8a55105-7dd4-c90c-33e2-31c4808892c6@collabora.com>
Date: Tue, 20 Dec 2022 12:30:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
 <Y6F8dlRQbOzIvJff@debian.me>
 <bf9bd0ba-c703-1903-7df2-ac95dea0f3e8@collabora.com>
 <20221220052333-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <20221220052333-mutt-send-email-mst@kernel.org>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, kernel@collabora.com
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

On 20/12/22 11:25, Michael S. Tsirkin wrote:
> This doesn't matter I think, what Fixes tag does is tell tools
> if you have commit A you want this one on top.

Ok, thanks for clarifying. v3 submitted.

Cheers,
Ricardo
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
