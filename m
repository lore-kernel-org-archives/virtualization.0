Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88A8C77B7A
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 18:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78ED883F66;
	Tue, 16 May 2023 18:38:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78ED883F66
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GWX6e1QL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLShaUcJ2qVk; Tue, 16 May 2023 18:38:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A8068404A;
	Tue, 16 May 2023 18:38:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A8068404A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC8D8C0036;
	Tue, 16 May 2023 18:38:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64FCFC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 324928404A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 324928404A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tLlWcfsNVb5j
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:38:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A46383F66
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A46383F66
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684262300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bR7XFUDwDwS2QCuwLOFs/PBnLvy7FY7D7eHZBo5Cn1w=;
 b=GWX6e1QLXUmS8XRGslSSnWAozRYrkSuB+E806Q3nEHdaTeQ/M1WLKNzaUTvW1m3k45/QXo
 1WqqMHzIgjnUQ4DdtpNYSD0gKcD8EG1mlEXuR/vYsVVvhgaF4VrWtkz0FB9eYwu23SAwnK
 h/C7JJg+xK6NRm/IabqXE+oloSJaEcg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-Qs50wazRPeS9HugWOpEC4A-1; Tue, 16 May 2023 14:38:16 -0400
X-MC-Unique: Qs50wazRPeS9HugWOpEC4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5D5D2802537;
 Tue, 16 May 2023 18:38:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.147])
 by smtp.corp.redhat.com (Postfix) with SMTP id F1DD22166B31;
 Tue, 16 May 2023 18:38:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Tue, 16 May 2023 20:38:02 +0200 (CEST)
Date: Tue, 16 May 2023 20:37:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230516183757.GA1286@redhat.com>
References: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
 <87cz30s20y.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87cz30s20y.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 stefanha@redhat.com, nicolas.dichtel@6wind.com,
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

On 05/16, Eric W. Biederman wrote:
>
> A kernel thread can block SIGKILL and that is supported.
>
> For a thread that is part of a process you can't block SIGKILL when the
> task is part of a user mode process.

Or SIGSTOP. Another thread can call do_signal_stop()->signal_wake_up/etc.

> There is this bit in complete_signal when SIGKILL is delivered to any
> thread in the process.
>
> 			t = p;
> 			do {
> 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
> 				sigaddset(&t->pending.signal, SIGKILL);
> 				signal_wake_up(t, 1);
> 			} while_each_thread(p, t);

That is why the latest version adds try_set_pending_sigkill(). No, no,
it is not that I think this is a good idea.

> For clarity that sigaddset(&t->pending.signal, SIGKILL);  Really isn't
> setting SIGKILL pending,

Hmm. it does? Nevermind.

> The important part of that code is that SIGNAL_GROUP_EXIT gets set.
> That indicates the entire process is being torn down.

Yes. and the same is true for io-thread even if it calls get_signal()
and dequeues SIGKILL and clears TIF_SIGPENDING.

> but in that case the vhost logic needs to act like a process, just
> like io_uring does.

confused... create_io_thread() creates a sub-thread too?

Although I never understood this logic. I can't even understand the usage
of lower_32_bits() in create_io_thread().

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
