Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EA4356746
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218395; cv=none; b=pebtZ21c7BJN4y+2wJutQjZNlbUrMc/1CJFdaAJF6SkkmCLQhhFOeJc9Yr3YQNxgKn2no7BptXMGRfveD4z6f/Qh2j4YhSl0r8k0xMt7reWyquZYrMNC7mMrz67QsqdYC4xrrNNt78JM+A50mVNAcTyc2laOF79P0Uc7KslzUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218395; c=relaxed/simple;
	bh=kKKZU3L+6reK4B7gcJARVHlxz60vhrpuTNd2xoB+G8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SSy1s7cngpwR7OLoIG+KhtHFfauVMkKQ6Y9Tlwn0ksGpFqCMSLwqfKL+VRoVtYhIud3wfnm4uFSvBeAixg08/rlYH0ebejph4jZQtfpLkZAxLX1KzYQtw2ZNMU8T2mqkeA8MEwWocCmsKP8Hsl/ewAI36QMavhTQG6Bo3t0ByKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyJ37Wt5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyJ37Wt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784218392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
	b=XyJ37Wt5Zisk5aTJPh45GIMqn6f50AnsL6AgY/kJiuS9U59p+/sr0ZuOq4yp4Ja4QLqxpM
	tjVGOFFw9qUWPmtIrpfrMwibiT5UsYQ0XZmkje89h21UGw2d6yfnwoqmbxev/FvywCvh/g
	o8d3HqA5+zM2lBeJSiXi3eHpfDx6k2Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Ablm7b5GN8682yTC56ysRQ-1; Thu, 16 Jul 2026 12:13:10 -0400
X-MC-Unique: Ablm7b5GN8682yTC56ysRQ-1
X-Mimecast-MFC-AGG-ID: Ablm7b5GN8682yTC56ysRQ_1784218389
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493bd52dae6so46055535e9.0
        for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 09:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218389; x=1784823189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9r6s/Iraoqi/k6oOHzDzgVXH/SASqKiz7NyQ8JhZ6M=;
        b=YINDHO8OotpWtOEFnuVY1TPFOwBH1F6PTobnUEMGe6Vnu664xiQNowk0sbvGl4sPOu
         7wtZPTtH4anZHRnkMkx7ce+7moZyomFb5YQFLt6b030dD7IdfaCxI2fsn/pCvfPR8oHk
         rLzsIeue+dcsj7ahr66zBSFgZUWk87WLHeJAn2WiVF/Z6QgR6FIKnoxs3i71tqRwXYd2
         o872Cr3mCUKyxjQ/AKaqV3J98J2PAkGOB9XX/qJHxJNEbLtXKKjr7sxkAStOOc+D8LKQ
         sUf8B17MIF8hSGFDTGKDyYL1txBPex2KBrIN4jj81zFrLsxk0VjSMQUItrPvJiMGilyR
         ykCg==
X-Forwarded-Encrypted: i=1; AHgh+RogJqEvGP4V3mWwT7PcyAfFtSkTEixyGUjQouB399tQ0BEfffodb8CMbhIXpDEkzpl14EBg72iJgL3V8+upnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFNKqlUs48z2CbO4CLqeVsBQ3VwyHzVDx1eTJv9V67++VPVm05
	Ptl1YHiJ3zzBTBAHmYs08/J3RY8etnyzu1Hytf6Wmfu9wg7rpfXv9ZaQVbJrz/LT30NXiYrBFGJ
	0ty8jmwvPVeSkCaI73NJRcQfijw6QIRwmo/K8qblTThV/qq6yLT02pnLk3OzHv9zUolJY
X-Gm-Gg: AfdE7cmTroS2tIYcwPl2jtmFgyPX4t6UNNCqipWstZa37yjsGq48hIHyTYPy6arcICd
	pES0Rb4UJzjtXggmIsuzKLakzmO7uOK2o/T/xztIicHFu7eSq79iGx+r/HZH+qB2EyoNmnAmwg6
	mSvZvoDv4PZAyIt1GNd/M0OUPe2FB18kGIO91ep+dNLDVePoo0QWRIxAiS45J6Y9o5vj0HGOxtM
	HxnLnzGscldCc1iVRd2GFe6RCpm4WjUTbIOcKT85I/EcXcIBGgmnoVWPmEjjFAfYYMcVHXXwRc8
	w0PwgiTp25L7gHBb8+5IQu/UHJeZoSmy2spjEC0Zl8ggTv9UgGlo1cqZ/l1Lxd/hEtbORhcXOh9
	5R7jr5iCztWCCpTeRO9m7tgGH3qmsH8oBOEBROIHkVxOghFljfQ==
X-Received: by 2002:a05:600d:6445:20b0:495:4182:444c with SMTP id 5b1f17b1804b1-49541824759mr38415325e9.26.1784218389344;
        Thu, 16 Jul 2026 09:13:09 -0700 (PDT)
X-Received: by 2002:a05:600d:6445:20b0:495:4182:444c with SMTP id 5b1f17b1804b1-49541824759mr38414535e9.26.1784218388605;
        Thu, 16 Jul 2026 09:13:08 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9ee07sm70836725e9.15.2026.07.16.09.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:13:07 -0700 (PDT)
