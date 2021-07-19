Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D33EC12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 09:40:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E7B6108B
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 09:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E7B6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DA4B40250;
	Mon, 19 Jul 2021 09:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U3FzRd6Xrkkb; Mon, 19 Jul 2021 09:40:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 373FC400C7;
	Mon, 19 Jul 2021 09:40:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D32DC001A;
	Mon, 19 Jul 2021 09:40:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 534FFC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 09:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35B8360610
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 09:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iS8GxkfK-YFh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 09:40:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65E3D6060A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626687616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o2neGtXxI9txkd6ubgbi9vatyoxKxqqynZLOY2Z98TM=;
 b=LIHuwQMywZDeP4woHUh4gyuGK+YgOsCN8n7Z31/XX9am0J8oXa9RBAfeKof1qoXaqes/F8
 CIfQHLkK5XVVWTnDX6XKUjYeckKRYpNkuzJpN2Y9AGf5WSd/Ow9Zlsc0AfGhVa25dQwsrm
 4W24/HP7UWEKW9Fk58M7jbwO4Rpnw68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-UG-Rc40-O8OHq2yyZyoSaQ-1; Mon, 19 Jul 2021 05:40:14 -0400
X-MC-Unique: UG-Rc40-O8OHq2yyZyoSaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9179804140;
 Mon, 19 Jul 2021 09:40:13 +0000 (UTC)
Received: from localhost (ovpn-112-158.ams2.redhat.com [10.36.112.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6717710016F2;
 Mon, 19 Jul 2021 09:40:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci
 device
In-Reply-To: <20210717164152-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-5-parav@nvidia.com>
 <20210717164152-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Mon, 19 Jul 2021 11:40:08 +0200
Message-ID: <878s22bq13.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org
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

On Sat, Jul 17 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sat, Jul 17, 2021 at 10:42:58AM +0300, Parav Pandit wrote:
>> When a virtio pci device undergo surprise removal (aka async removaln in
>
> typo
>
>> PCIe spec), mark the device is broken so that any upper layer drivers can
>> abort any outstanding operation.
>> 
>> When a virtio net pci device undergo surprise removal which is used by a
>> NetworkManager, a below call trace was observed.
>> 
>> kernel:watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:1:27059]
>> watchdog: BUG: soft lockup - CPU#1 stuck for 52s! [kworker/1:1:27059]
>> CPU: 1 PID: 27059 Comm: kworker/1:1 Tainted: G S      W I  L    5.13.0-hotplug+ #8
>> Hardware name: Dell Inc. PowerEdge R640/0H28RR, BIOS 2.9.4 11/06/2020
>> Workqueue: events linkwatch_event
>> RIP: 0010:virtnet_send_command+0xfc/0x150 [virtio_net]
>> Call Trace:
>>  virtnet_set_rx_mode+0xcf/0x2a7 [virtio_net]
>>  ? __hw_addr_create_ex+0x85/0xc0
>>  __dev_mc_add+0x72/0x80
>>  igmp6_group_added+0xa7/0xd0
>>  ipv6_mc_up+0x3c/0x60
>>  ipv6_find_idev+0x36/0x80
>>  addrconf_add_dev+0x1e/0xa0
>>  addrconf_dev_config+0x71/0x130
>>  addrconf_notify+0x1f5/0xb40
>>  ? rtnl_is_locked+0x11/0x20
>>  ? __switch_to_asm+0x42/0x70
>>  ? finish_task_switch+0xaf/0x2c0
>>  ? raw_notifier_call_chain+0x3e/0x50
>>  raw_notifier_call_chain+0x3e/0x50
>>  netdev_state_change+0x67/0x90
>>  linkwatch_do_dev+0x3c/0x50
>>  __linkwatch_run_queue+0xd2/0x220
>>  linkwatch_event+0x21/0x30
>>  process_one_work+0x1c8/0x370
>>  worker_thread+0x30/0x380
>>  ? process_one_work+0x370/0x370
>>  kthread+0x118/0x140
>>  ? set_kthread_struct+0x40/0x40
>>  ret_from_fork+0x1f/0x30
>> 
>> Hence, add the ability to abort the command on surprise removal
>> which prevents infinite loop and system lockup.
>> 
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> OK that's nice, but I suspect this is not enough.
> For example we need to also fix up all config space reads
> to handle all-ones patterns specially.
>
> E.g.
>
>         /* After writing 0 to device_status, the driver MUST wait for a read of
>          * device_status to return 0 before reinitializing the device.
>          * This will flush out the status write, and flush in device writes,
>          * including MSI-X interrupts, if any.
>          */
>         while (vp_modern_get_status(mdev))
>                 msleep(1);
>
> lots of code in drivers needs to be fixed too.
>
> I guess we need to annotate drivers somehow to mark up
> whether they support surprise removal? And maybe find a
> way to let host know?

I'm wondering whether virtio-pci surprise removal would need more
support in drivers than virtio-ccw surprise removal; given that
virtio-ccw *only* supports surprise removal and I don't remember any
problem reports, the situation is probably not that bad.

Is surprise removal of block devices still a big problem? We have some
support for (non-virtio) ccw devices (e.g. dasd) via a 'disconnected'
state that was designed to mitigate problems with block devices that are
suddenly gone.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
