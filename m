Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD666C433DF
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:08:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74552073A
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 13:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJM2otlY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74552073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78F4685D39;
	Mon, 10 Aug 2020 13:08:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a_ynO3XNWEGn; Mon, 10 Aug 2020 13:08:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F17985B4D;
	Mon, 10 Aug 2020 13:08:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FAFBC0864;
	Mon, 10 Aug 2020 13:08:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD061C004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A9EA285B4D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UDFdRxwoXez9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:08:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A7CE85A76
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597064904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbpPyMxeUTZufAlT4TB0KbZ9dM5w1NZ9B6YwnpXi1/s=;
 b=hJM2otlYUoPY7VxeCg+9S/SuDdXK/EMb63r95YBavEpwFYYx2bHe7xw5vabFMzkA9bv3aG
 GO+rnV5h9LFmhpGEzzGShn29p21HXvBnVGFrRX+y6S4jLgkre3rLGiwT2g0SAsWo7octz4
 xzEhTG6JX1B3/EzsojREJRmGfBPmSv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-bwrUS9gAOm6o0zWQN2BguA-1; Mon, 10 Aug 2020 09:08:21 -0400
X-MC-Unique: bwrUS9gAOm6o0zWQN2BguA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B63918A0F03;
 Mon, 10 Aug 2020 13:08:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.10.115.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5EAE10013C2;
 Mon, 10 Aug 2020 13:08:10 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 3286022036A; Mon, 10 Aug 2020 09:08:09 -0400 (EDT)
Date: Mon, 10 Aug 2020 09:08:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
 Dan Williams <dan.j.williams@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/20] virtiofs: Add DAX support
Message-ID: <20200810130809.GA455528@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <CAJfpegtboe-XssmqrcvsJm1R0FBP8fYFrTMv5cuBhfmebiGfQw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpegtboe-XssmqrcvsJm1R0FBP8fYFrTMv5cuBhfmebiGfQw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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

On Mon, Aug 10, 2020 at 09:29:47AM +0200, Miklos Szeredi wrote:
> On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> 
> > Most of the changes are limited to fuse/virtiofs. There are couple
> > of changes needed in generic dax infrastructure and couple of changes
> > in virtio to be able to access shared memory region.
> 
> So what's the plan for merging the different subsystems?  I can take
> all that into the fuse tree, but would need ACKs from the respective
> maintainers.

I am assuming for DAX patches we need ACK from Dan Williams and for
virtio patches we need ack from Michael S. Tsirkin.

Dan, Michael, can you please review the dax and virtio patches
respectively and if there are no concerns, please provide ACK. Or
suggest an alternative way of how these patches can be merged.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
