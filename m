Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7892EC433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:46:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331EE6137C
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 15:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 331EE6137C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0450C84C0E;
	Mon,  4 Oct 2021 15:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AtbEVyJjxWCv; Mon,  4 Oct 2021 15:46:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8278484C13;
	Mon,  4 Oct 2021 15:46:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 502E2C0011;
	Mon,  4 Oct 2021 15:46:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DC8EC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62369607AC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3AL1XIdET-bk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:46:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76AF86064B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633362365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/kgxHPxpLf6tZjNevWzK9k9Z43+ZiXIpJpi5hdMq0z0=;
 b=XMRbuasuWMdRdkkTewCKD9xn++bEitVkX/DV/+ByfyKYchlmDfmeArCSWl4769uAIfAwjL
 nRgiDnA7cnybwZM/n7XMN1fpeSttMSWi7kLMRXh2b1FS2hERcivK5jxM4k0y/neQLvdVWZ
 pW7QZqXZkCeD/nVxHoo7W84KSfiSNtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-x44U3w48N9KR2IkCHQKonA-1; Mon, 04 Oct 2021 11:46:02 -0400
X-MC-Unique: x44U3w48N9KR2IkCHQKonA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 341D58F51C;
 Mon,  4 Oct 2021 15:46:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21AE36B544;
 Mon,  4 Oct 2021 15:45:08 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
In-Reply-To: <20211004110152-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Mon, 04 Oct 2021 17:45:06 +0200
Message-ID: <87zgro23r1.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

> On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
>> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
>> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
>> >> >  Specification text within these sections generally does not apply
>> >> >  to non-transitional devices.
>> >> >  
>> >> > +\begin{note}
>> >> > +The device offers different features when used through
>> >> > +the legacy interface and when operated in accordance with this
>> >> > +specification.
>> >> > +\end{note}
>> >> > +
>> >> > +Transitional drivers MUST use Devices only through the legacy interface
>> >> 
>> >> s/Devices only through the legacy interface/devices through the legacy
>> >> interface only/
>> >> 
>> >> ?
>> >
>> > Both versions are actually confused, since how do you
>> > find out that device does not offer VIRTIO_F_VERSION_1?
>> >
>> > I think what this should really say is
>> >
>> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
>> > the legacy interface.
>> 
>> Ok, that makes sense.
>> 
>> Would it make sense that transitional drivers MUST accept VERSION_1
>> through the non-legacy interface? Or is that redundant?
>
> We already have:
>
> A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.

Yep, so it is redundant.

>
>
>> >
>> >
>> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
>> > through the legacy interface if offered?
>> 
>> I think that the Linux drivers will not operate on feature bit 32+ if
>> they are in legacy mode?
>
>
> Well ... with PCI there's no *way* for host to set bit 32 through
> legacy. But it might be possible with MMIO/CCW. Can you tell me
> what happens then?

ccw does not support accessing bit 32+, either. Not sure about mmio.

>
>
>> >> 
>> >> Generally, looks good to me.
>> >
>> > Do we want to also add explanation that features can be
>> > changed until FEATURES_OK?
>> 
>> I always considered that to be implict, as feature negotiation is not
>> over until we have FEATURES_OK. Not sure whether we need an extra note.
>
> Well Halil here says once you set a feature bit you can't clear it.
> So maybe not ...

Ok, so what about something like

"If FEATURES_OK is not set, the driver MAY change the set of features it
accepts."

in the device initialization section?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
