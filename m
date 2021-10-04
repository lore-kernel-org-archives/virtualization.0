Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C296C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149E261372
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 14:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 149E261372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D028A404B6;
	Mon,  4 Oct 2021 14:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EDOxIE6uOrq6; Mon,  4 Oct 2021 14:27:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 938F640449;
	Mon,  4 Oct 2021 14:27:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 532C9C000F;
	Mon,  4 Oct 2021 14:27:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2629C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D579760BE5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:27:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wqiUeEBsBuz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:27:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE2F560BAF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633357650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LIG9qMDkxH/Rmc/0k4eqilgYZwh4mc9sxcj/N2tODz8=;
 b=Q27OUBO2+dSYbizClPbliUwHadEfiFEnDRDkDBXjGeKyEw8086N59buAT4O5cKpSTC3h7g
 uQqFsiyRmh0cy7sWCUXoY6rk8vgzk2nEKBjw7KV/XizCSiY/KYEwe/XqKuMxI6fDfEzlBG
 8zhUTUCYuHfC32Q1s/+Lwbh87WwC3bI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-7_cAvUANPKCmXPubGlravA-1; Mon, 04 Oct 2021 10:27:27 -0400
X-MC-Unique: 7_cAvUANPKCmXPubGlravA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 296B484A602;
 Mon,  4 Oct 2021 14:27:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C8C45C1CF;
 Mon,  4 Oct 2021 14:27:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004083455-mutt-send-email-mst@kernel.org>
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
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Mon, 04 Oct 2021 16:27:23 +0200
Message-ID: <878rz83lx0.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

> On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
>> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
>> >  Specification text within these sections generally does not apply
>> >  to non-transitional devices.
>> >  
>> > +\begin{note}
>> > +The device offers different features when used through
>> > +the legacy interface and when operated in accordance with this
>> > +specification.
>> > +\end{note}
>> > +
>> > +Transitional drivers MUST use Devices only through the legacy interface
>> 
>> s/Devices only through the legacy interface/devices through the legacy
>> interface only/
>> 
>> ?
>
> Both versions are actually confused, since how do you
> find out that device does not offer VIRTIO_F_VERSION_1?
>
> I think what this should really say is
>
> Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> the legacy interface.

Ok, that makes sense.

Would it make sense that transitional drivers MUST accept VERSION_1
through the non-legacy interface? Or is that redundant?

>
>
> Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> through the legacy interface if offered?

I think that the Linux drivers will not operate on feature bit 32+ if
they are in legacy mode?

>> 
>> Generally, looks good to me.
>
> Do we want to also add explanation that features can be
> changed until FEATURES_OK?

I always considered that to be implict, as feature negotiation is not
over until we have FEATURES_OK. Not sure whether we need an extra note.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
