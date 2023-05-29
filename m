Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C6FC77B7A
	for <virtualization@archiver.kernel.org>; Mon, 29 May 2023 17:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F62A821D7;
	Mon, 29 May 2023 17:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F62A821D7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SsSohYm/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 47Qa1LqKrPYw; Mon, 29 May 2023 17:49:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9493E82199;
	Mon, 29 May 2023 17:49:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9493E82199
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6408FC0036;
	Mon, 29 May 2023 17:49:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E656BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 17:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5D49404B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 17:49:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5D49404B4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SsSohYm/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kzk1SKTS31vW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 17:49:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C35034031D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C35034031D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 May 2023 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685382541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jQ6O0cE8673VatXWo3WOH4FGuXlirbmlPmU9z6UkWkA=;
 b=SsSohYm/o9i+48b2r6t0V4Nb//Mi/N2f/Yv53WsLwN7z33j/Q1VCRTeQrUAgil4BIai7ud
 hazqM5oloPqNuysBL4oR9lVY5BLzqRCpd7kdguwfLxW7NFfLr6nkmwnR9nC6S/GNC4d9Sb
 HoZP1m1FkopEJpuo2iXrSh2utqfiuJg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-4R9wNrFdPXGWKDuWSBBpUA-1; Mon, 29 May 2023 13:47:09 -0400
X-MC-Unique: 4R9wNrFdPXGWKDuWSBBpUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BD912A59575;
 Mon, 29 May 2023 17:47:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.99])
 by smtp.corp.redhat.com (Postfix) with SMTP id 60EB217103;
 Mon, 29 May 2023 17:47:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Mon, 29 May 2023 19:46:50 +0200 (CEST)
Date: Mon, 29 May 2023 19:46:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230529174646.GB15193@redhat.com>
References: <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, linux@leemhuis.info,
 "Eric W. Biederman" <ebiederm@xmission.com>, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>
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

Mike, sorry, I don't understand your email.

Just in case, let me remind I know nothing about drivers/vhost/

On 05/29, michael.christie@oracle.com wrote:
>
> On 5/29/23 6:19 AM, Oleg Nesterov wrote:
> > On 05/27, Eric W. Biederman wrote:
> >>
> >> Looking forward I don't see not asking the worker threads to stop
> >> for the coredump right now causing any problems in the future.
> >> So I think we can use this to resolve the coredump issue I spotted.
> >
> > But we have almost the same problem with exec.
> >
> > Execing thread will wait for vhost_worker() while vhost_worker will wait for
> > .release -> vhost_task_stop().
>
> For this type of case, what is the goal or correct behavior in the end?
>
> When get_signal returns true we can code things like you mention below

and you have mentioned in the next email that you have already coded something
like this, so perhaps we can delay the further discussions until you send the
new code?

> and
> clean up the task_struct.

Hmm... If we you CLONE_THREAD the exiting vhost_worker() will auto-reap itself,

> However, we now have a non-functioning vhost device
> open and just sitting around taking up memory and it can't do any IO.

can't comment, see above.

> For this type of case, do we expect just not to crash/hang, or was this new
> exec'd thread suppose to be able to use the vhost device?

I just tried to point out that (unless I missed something) there are more corner
cases, not just coredump.

> > Or suppose that vhost_worker's sub-thread forks a child with CLONE_FILES...
>
> You mean the vhost_task's task/thread doing a function that does a copy_process
> right?

I meant that the vhost_task's sub-thread can do sys_clone(CLONE_FILES) from
userspace. Yes, this implies copy_process() but I still can't understand you.

> That type of thing is not needed.

Do you mean that userspace should never do this? But this doesn't matter, the
kernel should handle this case anyway.

Or what?

In short let me repeat that I don't understand you and - of course! - quite
possibly I missed something.

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
