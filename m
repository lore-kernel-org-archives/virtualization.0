Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156A6EB64DB
	for <virtualization@archiver.kernel.org>; Wed, 14 Jun 2023 17:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82F0481432;
	Wed, 14 Jun 2023 17:08:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82F0481432
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbhWByDr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ssl4Wci3zWUM; Wed, 14 Jun 2023 17:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 04DCC81409;
	Wed, 14 Jun 2023 17:08:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04DCC81409
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD072C007A;
	Wed, 14 Jun 2023 17:08:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE8E0C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 17:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8AC4D60BA7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 17:08:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8AC4D60BA7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbhWByDr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FitSKEasZWbT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 17:08:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 52983607E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52983607E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686762521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cm7QnVX+1Peb/lxYvy314RNV95pm5UqmDVNYkqh6DVM=;
 b=WbhWByDrEVOdsqfgqNZisI0Qq3Z8rrviKqwT1awf8rKOcZYF2wmj+L0WOr3b6p23DjMBdq
 1eTT6WQwFj1GCEyf3A+XkfPCFBIaYRlV6YnyAcYG5THSH+FCfGfq0vwqgE+71OG8N+wn/T
 zLS5gd7GZVjYRxDzoZ6c1WzHeSf/kxw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-XwCezD4iNx-HxUG8D2T_EQ-1; Wed, 14 Jun 2023 13:08:36 -0400
X-MC-Unique: XwCezD4iNx-HxUG8D2T_EQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11DCB3C0D842;
 Wed, 14 Jun 2023 17:08:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.56])
 by smtp.corp.redhat.com (Postfix) with SMTP id 199032166B25;
 Wed, 14 Jun 2023 17:08:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Wed, 14 Jun 2023 19:08:10 +0200 (CEST)
Date: Wed, 14 Jun 2023 19:08:04 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230614170803.GA18850@redhat.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
 <87o7llycau.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o7llycau.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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

On 06/11, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > Could you spell to explain why this can't work (again, in this simple case) ?
> >
> > My current (and I know, very poor) understanding is that .release() should
> > roughly do the following:
> >
> > 	1. Ensure that vhost_work_queue() can't add the new callbacks
> >
> > 	2. Call vhost_dev_flush() to ensure that worker->work_list is empty
> >
> > 	3. Call vhost_task_stop()
>
> At least in the case of exec by the time the final fput happens
> from close_on_exec the task has already changed it's mm.

Of course you are right.

But can't resist, please note that I only meant "this simple case" which
doesn't include exec/etc.

Nevermind. As Mike explains there are more problems even in this particular
"simple" case, and I am not surprised.

Sorry for noise,

Oleg.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
