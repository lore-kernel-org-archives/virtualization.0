Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FE2C83F14
	for <virtualization@archiver.kernel.org>; Wed, 30 Aug 2023 11:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F396141991;
	Wed, 30 Aug 2023 11:27:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F396141991
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOABM5/x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmfsKuWtuBBO; Wed, 30 Aug 2023 11:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 26C2C4026C;
	Wed, 30 Aug 2023 11:27:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26C2C4026C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3B98C0071;
	Wed, 30 Aug 2023 11:27:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21EEFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 11:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A7D261030
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 11:27:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A7D261030
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jOABM5/x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x28PzzbYWm7A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 11:27:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3604F61026
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Aug 2023 11:27:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3604F61026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693394846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gCpyYaDoykWvvFtRkJq4n5NwTWes+cVEb3SWcI7ddY=;
 b=jOABM5/xIm6NpW0UAQoq4OmBjDFyFMSxu6sa+bNnlm2FqG/V7Gdyj7YhOUhyKYNIxlhw7k
 tkZ8MR4dICOj5A7Z9bOu/4KT9neYqU5kMKryjbKL4+CBpEyW9aNkORXPk71w8WczvKqNZ1
 XEemuZc/8PMiGiEOUuxEBvGsPLvedNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-wNNx9Tt2PreOTKdwNUnwrw-1; Wed, 30 Aug 2023 07:27:22 -0400
X-MC-Unique: wNNx9Tt2PreOTKdwNUnwrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A065802C1E;
 Wed, 30 Aug 2023 11:27:22 +0000 (UTC)
Received: from [10.39.208.19] (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F6A1121315;
 Wed, 30 Aug 2023 11:27:19 +0000 (UTC)
Message-ID: <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
Date: Wed, 30 Aug 2023 13:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
 <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
 <20230829130430-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
In-Reply-To: <20230829130430-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Jakub Kicinski <kuba@kernel.org>, david.marchand@redhat.com
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



On 8/29/23 19:05, Michael S. Tsirkin wrote:
> On Tue, Aug 29, 2023 at 03:34:06PM +0200, Maxime Coquelin wrote:
>>
>>
>> On 8/11/23 00:00, Jakub Kicinski wrote:
>>> On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
>>>>> Directly into the stack? I thought VDUSE is vDPA in user space,
>>>>> meaning to get to the kernel the packet has to first go thru
>>>>> a virtio-net instance.
>>>>
>>>> yes. is that a sufficient filter in your opinion?
>>>
>>> Yes, the ability to create the device feels stronger than CAP_NET_RAW,
>>> and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
>>> experience with virt so no strong opinion, perhaps it does make sense
>>> for someone's deployment? Dunno..
>>>
>>
>> I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
>> devices, as the device could be attached to vhost-vDPA and so not
>> visible to the Kernel networking stack.
>>
>> However, CAP_NET_ADMIN should be required to attach the VDUSE device to
>> virtio-vdpa/virtio-net.
>>
>> Does that make sense?
>>
>> Maxime
> 
> OK. How are we going to enforce it?

Actually, it seems already enforced for all VDPA devices types.
Indeed, the VDPA_CMD_DEV_NEW Netlink command used to add the device to
the VDPA bus has the GENL_ADMIN_PERM flag set, and so require
CAT_NET_ADMIN.

> Also, we need a way for selinux to enable/disable some of these things
> but not others.

Ok, I can do it in a patch on top.
Do you have a pointer where it is done for Virtio Block devices?

Maxime

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
