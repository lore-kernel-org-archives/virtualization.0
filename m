Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF24D3F44FF
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192261; cv=none; b=kiTD15rBjw6BxbKSrE9ZvHHAH5Sy/2+ifEoL/p326TmdqO/LmARJ28TPXmUPT1dF7aLqjEFvIvi4VNOyp2ZuQEkZJ832z9bdl3/dzPyvvFOpXbVXjOP2QNc5cgcXsNPhOqNcyN33z+SlI4eZB/5PZH3w7Y5cRViVMn8U399edKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192261; c=relaxed/simple;
	bh=mEjKg4AVLSWrUhKw9xfuQN61xzTZPl4Xk3fNow6F/Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WyJBHI8ocO/cRfVNErOK+LpL9/m32X+t+lE6PjFtJ944rQwMzJgKPJxq0I9+S9UpZvZlXFVhRlYF4C9bdPKBqiJm8kYTcKnxpO7+rk4O8ln9ZWB0lNc6X90MVDrxjUta6z2KHUBoLV0/5Hy2Hp0cWnKeB+AeULZhBXqWc4NhtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLVq3Wz+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLVq3Wz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784192253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhxSO78Yf0RPA4wZRxf7Fd3u153hjXB7c8vtU2XnoBg=;
	b=JLVq3Wz+gYNU7egeg4nWqf+5RyefD+z7JeSxx6TxeyoYy3zfhPbnE8rYRTxt3YlMp5zGUR
	dLl9SfF8OjiR9rFF7Oc5X2fmh46wED7FyY3eb+vliAf9QcvaSWDIroBjnHJGDV8l0nbvdT
	JsSkrhipz7dIGvqUmlgPTf4KI+POBW8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-IdzN81BXNKe20i_rdvKJLw-1; Thu, 16 Jul 2026 04:57:30 -0400
X-MC-Unique: IdzN81BXNKe20i_rdvKJLw-1
X-Mimecast-MFC-AGG-ID: IdzN81BXNKe20i_rdvKJLw_1784192249
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-474170b59dfso3549954f8f.3
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 01:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192249; x=1784797049;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FhxSO78Yf0RPA4wZRxf7Fd3u153hjXB7c8vtU2XnoBg=;
        b=ad0JfrCghQcqM4yErdi74z9PiyX+JXwOL9Mrg/Tn4n4/5XfRrzKmk+TNZQGDxHNrME
         YWlghTTCS37nddibrO64mSINmCVw/mVZlWIKkyMwzWTsnf5lzAELxLSmLZFI4LMLjVQv
         qu6JsCBT3fsTxxXLRTaUmLBmsx2ahIvFISgqzafpBVrNdPQ/5qPV+EMVncvUHbFdNptJ
         /bXB5ZmzhSZCYra5dAEAp70SQSpS52tvjvsIvk3vQHcc9zUJB5emcrVoFiaRuInVCdfd
         hpuUzh8g0B1iAJOqx+ejIh+OWXfgc1APYbCD5OoYANrWOnvckQagOHKPjyo4BEfq7q2e
         990Q==
X-Forwarded-Encrypted: i=1; AHgh+RoZZtI/iOnJXRrZTM+5mnY7mjWQ08kv0H/Qe0xsKubjO9V20TAhG/eY8bivNfd8aXUC73mcxu/y4pdxU0+PNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDQrlMNsgJyijouXkBcOk+kmBB7wGqPK/PX3CEeOzFAORMZfPF
	/B1XpJOFt+FRkg1XZtyQ9sH7Y8rwts4u1h2FJoc6vEiPEhyVDZ7i3J0y0hAEzm2dCRoiZMy+Rup
	IHEu9WJyJtCem0/vI0fKA5NiCqGyzrIffBvqoYr9/gIWc3rlkzMDIMr8Ol7oj/3Yk6sOj
X-Gm-Gg: AfdE7cnp5dAJJ5OD+0Rg2qWEi3f1P6CI+jAvqsy/TTds0fLuqa/Yq9CnMO22dwMj7Kk
	mo14t9hVf3ONQYXHySGVsvUKiT5/Ht/bBWrQlbHTZES54wHLLchf5vEB9CdnDgZoIHv+cmR8s67
	z7p0NvBWk62E1f/iEFxpZHNDpoGqbnaC90Qp6TL1yHSj0WobvQ8qzRWz37l3F+5Is1vyHWa4mAs
	wLey18NhxTY96WQ/OYIog040aofPdnfYcWMjJqnH2JYJCtFYUS4XmcVpfVvzAiEPKwpB9PdqzhO
	bcT0upc1Xhel9VqaIjuuClfKdKKBMMP8JoFnrc5tLSq/gCHqh+l2Ro8JM1oxHMoETrfUTWRaCGi
	APQSauprWVtH2mkfDKT4ok9fzPadyVO+v8c6n+5+M7aqR98gzZw==
X-Received: by 2002:a05:6000:46c2:b0:47f:5298:a010 with SMTP id ffacd0b85a97d-47f5298a31emr4384407f8f.41.1784192248999;
        Thu, 16 Jul 2026 01:57:28 -0700 (PDT)
X-Received: by 2002:a05:6000:46c2:b0:47f:5298:a010 with SMTP id ffacd0b85a97d-47f5298a31emr4384387f8f.41.1784192248495;
        Thu, 16 Jul 2026 01:57:28 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635aa34sm20900447f8f.15.2026.07.16.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:57:27 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:57:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <alibLtcrC7o5r4Dh@sgarzare-redhat>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gN8t-6J6V1DAFptKdRNXAwCYGfM4867PcK1MYPwcILU_1784192249
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
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
>Close this the way vhost_worker_killed() already does: clear the
>vq->worker pointers, wait for a grace period, run whatever the last
>readers may have queued, and only then free the workers.  The
>synchronize_rcu() is skipped if the device has no workers, so cleanup of
>devices which never got an owner stays cheap.
>

Do we need a Fixes tag for this?

Thanks for pointing out that the issue wasn't occurring, but I think we 
should add it because it's a sneaky problem we discovered by chance.
IMO the code should already have `synchronize_rcu()` after 
`rcu_assign_pointer()` loop.

@Michael, what do you think?

>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..0d1414d40f4e 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>
> 	for (i = 0; i < dev->nvqs; i++)
> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+
>+	/*
>+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>+	 * caller that fetched a worker before we cleared the pointers above
>+	 * may still be about to queue work on it.  Wait for those RCU readers
>+	 * to finish before freeing the worker, then run whatever they queued
>+	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>+	 * vhost_worker_killed().
>+	 */
>+	if (!xa_empty(&dev->worker_xa)) {
>+		synchronize_rcu();
>+		xa_for_each(&dev->worker_xa, i, worker)
>+			vhost_run_work_list(worker);
>+	}
>+

Following sashiko review [1], I tried to undersand why we need this, but 
TBH I'm really confused. That said, this seems wrong also because it 
will work only with vhost_tasks, and not with kthreads.

IIUC vhost_worker_killed() will be called anyway when calling 
vhost_worker_destroy(). For vhost_tasks, it will call 
vhost_task_do_stop() that calls vhost_task_stop(). This sets 
VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing 
stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that 
is exactly vhost_worker_killed() you mentioned we are mirroring here.

So, why we need this?

Should be enough to call synchronize_rcu() in any case after the 
rcu_assign_pointer() loop?

Thanks,
Stefano

[1] 
https://sashiko.dev/#/patchset/20260714151638.143019-1-andrey.drobyshev@virtuozzo.com?part=4

