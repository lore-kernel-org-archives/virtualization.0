Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A43EC828
	for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344200; cv=none; b=OrmckpDXgSBGRIAnobew8M4foSkeQNFjz9QFK+WT4n9x3tAa4Q5f0UGifWrziAfQswPqD+0mutDdHifJSdFDk0aWfsgxQmkzSZw1qUSJhLcFkYR2Q5kYKU8frYQGe9NqgeH3lWJBDqD5sFlkY/HzVJs0Wmc63MQ+L6mQBAjo3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344200; c=relaxed/simple;
	bh=CT95xBYCpCa+zxjdMWn2uNJlNED4ojMFUWxcfzvOdLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OGFlqGrHrQiwgzg1+asOBLSvVFc4S+DXriGyImOv69s77+NLInD8NFImJCJLFNk5+jeniENuS1376B5UQr3avw3evAKBA5Kra0zydTq/piVWUkxMTnuEbIedC/VXa60yLlOgF/3lo7Qgof0JADFmyj6ljK+YKzIwC5CsIiP6e8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCnKCcJp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCnKCcJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785344193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nvryIhedkP6lGBa8VKtEBCZluIetqaiePM9xmEbN9Zc=;
	b=eCnKCcJpCcjx0jOHxnn/v9ZuMX8UD3emLpf0ScJCDalNLBSgwYeeg4cmFR6IwnHN0LZf8K
	YuVyvBaYEYf9udsl0Gz9yxk0cFL0r6+bn8n084zKOqAndOzG9OWIuo+4IJwqIT39PJ5Ldn
	wNj/diK5GN8sReyEygSHpOATg+H9Cmw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-Kw0ihHOKN4C1AXCxjMGE0A-1; Wed, 29 Jul 2026 12:56:32 -0400
X-MC-Unique: Kw0ihHOKN4C1AXCxjMGE0A-1
X-Mimecast-MFC-AGG-ID: Kw0ihHOKN4C1AXCxjMGE0A_1785344191
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so14316635e9.3
        for <virtualization@lists.linux.dev>; Wed, 29 Jul 2026 09:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344191; x=1785948991;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvryIhedkP6lGBa8VKtEBCZluIetqaiePM9xmEbN9Zc=;
        b=dYrQBmXpYGc1HU9w2FdTg9VrGQjxfgjpOlQeShR1bFGUSL2VvdOR1Gj1rEozNGr6H8
         dCt8Qb060yypW+rz+OHU/8U9MbiYiSL90DmZUNjgy53dIATNBmf7NafKvy/+SqG0tKm4
         opSrKhOb9Ub7E4v74ivsUoIB9VDBk9KTT6c8iO79xQ+Lf8TfFE/QA8wJ85W7I/GmZT1/
         h/98nbiWqdl4eJhs7xIHTLd+B23qfonoEpmeJhzMAsbWkNf7kLg/DfzgvpPnYn4MPRgV
         GKx5DebOhS9QscUjkZyYGmBRMISEazF7OygCZVZ7WbH/GbX47MRzgVd069RaxkxsK8L2
         Qy5w==
X-Forwarded-Encrypted: i=1; AHgh+RrK7tcydqgx5XnYuqNuWRIeaxU5p/BcfNn2O4l8BMMF7l5VKZOZcPxqg94/IVz1VaFfxAUPIKWyxH7jN+O/Ng==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/B0fTKIP9cOSypo3iinrPiuQCwZPX6BUBwfrn0VI91mMeltIX
	/epTdTk1HGzUWo01MYyBC9PSAzllt29ckpa2+cFdvUaT+6iZpP2IYL4kLSAZnjkhpbRZgSt5gO6
	GaoodR3dDabSEz0gWSxM6X7bLpEIgU+Gaur2vr790aSZqd60Pj68snsdglQ/taHckKqj7
X-Gm-Gg: AR+sD117SnFx8Amm4sbroqGzYMelDrk+CYWp/7Njx2tkl/YfSUHJw9TY8dLJmriPgbe
	myVPjsCJFJtc/7lPH3yP9xEBwTDbuSDpVKMt9mww2UG1oCCUYjMJQFTqhAsxJmyiDcs2M2Kn3Sd
	VrNbNnIm75gBQ7cwGaDA78Ouj1Z8toowvI/iRfnClDpOnvmoQDBMeovsbVuuxQqP9iMCKLAbi2k
	f6D3WvUfXDf8ISqBIOn8AvaVG8igqUg7d0WIy5FjuUYvH2pYOA+p6WTZSl2Cpx3nOgi2RfpwMTR
	uXcyFrLiKc8cIsjY3yAli2FG5NlDrZcEiGykOtEe/hdKeFxnuAhJRyKfTfvzbkZFttUXggh5hr9
	TPqBLRNWvKS9P5bCtZDymDrwqlMbP6NZnFfzuYVqegVo=