Date: Thu, 16 Jul 2026 18:13:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <alj_YKTitwqMjAez@sgarzare-redhat>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
 <alibLtcrC7o5r4Dh@sgarzare-redhat>
 <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YjfESTQAc5_UQW-j0X-f6hxZ7lR4kYt3EwVmRekxI90_1784218389
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 16, 2026 at 06:39:48PM +0300, Andrey Drobyshev wrote:
>On 7/16/26 11:57 AM, Stefano Garzarella wrote:
>> On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>> the vq->worker pointers and immediately frees the workers, without
>>> waiting for a grace period.  A caller that fetched the worker right
>>> before the pointer was cleared can therefore still be queueing work on
>>> it while it is freed.  And even when the queueing itself wins the race,
>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>> future attempts to queue it are silently skipped.
>>>
>>> None of the current callers can actually hit this: net and scsi stop
>>> their virtqueues before the workers are freed, and vsock unhashes the
>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>> the lockless send/cancel paths become able to race with the teardown.
>>>
>>> Close this the way vhost_worker_killed() already does: clear the
>>> vq->worker pointers, wait for a grace period, run whatever the last
>>> readers may have queued, and only then free the workers.  The
>>> synchronize_rcu() is skipped if the device has no workers, so cleanup of
>>> devices which never got an owner stays cheap.
>>>
>>
>> Do we need a Fixes tag for this?
>>
>
>I'm guessing it should be:
>
>Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>
>> Thanks for pointing out that the issue wasn't occurring, but I think we
>> should add it because it's a sneaky problem we discovered by chance.
>> IMO the code should already have `synchronize_rcu()` after
>> `rcu_assign_pointer()` loop.
>>
>> @Michael, what do you think?
>>
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> drivers/vhost/vhost.c | 15 +++++++++++++++
>>> 1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>> index 4c525b3e16ea..0d1414d40f4e 100644
>>> --- a/drivers/vhost/vhost.c
>>> +++ b/drivers/vhost/vhost.c
>>> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>>
>>> 	for (i = 0; i < dev->nvqs; i++)
>>> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>>> +
>>> +	/*
>>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>>> +	 * caller that fetched a worker before we cleared the pointers above
>>> +	 * may still be about to queue work on it.  Wait for those RCU readers
>>> +	 * to finish before freeing the worker, then run whatever they queued
>>> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>>> +	 * vhost_worker_killed().
>>> +	 */
>>> +	if (!xa_empty(&dev->worker_xa)) {
>>> +		synchronize_rcu();
>>> +		xa_for_each(&dev->worker_xa, i, worker)
>>> +			vhost_run_work_list(worker);
>>> +	}
>>> +
>>
>> Following sashiko review [1], I tried to undersand why we need this, but
>> TBH I'm really confused. That said, this seems wrong also because it
>> will work only with vhost_tasks, and not with kthreads.
>>
>> IIUC vhost_worker_killed() will be called anyway when calling
>> vhost_worker_destroy(). For vhost_tasks, it will call
>> vhost_task_do_stop() that calls vhost_task_stop(). This sets
>> VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing
>> stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that
>> is exactly vhost_worker_killed() you mentioned we are mirroring here.
>>
>
>Hmm, are we sure it's the case for our codepath?  Looking at the
>vhost_task loop function:
>
>> static int vhost_task_fn(void *data)
>> {
>>     for (;;) {
>>         if (signal_pending(current)) {
>>             if (get_signal(&ksig))
>>                 break;
>>         }
>>         ...
>>         if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>             __set_current_state(TASK_RUNNING);
>>             break;
>>         }
>>         did_work = vtsk->fn(vtsk->data);
>>         ...
>>     }
>>
>>     ...
>>
>>     if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>         set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>>         vtsk->handle_sigkill(vtsk->data);
>>     }
>>     ...
>> }
>
>AFAICT, we exit the loop in 2 cases: signal delivery or STOP bit
>setting.  Like you said, STOP is set by vhost_task_stop.  E.g. for our
>RESET_OWNER case:
>
>vhost_vsock_reset_owner()
>  vhost_dev_reset_owner()
>    vhost_dev_cleanup()
>      vhost_workers_free()
>        vhost_worker_destroy()
>          vhost_task_stop()  // for vhost_task_ops backend
>            set_bit(VHOST_TASK_FLAGS_STOP)
>
>So, first of all, actual work by .fn() callback is done after the exit
>checks, therefore we skip it - no chance to drain there.
>
>Secondly, the handle_sigkill() callback is deliberately NOT called in
>the STOP case and only called on fatal signal delivery.  And for
>vhost_task backend the .handle_sigkill() callback is exactly
>vhost_worker_killed().
>
>So my understanding is: if we only call synchronize_rcu() here and leave
>this path undrained, then whatever work which was put by send_pkt() for
>the worker currently being freed - will be lost.  Please correct me if
>I'm wrong.

Yep, your right. But what will be the issue of loosing them?

IIUC we are not loosing any data, just avoiding some works that will be 
handled later when/if will set a new owner.

>
>That said, I agree that vhost_run_work_list() will only work with
>vhost_task backend, not with kthreads backend.  If we do
>vhost_worker_flush() instead - I guess it'll keep the drain here, yet
>become backend-agnostic. I.e.:
>
>> +       if (!xa_empty(&dev->worker_xa)) {
>> +               synchronize_rcu();
>> +               xa_for_each(&dev->worker_xa, i, worker)
>> +                       vhost_worker_flush(worker);
>> +       }
>
>With the last 2 lines being equivalent to just calling
>vhost_dev_flush(dev).  And once we become backend-agnostic here, I'm
>guessing the warning reported by Sashiko should be dealt with as well.

I'd avoid `if !xa_empty(&dev->worker_xa)` at all, and call 
synchronize_rcu() in any case.

About vhost_dev_flush(), we are calling it in several places, and maybe 
we should re-check them. E.g. we call in vhost_vsock_flush(), but it's 
also called by vhost_dev_stop(), maybe we can avoid to call 
vhost_vsock_flush() if we call vhost_dev_stop().

I'm not sure we really need another one here, but if you think some 
other works can be queued between the vhost_dev_stop() and the 
synchronize_rcu() we are adding here, then okay, it may have sense.

Thanks,
Stefano

