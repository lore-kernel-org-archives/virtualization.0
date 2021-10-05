Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA60FC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:38:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FC66121F
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 07:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98FC66121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48033606E2;
	Tue,  5 Oct 2021 07:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f_z5ZM1MqI3t; Tue,  5 Oct 2021 07:38:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96043608E2;
	Tue,  5 Oct 2021 07:38:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64827C000F;
	Tue,  5 Oct 2021 07:38:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61BB9C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3946D83C76
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q9pEqj-F0DXg
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:38:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A08C83C5C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633419504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtTBfJ7umQKOo9c4zQtEMAqccC4CaaUVFj0BPcVpmPk=;
 b=XiJlvClezweNM6eqgBAgka1GbG0/XUBZCiCbFpQ/qYJ9/NMvGQiXq6uYNtK5WDT7AIglRk
 MeBdAmWd9pn+yzlyrSydXIsYJV6fpBh3Ly9e9zJsc6/8U5gEM1jWAVrRprzRTwDBxwA1Kq
 +yoNxUlqZ6s8lgKxrIXFgoTIb5Ue1Ww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-N9l1X2KRMuymU2ciTndIsQ-1; Tue, 05 Oct 2021 03:38:21 -0400
X-MC-Unique: N9l1X2KRMuymU2ciTndIsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F331DA40C0;
 Tue,  5 Oct 2021 07:38:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D750F18A50;
 Tue,  5 Oct 2021 07:38:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
In-Reply-To: <20211004160005-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
 <20211004160005-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Tue, 05 Oct 2021 09:38:05 +0200
Message-ID: <87r1cz2a76.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Xie Yongji <xieyongji@bytedance.com>, virtio-dev@lists.oasis-open.org
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

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 05:45:06PM +0200, Cornelia Huck wrote:
>> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
>> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > Do we want to also add explanation that features can be
>> >> > changed until FEATURES_OK?
>> >> 
>> >> I always considered that to be implict, as feature negotiation is not
>> >> over until we have FEATURES_OK. Not sure whether we need an extra note.
>> >
>> > Well Halil here says once you set a feature bit you can't clear it.
>> > So maybe not ...
>> 
>> Ok, so what about something like
>> 
>> "If FEATURES_OK is not set, the driver MAY change the set of features it
>> accepts."
>> 
>> in the device initialization section?
>
> Maybe "as long as". However Halil implied that some features are not
> turned off properly if that happens. Halil could you pls provide
> some examples?

Yes, "as long as" sounds better.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
