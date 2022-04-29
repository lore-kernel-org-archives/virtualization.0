Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9499C433F5
	for <virtualization@archiver.kernel.org>; Fri, 29 Apr 2022 07:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 740B260AD3;
	Fri, 29 Apr 2022 07:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F90i33IkzPht; Fri, 29 Apr 2022 07:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0691560AAA;
	Fri, 29 Apr 2022 07:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C343EC0032;
	Fri, 29 Apr 2022 07:25:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D2ABC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E62DA41C8F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FeaCZZOJT48M
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0891241C8B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 07:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651217121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XuyJmYFKz55Z9M8Cl2OBjrpxRlj1BN0WJexIrt3fWo0=;
 b=JENwA0inVJa2rtr9Sl/1jiGsog+aDqlTpXluoPN9PEGwxzOu9SmbgUXs59Oz2Q9FPCakxz
 //krM5Q83BCObc7kaP8FnacqTKgY7/0w8dy3xaVdviTyEFgjeqVJRfHRuCjr9f1RfmiwaR
 lDy0IfeUIrb2y02RhWdOzOGL0INsWr0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-bt6FmOATPuK0MAPIlheEJg-1; Fri, 29 Apr 2022 03:25:15 -0400
X-MC-Unique: bt6FmOATPuK0MAPIlheEJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AA8D1014A61;
 Fri, 29 Apr 2022 07:25:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5B4714152FA;
 Fri, 29 Apr 2022 07:25:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring
 callbacks
In-Reply-To: <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-4-jasowang@redhat.com> <87r15hlgel.fsf@redhat.com>
 <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Fri, 29 Apr 2022 09:25:13 +0200
Message-ID: <87ilqsl5ba.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Apr 29 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Thu, Apr 28, 2022 at 5:13 PM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:
>>
>> > This patch introduces new virtio config op to vring
>> > callbacks. Transport specific method is required to make sure the
>> > write before this function is visible to the vring_interrupt() that is
>>
>> Which kind of writes? I.e., what is the scope?
>
> Any writes before synchronize_cbs(). Is something like the following better?
>
> The function guarantees that all memory operations before it are
> visible to the vring_interrupt() that is called after it.

Maybe "all memory operations on the queue"?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
