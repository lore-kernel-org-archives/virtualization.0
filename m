Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2503FC636CA
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 20:46:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE35161153
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 20:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE35161153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F6B7607CA;
	Sat, 17 Jul 2021 20:46:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WqKiOx5XH9DX; Sat, 17 Jul 2021 20:46:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CADE96068C;
	Sat, 17 Jul 2021 20:46:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA54C0010;
	Sat, 17 Jul 2021 20:46:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED35C000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:46:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 153B240543
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmIQeop723ti
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:46:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F43D40540
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626554809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RTkgSVH2foNtu8zPXFVP+1H5bOrViZHljBBhKtycxpc=;
 b=M3y19P1Ol3h+w7tMT5K265Li1fhqrtJXqkgfJhzONymZreQPeDxLno6bZpv0DqVvqWIkzd
 uo2jXkW775dQ1fnCUcYzc29HKVDfbqVM14Q7OQjsJnEaZGA6LpgxjaJcSnGfXPWoiLx+xd
 qskNil9FAatmOyCk+qBJS8K6wIyd/b4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-RQnagQhEPXejycMMGFtA-A-1; Sat, 17 Jul 2021 16:46:44 -0400
X-MC-Unique: RQnagQhEPXejycMMGFtA-A-1
Received: by mail-ed1-f72.google.com with SMTP id
 j25-20020aa7ca590000b029039c88110440so6766856edt.15
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 13:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RTkgSVH2foNtu8zPXFVP+1H5bOrViZHljBBhKtycxpc=;
 b=acaQmwoCz8ejx27T36ZNN8A60dwHFjzFRI7U/hto2kxZm+2h4jQPK0vSqmYDIDx0Ic
 bg+cYFro7ffEZwNSFyQB/rQvcJpjr9XZ0MuVNBb/AB0pwTQcMQ/GtnP+BOnHDyeWAawh
 VDX5BZzXxAhES6w9BOt7vFMXdLznW8vELTJzasauhmW0EZAZtnfgba0EVkL2YxWf2eNl
 fECmKJlAHdkH0UnAOO+UDPLXBoYny0D4OoyaoA2tf29b+qviSGmhDjb59ytD1n8ehtBX
 7qKIYzO/EMpR1qerqkpiNhvPO2LgYnkk8EUWFhkQWGdKPZ5RCP+sv7QaAFUTq20c4zdN
 9bpA==
X-Gm-Message-State: AOAM530Lq39Ec8fACnGflF5Bub5+F2xpQ0XamPSPjR/X2pP1WHLcbp7w
 TptGgdX8HCLu6o9Co6aqFdNKKy0zjQHnwtbyUalllbSuOtZ8vAyjD7lJYgJKxhqriUIld9quoVS
 sfWALxNc9qnCAYMZdRv4vIsLtSn9npsQ0IYRkTdIjmg==
X-Received: by 2002:a17:906:e0e:: with SMTP id
 l14mr19116429eji.501.1626554803745; 
 Sat, 17 Jul 2021 13:46:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJZYKMI9lUt8Gxi6z27K2TB70RJQ9Wd9vI1pWP/TNcBJZRXrljxExs0n/9b0rHObGtqqx9CA==
X-Received: by 2002:a17:906:e0e:: with SMTP id
 l14mr19116420eji.501.1626554803576; 
 Sat, 17 Jul 2021 13:46:43 -0700 (PDT)
Received: from redhat.com ([2.55.29.175])
 by smtp.gmail.com with ESMTPSA id u5sm5498982edv.64.2021.07.17.13.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jul 2021 13:46:42 -0700 (PDT)
Date: Sat, 17 Jul 2021 16:46:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 4/4] virtio_pci: Support surprise removal of virtio pci
 device
Message-ID: <20210717164152-mutt-send-email-mst@kernel.org>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210717074258.1463313-5-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Sat, Jul 17, 2021 at 10:42:58AM +0300, Parav Pandit wrote:
> When a virtio pci device undergo surprise removal (aka async removaln in

typo

> PCIe spec), mark the device is broken so that any upper layer drivers can
> abort any outstanding operation.
> 
> When a virtio net pci device undergo surprise removal which is used by a
> NetworkManager, a below call trace was observed.
> 
> kernel:watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:1:27059]
> watchdog: BUG: soft lockup - CPU#1 stuck for 52s! [kworker/1:1:27059]
> CPU: 1 PID: 27059 Comm: kworker/1:1 Tainted: G S      W I  L    5.13.0-hotplug+ #8
> Hardware name: Dell Inc. PowerEdge R640/0H28RR, BIOS 2.9.4 11/06/2020
> Workqueue: events linkwatch_event
> RIP: 0010:virtnet_send_command+0xfc/0x150 [virtio_net]
> Call Trace:
>  virtnet_set_rx_mode+0xcf/0x2a7 [virtio_net]
>  ? __hw_addr_create_ex+0x85/0xc0
>  __dev_mc_add+0x72/0x80
>  igmp6_group_added+0xa7/0xd0
>  ipv6_mc_up+0x3c/0x60
>  ipv6_find_idev+0x36/0x80
>  addrconf_add_dev+0x1e/0xa0
>  addrconf_dev_config+0x71/0x130
>  addrconf_notify+0x1f5/0xb40
>  ? rtnl_is_locked+0x11/0x20
>  ? __switch_to_asm+0x42/0x70
>  ? finish_task_switch+0xaf/0x2c0
>  ? raw_notifier_call_chain+0x3e/0x50
>  raw_notifier_call_chain+0x3e/0x50
>  netdev_state_change+0x67/0x90
>  linkwatch_do_dev+0x3c/0x50
>  __linkwatch_run_queue+0xd2/0x220
>  linkwatch_event+0x21/0x30
>  process_one_work+0x1c8/0x370
>  worker_thread+0x30/0x380
>  ? process_one_work+0x370/0x370
>  kthread+0x118/0x140
>  ? set_kthread_struct+0x40/0x40
>  ret_from_fork+0x1f/0x30
> 
> Hence, add the ability to abort the command on surprise removal
> which prevents infinite loop and system lockup.
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>

OK that's nice, but I suspect this is not enough.
For example we need to also fix up all config space reads
to handle all-ones patterns specially.

E.g.

        /* After writing 0 to device_status, the driver MUST wait for a read of
         * device_status to return 0 before reinitializing the device.
         * This will flush out the status write, and flush in device writes,
         * including MSI-X interrupts, if any.
         */
        while (vp_modern_get_status(mdev))
                msleep(1);

lots of code in drivers needs to be fixed too.

I guess we need to annotate drivers somehow to mark up
whether they support surprise removal? And maybe find a
way to let host know?



> ---
>  drivers/virtio/virtio_pci_common.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 222d630c41fc..b35bb2d57f62 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -576,6 +576,13 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
>  	struct device *dev = get_device(&vp_dev->vdev.dev);
>  
> +	/*
> +	 * Device is marked broken on surprise removal so that virtio upper
> +	 * layers can abort any ongoing operation.
> +	 */
> +	if (!pci_device_is_present(pci_dev))
> +		virtio_break_device(&vp_dev->vdev);
> +
>  	pci_disable_sriov(pci_dev);
>  
>  	unregister_virtio_device(&vp_dev->vdev);
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
