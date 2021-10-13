Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E47C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:53:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAD0610CB
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DDAD0610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1A09608F3;
	Wed, 13 Oct 2021 12:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kjMkjmo6VPC0; Wed, 13 Oct 2021 12:53:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6EA68608B4;
	Wed, 13 Oct 2021 12:53:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53C34C000F;
	Wed, 13 Oct 2021 12:53:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 277E9C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09C91608EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hb-h7l3Il5Jd
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:52:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 675F6608B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634129578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EDsOoxW6EgtFgX4OT23FEb36jHTKMtrgphgk3Epw6BM=;
 b=IycEkUZMrJ9b89yKS9324D3Bc2GpnnuByQwzrQR72QMeJhr57SlOMN6eeyQ08f91PQGqM/
 O/zQlIvbPyMw0D0PLPdurmRtdw+f7ZYyBqBuTZVBsxojhgV/gfcPaQUsc37Ffgd5P6fnvi
 hVD1hRMr2P64tAILNhSguabyNBK1YHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-_kjdl3s9NGCosEq6_R0ySg-1; Wed, 13 Oct 2021 08:52:52 -0400
X-MC-Unique: _kjdl3s9NGCosEq6_R0ySg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0C7F19200C4;
 Wed, 13 Oct 2021 12:52:49 +0000 (UTC)
Received: from localhost (unknown [10.39.193.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6286C5DA60;
 Wed, 13 Oct 2021 12:52:39 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger
 <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
In-Reply-To: <20211013081836-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
 <20211013060923-mutt-send-email-mst@kernel.org>
 <96561e29-e0d6-9a4d-3657-999bad59914e@de.ibm.com>
 <20211013081836-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date: Wed, 13 Oct 2021 14:52:38 +0200
Message-ID: <87zgrdulwp.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com, qemu-devel@nongnu.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
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

On Wed, Oct 13 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Oct 13, 2021 at 01:23:50PM +0200, Christian Borntraeger wrote:
>> Can we get this kernel patch queued for 5.15 and stable without waiting for the QEMU patch
>> as we have a regression with 4.14?
>
> Probably. Still trying to decide between this and plain revert for 5.15
> and back. Maybe both?

Probably better queue this one, in case we have some undiscovered
problems with the config space access in virtio-net?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
