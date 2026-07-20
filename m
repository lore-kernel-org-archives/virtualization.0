Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE309389E05
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536788; cv=none; b=fH4SslR8LitQcI33rBRXT1c9QfhM5DBhCWnrrjy4iwSkeQPgLUc3o5K8f4GUdhBamgcGDkdArfbiNzGmFbp2VqtcMCNawNnQIoHfvSUc7laUxuDEbsITrwYu+8TkqEAY8qnlKhrI14f04bHZCMd22MRdB5OudnIrSvZ/8TGEMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536788; c=relaxed/simple;
	bh=Q7+IJX68QjV8feATeOoFyhllZFT4t92bU6G47rqe348=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=krUPySrM+3xU6DFk6JLUGxgDCHHBcF3Nc+IwFWnkibjDrA6mcef+Hph4uNX0/YNcy3qiYTmG7tSu7CIQmZRg5Ls+XArNgDv+ndHMvHSPZunTgo2NYf/bU2QT02x4vWcznfaQaxsuEIaH5weWFeuTySrRFOY985LyC3sVgDrnBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EcoQyTBA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcoQyTBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784536784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYv0JD6e9nQrV7B6V6a2cos4kkVgkS7qp+ggCOAYFgU=;
	b=EcoQyTBAzFUZg0Sgzd1zjTvsTY5lDpeRhsuCbLZRZTxmW2s80yOdFsd5Q1F3xOyTLcu/jy
	TLWquXIAB9L7Vk+ABJQIhr09R4Au44WTn2EZ7Bguwmk0EMTjXDsN1gkw3rCkhdPWb4Zc6M
	hOR3bjpWdAQggOEKFC9Qf780pfhl2as=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-PYuT2Vb1N82wDO1goJwoxQ-1; Mon, 20 Jul 2026 04:39:43 -0400
X-MC-Unique: PYuT2Vb1N82wDO1goJwoxQ-1
X-Mimecast-MFC-AGG-ID: PYuT2Vb1N82wDO1goJwoxQ_1784536782
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-495517d39fbso8622895e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 01:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536782; x=1785141582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZYv0JD6e9nQrV7B6V6a2cos4kkVgkS7qp+ggCOAYFgU=;
        b=Nks8fzHeeaSItQ2DzqTxD/s1xwXsLuFujql3Fv6feTwJhONRqKMJRrxVuPX870x9oC
         dRBdncjDqxeFO80kD/DJbC3IDHhq0NmyAJiz31Xmuw2NRCfPSbuFaxo5elHtMWwvvCq7
         dtVqcFQDLTmZ1b5fywkXhvbcYVuiraV4wr9kPNizV84awVju1p/LHk8T3ivdM2RXdtA4
         630fJIWJgma+VXAB8yOiFswhsQxbp0sN7wbDUh/6QLxyxr+n18qPBrwPeS7o166NjP9t
         cepqwZLfRykbAPcAgKBXu65/lJ2qnZ0qYM7dR97SvYQYKSSXvu2hABIYh7RzyXeTV3ke
         4QfA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4jub6yBZ/ErBWzVaQBLiUfFpcHgi7iUAWxV7idU9EMJXiLommIgSB49GZLJfYZHrVg4HJ0L7FgQDZfCQs1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YybVv8QMSeRq38xvsJjPEyxYz/cKreyopjbmpKfA6meFxqMkFAw
	W8P4x2lA0DbJSOzZCAiTjQLCyYp2oAVZN8Xiigafuemg8pXNtpbJobqJ5R9tHeJ5JWg/GbP47Y2
	Ldm2oY9z9tPb/wo9KbktK4lG/89x/z/ohpPEpUmPX9N7cnSf3CLg4ATABQDzcFyh0J8cl
