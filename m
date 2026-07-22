Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9140D565
	for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713426; cv=none; b=KJGAWSNGd6tZcRby+CamnXGRedOW5NeOlwqhyj5t4UTDBLbUEjesNMas06I2U9buUYK4L/K+fdhwhxCjA69edmIrcoW3RPUel0hFrf7WFZYsoFohXflkeErZKbRidscizF0yaZOfNBI9hb40e2DIAVg1enUGZ6VOiiWfxxMvzxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713426; c=relaxed/simple;
	bh=0Yu4rlSKE6ROlYI+xvQFCojN8cuCLeFtTpz/TZVKheI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oRDERSpycvh/qPvbOwXjO8FbXUkPSWbC5S+IelcSj1STaOWY3IXYdxByRuHYLji+vVibQjci4Jsx2d1EryoPXwC4r/Zy3L9F7kYeUwBl1ANf9V9A/kEfhXc24w7zeEUt1W1lREwZwtmef+WwV8vGFO5tJvMBBXPQQNznbuAGLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JChMp2Dk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JChMp2Dk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784713420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1qKPjC4I/XXec2U4Xjf51wijAauyxem8KgFjfP+Lbs8=;
	b=JChMp2DkBpi0GxiHRMgoHFT2QFag57nBw26FKMd1ivVOo+1s3zGttXz+hWqnM81NAEDiNO
	YRHKzNVa6NQJR/uNXAR63enXyXi12+zIKJLP5DZrGlaaF8k5IfH8sw2qmWmzcnQcALOS0x
	XJoFSU0wjjPsYORjSpmo52y02c6FZxw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-jMkIKz_oOyCojFor15CHKw-1; Wed, 22 Jul 2026 05:43:37 -0400
X-MC-Unique: jMkIKz_oOyCojFor15CHKw-1
X-Mimecast-MFC-AGG-ID: jMkIKz_oOyCojFor15CHKw_1784713416
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493e94719e7so84543315e9.0
        for <virtualization@lists.linux.dev>; Wed, 22 Jul 2026 02:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784713416; x=1785318216;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qKPjC4I/XXec2U4Xjf51wijAauyxem8KgFjfP+Lbs8=;
        b=AacsxOY8HCQtxsv737QR2oyaVeyCv6RfscRDDnZV/JsR0oZ0njaRhmX08YlRYDvS9L
         /e80hbCA4ktkF1YqlXZkuBK+PtQmITHHOqosN326gAfCAEhCzK4IQf3eAH0shV/kte2w
         S5J93/69k6PAUyI8wpNeOAP+UEeJFZYLcLUmFjXXo5mmgY+EQ4kMmb2xVdNKqrSkUrMj
         X9/1bYcby1PVx04qiHv/iGO4p2D2W1Ltse59CuKovSsvyHQ1RIvTGBxZE1iZFzVNSHE+
         9nrg4mjMsdR1mn3MEcttvjkwFO3giTAOIjXMR6RAm1MS4uYnJ/Ieq2r7drbPbdC7TFwg
         mqSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rri43fCb9NelD76nvg6fGht9jLi+Hz098I6nTAtLl7nN/mUr9NPRybE9gThB0FnO5qy/xlc/jFCj6exBM2k4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaHBxs7KBsw/sQ5PMGjWplWfQW3K767UnAg4HQ322EkWYzfA3J
	8Mw6mpfBi0ASm6jh9fCgMQzMotoyuTt5wy1ZZFaCetJxMX51nIZ+BGv54AeEDqXVF5ee9KMyOQv
	wV9xjmIygtU7yEvuQz3nYJeJyqj4+mjdGUWo77hdcE0/ObZrBkBNN9pWyhTOsimY1x1/i
X-Gm-Gg: AR+sD10N6kVfilYYDPOB5OhD6BovfqYjEffu2c1v+G91dDN9TkUkD7YAqZXzyE8URJY
	Gs59oqwbN194hJBOfj8Q3Aw5VEfOscl9cG0rA83/1xXSeEnlkZFc7cQpvOUmNN72Vd3RsarFYm/
	NtpB+Si7zkHphGbbupRBSa0cQZzIraEgsi7848qbfAwWlXxbf93XMhYEgEFXCp9EvAdCUQLicPr
	eb27RIeF4i4HeQuvg+28Og+vBhePyiwBV5eTN4rHqMsEWr1BCgfR6K5UwxuML4x1MqbjtA45ZFL
	U79ThI/eRVNWgeE/bIE898LSU5SxT1vmraSQdCSzirxxtXu2jwhyBkAK6V7EITHLt+Af0K2xaDr
	p5gEumXame2747fW7MnJrcv8yVcc0P80eLb1daXlMdWTeKM4LxQ==
X-Received: by 2002:a05:600c:42c6:b0:495:4182:4456 with SMTP id 5b1f17b1804b1-4954a4104e1mr155441585e9.29.1784713416060;
        Wed, 22 Jul 2026 02:43:36 -0700 (PDT)
X-Received: by 2002:a05:600c:42c6:b0:495:4182:4456 with SMTP id 5b1f17b1804b1-4954a4104e1mr155441405e9.29.1784713415638;
        Wed, 22 Jul 2026 02:43:35 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm4825813f8f.12.2026.07.22.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 02:43:34 -0700 (PDT)
Date: Wed, 22 Jul 2026 11:43:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amCPLOrnpYmr5n0p@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lbrbZxIA9poLGkrtQ9IKM_SqwXL-7vGDbskNZETpAOo_1784713416
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
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
>Fix this by clearing the vq->worker pointers, waiting for a grace
>period, and then flushing the workers so any work the last readers
>queued runs before the workers are freed.
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> drivers/vhost/vhost.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

Sashiko reported some potential issues here:
https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4

IMO the first one is pre-existing, but not really sure it is a real 
issue since happening when the worker/vmm is going to be killed.

The second one also not sure if it's an issue since the sender is not 
lockless IIUC.

But, please can you double check them?

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 4c525b3e16ea..d6e235c25254 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -729,6 +729,17 @@ static void vhost_workers_free(struct vhost_dev *dev)
>
> 	for (i = 0; i < dev->nvqs; i++)
> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+
>+	/*
>+	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>+	 * reader that fetched a worker before we cleared the pointers above
>+	 * may still be queueing work on it.  Wait for those readers to
>+	 * finish, then flush so any work they queued runs (clearing
>+	 * VHOST_WORK_QUEUED) before the workers are freed.
>+	 */
>+	synchronize_rcu();
>+	vhost_dev_flush(dev);
>+
> 	/*
> 	 * Free the default worker we created and cleanup workers userspace
> 	 * created but couldn't clean up (it forgot or crashed).
>-- 
>2.47.1
>

