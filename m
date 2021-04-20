Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A19C433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 16:41:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D76613CE
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 16:41:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D76613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 093D640235;
	Tue, 20 Apr 2021 16:41:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id atgC3hIDxHWN; Tue, 20 Apr 2021 16:41:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id ADA13401F5;
	Tue, 20 Apr 2021 16:41:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 813B2C000F;
	Tue, 20 Apr 2021 16:41:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16141C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 16:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB74C6086C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 16:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1LnGbYxforR8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 16:41:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C30860635
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618936881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvM6oaWg7r5AvRTXlx0P39Yy1ui/9+szAD2FRD6gYK4=;
 b=I+G9ATkx7ZpdtiA4gROwQuRIEMUAMMplqc7XD+LxCylQm7LFrA90NAMA559AMgN1X4YDSl
 2RdfA4dDg7PN2XUxzc+uWqCAvkDjfuMZc3zzQTeHy3959MQ9cxAHLngN0dU4YPUKgLDZjx
 G1mOCQkE9ju5jYaeW46s3fn5v/8DpZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-MnZj6cj8MVmVEaxWH4DIKQ-1; Tue, 20 Apr 2021 12:41:18 -0400
X-MC-Unique: MnZj6cj8MVmVEaxWH4DIKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEF3E80BCA6;
 Tue, 20 Apr 2021 16:41:16 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-244.ams2.redhat.com
 [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D43195D9C0;
 Tue, 20 Apr 2021 16:41:08 +0000 (UTC)
Date: Tue, 20 Apr 2021 18:41:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio_blk: Add support for lifetime feature
Message-ID: <20210420184106.3f9c5464.cohuck@redhat.com>
In-Reply-To: <20210420060807-mutt-send-email-mst@kernel.org>
References: <20210416194709.155497-1-egranata@google.com>
 <20210420070129.GA3534874@infradead.org>
 <20210420060807-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, stefanha@redhat.com,
 pbonzini@redhat.com, Enrico Granata <egranata@google.com>
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

On Tue, 20 Apr 2021 06:08:29 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 20, 2021 at 08:01:29AM +0100, Christoph Hellwig wrote:
> > Just to despit my 2 cents again:  I think the way this is specified
> > in the virtio spec is actively harmful and we should not suport it in
> > Linux.
> > 
> > If others override me we at least need to require a detailed
> > documentation of these fields as the virto spec does not provide it.
> > 
> > Please also do not add pointless over 80 character lines, and follow
> > the one value per sysfs file rule.  
> 
> Enrico would you like to raise the issues with the virtio TC
> for resolution?
> 

FWIW, I've opened https://github.com/oasis-tcs/virtio-spec/issues/106
to track this.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
