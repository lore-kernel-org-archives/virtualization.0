Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A44C433FE
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 10:13:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A0B76113A
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 10:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A0B76113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E935F4040B;
	Wed,  6 Oct 2021 10:13:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4pp4k6kRn6Z4; Wed,  6 Oct 2021 10:13:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9ABF9403F2;
	Wed,  6 Oct 2021 10:13:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69DA7C000F;
	Wed,  6 Oct 2021 10:13:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78092C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 10:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A6C740400
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 10:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T7wtjNVoSESQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 10:13:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34B61401D9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 10:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633515229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BECcZUCAGMep+whlUisrU7fulE9mw4zRy9eJJZW+/n0=;
 b=e7VEch9W3XvDswY2TfUHiy7Itfl70bfC74f9kal2/FQ1AHn88bDTO42Ero4EH7GV5UV9yy
 EjqqBHExLNw7SnmEYWxjDqxeGVBCHTluaPp4MYdxX9AMXYlQafD+0WuywCdjuFgaQoSTEr
 DcSbvHdh9B3LTQVEFjK5QqWp7VaT68k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Nx9lqvL7MEqHQKJ-9FBbkw-1; Wed, 06 Oct 2021 06:13:48 -0400
X-MC-Unique: Nx9lqvL7MEqHQKJ-9FBbkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FF4D1006AA2;
 Wed,  6 Oct 2021 10:13:46 +0000 (UTC)
Received: from localhost (unknown [10.39.193.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF4725FC13;
 Wed,  6 Oct 2021 10:13:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004151408-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
 <20211004110537-mutt-send-email-mst@kernel.org>
 <87wnms23hn.fsf@redhat.com>
 <20211004151408-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Wed, 06 Oct 2021 12:13:14 +0200
Message-ID: <87sfxezcjp.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Halil Pasic <pasic@linux.ibm.com>, Xie Yongji <xieyongji@bytedance.com>
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

> On Mon, Oct 04, 2021 at 05:50:44PM +0200, Cornelia Huck wrote:
>> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
>> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
>> >> >> 
>> >> >> [cc:qemu-devel]
>> >> >> 
>> >> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> >> 
>> >> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
>> >> >> > compatible device must use LE.
>> >> >> > It can also present a legacy config space where the
>> >> >> > endian depends on the guest.
>> >> >> 
>> >> >> So, how is the virtio core supposed to determine this? A
>> >> >> transport-specific callback?
>> >> >
>> >> > I'd say a field in VirtIODevice is easiest.
>> >> 
>> >> The transport needs to set this as soon as it has figured out whether
>> >> we're using legacy or not.
>> >
>> > Basically on each device config access?
>> 
>> Prior to the first one, I think. It should not change again, should it?
>
> Well yes but we never prohibited someone from poking at both ..
> Doing it on each access means we don't have state to migrate.

Yes; if it isn't too high overhead, that's probably the safest way to
handle it.

>
>> >
>> >> I guess we also need to fence off any
>> >> accesses respectively error out the device if the driver tries any
>> >> read/write operations that would depend on that knowledge?
>> >> 
>> >> And using a field in VirtIODevice would probably need some care when
>> >> migrating. Hm...
>> >
>> > It's just a shorthand to minimize changes. No need to migrate I think.
>> 
>> If we migrate in from an older QEMU, we don't know whether we are
>> dealing with legacy or not, until feature negotiation is already
>> done... don't we have to ask the transport?
>
> Right but the only thing that can happen is config access.

Checking on each config space access would be enough then.

> Well and for legacy a kick I guess.

I think any driver that does something that is not config space access,
status access, or feature bit handling without VERSION_1 being set is
neccessarily legacy? Does that really need special handling?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
