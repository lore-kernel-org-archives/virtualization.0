Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611EBC77B73
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 03:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E256F40B65;
	Mon, 22 May 2023 03:15:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E256F40B65
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J6YWqKJ5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bigOMAU6K0Aj; Mon, 22 May 2023 03:15:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74594400DC;
	Mon, 22 May 2023 03:15:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74594400DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4891BC0036;
	Mon, 22 May 2023 03:15:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB6CC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 03:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47F3482094
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 03:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47F3482094
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=J6YWqKJ5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rEDh11ZM8DJw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 03:15:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47BAC80C1B
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47BAC80C1B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 03:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684725349; x=1716261349;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=jIqX6zajsjiMoJFUkScr01I0qnpjPlxYg1+gUi8viQY=;
 b=J6YWqKJ5tQS5ZD1Dt8LG3e484TE36nrYqMq+GKzM0dniGOD1nDm4azv8
 fGkeh9x5t2JUUbc6l2ZUn75PKpVnqrVJQtIOjUa0aO9+TdM1lSDOjZ/jE
 vhmAEOgLK7tuoQox2nOJqYfcuU3asu0JQvvWyBVCeLwfEcs87IdTadDz2
 f/hnmnHpD0oY1NXCdZm1++umNxjHBWElvfNfsmQ/7qYlXeWGDyPAH7XUg
 2v/bl6yWkqKPgvEyLnd6PZHmIwQXsb4CHg/q8fa6F5OpyE31KuyVjzc+X
 utnjGUx0BgS5QCmnPkXVQQzSchGsDESXYs2sthyHKKxgg4zLoCBK6Sw4Y Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="418524512"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; d="scan'208";a="418524512"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2023 20:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="706366665"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; d="scan'208";a="706366665"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.255.30.47])
 ([10.255.30.47])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2023 20:15:47 -0700
Message-ID: <33f3d931-b5ba-9720-8f24-7753b9df8a8e@intel.com>
Date: Mon, 22 May 2023 11:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
To: mst@redhat.com, jasowang@redhat.com
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
In-Reply-To: <20230508180512.17371-1-lingshan.zhu@intel.com>
Cc: virtualization@lists.linux-foundation.org
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

ping

On 5/9/2023 2:05 AM, Zhu Lingshan wrote:
> Formerly, ifcvf driver has implemented a lazy-initialization mechanism
> for the virtqueues and other config space contents,
> it would store all configurations that passed down from the userspace,
> then load them to the device config space upon DRIVER_OK.
>
> This can not serve live migration, so this series implement an
> immediate initialization mechanism, which means rather than the
> former store-load process, the virtio operations like vq ops
> would take immediate actions by access the virtio registers.
>
> This series also implement irq synchronization in the reset
> routine
>
> Changes from V1:
> 1)pull device status in devce_reset (Jason)
> 2)simplify the procedure which sycn irqs (Jason)
> 3)fix typos(Michael)
>
> Zhu Lingshan (5):
>    vDPA/ifcvf: virt queue ops take immediate actions
>    vDPA/ifcvf: get_driver_features from virtio registers
>    vDPA/ifcvf: retire ifcvf_start_datapath and ifcvf_add_status
>    vDPA/ifcvf: synchronize irqs in the reset routine
>    vDPA/ifcvf: a vendor driver should not set _CONFIG_S_FAILED
>
>   drivers/vdpa/ifcvf/ifcvf_base.c | 146 ++++++++++++++++++--------------
>   drivers/vdpa/ifcvf/ifcvf_base.h |  17 ++--
>   drivers/vdpa/ifcvf/ifcvf_main.c |  98 ++++-----------------
>   3 files changed, 108 insertions(+), 153 deletions(-)
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
