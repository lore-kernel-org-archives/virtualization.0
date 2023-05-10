Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE659C7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 08:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3553460FF1;
	Wed, 10 May 2023 08:26:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3553460FF1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0LiSIdWi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5_B_Zdxyu9p; Wed, 10 May 2023 08:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B723860F81;
	Wed, 10 May 2023 08:26:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B723860F81
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F446C0037;
	Wed, 10 May 2023 08:26:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9AEDC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 760EC41F85
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:25:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 760EC41F85
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=0LiSIdWi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4oz4mV50Hn-f
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:25:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5DBD41F81
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5DBD41F81
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 08:25:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 127D663BF9;
 Wed, 10 May 2023 08:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3858CC4339B;
 Wed, 10 May 2023 08:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1683707156;
 bh=yyuOZPHJUbcP9aRarpv4MRiXOkJWXGAGGyeBIlMq4nc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0LiSIdWiydHsjiJsZ54H/qYkl8uWEKUlPA1USETAuz4e/hFVQ+Ekx7+/+fUO6lZ8u
 +hp8e+zrKfDfaeUa/gyx6wqCtOsUIwF5TKHQLHhrUvCHv23cDbUCpr3sFqNXY606RL
 WwUdqKEAeBMjRJRVVFULAWqg/156NVs9dBQo2dLY=
Date: Wed, 10 May 2023 10:25:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Subject: Re: [RFC PATCH 1/2] mm: multigen-LRU: working set reporting
Message-ID: <2023051016-snarl-fame-9d6b@gregkh>
References: <20230509185419.1088297-1-yuanchu@google.com>
 <20230509185419.1088297-2-yuanchu@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230509185419.1088297-2-yuanchu@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, kai.huang@intel.com,
 hch@lst.de, Yu Zhao <yuzhao@google.com>,
 Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 talumbau <talumbau@google.com>,
 "Sudarshan Rajagopalan \(QUIC\)" <quic_sudaraja@quicinc.com>,
 Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jon@nutanix.com,
 SeongJae Park <sj@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vasily Averin <vasily.averin@linux.dev>
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

On Wed, May 10, 2023 at 02:54:18AM +0800, Yuanchu Xie wrote:
> From: talumbau <talumbau@google.com>

Please fix the name here.

> 
> A single patch to be broken up into multiple patches.

What does this mean?

> - Add working set reporting structure.
> - Add per-node and per-memcg interfaces for working set reporting.
> - Implement working set backend for MGLRU.

Please break it up to be reviewable, otherwise no one will review it.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
