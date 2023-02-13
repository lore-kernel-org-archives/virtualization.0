Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B77C64EC4
	for <virtualization@archiver.kernel.org>; Mon, 13 Feb 2023 08:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65901405BE;
	Mon, 13 Feb 2023 08:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65901405BE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AVCImKmi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id znOqHhMCShgD; Mon, 13 Feb 2023 08:04:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4A6C405BB;
	Mon, 13 Feb 2023 08:03:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4A6C405BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96D34C0032;
	Mon, 13 Feb 2023 08:03:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5D3FC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 08:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FA49606E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 08:03:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FA49606E6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AVCImKmi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zskL5_yVfvtx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 08:03:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9435260644
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9435260644
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 08:03:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 47D1C608C1;
 Mon, 13 Feb 2023 08:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326D2C433D2;
 Mon, 13 Feb 2023 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676275434;
 bh=G8JZCVHBVv5OOpt9S16JA4H4MUeT37bgecZOL4vtXR8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AVCImKmiHFuEQ/EAwANllCGM/Y6ZT1FB73MMCrTk30dBl9JtWCIttb3gJqJwMvDH4
 copSDR1misku9lGp45uTp7kF0KdrQToEdyQkUSqaPua8eavVykSsr51ZoUMiyi932f
 eF5FAmF0I6ymjBl8K1mRU+AQP1Gw47l2sWB0KY1LzC0Gg3wyvR/U/A2LsokTbIf9O0
 /8pY/O0Am8hbfqXCoV8HIFpYpC0VDn8Dk7rfEgcG07aft7tMz0Gud2swVwzQFkqT0C
 LtqJ4k1KSjHPjETDeaAGN6JQfkK53YzhkeFlnLDDRqihK6lTKoMpKZiRk5MKnTnKtt
 AEZgWCjEyCfDw==
Date: Mon, 13 Feb 2023 10:03:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: Re: [PATCH] vhost: Add uAPI for Vhost SCMI backend
Message-ID: <Y+nu5pQs5a/MhriH@unreal>
References: <20230213043417.20249-1-quic_neeraju@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230213043417.20249-1-quic_neeraju@quicinc.com>
Cc: vincent.guittot@linaro.org, quic_sramana@quicinc.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, sudeep.holla@arm.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, Souvik.Chakravarty@arm.com,
 quic_tsoni@quicinc.com, cristian.marussi@arm.com
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

On Mon, Feb 13, 2023 at 10:04:17AM +0530, Neeraj Upadhyay wrote:
> Add a uAPI for starting and stopping a SCMI vhost based
> backend.
> 
> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> ---
> 
> SCMI Vhost backend implementation is work in progress: https://lore.kernel.org/linux-arm-kernel/20220609071956.5183-1-quic_neeraju@quicinc.com/

Excellent, and this UAPI patch should come together with kernel code
which needs this new define.

Thanks
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
