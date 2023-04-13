Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB364C77B61
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 13:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 430DD41E53;
	Thu, 13 Apr 2023 13:03:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 430DD41E53
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dy7Xwqlz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EOvuFhxsT3z1; Thu, 13 Apr 2023 13:03:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B557940103;
	Thu, 13 Apr 2023 13:03:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B557940103
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8101FC0037;
	Thu, 13 Apr 2023 13:03:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8F28C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8292D401DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:03:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8292D401DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RshBkOiPKlXk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:03:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B926640103
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B926640103
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681390996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Cu6EyWN8LOMXD9CXL7Crx6QPnPfI2MeMTBJ/W0AwsE=;
 b=dy7Xwqlzk5cUQkhthxYI/nnECy5DNRygrEcUD3NYmB94ymW66vkl/ucxUveOL+HtOoYRnR
 biL0JftEofEEZKjr1iCRU68Lt9FFQMGebCtBgWyD2BM8b+/20JtwP1J4ej9hZE5WhVlZuR
 2Vm5C6dBCxbEMOTZLfHldrDdUJ/gavA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-4XAPXDlqP0Wi9xKF4IlQTQ-1; Thu, 13 Apr 2023 09:03:12 -0400
X-MC-Unique: 4XAPXDlqP0Wi9xKF4IlQTQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32EE23C16E95;
 Thu, 13 Apr 2023 13:03:07 +0000 (UTC)
Received: from [10.39.208.7] (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D45C4042AD8;
 Thu, 13 Apr 2023 13:02:48 +0000 (UTC)
Message-ID: <f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.com>
Date: Thu, 13 Apr 2023 15:02:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
References: <20230413064027.13267-1-jasowang@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH net-next V2 0/2] virtio-net: don't busy poll for cvq
 command
In-Reply-To: <20230413064027.13267-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.marchand@redhat.com, davem@davemloft.net
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

Hi Jason,

On 4/13/23 08:40, Jason Wang wrote:
> Hi all:
> 
> The code used to busy poll for cvq command which turns out to have
> several side effects:
> 
> 1) infinite poll for buggy devices
> 2) bad interaction with scheduler
> 
> So this series tries to use sleep instead of busy polling. In this
> version, I take a step back: the hardening part is not implemented and
> leave for future investigation. We use to aggree to use interruptible
> sleep but it doesn't work for a general workqueue.
> 
> Please review.

Thanks for working on this.
My DPDK VDUSE RFC missed to set the interrupt, as Xuan Zhou highlighted
it makes the vdpa dev add/del commands to freeze:
[<0>] device_del+0x37/0x3d0
[<0>] device_unregister+0x13/0x60
[<0>] unregister_virtio_device+0x11/0x20
[<0>] device_release_driver_internal+0x193/0x200
[<0>] bus_remove_device+0xbf/0x130
[<0>] device_del+0x174/0x3d0
[<0>] device_unregister+0x13/0x60
[<0>] vdpa_nl_cmd_dev_del_set_doit+0x66/0xe0 [vdpa]
[<0>] genl_family_rcv_msg_doit.isra.0+0xb8/0x100
[<0>] genl_rcv_msg+0x151/0x290
[<0>] netlink_rcv_skb+0x54/0x100
[<0>] genl_rcv+0x24/0x40
[<0>] netlink_unicast+0x217/0x340
[<0>] netlink_sendmsg+0x23e/0x4a0
[<0>] sock_sendmsg+0x8f/0xa0
[<0>] __sys_sendto+0xfc/0x170
[<0>] __x64_sys_sendto+0x20/0x30
[<0>] do_syscall_64+0x59/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Once fixed on DPDK side (you can use my vduse_v1 branch [0] for
testing), it works fine:

Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>

For the potential missing interrupt with non-compliant devices, I guess
it could be handled with the hardening work as same thing could happen
if the VDUSE application crashed for example.

Regards,
Maxime

[0]:
> Thanks
> 
> Changes since V1:
> - use RTNL to synchronize rx mode worker
> - use completion for simplicity
> - don't try to harden CVQ command
> 
> Changes since RFC:
> 
> - switch to use BAD_RING in virtio_break_device()
> - check virtqueue_is_broken() after being woken up
> - use more_used() instead of virtqueue_get_buf() to allow caller to
>    get buffers afterwards
>    - break the virtio-net device when timeout
>    - get buffer manually since the virtio core check more_used() instead
> 
> Jason Wang (2):
>    virtio-net: convert rx mode setting to use workqueue
>    virtio-net: sleep instead of busy waiting for cvq command
> 
>   drivers/net/virtio_net.c | 76 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 66 insertions(+), 10 deletions(-)
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
