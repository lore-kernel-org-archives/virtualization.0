Return-Path: <SRS0=Jxal=KC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8334CC433B4
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 14:40:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72036142D
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 14:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72036142D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E20140E56;
	Fri,  7 May 2021 14:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVEQ-GhQgnBP; Fri,  7 May 2021 14:40:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F25A40391;
	Fri,  7 May 2021 14:40:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9EE6C000E;
	Fri,  7 May 2021 14:40:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8740C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:40:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95ADD4041B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rzlqjR8rsiO
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:40:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5752140515
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 14:40:40 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 622A361157;
 Fri,  7 May 2021 14:40:38 +0000 (UTC)
Date: Fri, 7 May 2021 10:40:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC][PATCH] vhost/vsock: Add vsock_list file to map cid with
 vhost tasks
Message-ID: <20210507104036.711b0b10@gandalf.local.home>
In-Reply-To: <20210507141120.ot6xztl4h5zyav2c@steredhat>
References: <20210505163855.32dad8e7@gandalf.local.home>
 <20210507141120.ot6xztl4h5zyav2c@steredhat>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, 7 May 2021 16:11:20 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> Hi Steven,
> 
> On Wed, May 05, 2021 at 04:38:55PM -0400, Steven Rostedt wrote:
> >The new trace-cmd 3.0 (which is almost ready to be released) allows for
> >tracing between host and guests with timestamp synchronization such that
> >the events on the host and the guest can be interleaved in the proper order
> >that they occur. KernelShark now has a plugin that visualizes this
> >interaction.
> >
> >The implementation requires that the guest has a vsock CID assigned, and on
> >the guest a "trace-cmd agent" is running, that will listen on a port for
> >the CID. The on the host a "trace-cmd record -A guest@cid:port -e events"
> >can be called and the host will connect to the guest agent through the
> >cid/port pair and have the agent enable tracing on behalf of the host and
> >send the trace data back down to it.
> >
> >The problem is that there is no sure fire way to find the CID for a guest.
> >Currently, the user must know the cid, or we have a hack that looks for the
> >qemu process and parses the --guest-cid parameter from it. But this is
> >prone to error and does not work on other implementation (was told that
> >crosvm does not use qemu).  
> 
> For debug I think could be useful to link the vhost-vsock kthread to the 
> CID, but for the user point of view, maybe is better to query the VM 
> management layer, for example if you're using libvirt, you can easily do:
> 
> $ virsh dumpxml fedora34 | grep cid
>      <cid auto='yes' address='3'/>

We looked into going this route, but then that means trace-cmd host/guest
tracing needs a way to handle every layer, as some people use libvirt
(myself included), some people use straight qemu, some people us Xen, and
some people use crosvm. We need to support all of them. Which is why I'm
looking at doing this from the lowest common denominator, and since vsock
is a requirement from trace-cmd to do this tracing, getting the thread
that's related to the vsock is that lowest denominator.

> 
> >
> >As I can not find a way to discover CIDs assigned to guests via any kernel
> >interface, I decided to create this one. Note, I'm not attached to it. If
> >there's a better way to do this, I would love to have it. But since I'm not
> >an expert in the networking layer nor virtio, I decided to stick to what I
> >know and add a debugfs interface that simply lists all the registered 
> >CIDs
> >and the worker task that they are associated with. The worker task at
> >least has the PID of the task it represents.  
> 
> I honestly don't know if it's the best interface, like I said maybe for 
> debugging it's fine, but if we want to expose it to the user in some 
> way, we could support devlink/netlink to provide information about the 
> vsock devices currently in use.

Ideally, a devlink/netlink is the right approach. I just had no idea on how
to implement that ;-)  So I went with what I know, which is debugfs files!



> >Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >---
> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >index 5e78fb719602..4f03b25b23c1 100644
> >--- a/drivers/vhost/vsock.c
> >+++ b/drivers/vhost/vsock.c
> >@@ -15,6 +15,7 @@
> > #include <linux/virtio_vsock.h>
> > #include <linux/vhost.h>
> > #include <linux/hashtable.h>
> >+#include <linux/debugfs.h>
> >
> > #include <net/af_vsock.h>
> > #include "vhost.h"
> >@@ -900,6 +901,128 @@ static struct miscdevice vhost_vsock_misc = {
> > 	.fops = &vhost_vsock_fops,
> > };
> >
> >+static struct dentry *vsock_file;
> >+
> >+struct vsock_file_iter {
> >+	struct hlist_node	*node;
> >+	int			index;
> >+};
> >+
> >+
> >+static void *vsock_next(struct seq_file *m, void *v, loff_t *pos)
> >+{
> >+	struct vsock_file_iter *iter = v;
> >+	struct vhost_vsock *vsock;
> >+
> >+	if (pos)
> >+		(*pos)++;
> >+
> >+	if (iter->index >= (int)HASH_SIZE(vhost_vsock_hash))
> >+		return NULL;
> >+
> >+	if (iter->node)
> >+		iter->node = rcu_dereference_raw(hlist_next_rcu(iter->node));
> >+
> >+	for (;;) {
> >+		if (iter->node) {
> >+			vsock = hlist_entry_safe(rcu_dereference_raw(iter->node),
> >+						 struct vhost_vsock, hash);
> >+			if (vsock->guest_cid)
> >+				break;
> >+			iter->node = rcu_dereference_raw(hlist_next_rcu(iter->node));
> >+			continue;
> >+		}
> >+		iter->index++;
> >+		if (iter->index >= HASH_SIZE(vhost_vsock_hash))
> >+			return NULL;
> >+
> >+		iter->node = rcu_dereference_raw(hlist_first_rcu(&vhost_vsock_hash[iter->index]));
> >+	}
> >+	return iter;
> >+}
> >+
> >+static void *vsock_start(struct seq_file *m, loff_t *pos)
> >+{
> >+	struct vsock_file_iter *iter = m->private;
> >+	loff_t l = 0;
> >+	void *t;
> >+
> >+	rcu_read_lock();  
> 
> Instead of keeping this rcu lock between vsock_start() and vsock_stop(), 
> maybe it's better to make a dump here of the bindings (pid/cid), save it 
> in an array, and iterate it in vsock_next().

The start/stop of a seq_file() is made for taking locks. I do this with all
my code in ftrace. Yeah, there's a while loop between the two, but that's
just to fill the buffer. It's not that long and it never goes to userspace
between the two. You can even use this for spin locks (but I wouldn't
recommend doing it for raw ones).

> 
> >+
> >+	iter->index = -1;
> >+	iter->node = NULL;
> >+	t = vsock_next(m, iter, NULL);
> >+
> >+	for (; iter->index < HASH_SIZE(vhost_vsock_hash) && l < *pos;
> >+	     t = vsock_next(m, iter, &l))
> >+		;  
> 
> A while() maybe was more readable...

Again, I just cut and pasted from my other code.

If you have a good idea on how to implement this with netlink (something
that ss or netstat can dislpay), I think that's the best way to go.

Thanks for looking at this!

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