X-Received: by 2002:a05:600c:a44:b0:495:4856:2659 with SMTP id 5b1f17b1804b1-496c6439442mr85245575e9.9.1785344190982;
        Wed, 29 Jul 2026 09:56:30 -0700 (PDT)
X-Received: by 2002:a05:600c:a44:b0:495:4856:2659 with SMTP id 5b1f17b1804b1-496c6439442mr85245375e9.9.1785344190485;
        Wed, 29 Jul 2026 09:56:30 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496e8e15a52sm45385795e9.0.2026.07.29.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:56:29 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:56:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v6 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amoinWjGmsk4oz5L@sgarzare-redhat>
References: <20260724114542.734623-1-andrey.drobyshev@virtuozzo.com>
 <20260724114542.734623-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724114542.734623-5-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2PSFxw74qhUcc0LkwvqF6ypiTHJb6cEOZukefFEPAyY_1785344191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jul 24, 2026 at 02:45:41PM +0300, Andrey Drobyshev wrote:
>vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>vq->worker and queues work on it.  vhost_workers_free() however clears
>the vq->worker pointers and immediately frees the workers, without
>waiting for a grace period.  A caller that fetched the worker right
>before the pointer was cleared can therefore still be queueing work on
>it while it is freed.  And even when the queueing itself wins the race,
>the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>future attempts to queue it are silently skipped.
>
>None of the current callers can actually hit this: net and scsi stop
>their virtqueues before the workers are freed, and vsock unhashes the
>device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>in vhost-vsock keeps the device hashed while its workers are freed, so
>the lockless send/cancel paths become able to race with the teardown.
>
>Fix this by threading a bool 'sync' param through the chain:
>
>  vhost_dev_reset_owner()
>    vhost_dev_cleanup()
>      vhost_workers_free()
>
>When set, after clearing the vq->worker pointers, wait for a grace
>period and flush the workers so any work the last RCU readers queued
>runs (clearing VHOST_WORK_QUEUED) before the workers are freed.  Only
>the vsock RESET_OWNER path (added in the next patch) passes sync=true;
>every other teardown has already quiesced and passes false, so they do
>not need to wait the grace period.

