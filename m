Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1214EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 14 Jun 2023 14:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D334612E1;
	Wed, 14 Jun 2023 14:20:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D334612E1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S6IOhfUW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bEA7RX_QqGos; Wed, 14 Jun 2023 14:20:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07249612FD;
	Wed, 14 Jun 2023 14:20:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07249612FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3392C0037;
	Wed, 14 Jun 2023 14:20:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F20A8C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAFCE41DE4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAFCE41DE4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=S6IOhfUW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4x5Mpx4xHajY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:20:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D642941D78
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D642941D78
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686752454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXku3YB8jZRDn1PVtMCllG5PapuVlNga2nXVph7/LWk=;
 b=S6IOhfUW4tD8/bdYn7OWNUgsUMmSXZNdFt8WAsSXj9ICiCF6orRtTh2rOGYnGMDIoC9VJI
 O9EnNOTKubsprdnNRFhiAJ+9yZ7vU41rAaYzf3Hdx18ifhQrVPXNvKNTc+5hTJznOCbb0d
 vPKIIm2s5hkr6SjvlTwAa6QrRWMUAkE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-omIYwGVnMVStkXOkagg0rQ-1; Wed, 14 Jun 2023 10:20:53 -0400
X-MC-Unique: omIYwGVnMVStkXOkagg0rQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-bc9483b506fso777415276.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jun 2023 07:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686752453; x=1689344453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXku3YB8jZRDn1PVtMCllG5PapuVlNga2nXVph7/LWk=;
 b=ezYD7Tn8W6zTrPefhIijQznpL6ObBq4j5pNNfNkslHbQSp8lWxpEoQaov+AbgzSGsW
 MdQ0VSAw+CZQcZls0OoWz9q9nr5fFzZAKDV9jk7FU3iYDjqbqLjcJ4dVK+lfviCLrrRs
 GICW359y1db5HzNZC6cAmk7qdM26V/x7+DUR0G18Tc6DuDDzS2TWh8LcF6sYHZosthkY
 IDePIP5f3Knco7PgMZ0+YhxnvHXgINhO7ohqKaDd/dgFe1VXZ01tdKe9yQyG11P+HB7w
 xkW8XKXMDQh8IUT0u/C4lRh80aCMMAf4WCtJqB9A6hzYt/eM0YZXTXMC4PvorDHl7QIq
 Uvpw==
X-Gm-Message-State: AC+VfDwhKSgPfLnXvPkdU+kk5h2rOsEnomTHy9KqzCyce3GpqQiXQgdr
 h0v7Vjtd56sZIC8M12nNfIu6vsyvCCboQJTVJ1OeldW/Ww49vs01FIDrzxWzcqeGApaswMQAlwC
 rjPx2MI2ayoHuNXoZMV0/l9afRZHVQWx+Xd9mhQUq5w==
X-Received: by 2002:a25:ae57:0:b0:bc9:92c9:7fd1 with SMTP id
 g23-20020a25ae57000000b00bc992c97fd1mr2036294ybe.3.1686752452993; 
 Wed, 14 Jun 2023 07:20:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55c4UJLMpZucuKbY6+TCCYSBjctZCn+vU6/vzdkwA5/zCwTGxJVt7jQHO4SoPbkTdGrqyhIw==
X-Received: by 2002:a25:ae57:0:b0:bc9:92c9:7fd1 with SMTP id
 g23-20020a25ae57000000b00bc992c97fd1mr2036256ybe.3.1686752452550; 
 Wed, 14 Jun 2023 07:20:52 -0700 (PDT)
Received: from redhat.com ([172.58.139.140]) by smtp.gmail.com with ESMTPSA id
 e71-20020a25694a000000b00bd586162582sm646086ybc.53.2023.06.14.07.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 07:20:52 -0700 (PDT)
Date: Wed, 14 Jun 2023 10:20:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Can vhost translate to io_uring?
Message-ID: <20230614101951-mutt-send-email-mst@kernel.org>
References: <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
 <cfbf1a0d-5d62-366f-f32f-6c63b151489e@oracle.com>
 <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
In-Reply-To: <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, brauner@kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info, stefanha@redhat.com,
 nicolas.dichtel@6wind.com, virtualization@lists.linux-foundation.org,
 torvalds@linux-foundation.org
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

On Wed, Jun 14, 2023 at 01:02:58AM -0500, Eric W. Biederman wrote:
> 
> I am sad my idea for simplifying things did not work out.
> 
> 
> Let's try an even bigger idea to reduce maintenance and simplify things.
> 
> Could vhost depend on io_uring?
> 
> Could vhost just be a translation layer of existing vhost requests to
> io_uring requests?

I expect that's going to have a measureable performance impact.

> At a quick glance it looks like io_uring already supports the
> functionality that vhost supports (which I think is networking and
> scsi).
> 
> If vhost could become a translation layer that would allow removing
> the vhost worker and PF_USER_WORKER could be removed completely,
> leaving only PF_IO_WORKER.
> 
> 
> I suggest this because a significant vhost change is needed because in
> the long term the hacks in exec and coredump are not a good idea.  Which
> means something like my failed "[PATCH v3] fork, vhost: Use CLONE_THREAD
> to fix freezer/ps regression".
> 
> If we have to go to all of the trouble of reworking things it why can't
> we just make io_uring do all of the work?
> 
> Eric

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
