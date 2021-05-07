Return-Path: <SRS0=Jxal=KC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70692C43460
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 15:43:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D632260551
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 15:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D632260551
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56D4C41894;
	Fri,  7 May 2021 15:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQiirW_gxzos; Fri,  7 May 2021 15:43:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 577FF40650;
	Fri,  7 May 2021 15:43:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE30C000D;
	Fri,  7 May 2021 15:43:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D563C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 15:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B48A8444E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 15:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fW8D0wHuif8K
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 15:43:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 472E184452
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620402219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=igWUiltl+YCLkoRgKhfdDwlU7m05eUi8sttV6ydTSnQ=;
 b=MxZXsyzHHAvpQFtAd2NkiAn2oyqCartcT9HzVFIZpBPWPwHwNQdNzc/wE/ZKZ8JoJicOHz
 Mmu5yhCXhUiE0hpTr8sk3GFMdVpfeAHSeNS+498W4dDrQptB1wWKWUuE2q3yCxuZJTpR9X
 IAPuU+/svlJliwFpoJpu3M4HP+6FLxU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-87YSLq8XPceGhmqfYBGHyQ-1; Fri, 07 May 2021 11:43:36 -0400
X-MC-Unique: 87YSLq8XPceGhmqfYBGHyQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 y17-20020a0564023591b02903886c26ada4so4665697edc.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 May 2021 08:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=igWUiltl+YCLkoRgKhfdDwlU7m05eUi8sttV6ydTSnQ=;
 b=mIjz5ibjO/WwQIRipRG64uyITM7mqPeJHlK8vgn4D0G+ojv4YBLXLIWUp+MujDc69R
 FXfSOSH0QDEz9aMNAAJ/eRFjQWsgs6qfV9wigfBoyHF9LZ71clbDSHi0a3jHF0l13OMY
 rtsStwJVOUPY0KN+fs88BX9TpbXhNV6Jy3OHiztaoVz2z1LsKdszac3Nz6MNpqt+iNNK
 u2c6JBbWPSyu6vFMCZAZtOld0A4DRNrICace54x8f4BHgGD6qpPRAsMO/a+6M5jRBDrX
 VAMquZATtVaYpdR9+yzX3zWhrprpSN5HXgajs5nkyVIbiNQb7POvHDqUXEnCDnfx7WD5
 DSxg==
X-Gm-Message-State: AOAM532Mp8GbC5cOWU/8khD/gi+dkf77QprqrG6P21AvWAPdQnDwY1dG
 XHcTNdxAfWm4w/dZipsR1aZIVW4y/Zks8e1KHGWeeggUm8rVesCJxe6xNAQkS6Ba5wsExUo6+DA
 dW/6blGGYS6cmS1fdQFhCY2DJaFlkM2pF2g121x0/eQ==
X-Received: by 2002:a17:906:2a16:: with SMTP id
 j22mr10671847eje.397.1620402215568; 
 Fri, 07 May 2021 08:43:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhqzGQ5WsonJAUm+Gaadfs9rV2/KnHZzLpkGO2HPjKexzKbktOUtpSyXiW4IJSVMBDZ+ZOdw==
X-Received: by 2002:a17:906:2a16:: with SMTP id
 j22mr10671832eje.397.1620402215376; 
 Fri, 07 May 2021 08:43:35 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id b21sm3660039ejg.80.2021.05.07.08.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 May 2021 08:43:34 -0700 (PDT)
Date: Fri, 7 May 2021 17:43:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] vhost/vsock: Add vsock_list file to map cid with
 vhost tasks
Message-ID: <20210507154332.hiblsd6ot5wzwkdj@steredhat>
References: <20210505163855.32dad8e7@gandalf.local.home>
 <20210507141120.ot6xztl4h5zyav2c@steredhat>
 <20210507104036.711b0b10@gandalf.local.home>
MIME-Version: 1.0
In-Reply-To: <20210507104036.711b0b10@gandalf.local.home>
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

On Fri, May 07, 2021 at 10:40:36AM -0400, Steven Rostedt wrote:
>On Fri, 7 May 2021 16:11:20 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> Hi Steven,
>>
>> On Wed, May 05, 2021 at 04:38:55PM -0400, Steven Rostedt wrote:
>> >The new trace-cmd 3.0 (which is almost ready to be released) allows for
>> >tracing between host and guests with timestamp synchronization such that
>> >the events on the host and the guest can be interleaved in the proper order
>> >that they occur. KernelShark now has a plugin that visualizes this
>> >interaction.
>> >
>> >The implementation requires that the guest has a vsock CID assigned, and on
>> >the guest a "trace-cmd agent" is running, that will listen on a port for
>> >the CID. The on the host a "trace-cmd record -A guest@cid:port -e events"
>> >can be called and the host will connect to the guest agent through the
>> >cid/port pair and have the agent enable tracing on behalf of the host and
>> >send the trace data back down to it.
>> >
>> >The problem is that there is no sure fire way to find the CID for a guest.
>> >Currently, the user must know the cid, or we have a hack that looks for the
>> >qemu process and parses the --guest-cid parameter from it. But this is
>> >prone to error and does not work on other implementation (was told that
>> >crosvm does not use qemu).
>>
>> For debug I think could be useful to link the vhost-vsock kthread to the
>> CID, but for the user point of view, maybe is better to query the VM
>> management layer, for example if you're using libvirt, you can easily do:
>>
>> $ virsh dumpxml fedora34 | grep cid
>>      <cid auto='yes' address='3'/>
>
>We looked into going this route, but then that means trace-cmd host/guest
>tracing needs a way to handle every layer, as some people use libvirt
>(myself included), some people use straight qemu, some people us Xen, and
>some people use crosvm. We need to support all of them. Which is why I'm
>looking at doing this from the lowest common denominator, and since vsock
>is a requirement from trace-cmd to do this tracing, getting the thread
>that's related to the vsock is that lowest denominator.

