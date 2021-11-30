Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F517C433EF
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 23:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C04EF80D9F;
	Tue, 30 Nov 2021 23:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ROnnn6DGurFv; Tue, 30 Nov 2021 23:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C67A80CE2;
	Tue, 30 Nov 2021 23:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17CE3C001C;
	Tue, 30 Nov 2021 23:56:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D38CC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BDBC606EB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znx0mNJH9fsN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48E5E60619
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638316607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4Ly6xHNhtVUY3AH8Qlby8GSJHjPJLpcoba68bX+aow=;
 b=GgZ5uRRPqC44VgxA1bPyj/d5Glgwxi5mKD5HbK8o4lNP7wDaZFJ/y1WTGPslDCaEQtgoAA
 4hDXbPpQL7nyJYm5fKd+VJOI9A6uptj9BmSV5d/FtE+WUY7O5ycJjIYZUXYkgFVUN/BYLy
 hikQknJ4J+uQaWQPGvvfyNgrvV2IzvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-603-oYp0LaGbORWg6nWqy996pQ-1; Tue, 30 Nov 2021 18:56:43 -0500
X-MC-Unique: oYp0LaGbORWg6nWqy996pQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 c8-20020a7bc848000000b0033bf856f0easo14688412wml.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 15:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+4Ly6xHNhtVUY3AH8Qlby8GSJHjPJLpcoba68bX+aow=;
 b=aqfYCkJp4yZ9kw+mH4HlunL5vFcnOT2grIN5hdZdZ1MhZ+UDSDi3TodxXu6M0XhbS6
 57YNomYzB3u7iiUKoXiAzc6HaXDEORT7lTgOPTaGVjRJSRMARoWTO8Z50MCBR2OEXjZy
 fqtO9/2IShCvjDIdMKyivJNrZGIx4p/C+JSJfVyeCO566jDiiGDf1JYCS8cndZKq6LAd
 x0kWabVNJ84XiWDgry00RheHx6tehK2NtBMBPRkyy12/EMtvnPZzhXvIpO92TJLZUOH/
 civS5u5Mem3HrGhoa89BSQYYTUc6DKsODn8gndo2aMtdkqq8/lSqKVmLjtujLE7EtDN3
 JqSA==
X-Gm-Message-State: AOAM532fQxldHsPcjU1WjESx8rBxMidqABOoioE440u8vOhRcbwfjwzD
 fPNycXRX2Wuim1TVxzDLezaJaKS9/PSMJrzXTbPN0TYX5Hc1+hTkvv/ifJIWaQfTud0dOuuP1tm
 1pAi/dXYMLsgi5XuIuRac+TkOabNEeq8Y3xYHNwInhA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr2507452wmj.60.1638316602448;
 Tue, 30 Nov 2021 15:56:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQ8RabJd/yKEXGAgH6YMRKO+2L/7mA0kjS4lJhWYXjOug4extDYcFzwzfNJvdxbSacBrlLnQ==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr2507417wmj.60.1638316602217;
 Tue, 30 Nov 2021 15:56:42 -0800 (PST)
Received: from redhat.com ([2.53.15.215])
 by smtp.gmail.com with ESMTPSA id g18sm17573721wrv.42.2021.11.30.15.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 15:56:41 -0800 (PST)
Date: Tue, 30 Nov 2021 18:56:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than
 MAX_ORDER - 1
Message-ID: <20211130185612-mutt-send-email-mst@kernel.org>
References: <20211126134209.17332-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211126134209.17332-1-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Gavin Shan <gshan@redhat.com>,
 Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, Eric Ren <renzhengeek@gmail.com>,
 Hui Zhu <teawater@gmail.com>, Wei Yang <richard.weiyang@linux.alibaba.com>
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

On Fri, Nov 26, 2021 at 02:42:07PM +0100, David Hildenbrand wrote:
> The virtio-mem driver currently supports logical hot(un)plug in
> MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to support
> pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
> flexible, and to improve hotunplug when using ZONE_NORMAL.
> 
> With pageblock granularity, we then have a granularity comparable to
> hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so
> we really want to decouple it from MAX_ORDER.
> 
> While ZONE_MOVABLE should mostly work already, alloc_contig_range() still
> needs work to be able to properly handle pageblock granularity on
> ZONE_NORMAL. This support is in the works [1], so let's prepare
> virtio-mem for supporting smaller granularity than MAX_ORDER - 1.

is there value to merging this seprately? or should this just
be part of that patchset?

> Tested with ZONE_MOVABLE after removing the MAX_ORDER - 1 granularity
> limitation in virtio-mem, and using different device block sizes (2MiB,
> 4MiB, 8MiB).
> 
> [1] https://lkml.kernel.org/r/20211115193725.737539-1-zi.yan@sent.com
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Hui Zhu <teawater@gmail.com>
> Cc: Eric Ren <renzhengeek@gmail.com>
> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> 
> David Hildenbrand (2):
>   virtio-mem: prepare page onlining code for granularity smaller than
>     MAX_ORDER - 1
>   virtio-mem: prepare fake page onlining code for granularity smaller
>     than MAX_ORDER - 1
> 
>  drivers/virtio/virtio_mem.c | 110 ++++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 36 deletions(-)
> 
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
