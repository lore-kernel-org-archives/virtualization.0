Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FADC433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCE2B82AC8;
	Mon, 14 Mar 2022 09:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wV6yT_A6RXCL; Mon, 14 Mar 2022 09:50:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89ABA82909;
	Mon, 14 Mar 2022 09:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6773CC001D;
	Mon, 14 Mar 2022 09:50:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8019C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E51760669
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sXsK3yP5-okD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84C9E600BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647251411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtLbfFoJdTrpJtjuI/aGC/BMVEtxNUcexTJUY7kZ1ag=;
 b=CMBIC5oGomDfxQZeUE3i7Tt+NbnGqynglOzuNescfTCjYwYgszut41M86kjdQZWy+kOft8
 3EfuYU/xwXqYrpbgh9YdcfoKerPoPaoVnsRzDFIdHdzvjpj/qcNqrfeOn1qWHtPCxwH+HV
 kG81olFDSlJ+NgVC7sIMxdIlMpd5mMU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-u8fFhDHjMhW60s5SNxlmHQ-1; Mon, 14 Mar 2022 05:50:10 -0400
X-MC-Unique: u8fFhDHjMhW60s5SNxlmHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B60E585A5BC;
 Mon, 14 Mar 2022 09:50:09 +0000 (UTC)
Received: from localhost (unknown [10.39.194.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E6ABC531E3;
 Mon, 14 Mar 2022 09:50:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 01/16] virtio: add helper virtqueue_get_vring_max_size()
In-Reply-To: <20220314093455.34707-2-xuanzhuo@linux.alibaba.com>
Organization: Red Hat GmbH
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-2-xuanzhuo@linux.alibaba.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Mon, 14 Mar 2022 10:50:08 +0100
Message-ID: <87cziohnhr.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Mar 14 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> Record the maximum queue num supported by the device.
>
> virtio-net can display the maximum (supported by hardware) ring size in
> ethtool -g eth0.
>
> When the subsequent patch implements vring reset, it can judge whether
> the ring size passed by the driver is legal based on this.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_mmio.c       |  2 ++
>  drivers/virtio/virtio_pci_legacy.c |  2 ++
>  drivers/virtio/virtio_pci_modern.c |  2 ++
>  drivers/virtio/virtio_ring.c       | 14 ++++++++++++++
>  include/linux/virtio.h             |  2 ++
>  5 files changed, 22 insertions(+)

Don't you also need to init this for ccw (even though we won't do ring
reset there), just for completeness? (Any other transports?)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
