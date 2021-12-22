Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE68EC433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 00:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 457E840A71;
	Wed, 22 Dec 2021 00:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00XL_TD7N19K; Wed, 22 Dec 2021 00:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8322040124;
	Wed, 22 Dec 2021 00:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 676C3C001E;
	Wed, 22 Dec 2021 00:09:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 458D6C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B065410E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plF9V-L0X0ju
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:09:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD27D40940
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:09:07 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id l11so676681qke.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p6IPtjYLk9ApU3C7Ntq5pzotDKFMZC8bLzlwMwv2DHo=;
 b=gdeWu7dcldq1KRDtXrK466kfK8ZpHrcRgPVzyQPYoZHEx9qR5NNRQnXdVTPhjY05pS
 VX54P/WP7bBdN0Y2YviUR+IzQczADq36rQPDvSeBSlR5CzNBM9hnUWmpeLwh1zOgIfG4
 T1ItolfMfK71PTBrsf594uOVGuRXfsMiL7rUYjcaQdrzDkXfR72il5m2jMYTcW+/hd/4
 pJXYLsW1GpV4xGgUZjfQk/9GLjuyd3LG4uiIxEhBeAPgio5IpswJHOM1wzN1JoffZwqF
 0w74l8kyv5Y2z+6wvMkdK3wXIuGOEzR/6OvL6lryE3Ism03q74Y3rB7rEvGeBhEU3L/r
 JRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p6IPtjYLk9ApU3C7Ntq5pzotDKFMZC8bLzlwMwv2DHo=;
 b=A0SD8O4XySCmnw5eYPFn5rYGGSWek4dod2NbGonx6bYNLMb8zvnnwtMJXhAWxESxjD
 GUaOd/lyQlKx0b1ADSV2q5DFi2w06UWyX/BAHAMEtV70C0fntLh97H+3g0Ec+Qndr2TF
 oDEF2RXqkO5hAloBAB+RaPa8nE19wpptVL04UNxHCX8Mh9t4LzotaC90plkvJsVUizfY
 sLMzneKj7jZKuwhiYgWsKQu2iS3+F4pdX9ZHNZwixjPgHQf6vO2rXO//UGmJVkK3MuSS
 EINkS1+EDcGYdzALJ/fxOyO5yDEvX56H6r+6u5xXSrwTR6LRVZ34CSZfoekuVfjCFCu5
 6EcQ==
X-Gm-Message-State: AOAM531meETsRfa/k0vVzLB4nRr1DbtNlA7Fm+iIWBIT5xJsquFhxKlv
 25tE39BFcR1tOtgWfxiNhquYWw==
X-Google-Smtp-Source: ABdhPJxZLJ+lxeM7m6HgpAAgvnFViXb+v/+egaiwjU9Z/pHPuR+zNWgaBbyZ73XdGEkhpy4k4oD6XA==
X-Received: by 2002:a05:620a:4687:: with SMTP id
 bq7mr553892qkb.231.1640131746529; 
 Tue, 21 Dec 2021 16:09:06 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id h2sm457177qkn.136.2021.12.21.16.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Dec 2021 16:09:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mzpBp-007GVm-3o; Tue, 21 Dec 2021 20:09:05 -0400
Date: Tue, 21 Dec 2021 20:09:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 0/4] driver_core: Auxiliary drvdata helper cleanup
Message-ID: <20211222000905.GN6467@ziepe.ca>
References: <20211221235852.323752-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221235852.323752-1-david.e.box@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 mustafa.ismail@intel.com, leon@kernel.org, mst@redhat.com,
 linux-rdma@vger.kernel.org, gregkh@linuxfoundation.org,
 virtualization@lists.linux-foundation.org, vkoul@kernel.org,
 davem@davemloft.net, hdegoede@redhat.com, dledford@redhat.com,
 yung-chuan.liao@linux.intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 andriy.shevchenko@linux.intel.com, shiraz.saleem@intel.com, saeedm@nvidia.com,
 linux-kernel@vger.kernel.org
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

On Tue, Dec 21, 2021 at 03:58:48PM -0800, David E. Box wrote:
> Depends on "driver core: auxiliary bus: Add driver data helpers" patch [1].
> Applies the helpers to all auxiliary device drivers using
> dev_(get/set)_drvdata. Drivers were found using the following search:
> 
>     grep -lr "struct auxiliary_device" $(grep -lr "drvdata" .)
> 
> Changes were build tested using the following configs:
> 
>     vdpa/mlx5:       CONFIG_MLX5_VDPA_NET
>     net/mlx53:       CONFIG_MLX5_CORE_EN
>     soundwire/intel: CONFIG_SOUNDWIRE_INTEL
>     RDAM/irdma:      CONFIG_INFINIBAND_IRDMA
>                      CONFIG_MLX5_INFINIBAND
> 
> [1] https://www.spinics.net/lists/platform-driver-x86/msg29940.html 

I have to say I don't really find this to be a big readability
improvement.

Also, what use is 'to_auxiliary_dev()' ? I didn't see any users added..

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
