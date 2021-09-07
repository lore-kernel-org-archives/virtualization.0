Return-Path: <SRS0=fvq/=N5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC1C433FE
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 18:11:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BB660ED8
	for <virtualization@archiver.kernel.org>; Tue,  7 Sep 2021 18:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58BB660ED8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DBD64038A;
	Tue,  7 Sep 2021 18:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rYY-uc4UPrtk; Tue,  7 Sep 2021 18:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB15340356;
	Tue,  7 Sep 2021 18:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC94C0011;
	Tue,  7 Sep 2021 18:11:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57560C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 18:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 38F1540155
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 18:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i80PKtXW1Azy
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 18:10:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0AF8F40019
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631038256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ZQ77LfQrAYIlW/IP+7FgGcr5kmtkI9421/WQcrZKBc=;
 b=PDqoEJaDSgD5wWJxrQ0fSicyxUoLjnUootSHY0CFD+z9TXY46LgJpAdMrOipWW23rBBXDa
 BHHCPbio3wdGiW2sCILShtHRoqilofgumQFvZeF7rvSmTx5F6mh0B/fVeUf32B8Fsk6b++
 7laXhwOwXLS6wFdvZrr4I0EExb2XQn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-TxqX7602Pjijwm8cjH2BZA-1; Tue, 07 Sep 2021 14:10:55 -0400
X-MC-Unique: TxqX7602Pjijwm8cjH2BZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 223B8425D9;
 Tue,  7 Sep 2021 18:10:54 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AA475D9CA;
 Tue,  7 Sep 2021 18:10:48 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 9E36E220257; Tue,  7 Sep 2021 14:10:47 -0400 (EDT)
Date: Tue, 7 Sep 2021 14:10:47 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 2/2] virtiofs: reduce lock contention on fpq->lock
Message-ID: <YTerJ1bvGSfOYjBY@redhat.com>
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
 <20210812054618.26057-3-jefflexu@linux.alibaba.com>
 <CAJfpegt48RM_y7mOj5EBcohF0zEmE4D6D7sHNgYgKNgGqDgTsA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpegt48RM_y7mOj5EBcohF0zEmE4D6D7sHNgYgKNgGqDgTsA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, linux-fsdevel@vger.kernel.org,
 Liu Bo <bo.liu@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Sep 07, 2021 at 10:57:07AM +0200, Miklos Szeredi wrote:
> On Thu, 12 Aug 2021 at 07:46, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >
> > From: Liu Bo <bo.liu@linux.alibaba.com>
> >
> > Since %req has been removed from fpq->processing_list, no one except
> > request_wait_answer() is looking at this %req and request_wait_answer()
> > waits only on FINISH flag, it's OK to remove fpq->lock after %req is
> > dropped from the list.
> 
> I'll accept a patch to remove FR_SENT completely from virtiofs.
> 

Recently I was also looking at FR_SENT flag and was wondering if it
is atomic bit flag, then why do we need to take spin lock around it.
Probably we need just some barrier if code needs it but not necessarily
any lock.

But I agree that FR_SENT seems not usable from virtiofs point of view
as we don't have support for interrupt request.

> This flag is used for queuing interrupts but interrupts are not yet
> implemented in virtiofs.    When blocking lock support is added the
> interrupt handling needs to be properly designed.

Hmm.., I did not think about this. I was getting ready to post patches
for blocking posix locks but it does not have any support for interrupting
the locking request (either blocked or queued).

Is implementing interrupt support a requirement for getting blocking
posix lock patches in?

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
