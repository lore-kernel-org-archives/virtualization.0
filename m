Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76370C433ED
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 16:08:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86F161439
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 16:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86F161439
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8414484500;
	Thu, 13 May 2021 16:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJyEZf1P5-7r; Thu, 13 May 2021 16:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8202D84490;
	Thu, 13 May 2021 16:08:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4777AC000D;
	Thu, 13 May 2021 16:08:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B182CC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AF6984500
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U8kSx5Po25uA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:08:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AFD184490
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:08:45 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4AB6613B6;
 Thu, 13 May 2021 16:08:43 +0000 (UTC)
Date: Thu, 13 May 2021 12:08:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC][PATCH] vhost/vsock: Add vsock_list file to map cid with
 vhost tasks
Message-ID: <20210513120842.4ed3fb0e@gandalf.local.home>
In-Reply-To: <YJ1Mbie1YGKRR6b8@stefanha-x1.localdomain>
References: <20210505163855.32dad8e7@gandalf.local.home>
 <YJ1Mbie1YGKRR6b8@stefanha-x1.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Joel Fernandes <joelaf@google.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Thu, 13 May 2021 16:57:34 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:


> This approach relies on process hierarchy of the VMM (QEMU).
> Multi-process QEMU is in development and will allow VIRTIO devices to
> run as separate processes from the main QEMU. It then becomes harder to
> correlate a VIRTIO device process with its QEMU process.

And we need to know all these mapping regardless, as we need to map each
thread / process to the vCPU in order to correlate between host thread and
vCPU thread for showing in KernelShark.

Thus this mapping to find the main thread/process needs to be done
regardless.

> 
> So I think in the end this approach ends up being as fragile as parsing
> command-lines. The kernel doesn't really have the concept of a "VM" that
> the vhost_vsock is associated with :). Maybe just parse QEMU and crosvm
> command-lines?
>

That's what we do now, and it already broke once, and even parsing the
command line wont be enough for the stated reasons above.

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
