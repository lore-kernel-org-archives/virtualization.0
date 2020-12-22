Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11913C433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 08:28:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857BB2312D
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 08:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857BB2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 355BC85D08;
	Tue, 22 Dec 2020 08:28:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 878s4V8pu7iN; Tue, 22 Dec 2020 08:28:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7EF9585C9F;
	Tue, 22 Dec 2020 08:28:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60DF4C1825;
	Tue, 22 Dec 2020 08:28:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72937C0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5711885CFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:28:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lsSlnm9fWwTP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:28:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7B4CE85C9F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608625697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMn1z+3qEykzQHkIqp2VNssqA3PWvgFfJWR1Q6w9VTw=;
 b=VZWJwCuaRSoxBKvTuj0fE+S8oDJn5/Dg7o0A1OXUeM8uqN0FFUpekcDt5DbaPDqQf3hRa/
 4m/DhEGbrR6FS5gs/EYhEWp4BFwfmIhicrgFuE5L6gA9JPf00XASoasQuNDjt4jEmBKToc
 Uyz8O/p5MGu9gIazAcuu9XT5GrNVRQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Q9G-OknUPU6OWsvwirBTBg-1; Tue, 22 Dec 2020 03:28:14 -0500
X-MC-Unique: Q9G-OknUPU6OWsvwirBTBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C301107ACE8;
 Tue, 22 Dec 2020 08:28:12 +0000 (UTC)
Received: from [10.36.113.220] (ovpn-113-220.ams2.redhat.com [10.36.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDF0C5D9D3;
 Tue, 22 Dec 2020 08:28:05 +0000 (UTC)
Subject: Re: [RFC PATCH 2/3] virtio-balloon: add support for providing free
 huge page reports to host
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
 Liang Li <liliangleo@didiglobal.com>, Mike Kravetz
 <mike.kravetz@oracle.com>, Liang Li <liliang324@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
References: <20201222074810.GA30047@open-light-1.localdomain>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6846ff7a-b302-a0fd-1cd9-af0f2ee733ea@redhat.com>
Date: Tue, 22 Dec 2020 09:28:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201222074810.GA30047@open-light-1.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On 22.12.20 08:48, Liang Li wrote:
> Free page reporting only supports buddy pages, it can't report the
> free pages reserved for hugetlbfs case. On the other hand, hugetlbfs

The virtio-balloon free page reporting interface accepts a generic sg,
so it isn't glue to buddy pages. There is no need for a new interface.


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
