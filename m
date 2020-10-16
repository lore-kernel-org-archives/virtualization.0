Return-Path: <SRS0=Urmt=DX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D80AC433DF
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 08:57:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A18120829
	for <virtualization@archiver.kernel.org>; Fri, 16 Oct 2020 08:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVAYNwE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A18120829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DA2B888B9E;
	Fri, 16 Oct 2020 08:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X7raBfC3SYmi; Fri, 16 Oct 2020 08:57:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE3DF88B0B;
	Fri, 16 Oct 2020 08:57:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97839C0052;
	Fri, 16 Oct 2020 08:57:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3335FC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 08:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 13147888F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 08:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id agE76PX1HIGY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 08:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 56BD2888F1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602838667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yajcjuZ6uO56PGYXi5xPi6C1F2lWsOwbXSJhWt9V0A8=;
 b=cVAYNwE8HF78DbtLRRJBdd2/SAnBrpUGd9TQ9TinTLe15XG3CzUnnjx+TSAeL8Ilm9DYYs
 CTgJF4+JFWwouGYqvxGoS9atPD+cok9OpgraqXDX/mXZy4FSPhcIvwafuDL+ac6pdHtQ5A
 WOSWHMgePa6AFzqkso0jPSFLra6HeRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-FPbhpK8fPrK86akRRhCSSQ-1; Fri, 16 Oct 2020 04:57:42 -0400
X-MC-Unique: FPbhpK8fPrK86akRRhCSSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13CCA835B73;
 Fri, 16 Oct 2020 08:57:41 +0000 (UTC)
Received: from [10.36.113.23] (ovpn-113-23.ams2.redhat.com [10.36.113.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B32276649;
 Fri, 16 Oct 2020 08:57:36 +0000 (UTC)
Subject: Re: [PATCH v1 13/29] virtio-mem: factor out handling of fake-offline
 pages in memory notifier
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-14-david@redhat.com>
 <20201016071502.GM86495@L-31X9LVDL-1304.local>
 <20201016080046.GA43862@L-31X9LVDL-1304.local>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <17ca9bd8-bdc6-541c-b8f9-4076cb9a7322@redhat.com>
Date: Fri, 16 Oct 2020 10:57:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201016080046.GA43862@L-31X9LVDL-1304.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
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

>> Do we adjust the count twice?
>>
> 
> Ah, I got the reason why we need to adjust count for *unplugged* sub-blocks.

Exactly.

> 
>>> -		for (i = 0; i < nr_pages; i++) {
>>> -			page = pfn_to_page(pfn + i);
>>> -			if (WARN_ON(!page_ref_dec_and_test(page)))
> 
> Another question is when we grab a refcount for the unpluged pages? The one
> you mentioned in virtio_mem_set_fake_offline().

Yeah, that was confusing on my side. I actually meant
virtio_mem_fake_offline() - patch #12.

We have a reference on unplugged (fake offline) blocks via

1. memmap initialization, if never online via generic_online_page()

So if we keep pages fake offline when onlining memory, they

a) Have a refcount of 1
b) Have *not* increased the managed page count

2. alloc_contig_range(), if fake offlined. After we fake-offlined pages
(e.g., patch #12), such pages

a) Have a refcount of 1
b) Have *not* increased the managed page count (because we manually
decreased it)


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
