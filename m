Return-Path: <SRS0=Jxal=KC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F76C43460
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 16:09:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A666142C
	for <virtualization@archiver.kernel.org>; Fri,  7 May 2021 16:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A666142C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AA588444E;
	Fri,  7 May 2021 16:09:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z0QIKC94HYTI; Fri,  7 May 2021 16:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1603843A0;
	Fri,  7 May 2021 16:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5004C000D;
	Fri,  7 May 2021 16:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E2A1C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 16:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 835A340610
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 16:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yH96QlV2hp1C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 16:09:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8920C40391
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 May 2021 16:09:45 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C4DDF61377;
 Fri,  7 May 2021 16:09:43 +0000 (UTC)
Date: Fri, 7 May 2021 12:09:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC][PATCH] vhost/vsock: Add vsock_list file to map cid with
 vhost tasks
Message-ID: <20210507120942.0b06655e@gandalf.local.home>
In-Reply-To: <20210507154332.hiblsd6ot5wzwkdj@steredhat>
References: <20210505163855.32dad8e7@gandalf.local.home>
 <20210507141120.ot6xztl4h5zyav2c@steredhat>
 <20210507104036.711b0b10@gandalf.local.home>
 <20210507154332.hiblsd6ot5wzwkdj@steredhat>
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

On Fri, 7 May 2021 17:43:32 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> >The start/stop of a seq_file() is made for taking locks. I do this with all
> >my code in ftrace. Yeah, there's a while loop between the two, but that's
> >just to fill the buffer. It's not that long and it never goes to userspace
> >between the two. You can even use this for spin locks (but I wouldn't
> >recommend doing it for raw ones).  
> 
> Ah okay, thanks for the clarification!
> 
> I was worried because building with `make C=2` I had these warnings:
> 
> ../drivers/vhost/vsock.c:944:13: warning: context imbalance in 'vsock_start' - wrong count at exit
> ../drivers/vhost/vsock.c:963:13: warning: context imbalance in 'vsock_stop' - unexpected unlock
> 
> Maybe we need to annotate the functions somehow.

Yep, I it should have been.

static void *vsock_start(struct seq_file *m, loff_t *pos)
	__acquires(rcu)
{
	[...]

}

static void vsock_stop(struct seq_file *m, void *p)
	__releases(rcu)
{
	[...]
}

static int vsock_show(struct seq_file *m, void *v)
	__must_hold(rcu)
{
	[...]
}


And guess what? I just copied those annotations from sock_hash_seq_start(),
sock_hash_seq_show() and sock_hash_seq_stop() from net/core/sock_map.c
which is doing exactly the same thing ;-)

So there's definitely precedence for this.

> 
> >  
> >>  
> >> >+
> >> >+	iter->index = -1;
> >> >+	iter->node = NULL;
> >> >+	t = vsock_next(m, iter, NULL);
> >> >+
> >> >+	for (; iter->index < HASH_SIZE(vhost_vsock_hash) && l < *pos;
> >> >+	     t = vsock_next(m, iter, &l))
> >> >+		;  
> >>
> >> A while() maybe was more readable...  
> >
> >Again, I just cut and pasted from my other code.
> >
> >If you have a good idea on how to implement this with netlink (something
> >that ss or netstat can dislpay), I think that's the best way to go.  
> 
> Okay, I'll take a look and get back to you.
> If it's too complicated, we can go ahead with this patch.

Awesome, thanks!

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
