Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31ECC47082
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:55:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5354D613F8
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5354D613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 284D96F93C;
	Fri,  4 Jun 2021 01:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p46XojVgMxB7; Fri,  4 Jun 2021 01:55:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50EE96F93B;
	Fri,  4 Jun 2021 01:55:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C69D1C0022;
	Fri,  4 Jun 2021 01:55:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16BFAC0001;
 Fri,  4 Jun 2021 01:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E528B60AE1;
 Fri,  4 Jun 2021 01:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4W7-tmUwq1za; Fri,  4 Jun 2021 01:55:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42FC260ADE;
 Fri,  4 Jun 2021 01:55:13 +0000 (UTC)
IronPort-SDR: cx82th5ef+LOrT3wzYSqlBusHPbstlNGPN9dk59s5DA5IWNXsKrCu12Uy4cn3mwjDEE4GzCZPR
 ZNR8mYM5L3mw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191540398"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="191540398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 18:54:58 -0700
IronPort-SDR: GIuUhVXRQGGXpdsR8TZ9byLZ0RpOG9Jow67XS70dt0XTNpfjTOwpdL3cfgXqwC33OJXkMLPV2G
 TVxuxMDYq99g==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="550918837"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237])
 ([10.209.7.237])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 18:54:56 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andy Lutomirski <luto@kernel.org>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
 <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
 <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
 <308e7187-1ea7-49a7-1083-84cf8654f52a@kernel.org>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <d3bf637e-556a-be48-39f9-dc7defd19092@linux.intel.com>
Date: Thu, 3 Jun 2021 18:54:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <308e7187-1ea7-49a7-1083-84cf8654f52a@kernel.org>
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Josh Poimboeuf <jpoimboe@redhat.com>, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
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


> For most Linux drivers, a report that a misbehaving device can corrupt
> host memory is a bug, not a feature.  If a USB device can corrupt kernel
> memory, that's a serious bug.  If a USB-C device can corrupt kernel
> memory, that's also a serious bug, although, sadly, we probably have
> lots of these bugs.  If a Firewire device can corrupt kernel memory,
> news at 11.  If a Bluetooth or WiFi peer can corrupt kernel memory,
> people write sonnets about it and give it clever names.  Why is virtio
> special?

Well for most cases it's pointless because they don't have any memory 
protection anyways.

Why break compatibility if it does not buy you anything?

Anyways if you want to enable the restricted mode for something else, 
it's easy to do. The cases where it matters seem to already work on it, 
like the user space virtio ring.

My changes for boundary checking are enabled unconditionally anyways, as 
well as the other patchkits.


>
> This one:
>
> int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return is_tdx_guest();
> +}
>
> I'm looking at a fairly recent kernel, and I don't see anything for s390
> wired up in vring_use_dma_api.

It's not using vring_use_dma_api, but enforces the DMA API at virtio 
ring setup time, same as SEV/TDX.

-Andi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