X-Gm-Gg: AfdE7ckT1Er3zoFny9byZMB8UjnlpK+946T+N9PFlBlnfo8zQ+ccpEZ3mOiLDVq0jqr
	Ef9M4TfbZesS4l+WbB/72YpSLRoi137ILJ1W+9Z1jGRWHFYHK3C9X7DNg92mi26N6rcn9qKcnV2
	Xl7OIr6mJJNhUM30q2lOv1GoOqHTm6dK74mQDa84Xijvv3P7N2gOADloY9ToXCMWd72iLJ9ooNl
	yaxaTLEtoLM0AZxbCMKGuT3CxnrBF969GgyIzZIqpmxoPG1maI9SLVUeipcfbTJJdZLZDTJ3gZ0
	v4MJXmGz5vfmQ6C71fAtrozs3Gkx7n/h6jqTHpvQaQmqlJzWLID7vtQq33dZHy1VvxR51HnZCBN
	4YBJppkdhroK/hWHzxDpwRLVenJFrygJLCg7Ugi0JXHjDZaVw2w==
X-Received: by 2002:a05:600c:4e94:b0:495:522f:d994 with SMTP id 5b1f17b1804b1-495522fda7amr90343265e9.0.1784536782012;
        Mon, 20 Jul 2026 01:39:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e94:b0:495:522f:d994 with SMTP id 5b1f17b1804b1-495522fda7amr90342865e9.0.1784536781447;
        Mon, 20 Jul 2026 01:39:41 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954ba2abd0sm234410465e9.15.2026.07.20.01.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:39:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:39:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v4 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <al3bcMk0ZxMGq7Pt@sgarzare-redhat>
