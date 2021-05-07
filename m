Return-Path: <SRS0=Jxal=KC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27EBC43460
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 14:11:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1EC6141F
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 14:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1EC6141F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCC9E4058E;
	Fri,  7 May 2021 14:11:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JkOKgb0U4_6C; Fri,  7 May 2021 14:11:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03C4840298;
	Fri,  7 May 2021 14:11:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2194C000E;
	Fri,  7 May 2021 14:11:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13490C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01CA7406A8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:11:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5-1BqYX_8zfX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:11:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B8E2640113
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620396686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N7Nag0a9zg6fxSLJSO2EqPJSOet0wHr0s3L231n3+Mk=;
 b=FHJFLkIwjaQdVZ36Ps3fU1nEmTfxTc7xFdD/xj04LomlKOH5OAR78DLQCbZdghCIbFdSUA
 afFUMpYibHXgpE/kgV4z8nVBCQN5YCR48xdcMeOau1A1EXz7K+0mmkkbSkTifmAg9kEAUI
 Pfp1usxmweh9+E8vkAL6mlSXzppaooQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-X5u9wbsJNUqH4Z9ZxM-BAw-1; Fri, 07 May 2021 10:11:24 -0400
X-MC-Unique: X5u9wbsJNUqH4Z9ZxM-BAw-1
Received: by mail-ed1-f71.google.com with SMTP id
 bm3-20020a0564020b03b0290387c8b79486so4493587edb.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 May 2021 07:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3xemaWuClFSKLtaEonBaCJQAvDoWvpQU/PJ5oe6FUAg=;
 b=DZkQbE3ASPceOyHyaG+CAPXjKhuA/OvfYL3UwfyhCKk0JfPS8wz0SD2p1OXEIilJKC
 cMkpQc70bCOu3Lf2JYRNKrG5M/QWFdlXl9LYlZEIGVRoU2JRiVLulNS391vldZv7jFAm
 9Pzbw1VLtdROGUdX4X+2/OoBxAMMflE5EknKmsRTIz7U0GQ8SHLKFoqi5OlwOnw43rpD
 Xc0tQWAPpiKItIxq/deggC6gOYJ6aDK1IFTj8Qz38AELDHpx724Yr6BNk8H854Wk2v3V
 JZm5uj7fMU2oLFE4jbVnEQApveO6lHWCcp3s81VPRlowsX8TdtmWTHARfk8tzwr1yxNt
 vd8g==
X-Gm-Message-State: AOAM5331Hro9MlujApALBnQK1j3n+7+bfN0E9xd46hdz3ej0fKvU/red
 tPC2oE1e/XIEdULFvrmiAZY6nXKK+BpLMuAJiV8kS+KwAzPVxuQp1Vtq9DwSh00x+eR1kzmuiQh
 lHshqIpIvUGsSkFWNkzqxlmAGS0rmWXPtEd2snBCkCQ==
X-Received: by 2002:a17:906:b0cd:: with SMTP id
 bk13mr10393832ejb.184.1620396683538; 
 Fri, 07 May 2021 07:11:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXr8UvxvxaXMzinyfRTZbCVHa8v6FhIvaqZukbWNaaGPDQqQTGT/mEtRf9SwSMNBw9IPtE+Q==
X-Received: by 2002:a17:906:b0cd:: with SMTP id
 bk13mr10393792ejb.184.1620396683250; 
 Fri, 07 May 2021 07:11:23 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id k5sm4910773edk.46.2021.05.07.07.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 May 2021 07:11:22 -0700 (PDT)
Date: Fri, 7 May 2021 16:11:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] vhost/vsock: Add vsock_list file to map cid with
 vhost tasks
Message-ID: <20210507141120.ot6xztl4h5zyav2c@steredhat>
References: <20210505163855.32dad8e7@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20210505163855.32dad8e7@gandalf.local.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Joel Fernandes <joelaf@google.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

Hi Steven,

On Wed, May 05, 2021 at 04:38:55PM -0400, Steven Rostedt wrote:
>The new trace-cmd 3.0 (which is almost ready to be released) allows for
>tracing between host and guests with timestamp synchronization such that
>the events on the host and the guest can be interleaved in the proper order
>that they occur. KernelShark now has a plugin that visualizes this
>interaction.
>
>The implementation requires that the guest has a vsock CID assigned, and on
>the guest a "trace-cmd agent" is running, that will listen on a port for
>the CID. The on the host a "trace-cmd record -A guest@cid:port -e events"
>can be called and the host will connect to the guest agent through the
>cid/port pair and have the agent enable tracing on behalf of the host and
>send the trace data back down to it.
>
>The problem is that there is no sure fire way to find the CID for a guest.
>Currently, the user must know the cid, or we have a hack that looks for the
>qemu process and parses the --guest-cid parameter from it. But this is
>prone to error and does not work on other implementation (was told that
>crosvm does not use qemu).

For debug I think could be useful to link the vhost-vsock kthread to the 
CID, but for the user point of view, maybe is better to query the VM 
management layer, for example if you're using libvirt, you can easily do:

$ virsh dumpxml fedora34 | grep cid
     <cid auto='yes' address='3'/>

>
>As I can not find a way to discover CIDs assigned to guests via any kernel
>interface, I decided to create this one. Note, I'm not attached to it. If
>there's a better way to do this, I would love to have it. But since I'm not
>an expert in the networking layer nor virtio, I decided to stick to what I
>know and add a debugfs interface that simply lists all the registered 
>CIDs
>and the worker task that they are associated with. The worker task at
>least has the PID of the task it represents.

