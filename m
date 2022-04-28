Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F73C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 09:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30A4E40895;
	Thu, 28 Apr 2022 09:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oX7ic934Zwdq; Thu, 28 Apr 2022 09:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7A46A410A5;
	Thu, 28 Apr 2022 09:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5883FC0039;
	Thu, 28 Apr 2022 09:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 198B7408D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MAXN6yizxneo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:07:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38BF840895
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651136835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9kVeJdDfkB7t2TmQA0Ji3JTf35Unj7NXBdpwyuRWh6Y=;
 b=FsTJQp5JAlXLhVnQkqY4/554i9RMLdYQsIJHHsoH6gaDBmMdnaNw0o+GnhfLARO3T56EiS
 +QSzXjAdMUSzbDR0BjIw6qj8HPZrC2ICnpzsb3qV1fOKQ3GNTy4kmRqZEgyhC6BjQOYOHX
 Rnk7TAwh7aqMbrVy62ama8EY3Xl4aos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-StjCr-X0PCmmEhl6tTuojw-1; Thu, 28 Apr 2022 05:07:11 -0400
X-MC-Unique: StjCr-X0PCmmEhl6tTuojw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6445086B8A1;
 Thu, 28 Apr 2022 09:07:10 +0000 (UTC)
Received: from localhost (unknown [10.39.193.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4E8F401E09;
 Thu, 28 Apr 2022 09:07:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V3 1/9] virtio: use virtio_device_ready() in
 virtio_device_restore()
In-Reply-To: <20220425024418.8415-2-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-2-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Thu, 28 Apr 2022 11:07:06 +0200
Message-ID: <87wnf9lgp1.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Cc: lulu@redhat.com, paulmck@kernel.org, peterz@infradead.org, maz@kernel.org,
 pasic@linux.ibm.com, eperezma@redhat.com, tglx@linutronix.de
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

On Mon, Apr 25 2022, Jason Wang <jasowang@redhat.com> wrote:

> From: Stefano Garzarella <sgarzare@redhat.com>
>
> It will allow us to do extension on virtio_device_ready() without
> duplicating code.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
