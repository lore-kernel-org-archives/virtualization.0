Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFF1C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 09:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC93C81439;
	Thu, 28 Apr 2022 09:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7PyDFw7DEMu2; Thu, 28 Apr 2022 09:13:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51BD98136D;
	Thu, 28 Apr 2022 09:13:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21D40C0032;
	Thu, 28 Apr 2022 09:13:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EEB9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4147240292
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fcyvAxzwUKR4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:13:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E24441730
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651137212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4zZpdNOPi0WVFim58wTW/tRyBHrzLYktI6b26zWCEE=;
 b=K4VFA20kMIN7T+Yo4QRqwALJtiZtTu8uzdHmsxIinnwKzBLEfA0HgDnhP1OhwF8+8rZ/WQ
 6IQOxjQIfrQ1JHiJbrXta2wkSQdBmeKKnLlMUqMSmSlYyCexexLp711R2M4/+frWz2lLrG
 hZW4SNAwPTxjHVAve5C7zllBgfp5e/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-Hrmmk8wyPFmtCbZ-Px_e2A-1; Thu, 28 Apr 2022 05:13:26 -0400
X-MC-Unique: Hrmmk8wyPFmtCbZ-Px_e2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D9FF811E75;
 Thu, 28 Apr 2022 09:13:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD34940869CB;
 Thu, 28 Apr 2022 09:13:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring
 callbacks
In-Reply-To: <20220425024418.8415-4-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-4-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Thu, 28 Apr 2022 11:13:22 +0200
Message-ID: <87r15hlgel.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
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

> This patch introduces new virtio config op to vring
> callbacks. Transport specific method is required to make sure the
> write before this function is visible to the vring_interrupt() that is

Which kind of writes? I.e., what is the scope?

> called after the return of this function. For the transport that
> doesn't provide synchronize_vqs(), use synchornize_rcu() which

Typo: synchronize_rcu()

> synchronize with IRQ implicitly as a fallback.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_config.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b341dd62aa4d..14fe89ff99c7 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -57,6 +57,10 @@ struct virtio_shm_region {
>   *		include a NULL entry for vqs unused by driver
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
> + * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> + *      Make sure the writes commited before this method is visible to
> + *      vring_interrupt() which is called after this method.

Same here, I think the description needs to be a bit more explicit about
which writes we care about here.

> + *      vdev: the virtio_device
>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
>   *	Returns the first 64 feature bits (all we currently need).
> @@ -89,6 +93,7 @@ struct virtio_config_ops {
>  			const char * const names[], const bool *ctx,
>  			struct irq_affinity *desc);
>  	void (*del_vqs)(struct virtio_device *);
> +	void (*synchronize_cbs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);
>  	int (*finalize_features)(struct virtio_device *vdev);
>  	const char *(*bus_name)(struct virtio_device *vdev);

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