Makes sense.
Just a note, there are some VMMs, like Firecracker, Cloud Hypervisor, or 
QEMU with vhost-user-vsock, that don't use vhost-vsock in the host, but 
they implements an hybrid vsock over Unix Domain Socket:
https://github.com/firecracker-microvm/firecracker/blob/main/docs/vsock.md

So in that case this approach or netlink/devlink, would not work, but 
the application in the host can't use a vsock socket, so maybe isn't a 
problem.

>
>>
>> >
>> >As I can not find a way to discover CIDs assigned to guests via any kernel
>> >interface, I decided to create this one. Note, I'm not attached to it. If
>> >there's a better way to do this, I would love to have it. But since I'm not
>> >an expert in the networking layer nor virtio, I decided to stick to what I
>> >know and add a debugfs interface that simply lists all the 
>> >registered
>> >CIDs
>> >and the worker task that they are associated with. The worker task at
>> >least has the PID of the task it represents.
>>
>> I honestly don't know if it's the best interface, like I said maybe for
>> debugging it's fine, but if we want to expose it to the user in some
>> way, we could support devlink/netlink to provide information about the
>> vsock devices currently in use.
>
>Ideally, a devlink/netlink is the right approach. I just had no idea on how
>to implement that ;-)  So I went with what I know, which is debugfs files!
>
>
>
>> >Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> >---
>> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> >index 5e78fb719602..4f03b25b23c1 100644
>> >--- a/drivers/vhost/vsock.c
>> >+++ b/drivers/vhost/vsock.c
>> >@@ -15,6 +15,7 @@
>> > #include <linux/virtio_vsock.h>
>> > #include <linux/vhost.h>
>> > #include <linux/hashtable.h>
>> >+#include <linux/debugfs.h>
>> >
>> > #include <net/af_vsock.h>
>> > #include "vhost.h"
>> >@@ -900,6 +901,128 @@ static struct miscdevice vhost_vsock_misc = {
>> > 	.fops = &vhost_vsock_fops,
>> > };
>> >
>> >+static struct dentry *vsock_file;
>> >+
>> >+struct vsock_file_iter {
>> >+	struct hlist_node	*node;
>> >+	int			index;
>> >+};
>> >+
>> >+
>> >+static void *vsock_next(struct seq_file *m, void *v, loff_t *pos)
>> >+{
>> >+	struct vsock_file_iter *iter = v;
>> >+	struct vhost_vsock *vsock;
>> >+
>> >+	if (pos)
>> >+		(*pos)++;
>> >+
>> >+	if (iter->index >= (int)HASH_SIZE(vhost_vsock_hash))
>> >+		return NULL;
>> >+
>> >+	if (iter->node)
>> >+		iter->node = rcu_dereference_raw(hlist_next_rcu(iter->node));
>> >+
>> >+	for (;;) {
>> >+		if (iter->node) {
>> >+			vsock = hlist_entry_safe(rcu_dereference_raw(iter->node),
>> >+						 struct vhost_vsock, hash);
>> >+			if (vsock->guest_cid)
>> >+				break;
>> >+			iter->node = 
>> >rcu_dereference_raw(hlist_next_rcu(iter->node));
>> >+			continue;
>> >+		}
>> >+		iter->index++;
>> >+		if (iter->index >= HASH_SIZE(vhost_vsock_hash))
>> >+			return NULL;
>> >+
>> >+		iter->node = rcu_dereference_raw(hlist_first_rcu(&vhost_vsock_hash[iter->index]));
>> >+	}
>> >+	return iter;
>> >+}
>> >+
>> >+static void *vsock_start(struct seq_file *m, loff_t *pos)
>> >+{
>> >+	struct vsock_file_iter *iter = m->private;
>> >+	loff_t l = 0;
>> >+	void *t;
>> >+
>> >+	rcu_read_lock();
>>
>> Instead of keeping this rcu lock between vsock_start() and vsock_stop(),
>> maybe it's better to make a dump here of the bindings (pid/cid), save it
>> in an array, and iterate it in vsock_next().
>
>The start/stop of a seq_file() is made for taking locks. I do this with all
>my code in ftrace. Yeah, there's a while loop between the two, but that's
>just to fill the buffer. It's not that long and it never goes to userspace
>between the two. You can even use this for spin locks (but I wouldn't
>recommend doing it for raw ones).

Ah okay, thanks for the clarification!

I was worried because building with `make C=2` I had these warnings:

../drivers/vhost/vsock.c:944:13: warning: context imbalance in 'vsock_start' - wrong count at exit
../drivers/vhost/vsock.c:963:13: warning: context imbalance in 'vsock_stop' - unexpected unlock

Maybe we need to annotate the functions somehow.

>
>>
>> >+
>> >+	iter->index = -1;
>> >+	iter->node = NULL;
>> >+	t = vsock_next(m, iter, NULL);
>> >+
>> >+	for (; iter->index < HASH_SIZE(vhost_vsock_hash) && l < *pos;
>> >+	     t = vsock_next(m, iter, &l))
>> >+		;
>>
>> A while() maybe was more readable...
>
>Again, I just cut and pasted from my other code.
>
>If you have a good idea on how to implement this with netlink (something
>that ss or netstat can dislpay), I think that's the best way to go.

Okay, I'll take a look and get back to you.
If it's too complicated, we can go ahead with this patch.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
