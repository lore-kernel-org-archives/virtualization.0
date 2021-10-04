Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6953EC433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 09:51:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238C2610A2
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 09:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 238C2610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD3BB84B72;
	Mon,  4 Oct 2021 09:51:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WFDesAD5G8l1; Mon,  4 Oct 2021 09:51:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89C2484B78;
	Mon,  4 Oct 2021 09:51:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E006C0011;
	Mon,  4 Oct 2021 09:51:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F451C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 103054061D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ki14PcCh1vU6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:51:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B8284039E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 09:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633341097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=11lDRR5Yz28JFxRtHvrquBSIh5tMxQHAlBJP5+qYWSo=;
 b=DHWBpIMySfcR2f34HYwHLXAqDbZ7a++6s9liwrPFBsGZ0LsMLTV/6c0ShUgiPCjxdAWE0k
 mxIAbSLizVyzKCIUX1+PCsCok6iL1egx4qfVoRgsOp3g2HEXjDLeV7R/74VrjrAl+h+Olp
 tRCjKztEA3Eu76TzajUFMSvA0xb3d9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-TsrUeYovNKGhF15TjTdcUg-1; Mon, 04 Oct 2021 05:51:35 -0400
X-MC-Unique: TsrUeYovNKGhF15TjTdcUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B63E8015C7;
 Mon,  4 Oct 2021 09:51:34 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 154DC60657;
 Mon,  4 Oct 2021 09:51:29 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004112528.74442e52.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <87pmsl2rzd.fsf@redhat.com> <20211004112528.74442e52.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Mon, 04 Oct 2021 11:51:28 +0200
Message-ID: <87mtnp2k4f.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Xie Yongji <xieyongji@bytedance.com>,
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

On Mon, Oct 04 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 04 Oct 2021 09:01:42 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Fri, Oct 01, 2021 at 05:18:46PM +0200, Cornelia Huck wrote:  
>> >> I'd say we need a hack here so that we assume little-endian config space
>> >> if VERSION_1 has been offered; if your patch here works, I assume QEMU
>> >> does what we expect (assmuming little-endian as well.) I'm mostly
>> >> wondering what happens if you use a different VMM; can we expect it to
>> >> work similar to QEMU?  
>> >
>> > Hard to say of course ... hopefully other VMMs are actually
>> > implementing the spec. E.g. IIUC rust vmm is modern only.  
>> 
>> Yes, I kind of hope they are simply doing LE config space accesses.
>> 
>> Are there any other VMMs that are actually supported on s390x (or other
>> BE architectures)?
>> 
>
> I think zCX (z/OS Container Extensions) is relevant as it uses virtio.
> That is all I know about.

Ok, I'll assume that you (IBM) will be able to verify that any fixup
will continue to work there.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