I honestly don't know if it's the best interface, like I said maybe for 
debugging it's fine, but if we want to expose it to the user in some 
way, we could support devlink/netlink to provide information about the 
vsock devices currently in use.

>
>Now I can find the cid / host process in charge of the guest pair:
>
>  # cat /sys/kernel/debug/vsock_list
>  3	vhost-1954:2002
>
>  # ps aux | grep 1954
>  qemu        1954  9.9 21.3 1629092 796148 ?      Sl   16:22   0:58  /usr/bin/qemu-kvm -name guest=Fedora21,debug-threads=on -S -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-1-Fedora21/master-key.aes -machine pc-1.2,accel=kvm,usb=off,dump-guest-core=off -cpu qemu64 -m 1000 -overcommit mem-lock=off -smp 2,sockets=2,cores=1,threads=1 -uuid 1eefeeb0-3ac7-07c1-926e-236908313b4c -no-user-config -nodefaults -chardev socket,id=charmonitor,fd=32,server,nowait -mon chardev=charmonitor,id=monitor,mode=control -rtc base=utc -no-shutdown -boot strict=on -device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 -device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x6 -blockdev {"driver":"host_device","filename":"/dev/mapper/vg_bxtest-GuestFedora","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"} -blockdev {"node-name":"libvirt-1-format","read-only":false,"driver":"raw","file":"libvirt-1-storage"} -device ide-hd,bus=ide.0,unit=0,drive=libvirt-1
 -
> format,id=ide0-0-0,bootindex=1 -netdev tap,fd=34,id=hostnet0 -device rtl8139,netdev=hostnet0,id=net0,mac=52:54:00:9f:e9:d5,bus=pci.0,addr=0x3 -netdev tap,fd=35,id=hostnet1 -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:ec:dc:6e,bus=pci.0,addr=0x5 -chardev pty,id=charserial0 -device isa-serial,chardev=charserial0,id=serial0 -chardev pipe,id=charchannel0,path=/var/lib/trace-cmd/virt/Fedora21/trace-pipe-cpu0 -device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=trace-pipe-cpu0 -chardev pipe,id=charchannel1,path=/var/lib/trace-cmd/virt/Fedora21/trace-pipe-cpu1 -device virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel1,id=channel1,name=trace-pipe-cpu1 -vnc 127.0.0.1:0 -device cirrus-vga,id=video0,bus=pci.0,addr=0x2 -device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x4 -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny -device vhost-vsock-pci,id=vsock0,guest-cid=3,vhostfd=16,bus=pci.0,addr=0x7 -msg
> timestamp=on
>  root        2000  0.0  0.0      0     0 ?        S    16:22   0:00 [kvm-pit/1954]
>  root        2002  0.0  0.0      0     0 ?        S    16:22   0:00 [vhost-1954]
>
>
>This is just an example of what I'm looking for. Just a way to find what
>process is using what cid.
>
>Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>---
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5e78fb719602..4f03b25b23c1 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -15,6 +15,7 @@
> #include <linux/virtio_vsock.h>
> #include <linux/vhost.h>
> #include <linux/hashtable.h>
>+#include <linux/debugfs.h>
>
> #include <net/af_vsock.h>
> #include "vhost.h"
>@@ -900,6 +901,128 @@ static struct miscdevice vhost_vsock_misc = {
> 	.fops = &vhost_vsock_fops,
> };
>
>+static struct dentry *vsock_file;
>+
>+struct vsock_file_iter {
>+	struct hlist_node	*node;
>+	int			index;
>+};
>+
>+
>+static void *vsock_next(struct seq_file *m, void *v, loff_t *pos)
>+{
>+	struct vsock_file_iter *iter = v;
>+	struct vhost_vsock *vsock;
>+
>+	if (pos)
>+		(*pos)++;
>+
>+	if (iter->index >= (int)HASH_SIZE(vhost_vsock_hash))
>+		return NULL;
>+
>+	if (iter->node)
>+		iter->node = rcu_dereference_raw(hlist_next_rcu(iter->node));
>+
>+	for (;;) {
>+		if (iter->node) {
>+			vsock = hlist_entry_safe(rcu_dereference_raw(iter->node),
>+						 struct vhost_vsock, hash);
>+			if (vsock->guest_cid)
>+				break;
>+			iter->node = rcu_dereference_raw(hlist_next_rcu(iter->node));
>+			continue;
>+		}
>+		iter->index++;
>+		if (iter->index >= HASH_SIZE(vhost_vsock_hash))
>+			return NULL;
>+
>+		iter->node = rcu_dereference_raw(hlist_first_rcu(&vhost_vsock_hash[iter->index]));
>+	}
>+	return iter;
>+}
>+
>+static void *vsock_start(struct seq_file *m, loff_t *pos)
>+{
>+	struct vsock_file_iter *iter = m->private;
>+	loff_t l = 0;
>+	void *t;
>+
>+	rcu_read_lock();

Instead of keeping this rcu lock between vsock_start() and vsock_stop(), 
maybe it's better to make a dump here of the bindings (pid/cid), save it 
in an array, and iterate it in vsock_next().

>+
>+	iter->index = -1;
>+	iter->node = NULL;
>+	t = vsock_next(m, iter, NULL);
>+
>+	for (; iter->index < HASH_SIZE(vhost_vsock_hash) && l < *pos;
>+	     t = vsock_next(m, iter, &l))
>+		;

A while() maybe was more readable...

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
