Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388DDEB64DD
	for <virtualization@archiver.kernel.org>; Fri, 21 Jul 2023 14:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFB176136B;
	Fri, 21 Jul 2023 14:58:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFB176136B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V1rnVa3o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QMR_Fyy-GJVs; Fri, 21 Jul 2023 14:58:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4CD2C6137E;
	Fri, 21 Jul 2023 14:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CD2C6137E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C25AC0072;
	Fri, 21 Jul 2023 14:58:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F47AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2680C417B2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:58:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2680C417B2
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=V1rnVa3o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpip-duLBpqt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:58:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F188417AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jul 2023 14:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F188417AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689951495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1qQ37MMJd6MivrcwkUnYSPTqHJ5IN0DRXHoCePfwTc=;
 b=V1rnVa3omVXnU9mqgApN9lxf11nkdV4OhwnrQJwkF+KgdqaGJ0JgwhWl0DHrX504HH18hX
 IdwXqxPf2iP6/t/hm0JdAQmtxn051svF0zlzOep6oEFgfID+zbrDAv3QihVRxTNh0tsJta
 J5biX/LFOpF8lOQSyvj9imGqjT+V7a4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80--sJhcl7SMfaUKSuhATyG2A-1; Fri, 21 Jul 2023 10:58:10 -0400
X-MC-Unique: -sJhcl7SMfaUKSuhATyG2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE9A2800B35;
 Fri, 21 Jul 2023 14:58:09 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B43304094DC0;
 Fri, 21 Jul 2023 14:58:07 +0000 (UTC)
Message-ID: <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
Date: Fri, 21 Jul 2023 16:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230721104445-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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



On 7/21/23 16:45, Michael S. Tsirkin wrote:
> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
>>
>>
>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
>>>>>
>>>>> Adding cond_resched() to the command waiting loop for a better
>>>>> co-operation with the scheduler. This allows to give CPU a breath to
>>>>> run other task(workqueue) instead of busy looping when preemption is
>>>>> not allowed on a device whose CVQ might be slow.
>>>>>
>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>
>>>> This still leaves hung processes, but at least it doesn't pin the CPU any
>>>> more.  Thanks.
>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>>>>
>>>
>>> I'd like to see a full solution
>>> 1- block until interrupt
>>
>> Would it make sense to also have a timeout?
>> And when timeout expires, set FAILED bit in device status?
> 
> virtio spec does not set any limits on the timing of vq
> processing.

Indeed, but I thought the driver could decide it is too long for it.

The issue is we keep waiting with rtnl locked, it can quickly make the
system unusable.

>>> 2- still handle surprise removal correctly by waking in that case
>>>
>>>
>>>
>>>>> ---
>>>>>     drivers/net/virtio_net.c | 4 +++-
>>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
>>>>> --- a/drivers/net/virtio_net.c
>>>>> +++ b/drivers/net/virtio_net.c
>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>>>>>             * into the hypervisor, so the request should be handled immediately.
>>>>>             */
>>>>>            while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>>>> -              !virtqueue_is_broken(vi->cvq))
>>>>> +              !virtqueue_is_broken(vi->cvq)) {
>>>>> +               cond_resched();
>>>>>                    cpu_relax();
>>>>> +       }
>>>>>
>>>>>            return vi->ctrl->status == VIRTIO_NET_OK;
>>>>>     }
>>>>> --
>>>>> 2.39.3
>>>>>
>>>>> _______________________________________________
>>>>> Virtualization mailing list
>>>>> Virtualization@lists.linux-foundation.org
>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>>>
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
