Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15EAC433EF
	for <virtualization@archiver.kernel.org>; Thu, 23 Dec 2021 03:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38CC781B36;
	Thu, 23 Dec 2021 03:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZsYcPlfHQ4L; Thu, 23 Dec 2021 03:34:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E661381B3E;
	Thu, 23 Dec 2021 03:34:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C14A8C001E;
	Thu, 23 Dec 2021 03:34:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E708C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 03:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B8BF81B3E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 03:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3GTFOF2kDC_Q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 03:34:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60A6B81B36
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Dec 2021 03:34:50 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:41304)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1n0EsS-008mUJ-A0; Wed, 22 Dec 2021 20:34:48 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:43790
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1n0EsR-00AR5u-8e; Wed, 22 Dec 2021 20:34:47 -0700
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-9-ebiederm@xmission.com>
 <YcNsG0Lp94V13whH@archlinux-ax161>
 <87zgoswkym.fsf@email.froward.int.ebiederm.org>
 <YcNyjxac3wlKPywk@archlinux-ax161>
 <87pmpow7ga.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
Date: Wed, 22 Dec 2021 21:34:39 -0600
In-Reply-To: <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
 (Linus Torvalds's message of "Wed, 22 Dec 2021 17:44:19 -0800")
Message-ID: <87o858uh80.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1n0EsR-00AR5u-8e; ; ;
 mid=<87o858uh80.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.24.146; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1/fF160QdsqN4oM1IDCMSjxQAhzKoPXXSg=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all
 kthreads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: linux-arch <linux-arch@vger.kernel.org>, axboe@kernel.dk,
 Kees Cook <keescook@chromium.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Kyle Huey <me@kylehuey.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 virtualization@lists.linux-foundation.org, Alexey Gladkov <legion@kernel.org>,
 christian.brauner@ubuntu.com
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


Added a couple of people from the vhost thread.

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Dec 22, 2021 at 3:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Solve this by skipping the put_user for all kthreads.
>
> Ugh.
>
> While this fixes the problem, could we please just not mis-use that
> 'set_child_tid' as that kthread pointer any more?
>
> It was always kind of hacky. I think a new pointer with the proper
> 'struct kthread *' type would be an improvement.
>
> One of the "arguments" in the comment for re-using that set_child_tid
> pointer was that 'fork()' used to not wrongly copy it, but your patch
> literally now does that "allocate new kthread struct" at fork-time, so
> that argument is actually bogus now.

I agree.  I think I saw in the recent vhost patches that were
generalizing create_io_thread that the pf_io_worker field of
struct task_struct was being generalized as well.

If so I think it makes sense just to take that approach.

Just build some basic infrastructure that can be used for io_workers,
vhost_workers, and kthreads.

Eric


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
