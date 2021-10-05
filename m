Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C5EC433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:14:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D637D6128A
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D637D6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04EAC80024;
	Tue,  5 Oct 2021 11:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f9PM253FmyaY; Tue,  5 Oct 2021 11:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F45383CE1;
	Tue,  5 Oct 2021 11:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F62CC000F;
	Tue,  5 Oct 2021 11:14:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE9EDC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B0CED60679
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9TFtlEAUx_T
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40AEB60624
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633432435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l9NIjeIAQCFxtj6GGh0Whhg4tP/fsFPSi3algChPtGc=;
 b=MQr7hp8zB8W55b6ANOCl0DCKrGIAwn3eJN415O+lwsL3juWdkuEHsKX1jnN0I5zXUFECeU
 ngnXFjU8hOe8HYVDN9JTUnxOZoJ2IuoHNX1Ao7lWYuD4e55BpLtzHuSbawKhn7gtEbORq8
 ZP20suMnu416OdipnnlMrW+45yaDoZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-SJRXkDwFOOWPwxdT0Az79Q-1; Tue, 05 Oct 2021 07:13:54 -0400
X-MC-Unique: SJRXkDwFOOWPwxdT0Az79Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86271006AA2;
 Tue,  5 Oct 2021 11:13:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA34B1036B32;
 Tue,  5 Oct 2021 11:13:38 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211005124303.3abf848b.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
 <20211005124303.3abf848b.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Tue, 05 Oct 2021 13:13:31 +0200
Message-ID: <87lf372084.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Xie Yongji <xieyongji@bytedance.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
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

On Tue, Oct 05 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 4 Oct 2021 05:07:13 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> Well we established that we can know. Here's an alternative explanation:
>
>
> I thin we established how this should be in the future, where a transport
> specific mechanism is used to decide are we operating in legacy mode or
> in modern mode. But with the current QEMU reality, I don't think so.
> Namely currently the switch native-endian config -> little endian config
> happens when the VERSION_1 is negotiated, which may happen whenever
> the VERSION_1 bit is changed, or only when FEATURES_OK is set
> (vhost-user).
>
> This is consistent with device should detect a legacy driver by checking
> for VERSION_1, which is what the spec currently says.
>
> So for transitional we start out with native-endian config. For modern
> only the config is always LE.
>
> The guest can distinguish between a legacy only device and a modern
> capable device after the revision negotiation. A legacy device would
> reject the CCW.
>
> But both a transitional device and a modern only device would accept
> a revision > 0. So the guest does not know for ccw.

Well, for pci I think the driver knows that it is using either legacy or
modern, no?

And for ccw, the driver knows at that point in time which revision it
negotiated, so it should know that a revision > 0 will use LE (and the
device will obviously know that as well.)

Or am I misunderstanding what you're getting at?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
