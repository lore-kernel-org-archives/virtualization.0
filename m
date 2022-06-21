Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C8AC43334
	for <virtualization@archiver.kernel.org>; Tue, 21 Jun 2022 09:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9451483EA9;
	Tue, 21 Jun 2022 09:58:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9451483EA9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SnKPglmi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DUDw5HdpHrds; Tue, 21 Jun 2022 09:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A6F082F9E;
	Tue, 21 Jun 2022 09:58:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A6F082F9E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCDB6C0032;
	Tue, 21 Jun 2022 09:58:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4973C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CD3A41900
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:58:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CD3A41900
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SnKPglmi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r4jNTUM6GLdn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EFDD418FB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EFDD418FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 09:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655805508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H4C/sB5um4hN9/XHAJjRJCQS2mg0bGELmgXp1B2D5DI=;
 b=SnKPglmiRnjfL0kweB63w93nV7KvirobonvhqyRxpoRrG+EZLsAZC7kRBhxOQsfeUciaXV
 uN1JdjjlJLAyi0PAX9v0MLmJFyCO7RivSk5IVjV0zmXgZbWaYxm7PRv02iBfBCWoemftbV
 wokibeTAboSZ6mSwblTncQO/d5GnnBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-88tBitKPN0CK2RYLsijSLA-1; Tue, 21 Jun 2022 05:58:21 -0400
X-MC-Unique: 88tBitKPN0CK2RYLsijSLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F208F101E9BC;
 Tue, 21 Jun 2022 09:58:20 +0000 (UTC)
Received: from localhost (unknown [10.39.193.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F16F1121314;
 Tue, 21 Jun 2022 09:58:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] virtio: disable notification hardening by default
In-Reply-To: <CACGkMEun6C9RgQVGq1B8BJMd9DyRQkSXj8shXVVhDymQYQLxgA@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220620024158.2505-1-jasowang@redhat.com>
 <87y1xq8jgw.fsf@redhat.com>
 <CACGkMEun6C9RgQVGq1B8BJMd9DyRQkSXj8shXVVhDymQYQLxgA@mail.gmail.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date: Tue, 21 Jun 2022 11:58:19 +0200
Message-ID: <87sfny8hj8.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Cc: linux-s390@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
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

On Tue, Jun 21 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Tue, Jun 21, 2022 at 5:16 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> The ifdeffery looks a big ugly, but I don't have a better idea.
>
> I guess you meant the ccw part, I leave the spinlock here in V1, but
> Michael prefers to have that.

Not doing the locking dance is good; I think the #ifdefs all over are a
bit ugly, but as I said, I can't think of a good, less-ugly way...

> In the future, we may consider removing that, one possible way is to
> have a per driver boolean for the hardening.

As in "we've reviewed and tested this driver, so let's turn it on for
every device bound to it"?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
