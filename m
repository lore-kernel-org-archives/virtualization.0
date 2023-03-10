Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E140C6FD19
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 19:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4A9460FCE;
	Fri, 10 Mar 2023 19:37:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4A9460FCE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M5xBMwFmX90V; Fri, 10 Mar 2023 19:37:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5425060FB5;
	Fri, 10 Mar 2023 19:37:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5425060FB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F7D2C0035;
	Fri, 10 Mar 2023 19:37:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7518C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 19:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 854258129F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 19:37:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 854258129F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HG6Df6Tp5RXO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 19:37:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92923812B2
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92923812B2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 19:37:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CD500B82325;
 Fri, 10 Mar 2023 19:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD037C433D2;
 Fri, 10 Mar 2023 19:37:38 +0000 (UTC)
Date: Fri, 10 Mar 2023 14:37:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH v2 0/6] use canonical ftrace path whenever possible
Message-ID: <20230310143736.7d3b8656@gandalf.local.home>
In-Reply-To: <20230310190658.GA3723158@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
 <20230310032921-mutt-send-email-mst@kernel.org>
 <20230310190658.GA3723158@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ross Zwisler <zwisler@chromium.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-trace-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.pizza>,
 "Tobin C. Harding" <me@tobin.cc>
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

On Fri, 10 Mar 2023 12:06:58 -0700
Ross Zwisler <zwisler@google.com> wrote:

> On Fri, Mar 10, 2023 at 03:29:49AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Feb 15, 2023 at 03:33:44PM -0700, Ross Zwisler wrote:  
> > > Changes in v2:
> > >  * Dropped patches which were pulled into maintainer trees.
> > >  * Split BPF patches out into another series targeting bpf-next.
> > >  * trace-agent now falls back to debugfs if tracefs isn't present.
> > >  * Added Acked-by from mst@redhat.com to series.
> > >  * Added a typo fixup for the virtio-trace README.
> > > 
> > > Steven, assuming there are no objections, would you feel comfortable
> > > taking this series through your tree?  
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > if you want the virtio patches through my tree after all, let me know.  
> 
> Yes, please, that would be great.  I'll send out v3 with the few patches that
> haven't gotten a response, but I'll drop the virtio patches assuming you've
> got them.
>

Since the last patch 6/6 is not tracing related, I would prefer it to go
through the virtio tree.

For patches 1-5, please add:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

-- Steve
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
