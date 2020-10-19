Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC90EC433DF
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 11:57:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2618622268
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 11:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8w4u19v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2618622268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2ECFF875E3;
	Mon, 19 Oct 2020 11:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id So8SMmgLBeJM; Mon, 19 Oct 2020 11:57:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 830E48746B;
	Mon, 19 Oct 2020 11:57:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57CC5C0052;
	Mon, 19 Oct 2020 11:57:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EA04C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 11:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 75606228DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 11:57:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ylHGXccUOdSh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 11:57:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 255C4203B9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 11:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603108662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SlL4Q5SbHMhStfWfVjsxTibC0dKmqUQeioCU1eaaZw=;
 b=D8w4u19vZkyQT/erSNh40ToWrPVy04MugYGNHaATk2jKbcQ1vEB88jGFDo49kP+dKguMaU
 jZqOAGPTk4mXSkY/AaFn+WVOix4WkNdKupk+BiNrGnF1rOTA7C8LVlqE6GRo3w9pdkus4x
 LgzJ8tLk2Hj9DGJDX33q3x7gTYyU33o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-6W0ZzrGiPiWqR5E7wegN8w-1; Mon, 19 Oct 2020 07:57:39 -0400
X-MC-Unique: 6W0ZzrGiPiWqR5E7wegN8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C2D257088;
 Mon, 19 Oct 2020 11:57:37 +0000 (UTC)
Received: from [10.36.115.26] (ovpn-115-26.ams2.redhat.com [10.36.115.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 959A56EF44;
 Mon, 19 Oct 2020 11:57:30 +0000 (UTC)
Subject: Re: [PATCH v1 20/29] virtio-mem: nb_sb_per_mb and subblock_size are
 specific to Sub Block Mode (SBM)
To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-21-david@redhat.com>
 <20201016085319.GD44269@L-31X9LVDL-1304.local>
 <7b55ffe1-95fc-1e71-ea6b-82bd0a98a6b4@redhat.com>
 <20201018124104.GD50506@L-31X9LVDL-1304>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c5a22f50-210d-a4ab-90b0-ba3d454c1882@redhat.com>
Date: Mon, 19 Oct 2020 13:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201018124104.GD50506@L-31X9LVDL-1304>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On 18.10.20 14:41, Wei Yang wrote:
> On Fri, Oct 16, 2020 at 03:17:06PM +0200, David Hildenbrand wrote:
>> On 16.10.20 10:53, Wei Yang wrote:
>>> On Mon, Oct 12, 2020 at 02:53:14PM +0200, David Hildenbrand wrote:
>>>> Let's rename to "sbs_per_mb" and "sb_size" and move accordingly.
>>>>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Jason Wang <jasowang@redhat.com>
>>>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>
>>> One trivial suggestion, could we move this patch close the data structure
>>> movement patch?
>>>
>>> I know this would be some work, since you have changed some of the code logic.
>>> This would take you some time to rebase.
>>
>> You mean after patch #17 ?
> 
> Yes
> 
>>
>> I guess I can move patch #18 (prereq) a little further up (e.g., after
>> patch #15). Guess moving it in front of #19 shouldn't be too hard.
>>
>> Will give it a try - if it takes too much effort, I'll leave it like this.
>>
> 
> Not a big deal, while it will make the change more intact to me.
> 
> This is a big patch set to me. In case it could be split into two parts, like
> bug fix/logic improvement and BBM implementation, that would be more friendly
> to review.

I'll most probably keep it as a single series, but reshuffle the patches
into

1. cleanups
2. preparations
3. BBM

That should make things easier to digest. Thanks!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