Maybe the previous version was enough, but this one definitely covers
it, so if it's okay with Michael, it's okay with me too:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/net.c   |  4 ++--
> drivers/vhost/scsi.c  |  2 +-
> drivers/vhost/test.c  |  4 ++--
> drivers/vhost/vdpa.c  |  4 ++--
> drivers/vhost/vhost.c | 26 +++++++++++++++++++++-----
> drivers/vhost/vhost.h |  5 +++--
> drivers/vhost/vsock.c |  2 +-
> 7 files changed, 32 insertions(+), 15 deletions(-)
>
>diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
>index 3e72b9c6af0c..fd089412c020 100644
>--- a/drivers/vhost/net.c
>+++ b/drivers/vhost/net.c
>@@ -1452,7 +1452,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
> 	vhost_net_stop(n, &tx_sock, &rx_sock);
> 	vhost_net_flush(n);
> 	vhost_dev_stop(&n->dev);
>-	vhost_dev_cleanup(&n->dev);
>+	vhost_dev_cleanup(&n->dev, false);
> 	vhost_net_vq_reset(n);
> 	if (tx_sock)
> 		sockfd_put(tx_sock);
>@@ -1661,7 +1661,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
> 	vhost_net_stop(n, &tx_sock, &rx_sock);
> 	vhost_net_flush(n);
> 	vhost_dev_stop(&n->dev);
>-	vhost_dev_reset_owner(&n->dev, umem);
>+	vhost_dev_reset_owner(&n->dev, umem, false);
> 	vhost_net_vq_reset(n);
> done:
> 	mutex_unlock(&n->dev.mutex);
>diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>index 9a1253b9d8c5..b6002b64cf42 100644
>--- a/drivers/vhost/scsi.c
>+++ b/drivers/vhost/scsi.c
>@@ -2350,7 +2350,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
> 	mutex_unlock(&vs->dev.mutex);
> 	vhost_scsi_clear_endpoint(vs, &t);
> 	vhost_dev_stop(&vs->dev);
>-	vhost_dev_cleanup(&vs->dev);
>+	vhost_dev_cleanup(&vs->dev, false);
> 	kfree(vs->dev.vqs);
> 	kfree(vs->vqs);
> 	kfree(vs->old_inflight);
>diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
>index 24514c8fdee4..84ed9ea81219 100644
>--- a/drivers/vhost/test.c
>+++ b/drivers/vhost/test.c
>@@ -163,7 +163,7 @@ static int vhost_test_release(struct inode *inode, struct file *f)
> 	vhost_test_stop(n, &private);
> 	vhost_test_flush(n);
> 	vhost_dev_stop(&n->dev);
>-	vhost_dev_cleanup(&n->dev);
>+	vhost_dev_cleanup(&n->dev, false);
> 	kfree(n->dev.vqs);
> 	kfree(n);
> 	return 0;
>@@ -238,7 +238,7 @@ static long vhost_test_reset_owner(struct vhost_test *n)
> 	vhost_test_stop(n, &priv);
> 	vhost_test_flush(n);
> 	vhost_dev_stop(&n->dev);
>-	vhost_dev_reset_owner(&n->dev, umem);
>+	vhost_dev_reset_owner(&n->dev, umem, false);
> done:
> 	mutex_unlock(&n->dev.mutex);
> 	return err;
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index ac55275fa0d0..427c4a34db2c 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -898,7 +898,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 	case VHOST_SET_OWNER:
> 		r = vhost_vdpa_bind_mm(v);
> 		if (r)
>-			vhost_dev_reset_owner(d, NULL);
>+			vhost_dev_reset_owner(d, NULL, false);
> 		break;
> 	}
> out:
>@@ -1396,7 +1396,7 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa 
>*v)
> 	}
>
> 	vhost_vdpa_free_domain(v);
>-	vhost_dev_cleanup(&v->vdev);
>+	vhost_dev_cleanup(&v->vdev, false);
> 	kfree(v->vdev.vqs);
> 	v->vdev.vqs = NULL;
> }
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..b18429b15d32 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -719,7 +719,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> 	kfree(worker);
> }
>
>-static void vhost_workers_free(struct vhost_dev *dev)
>+static void vhost_workers_free(struct vhost_dev *dev, bool sync)
> {
> 	struct vhost_worker *worker;
> 	unsigned long i;
>@@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>
> 	for (i = 0; i < dev->nvqs; i++)
> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+
>+	/*
>+	 * This path can be reached by lockless work queuers.  In this case
>+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>+	 * RCU reader that fetched a worker before we cleared the pointers above
>+	 * may still be queueing work on it.  Wait for those readers to finish,
>+	 * then flush so any work they queued runs (clearing VHOST_WORK_QUEUED)
>+	 * before the workers are freed.  Notably, that is the case for the
>+	 * vsock RESET_OWNER path.
>+	 */
>+	if (sync) {
>+		synchronize_rcu();
>+		vhost_dev_flush(dev);
>+	}
>+
> 	/*
> 	 * Free the default worker we created and cleanup workers userspace
> 	 * created but couldn't clean up (it forgot or crashed).
>@@ -1148,11 +1163,12 @@ struct vhost_iotlb *vhost_dev_reset_owner_prepare(void)
> EXPORT_SYMBOL_GPL(vhost_dev_reset_owner_prepare);
>
> /* Caller should have device mutex */
>-void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
>+void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem,
>+			   bool sync)
> {
> 	int i;
>
>-	vhost_dev_cleanup(dev);
>+	vhost_dev_cleanup(dev, sync);
>
> 	dev->fork_owner = fork_from_owner_default;
> 	dev->umem = umem;
>@@ -1197,7 +1213,7 @@ void vhost_clear_msg(struct vhost_dev *dev)
> }
> EXPORT_SYMBOL_GPL(vhost_clear_msg);
>
>-void vhost_dev_cleanup(struct vhost_dev *dev)
>+void vhost_dev_cleanup(struct vhost_dev *dev, bool sync)
> {
> 	int i;
>
>@@ -1221,7 +1237,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> 	dev->iotlb = NULL;
> 	vhost_clear_msg(dev);
> 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
>-	vhost_workers_free(dev);
>+	vhost_workers_free(dev, sync);
> 	vhost_detach_mm(dev);
> }
> EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 0192ade6e749..29fb1f510a34 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -216,8 +216,9 @@ long vhost_dev_set_owner(struct vhost_dev *dev);
> bool vhost_dev_has_owner(struct vhost_dev *dev);
> long vhost_dev_check_owner(struct vhost_dev *);
> struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
>-void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *iotlb);
>-void vhost_dev_cleanup(struct vhost_dev *);
>+void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *iotlb,
>+			   bool sync);
>+void vhost_dev_cleanup(struct vhost_dev *dev, bool sync);
> void vhost_dev_stop(struct vhost_dev *);
> long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
> long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index d5022d21120b..87309c68af15 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -824,7 +824,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
>
> 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>
>-	vhost_dev_cleanup(&vsock->dev);
>+	vhost_dev_cleanup(&vsock->dev, false);
> 	put_net_track(vsock->net, &vsock->ns_tracker);
> 	kfree(vsock->dev.vqs);
> 	vhost_vsock_free(vsock);
>-- 
>2.47.1
>