References: <20260714151638.143019-1-andrey.drobyshev@virtuozzo.com>
 <20260714151638.143019-5-andrey.drobyshev@virtuozzo.com>
 <alibLtcrC7o5r4Dh@sgarzare-redhat>
 <2f680236-f4c1-418b-8401-4dea1230caf0@virtuozzo.com>
 <alj_YKTitwqMjAez@sgarzare-redhat>
 <55d7c896-b871-4c50-a324-35f5c4a9d11a@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <55d7c896-b871-4c50-a324-35f5c4a9d11a@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -N-62kAUTtD_PtcyErh06bK-vphxUAFJEmRmPFC6VN0_1784536782
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 16, 2026 at 09:01:22PM +0300, Andrey Drobyshev wrote:
>On 7/16/26 7:13 PM, Stefano Garzarella wrote:
>> On Thu, Jul 16, 2026 at 06:39:48PM +0300, Andrey Drobyshev wrote:
>>> On 7/16/26 11:57 AM, Stefano Garzarella wrote:
>>>> On Tue, Jul 14, 2026 at 06:16:37PM +0300, Andrey Drobyshev wrote:
>>>>> vhost_vq_work_queue() only holds the RCU read lock while it dereferences
>>>>> vq->worker and queues work on it.  vhost_workers_free() however clears
>>>>> the vq->worker pointers and immediately frees the workers, without
>>>>> waiting for a grace period.  A caller that fetched the worker right
>>>>> before the pointer was cleared can therefore still be queueing work on
>>>>> it while it is freed.  And even when the queueing itself wins the race,
>>>>> the work is never run, so its VHOST_WORK_QUEUED bit stays set and all
>>>>> future attempts to queue it are silently skipped.
>>>>>
>>>>> None of the current callers can actually hit this: net and scsi stop
>>>>> their virtqueues before the workers are freed, and vsock unhashes the
>>>>> device and does synchronize_rcu() of its own in vhost_vsock_dev_release()
>>>>> before the workers go away.  But the upcoming VHOST_RESET_OWNER support
>>>>> in vhost-vsock keeps the device hashed while its workers are freed, so
>>>>> the lockless send/cancel paths become able to race with the teardown.
>>>>>
>>>>> Close this the way vhost_worker_killed() already does: clear the
>>>>> vq->worker pointers, wait for a grace period, run whatever the last
>>>>> readers may have queued, and only then free the workers.  The
>>>>> synchronize_rcu() is skipped if the device has no workers, so cleanup of
>>>>> devices which never got an owner stays cheap.
>>>>>
>>>>
>>>> Do we need a Fixes tag for this?
>>>>
>>>
>>> I'm guessing it should be:
>>>
>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>
>>>> Thanks for pointing out that the issue wasn't occurring, but I think we
>>>> should add it because it's a sneaky problem we discovered by chance.
>>>> IMO the code should already have `synchronize_rcu()` after
>>>> `rcu_assign_pointer()` loop.
>>>>
>>>> @Michael, what do you think?
>>>>
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>> ---
>>>>> drivers/vhost/vhost.c | 15 +++++++++++++++
>>>>> 1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>>>>> index 4c525b3e16ea..0d1414d40f4e 100644
>>>>> --- a/drivers/vhost/vhost.c
>>>>> +++ b/drivers/vhost/vhost.c
>>>>> @@ -729,6 +729,21 @@ static void vhost_workers_free(struct vhost_dev *dev)
>>>>>
>>>>> 	for (i = 0; i < dev->nvqs; i++)
>>>>> 		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>>>>> +
>>>>> +	/*
>>>>> +	 * vhost_vq_work_queue() reads vq->worker under rcu_read_lock(), so a
>>>>> +	 * caller that fetched a worker before we cleared the pointers above
>>>>> +	 * may still be about to queue work on it.  Wait for those RCU readers
>>>>> +	 * to finish before freeing the worker, then run whatever they queued
>>>>> +	 * so nothing is left with VHOST_WORK_QUEUED set.  Mirrors
>>>>> +	 * vhost_worker_killed().
>>>>> +	 */
>>>>> +	if (!xa_empty(&dev->worker_xa)) {
>>>>> +		synchronize_rcu();
>>>>> +		xa_for_each(&dev->worker_xa, i, worker)
>>>>> +			vhost_run_work_list(worker);
>>>>> +	}
>>>>> +
>>>>
>>>> Following sashiko review [1], I tried to undersand why we need this, but
>>>> TBH I'm really confused. That said, this seems wrong also because it
>>>> will work only with vhost_tasks, and not with kthreads.
>>>>
>>>> IIUC vhost_worker_killed() will be called anyway when calling
>>>> vhost_worker_destroy(). For vhost_tasks, it will call
>>>> vhost_task_do_stop() that calls vhost_task_stop(). This sets
>>>> VHOST_TASK_FLAGS_STOP and wait the worker on vtsk->exited before freeing
>>>> stuff. The worker breaks the loop and calls vtsk->handle_sigkill() that
>>>> is exactly vhost_worker_killed() you mentioned we are mirroring here.
>>>>
>>>
>>> Hmm, are we sure it's the case for our codepath?  Looking at the
>>> vhost_task loop function:
>>>
>>>> static int vhost_task_fn(void *data)
>>>> {
>>>>     for (;;) {
>>>>         if (signal_pending(current)) {
>>>>             if (get_signal(&ksig))
>>>>                 break;
>>>>         }
>>>>         ...
>>>>         if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>>>             __set_current_state(TASK_RUNNING);
>>>>             break;
>>>>         }
>>>>         did_work = vtsk->fn(vtsk->data);
>>>>         ...
>>>>     }
>>>>
>>>>     ...
>>>>
>>>>     if (!test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)) {
>>>>         set_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags);
>>>>         vtsk->handle_sigkill(vtsk->data);
>>>>     }
>>>>     ...
>>>> }
>>>
>>> AFAICT, we exit the loop in 2 cases: signal delivery or STOP bit
>>> setting.  Like you said, STOP is set by vhost_task_stop.  E.g. for our
>>> RESET_OWNER case:
>>>
>>> vhost_vsock_reset_owner()
>>>  vhost_dev_reset_owner()
>>>    vhost_dev_cleanup()
>>>      vhost_workers_free()
>>>        vhost_worker_destroy()
>>>          vhost_task_stop()  // for vhost_task_ops backend
>>>            set_bit(VHOST_TASK_FLAGS_STOP)
>>>
>>> So, first of all, actual work by .fn() callback is done after the exit
>>> checks, therefore we skip it - no chance to drain there.
>>>
>>> Secondly, the handle_sigkill() callback is deliberately NOT called in
>>> the STOP case and only called on fatal signal delivery.  And for
>>> vhost_task backend the .handle_sigkill() callback is exactly
>>> vhost_worker_killed().
>>>
>>> So my understanding is: if we only call synchronize_rcu() here and leave
>>> this path undrained, then whatever work which was put by send_pkt() for
>>> the worker currently being freed - will be lost.  Please correct me if
>>> I'm wrong.
>>
>> Yep, your right. But what will be the issue of loosing them?
>>
>> IIUC we are not loosing any data, just avoiding some works that will be
>> handled later when/if will set a new owner.
>>
>
>But will it actually be handled?
>
>vhost_transport_send_pkt()  // called on every packet send
>  virtio_vsock_skb_queue_tail(&send_pkt_queue, skb) // add skb to list
>  vhost_vq_work_queue(&send_pkt_work) // try to arm the work
>    vhost_worker_queue()
>      if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>        llist_add(&worker->work_list)
>      }
>
>So send_pkt_queue is a list of skbs, it lives on the vhost_vsock device
>state, and survives RESET_OWNER.  In that sense you're probably right
>that we aren't loosing any data.
>
>There's also send_pkt_work object, also living on the vhost_vsock device
>state.  So we're accumulating skbs, and then send_pkg_work gets put in
>the worker task list - but only if it's NOT already armed in there, i.e.
>QUEUED bit is unset.  And the bit gets cleared by the workload callback
>- for vhost_task backend it's vhost_run_work_list().
>
>The most important thing is WHERE this piece of work is being put.  That
>is worker->work_list - this list does not survive RESET_OWNER, as we
>free the worker in vhost_workers_free().
>
>Now imagine we have RESET_OWNER racing with send_pkt.  In
>vhost_workers_free() we acquire ptr to a worker but not NULL'ify it yet.
> Then on the send_pkt path we arm the send_pkt_work, set the QUEUED bit,
>and place it on the work_list of a DYING worker.  Then the worker gets
>freed.  Now we have send_pkt_work (a singleton struct) with QUEUED set
>in its flags, and with no worker to walk through this piece of work and
>clear this flag.  As a result - send_pkt_work can't be placed in the
>list of any other worker, because it doesn't pass the "if
>(!test_and_set_bit(QUEUED)" check.  Thus no new packets can be
>processed, and the connection is stalled.
>
>Does this make sense?

Honestly, I don't see the problem. The device is about to be stopped 
because the VMM is resetting the owner, so the connection is going to 
stall anyway, since I don't think the guest will never answer, isn't it?

>>>
>>> That said, I agree that vhost_run_work_list() will only work with
>>> vhost_task backend, not with kthreads backend.  If we do
>>> vhost_worker_flush() instead - I guess it'll keep the drain here, yet
>>> become backend-agnostic. I.e.:
>>>
>>>> +       if (!xa_empty(&dev->worker_xa)) {
>>>> +               synchronize_rcu();
>>>> +               xa_for_each(&dev->worker_xa, i, worker)
>>>> +                       vhost_worker_flush(worker);
>>>> +       }
>>>
>>> With the last 2 lines being equivalent to just calling
>>> vhost_dev_flush(dev).  And once we become backend-agnostic here, I'm
>>> guessing the warning reported by Sashiko should be dealt with as well.
>>
>> I'd avoid `if !xa_empty(&dev->worker_xa)` at all, and call
>> synchronize_rcu() in any case.
>>
>
>Agreed.
>
>> About vhost_dev_flush(), we are calling it in several places, and maybe
>> we should re-check them. E.g. we call in vhost_vsock_flush(), but it's
>> also called by vhost_dev_stop(), maybe we can avoid to call
>> vhost_vsock_flush() if we call vhost_dev_stop().
>>
>> I'm not sure we really need another one here, but if you think some
>> other works can be queued between the vhost_dev_stop() and the
>> synchronize_rcu() we are adding here, then okay, it may have sense.
>>
>
>Note that in our particular case we're gonna do:
>
>vhost_workers_free()
>  vhost_dev_flush()  // the flush we're planning to add
>  xa_for_each(&dev->worker_xa, i, worker)
>    vhost_worker_destroy(dev, worker)
>  xa_destroy(&dev->worker_xa)
>
>So we walk through the XArray, destroy workers in it one by one, then
>destroy the XArray itself.  Then the next time we call
>vhost_dev_flush(), e.g. from vhost_dev_stop() or wherever else, it tries
>iterating over the XArray which no longer exists - which is gonna be a
>no-op.
>
>Now, we can reach vhost_workers_free() via (at least) 2 paths:
>RESET_OWNER and device release path.  On the former the flush is needed
>as I illustrated above.  On the latter it's indeed redundant but is
>cheap as it's a no-op.

Again, I don't see the need for it TBH, but at the same time, I don't 
think it's a problem to include it, so if you think it's necessary, go 
ahead and add it.

Thanks,
Stefano

