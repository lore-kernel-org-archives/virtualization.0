Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C73C433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 17:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C729B402B5;
	Mon, 17 Jan 2022 17:31:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TqjbbFR5ZqGT; Mon, 17 Jan 2022 17:31:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BE33402B2;
	Mon, 17 Jan 2022 17:31:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC24C0039;
	Mon, 17 Jan 2022 17:31:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E16FC002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 17:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E49660B54
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 17:31:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eyq5MrVpi0EO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 17:31:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9C986063B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 17:31:34 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:44742)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1n9Vqt-00HRqg-CU; Mon, 17 Jan 2022 10:31:31 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:47238
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1n9Vqs-00FkwG-D8; Mon, 17 Jan 2022 10:31:31 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mike Christie <michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <87tuf79gni.fsf@email.froward.int.ebiederm.org>
 <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
 <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
 <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
 <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
 <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com>
Date: Mon, 17 Jan 2022 11:31:22 -0600
In-Reply-To: <783145b7-243b-b85e-e274-44ef6c0696b9@oracle.com> (Mike
 Christie's message of "Mon, 17 Jan 2022 10:41:05 -0600")
Message-ID: <874k62b76d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1n9Vqs-00FkwG-D8; ; ;
 mid=<874k62b76d.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.24.146; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX19/12qxSuzbVIP5mosEcqpM6N5wKVRUr9o=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: axboe@kernel.dk, hdanton@sina.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, vverma@digitalocean.com, geert@linux-m68k.org,
 stefanha@redhat.com, christian.brauner@ubuntu.com
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

Mike Christie <michael.christie@oracle.com> writes:

> On 12/22/21 12:24 PM, Eric W. Biederman wrote:
>> All I am certain of is that you need to set
>> "args->exit_signal = -1;".  This prevents having to play games with
>> do_notify_parent.
>
> Hi Eric,
>
> I have all your review comments handled except this one. It's looking like it's
> more difficult than just setting the exit_signal=-1, so I wanted to check that
> I understood you.

[snip problems with exit_signal = -1]

>
> What do you think?

I was wrong.  I appear to have confused the thread and the non-thread
cases.

Perhaps I meant "args->exit_signal = 0".  That looks like
do_notify_parent won't send it, and thread_group_leader continues to do
the right thing.

Baring any additional confusion on my part that cleanly solves the
problem of how not to send a signal from a child process cleanly.

My apologies for sending you on a wild goose chase.

Eric


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
