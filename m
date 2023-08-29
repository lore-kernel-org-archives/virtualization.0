Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB444C83F35
	for <virtualization@archiver.kernel.org>; Tue, 29 Aug 2023 13:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 563D440363;
	Tue, 29 Aug 2023 13:34:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 563D440363
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4zJVlgW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-O24VkUz4uy; Tue, 29 Aug 2023 13:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A603A402C4;
	Tue, 29 Aug 2023 13:34:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A603A402C4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 796F7C0039;
	Tue, 29 Aug 2023 13:34:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20164C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E1CF98145B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:34:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1CF98145B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O4zJVlgW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zo6GFKb3X0PK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:34:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F42A8142C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Aug 2023 13:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F42A8142C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693316054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meHgujCAcJWGepUP3mVRioCZxpb1/KV09es2CrqMcik=;
 b=O4zJVlgW2tO9d7OW6qZaMVleBwj8NWENSs/VMYYX4zRUI8y3NCPGj8KWU06yoGeNxrs1oc
 Z1FAuLI+IhnNV+ISLN5SnX3SbNIHzb7ghnXTZrcAQAQ/U7PCy7hIWXCFEhkFY4yWduDT2x
 JHttZZgEdcAcekXgAgmv61NelHTkGPY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-pDofYS_2OEqJMmIBLgET0Q-1; Tue, 29 Aug 2023 09:34:11 -0400
X-MC-Unique: pDofYS_2OEqJMmIBLgET0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D63A2815E23;
 Tue, 29 Aug 2023 13:34:11 +0000 (UTC)
Received: from [10.39.208.19] (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A4F640C6F4C;
 Tue, 29 Aug 2023 13:34:08 +0000 (UTC)
Message-ID: <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
Date: Tue, 29 Aug 2023 15:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230810150054.7baf34b7@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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



On 8/11/23 00:00, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
>>> Directly into the stack? I thought VDUSE is vDPA in user space,
>>> meaning to get to the kernel the packet has to first go thru
>>> a virtio-net instance.
>>
>> yes. is that a sufficient filter in your opinion?
> 
> Yes, the ability to create the device feels stronger than CAP_NET_RAW,
> and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
> experience with virt so no strong opinion, perhaps it does make sense
> for someone's deployment? Dunno..
> 

I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
devices, as the device could be attached to vhost-vDPA and so not
visible to the Kernel networking stack.

However, CAP_NET_ADMIN should be required to attach the VDUSE device to 
virtio-vdpa/virtio-net.

Does that make sense?

Maxime

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
