Return-Path: <SRS0=voLO=GK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBAC433DB
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 08:54:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C8F2333E
	for <virtualization@archiver.kernel.org>; Thu,  7 Jan 2021 08:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C8F2333E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8EC3E20357;
	Thu,  7 Jan 2021 08:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2E1b106fgJv8; Thu,  7 Jan 2021 08:54:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2AC3D2014B;
	Thu,  7 Jan 2021 08:54:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12EDBC088B;
	Thu,  7 Jan 2021 08:54:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E7A6C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 08:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2BCD78735D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 08:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2DA7X2Xrvg7x
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 08:53:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BF89F87301
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610009637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VnMdV8KJMJ17J1dCjQPgPbu7cJhRA01SnsrY34SOH7c=;
 b=eMhAfBD5YV/nB1NTBFTVqwwF7IZQfzZchY2k19CDwjC9h6wIaebfAkov1zVgaz9efD0UbM
 IV42MquXTNKAIdTId7jeW+8rVEoonheITqBwlRTgfukkQRH/B1k62QVPzpUSR+ZSoq7/9/
 t9dI7h8gs6btCmJ9RfugDK9jgdDaLyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-clAEW5aGPXGlyysB1gR9YA-1; Thu, 07 Jan 2021 03:53:53 -0500
X-MC-Unique: clAEW5aGPXGlyysB1gR9YA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F1B801817;
 Thu,  7 Jan 2021 08:53:50 +0000 (UTC)
Received: from [10.36.114.161] (ovpn-114-161.ams2.redhat.com [10.36.114.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DE7D5C8AA;
 Thu,  7 Jan 2021 08:53:44 +0000 (UTC)
Subject: Re: [PATCH 3/6] hugetlb: add free page reporting support
To: Liang Li <liliang324@gmail.com>, Michal Hocko <mhocko@suse.com>
References: <20210106034918.GA1154@open-light-1.localdomain>
 <20210106160827.GO13207@dhcp22.suse.cz>
 <CA+2MQi-pxRkaftawN=tMxDT7wWyXuS6ZjofcqK+2fwQ9LHvwfQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f711ff53-4ba2-9474-73e8-48363a5157d7@redhat.com>
Date: Thu, 7 Jan 2021 09:53:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+2MQi-pxRkaftawN=tMxDT7wWyXuS6ZjofcqK+2fwQ9LHvwfQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Dan Williams <dan.j.williams@intel.com>,
 Liang Li <liliangleo@didiglobal.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

On 07.01.21 04:38, Liang Li wrote:
> On Thu, Jan 7, 2021 at 12:08 AM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Tue 05-01-21 22:49:21, Liang Li wrote:
>>> hugetlb manages its page in hstate's free page list, not in buddy
>>> system, this patch try to make it works for hugetlbfs. It canbe
>>> used for memory overcommit in virtualization and hugetlb pre zero
>>> out.
>>
>> David has layed down some more fundamental questions in the reply to the
>> cover letter (btw. can you fix your scripts to send patches and make all
>> the patches to be in reply to the cover letter please?). But I would
> 
> Do you mean attach the patches in the email for the cover letter ?

You should be using "git format-patch --cover-letter . .." followed by
"git send-email ...", so the end result is a nicely structured thread.

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
