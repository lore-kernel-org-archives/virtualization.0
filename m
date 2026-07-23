Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF14C0436
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817571; cv=none; b=DSrmNH1qiygrvLUDESF0W6YxR/drGp1CX8A0e3BhuIclwpaVnm7n1KTmT9LH39GHmrbKL41n4krDaQrjmiGnK+Qtwpf6V6nraoc0nhdNkQ9EHv7vMxLjRFALQIsOlRKfR15rQysuyBAaBf0hiVfq2HqY7CzAieoV1l0nDrFVT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817571; c=relaxed/simple;
	bh=epZHNJdb1jvaOZ4O6cy2hUvP2FOzogSGFkn2SNuLRcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SRl9cMxEKMFYsXcSkVx0xT2ODeUT0n0rzfWxHN6VKpHM8E8Sz17CHAVfnnelymmlSRA2yk539ooNPsRnGdlzdQbBh8SpDS7BslD+6p8JLdF+JDyf5xkTJAdNs8HkGRIzIzXeVYKSVzZw3GLJIPuJ8Hs3DozGhFS077R8pU04JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP8n1E3w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MP8n1E3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784817560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gqFSWQaMTz+T5mXHuwtGx1/VHZD0uStv1s9M8jprGVg=;
	b=MP8n1E3wkpjQpj98nIEC11pHyU6OaUVvEILOWuYB/HQtvbZ/UgsLwaasA8ovyi8Hy9zFEt
	B4dOYSnt1Hh0SZuHKNFGIum4DlfQX8Kv1nN0CQJSix+cGa05+Cyi0QnxLUUXyMQ/PWfDVR
	Ci1QsCkvfoj6egblcfKV8TocKqtehFg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60--zwwoprdO8e0T1lbqePX8w-1; Thu, 23 Jul 2026 10:39:18 -0400
X-MC-Unique: -zwwoprdO8e0T1lbqePX8w-1
X-Mimecast-MFC-AGG-ID: -zwwoprdO8e0T1lbqePX8w_1784817558
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4740be00302so683394f8f.2
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 07:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784817557; x=1785422357;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqFSWQaMTz+T5mXHuwtGx1/VHZD0uStv1s9M8jprGVg=;
        b=kGg/5MULzoZMu+8r25I5M81xN/A3bKhlw6pYRuOStoYkweraZqZR2XD+S7gnOJ4xjB
         1Nb0MXoshhXosO+sOh3C5sneodttOjjbVrUiwjxb7DuLwoNAvv0YQYYxTYvTdCxfBwoy
         LvRFpqhKfpKebeQ2JNbOJ72ac0+1p/nHFc6blpMdHlImVk49Rtl/L7XitTNrhufOJAQL
         14H/+AZQsMKDu9oBY231u6E3//Vy57JHQO1DboI9y20xowlgClDeB8EKqsPmR6QhIKxz
         8yh8UX1lqZJY4Bjs3sZw5FcRpE0rS/HfOQzfTxq3nud/+iO88fsuVQGYRZAXfv7EFTsq
         8wlA==
X-Forwarded-Encrypted: i=1; AHgh+RopOfL3CgoO3vjSLiEgwJbgD0jhzMaYJ9wexEbRgK/qvcxs9oxGdPm3tUWrVzLXmc01zLBH7yk3444uR6V6yg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrkyDk0Q3VFyr7evOdUC6wvgBGEcUODUEpnGMwP7b5Pm+XMmOV
	v2DdKRvi0A3XvHUNUIzX6SPe8dg4vxlIdwtR1XplohzPycGt7+bxtI8NkUx5p2dPxWy5M9ZVyQb
	w8prqCXgPX8VY4bxonUnxKdjHwikCwpZU54C3PJTZwHmW8ul4kWrlnVEH+ApjE6z4ZoayGL43P/
	Ke
X-Gm-Gg: AR+sD11FuD+EKcvy/ZJgV8krl1HfuSBdtHeO5jrsh9T9uzHcM+QY44Y8rMsukvr/iHP
	UqVFGjuvwkSrIhfjuA+AKRN3yEpkkuCwm8kNlRXoDFS9qab/aBlQ0R4GyuK66w+D/xfATQkf8U8
	Z+qj3tabmZLvFf4euCz4rQeIk2T3lOLt71/ZOEmyXVMeeDT5rYEHWtrL0XOBOfIy6MDvOVdQu55
	B9yz4i2QznybcDW+myUx6E8OzWC7ACco5gEqWai2lfyExRDrQAXafoO6QtoeYM4dAlsyPp2BEfG
	V6vsTXg+NBUF0QtSbEuEJydBJkNddvHcnWXvl9umnkBPlJKi8Pc+3ZOhkF04vdqFMhy4lcQEUMB
	Z4AERyaM5v2pDA3/y6Jm8pvMVN6P24ZUORPTLko68ngpn0cEhEg==
