Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A0BECAAA1
	for <virtualization@archiver.kernel.org>; Mon, 31 Oct 2022 00:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B3E440156;
	Mon, 31 Oct 2022 00:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B3E440156
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YAOkHuvo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3vGpDull4iNJ; Mon, 31 Oct 2022 00:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1449C400D1;
	Mon, 31 Oct 2022 00:34:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1449C400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF0BCC0032;
	Mon, 31 Oct 2022 00:34:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44496C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 00:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1084240243
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 00:34:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1084240243
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YAOkHuvo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f0o_mbJN_L8J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 00:34:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D462D4019D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D462D4019D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 00:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667176470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nK9JUhdTgb0upsG9+KDhCEy0NCFqRXTlysqwPYilhWA=;
 b=YAOkHuvoxVgFDV1ORE2nnkamdG2v/rELdhRKqkkKalIaQS5eH9B0dMJPYLrKgbRtRog7hA
 Ho33r9d3DvQrAndqLvypj/vxKy82Vf4/iZZyMzmKgXF9KvMxnlY85tYkYT3YXm3CH1sxHL
 q4O3Ywp325b2QSl2RpLw7ViH7kquCtA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-YEHptREUO1WcTj8qR0PADA-1; Sun, 30 Oct 2022 20:34:27 -0400
X-MC-Unique: YEHptREUO1WcTj8qR0PADA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E12BC185A792;
 Mon, 31 Oct 2022 00:34:26 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 140431759E;
 Mon, 31 Oct 2022 00:34:21 +0000 (UTC)
Date: Mon, 31 Oct 2022 08:34:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH V3 1/1] blk-mq: avoid double ->queue_rq() because of
 early timeout
Message-ID: <Y18YCBE/oCvM1+IA@T590>
References: <20221026051957.358818-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221026051957.358818-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: David Jeffery <djeffery@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>
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

On Wed, Oct 26, 2022 at 01:19:57PM +0800, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> David Jeffery found one double ->queue_rq() issue, so far it can
> be triggered in VM use case because of long vmexit latency or preempt
> latency of vCPU pthread or long page fault in vCPU pthread, then block
> IO req could be timed out before queuing the request to hardware but after
> calling blk_mq_start_request() during ->queue_rq(), then timeout handler
> may handle it by requeue, then double ->queue_rq() is caused, and kernel
> panic.
> 
> So far, it is driver's responsibility to cover the race between timeout
> and completion, so it seems supposed to be solved in driver in theory,
> given driver has enough knowledge.
> 
> But it is really one common problem, lots of driver could have similar
> issue, and could be hard to fix all affected drivers, even it isn't easy
> for driver to handle the race. So David suggests this patch by draining
> in-progress ->queue_rq() for solving this issue.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V3:
> 	- add callback for handle expired only, suggested by Keith Busch

Hi Jens,

Any chance to merge this fix? Either 6.1 or 6.2 is fine for me.


Thanks,
Ming

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
