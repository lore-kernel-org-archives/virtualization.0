Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F57C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 13:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27BA0610B9;
	Wed,  6 Apr 2022 13:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGT74idCu3NR; Wed,  6 Apr 2022 13:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6CF860608;
	Wed,  6 Apr 2022 13:05:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABFF2C002C;
	Wed,  6 Apr 2022 13:05:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AEE0C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 13:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29A5B6068B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 13:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PMqgbMljCPYQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 13:04:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D5D560608
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649250298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WSZMUg62M/bE0Jpk+nJJkdqRfcMAUEwvNHLM7s1fLUM=;
 b=HMmkHofTbFnAVy7IJ9zWPKnwCNHyTO+KsVurilqmReEj5cc8DXlnB896m1EWeLWd7SYtye
 N+ft0eo/NeZH5rDZ1/K0DcEtXVN0hLAFJQZc4RNnFs0PlE5zc/zmziz3SQ/oo5ZQXk7b81
 1ufS1218N6QSFELrpxshGal87Pt4Zak=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-DqkpcBGmNWm0dX4eUzXhdA-1; Wed, 06 Apr 2022 09:04:56 -0400
X-MC-Unique: DqkpcBGmNWm0dX4eUzXhdA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C51F28092CC;
 Wed,  6 Apr 2022 13:04:56 +0000 (UTC)
Received: from localhost (dhcp-192-213.str.redhat.com [10.33.192.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C373141513E;
 Wed,  6 Apr 2022 13:04:33 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <20220406075952-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Wed, 06 Apr 2022 15:04:32 +0200
Message-ID: <87wng2e527.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 tglx@linutronix.de
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

On Wed, Apr 06 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 06, 2022 at 04:35:37PM +0800, Jason Wang wrote:
>> This patch implements PCI version of synchronize_vqs().
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Please add implementations at least for ccw and mmio.

I'm not sure what (if anything) can/should be done for ccw...

>
>> ---
>>  drivers/virtio/virtio_pci_common.c | 14 ++++++++++++++
>>  drivers/virtio/virtio_pci_common.h |  2 ++
>>  drivers/virtio/virtio_pci_legacy.c |  1 +
>>  drivers/virtio/virtio_pci_modern.c |  2 ++
>>  4 files changed, 19 insertions(+)
>> 
>> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
>> index d724f676608b..b78c8bc93a97 100644
>> --- a/drivers/virtio/virtio_pci_common.c
>> +++ b/drivers/virtio/virtio_pci_common.c
>> @@ -37,6 +37,20 @@ void vp_synchronize_vectors(struct virtio_device *vdev)
>>  		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>>  }
>>  
>> +void vp_synchronize_vqs(struct virtio_device *vdev)
>> +{
>> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>> +	int i;
>> +
>> +	if (vp_dev->intx_enabled) {
>> +		synchronize_irq(vp_dev->pci_dev->irq);
>> +		return;
>> +	}
>> +
>> +	for (i = 0; i < vp_dev->msix_vectors; ++i)
>> +		synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>> +}
>> +

...given that this seems to synchronize threaded interrupt handlers?
Halil, do you think ccw needs to do anything? (AFAICS, we only have one
'irq' for channel devices anyway, and the handler just calls the
relevant callbacks directly.)

>>  /* the notify function used when creating a virt queue */
>>  bool vp_notify(struct virtqueue *vq)
>>  {

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
