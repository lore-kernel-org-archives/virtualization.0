Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A06ECAAD2
	for <virtualization@archiver.kernel.org>; Mon, 29 Aug 2022 07:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E9668138B;
	Mon, 29 Aug 2022 07:23:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E9668138B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uxn4y1SX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EbP9pp9nZwsC; Mon, 29 Aug 2022 07:23:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F3C381383;
	Mon, 29 Aug 2022 07:23:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F3C381383
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CECFC0032;
	Mon, 29 Aug 2022 07:23:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16056C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6CB5408AA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D6CB5408AA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uxn4y1SX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V32jdtD6YWEG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:23:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8879C408A2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8879C408A2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Aug 2022 07:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661757818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcPRhFm7mNV6NpDp2k0Lb7eWVPc8YWQH000p3YsLMTU=;
 b=Uxn4y1SXoRWugzFGvW6MhjriLT1hq+7zrd/y61PzVpmzJLjos0ZUvR1dmvlpfzZkYmiNoM
 bczeX8SBvHOAzBnutAhrSxdTvhvkrEcYu+YPyby3EhXSNIPXVTeI+8BGdD+HtWvQSStzGH
 G7avESVNpQlGhM45sLCQy9X6mUbRh18=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-32U3eHkIMCOWtsWdYN67hA-1; Mon, 29 Aug 2022 03:23:35 -0400
X-MC-Unique: 32U3eHkIMCOWtsWdYN67hA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 736BF811E81;
 Mon, 29 Aug 2022 07:23:34 +0000 (UTC)
Received: from [10.39.208.19] (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40EA72166B26;
 Mon, 29 Aug 2022 07:23:32 +0000 (UTC)
Message-ID: <6f874c0b-cea2-e835-ad1c-8cd21fb1a82e@redhat.com>
Date: Mon, 29 Aug 2022 09:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] vduse: prevent uninitialized memory accesses
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20220826161605.559317-1-maxime.coquelin@redhat.com>
 <20220827065435.GL2030@kadam>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20220827065435.GL2030@kadam>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: guanjun@linux.alibaba.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 gautam.dawar@xilinx.com, elic@nvidia.com
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



On 8/27/22 08:54, Dan Carpenter wrote:
> On Fri, Aug 26, 2022 at 06:16:05PM +0200, Maxime Coquelin wrote:
>> If the VDUSE application provides a smaller config space
>> than the driver expects, the driver may use uninitialized
>> memory from the stack.
>>
>> This patch prevents it by initializing the buffer passed by
>> the driver to store the config value.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> This sounds like it needs a Fixes tag?

Yes, I actually did it, but somehow forgot to generate the patch bedore
posting.

I'll post a v2 soon.

Thanks,
Maxime

> regards,
> dan carpenter
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
