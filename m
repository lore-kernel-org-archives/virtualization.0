Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFEC433EF
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 16:25:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638BA61245
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 16:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 638BA61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B6CD84144;
	Thu,  7 Oct 2021 16:25:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUzhic-nPtCW; Thu,  7 Oct 2021 16:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CDF62840D0;
	Thu,  7 Oct 2021 16:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94E2FC0011;
	Thu,  7 Oct 2021 16:25:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB4B7C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF9FA40976
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WDhgPO5rD5rx
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A87A14091E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633623922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kbk2lcxg9O2Y1a76hO9mtdUGaa5nIQDze4u6D1O12E=;
 b=PkHT6QrRFZHi8wg+5gLEvlzDKpgeuFejFwvg0IIjD0WDxGG/a/ec+JTboWjAq1iN7GHxfd
 1awDTHsp5cjn8DdTnJm1ObPpb2lPpOqPteiVDqeNMVP5qlvklUP81jdcopuojVCzuJQfBo
 hqp8xskq7MM+KJrbPjmVCXbgwqei6lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-SUq8qOLJPw6XCB59yiXLGA-1; Thu, 07 Oct 2021 12:25:18 -0400
X-MC-Unique: SUq8qOLJPw6XCB59yiXLGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9546111EB683;
 Thu,  7 Oct 2021 16:17:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6506671B90;
 Thu,  7 Oct 2021 16:16:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio: write back F_VERSION_1 before validate
In-Reply-To: <20211007175242.4b0155b8.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211006142533.2735019-1-pasic@linux.ibm.com>
 <875yu9yruv.fsf@redhat.com> <20211007163255.61d95513.pasic@linux.ibm.com>
 <8735pczwjj.fsf@redhat.com> <20211007175242.4b0155b8.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Thu, 07 Oct 2021 18:16:16 +0200
Message-ID: <87wnmoyfn3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
 Xie Yongji <xieyongji@bytedance.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
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

On Thu, Oct 07 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 07 Oct 2021 17:25:52 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Thu, Oct 07 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
>> 
>> > On Thu, 07 Oct 2021 13:52:24 +0200
>> > Cornelia Huck <cohuck@redhat.com> wrote:
>> >  
>> >> On Wed, Oct 06 2021, Halil Pasic <pasic@linux.ibm.com> wrote:
>> >>   
>> >> > The virtio specification virtio-v1.1-cs01 states: "Transitional devices
>> >> > MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
>> >> > been acknowledged by the driver."  This is exactly what QEMU as of 6.1
>> >> > has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
>> >> >
>> >> > However, the specification also says: "... driver MAY read (but MUST NOT
>> >> > write) the device-specific configuration fields to check that it can
>> >> > support the device ..." before setting FEATURES_OK.    
>> >> 
>> >> Suggest to put the citations from the spec into quotes, so that they are
>> >> distinguishable from the rest of the text.  
>> >
>> > For the record: I basically took Michael's description, the one which you
>> > said you prefer, with some minor changes.  
>> 
>> Well I did look at what the text said, not the details in the formatting...
>> 
>> >
>> > This is one of the changes, which renders this a paraphrase and not a
>> > quote. Michael didn't use quotation marks so I was not sure it is was
>> > a word by word quote anyway. It was. But the spec depends on "During this
>> > step" which does not make any sense without the context. That is why I made
>> > the end of step explicit.  
>> 
>> I still think that would be nicer while using some quotation marks, even
>> if you are just doing a partial quote.
>> 
>> In the first paragraph, however, we really should mark the quote
>> properly. It gave me a stop when I first read it.
>
> I've added in some quotation marks and ellipsis marks. Does that look
> good for you?

Yep, works for me.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