X-Received: by 2002:a5d:5e87:0:b0:47f:6d9a:d7a6 with SMTP id ffacd0b85a97d-47f8d72996fmr4387780f8f.25.1784817557345;
        Thu, 23 Jul 2026 07:39:17 -0700 (PDT)
X-Received: by 2002:a5d:5e87:0:b0:47f:6d9a:d7a6 with SMTP id ffacd0b85a97d-47f8d72996fmr4387716f8f.25.1784817556761;
        Thu, 23 Jul 2026 07:39:16 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c531basm15770037f8f.19.2026.07.23.07.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:39:15 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:39:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amInL2hPEG9ejUd0@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <amCPLOrnpYmr5n0p@sgarzare-redhat>
 <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
 <amIe79X3j7GxDBdO@sgarzare-redhat>
 <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f21667c3-64f1-40c6-9941-9453af173eda@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: akUP-svkSRuhzL8f7AVgUlc_MPqWp_8ruC-zfDMc9PE_1784817558
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 23, 2026 at 05:29:12PM +0300, Andrey Drobyshev wrote:
>On 7/23/26 5:03 PM, Stefano Garzarella wrote:
>> On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
>>> On 7/22/26 12:43 PM, Stefano Garzarella wrote:
>>>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
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
>>>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>>>> period, and then flushing the workers so any work the last readers
>>>>> queued runs before the workers are freed.
>>>>>
>>>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>> ---
>>>>> drivers/vhost/vhost.c | 11 +++++++++++
>>>>> 1 file changed, 11 insertions(+)
>>>>
>>>> Sashiko reported some potential issues here:
>>>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
>>>>
>>>> IMO the first one is pre-existing, but not really sure it is a real
>>>> issue since happening when the worker/vmm is going to be killed.
>>>>
>>>
>>> Sashiko claims:
>>>
>>>> Will this leave the queued work unexecuted and permanently break the
>>> virtqueue by leaving VHOST_WORK_QUEUED set?
>>>
>>> I agree this issue is pre-existing and doesn't have much to do with our
>>> series here.  It looks real, but in reality should be harmless since we
>>> may only hit it while the device already dying.  Means there's no VQ
>>> state to be saved.  The only potentially observable artifact I guess is
>>> a warning here:
>>>
>>> vhost_workers_free()
>>>  vhost_worker_destroy()
>>>    WARN_ON(!llist_empty())
>>>
>>> So more of a cosmetic noise on a dying device.  Again, not relevant to
>>> this series.  But one optional way to make it go away would be to clear
>>> vq->worker under vq->mutex in vhost_workers_free() (mirroring
>>> vhost_worker_killed()).
>>>> The second one also not sure if it's an issue since the sender is not
>>>> lockless IIUC.
>>>>
>>>
>>> The term 'sender' is confusing here:
>>>
>>> * vhost_transport_send_pkt() is the .send_pkt() method of struct
>>> virtio_transport.  It only stores skbs into the queue, doesn't process
>>> them. It indeed is lockless as it doesn't take vq->mutex.
>>>
>>> * vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
>>> It's called by the worker thread to process skbs in the queue, calls
>>> vhost_transport_do_send_pkt() which does in turn take vq->mutex.
>>>
>>> I think sashiko points out to the former.  Still, I don't think it's an
>>> actual bug.  Look:
>>>
>>> 1) By invoking flush, we wake the worker thread:
>>> vhost_dev_flush()
>>>  __vhost_worker_flush()
>>>    vhost_worker_queue(flush.work)
>>>      worker->ops->wakeup()
>>>
>>> 2) Then woken worker does:
>>> vhost_run_work_list()
>>>  llist_for_each_entry_safe(work) {
>>>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
>>>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
>>>  }
>>>
>>> 3) And then in work->fn() (vhost_transport_send_pkt_work):
>>> vhost_transport_send_pkt_work()
>>>  vhost_transport_do_send_pkt()
>>>    if (!vhost_vq_get_backend(vq))
>>>      goto out;
>>>
>>> As you can see, we return early in case backend was unset.
>>>
>>> So after doing this flush, we have: 1) QUEUED bit is unset; that makes
>>> send_pkt_work re-queueable. 2) But the queue doesn't actually get
>>> processed, and VQ state isn't actually touched here - so I guess
>>> Sashiko's conclusion is incorrect and there's no actual bug.
>>>
>>>> But, please can you double check them?
>>>>
>>>
>>> In general I'd leave this patch as-is as Sashiko's complaints aren't
>>> very convincing so far.  If you want I can add another patch which wraps
>>> NULLifying workers in vhost_workers_free() in vq->mutex.
>>>
>>> WDYT?
>>
>> Yeah, I agree, about the other patch, up to you, but I'll eventually
>> send it separately.
>>
>> Thanks,
>> Stefano
>>
>
>Alright, then let me resend it once more along with this 6th patch, so
>that we don't have it uncovered.

But why it should be part of this series?

If there is no strong reason, I'd send it as a separate patch.

E.g. even this patch in theory may be a separate one, but this is 
related to this series, so makes sense to have this included.

Thanks,
Stefano

