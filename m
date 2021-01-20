Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A6CC433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 11:14:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E722C22AAA
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 11:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E722C22AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9285A86FF0;
	Wed, 20 Jan 2021 11:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id soX9HEr-vqKS; Wed, 20 Jan 2021 11:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0380E86FAF;
	Wed, 20 Jan 2021 11:14:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB2B1C088B;
	Wed, 20 Jan 2021 11:14:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94CCBC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 90CD884948
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3GcfyOnD3o3I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:14:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F10DA804AC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611141265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/EVI+1MCqEvTLfz42IzqWVQkkuhCL254qM17MstwaY=;
 b=X8AsT5ZLL3kkXH4TBZhTyESw70bgGj2UFgD0lek1yJviL/8OYjl8oWuh4P1XqQftYwrO0r
 0RDKW6X0KrIyNec1ROUajBtlN58erYswKbhiENxQSG6ikAAJfBf550piAUsPAalPLJrWmx
 8zDHNA0/QP/b7WvPT5+4OZIOkp9S/hI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-G7gZTGtOOB2URGV0p1tCAg-1; Wed, 20 Jan 2021 06:14:21 -0500
X-MC-Unique: G7gZTGtOOB2URGV0p1tCAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B17F01800D41;
 Wed, 20 Jan 2021 11:14:20 +0000 (UTC)
Received: from [10.36.115.161] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9967A10023B2;
 Wed, 20 Jan 2021 11:14:15 +0000 (UTC)
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
 <20210120045736-mutt-send-email-mst@kernel.org>
 <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
 <20210120060301-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a61b016e-7896-134c-a1be-8ff8e8e6fbe2@redhat.com>
Date: Wed, 20 Jan 2021 12:14:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210120060301-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Tian Tao <tiantao6@hisilicon.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
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

On 20.01.21 12:03, Michael S. Tsirkin wrote:
> On Wed, Jan 20, 2021 at 11:04:18AM +0100, David Hildenbrand wrote:
>> On 20.01.21 10:57, Michael S. Tsirkin wrote:
>>> On Wed, Jan 20, 2021 at 10:40:37AM +0100, David Hildenbrand wrote:
>>>> On 20.01.21 08:50, Jiapeng Zhong wrote:
>>>>> Fix the following coccicheck warnings:
>>>>>
>>>>> ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
>>>>> of 0/1 to bool variable.
>>>>>
>>>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>>>> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
>>>>> ---
>>>>>  drivers/virtio/virtio_mem.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>>>>> index 9fc9ec4..85a272c 100644
>>>>> --- a/drivers/virtio/virtio_mem.c
>>>>> +++ b/drivers/virtio/virtio_mem.c
>>>>> @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
>>>>>  	 * actually in use (e.g., trying to reload the driver).
>>>>>  	 */
>>>>>  	if (vm->plugged_size) {
>>>>> -		vm->unplug_all_required = 1;
>>>>> +		vm->unplug_all_required = true;
>>>>>  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
>>>>>  	}
>>>>>  
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> we already had a fix on the list for quite a while:
>>>>
>>>> https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com
>>>
>>> Can't find that one.
>>
>> Looks like it was only on virtualization@ and a couple of people on cc.
>>
>> https://lists.linuxfoundation.org/pipermail/virtualization/2020-December/051662.html
>>
>> Interestingly, I cannot find the follow-up ("[PATCH] virtio-mem: use
>> boolean value when setting vm->unplug_all_required") in the mailing list
>> archives, even though it has virtualization@ on cc.
> 
> 
> Unsurprising that I didn't merge it then ;)

Well, you were on cc ;)

> Want to send your ack on this one?

Sure

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
