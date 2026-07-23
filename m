Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0033C18B
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815414; cv=none; b=ZOCJRqFl/HMtLK+DxbEZ1ZzTUEKrevf5D8YKzkx/PCzBbKTN2NTEqpK52VyuOIRwJBCKZ+HkdLbdeto+qtAOT2U0HMskLaIAV0TJwlBtsiyIDagP1QMbcxaUTJbY7bNHw0JPNzv+JsI3u4EN18wXQGak/mZ+5oKo2bUi5yuYQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815414; c=relaxed/simple;
	bh=EVWutf23s/oOQfhofJPqDNYbR+2MaeOSPLVgIc90TwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DFm48cvI1qO/CsciEHkHje424lnNJ/P6i9ZLKqtSreN354ZhrzT0DKq1scVhq17qOOGSaSYLH71oiGDwCP9eYsCryk6Un0AFoyN2IvCiHtEMdMXUnrL4Hn3KthxN4oIkLZ456L3J2A+L2uDMXrht1UIfFwc2twRQOY1FI0SiaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnD9hTrG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnD9hTrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KHv44vLStOGdeWCOIZDC6gv5b89UGcYrbfGwIxzvwo=;
	b=cnD9hTrGJX6x4xuI0VHTEikp3F+plGjKZ/7cuu1NHqK7NJnFFCTa9XXahObY2TL8BsBmSR
	Tcm1ZtB+55yzKqLV9qPvQsGxWjC3fmKFJmkXK4ghoheoKiH58N1/WyVBl/bnJ7gz75rzyj
	RZqQp/4YC1nocqUO8lyFM6gUgYYho58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-90EOFRNsO5m7afYvqyKmUA-1; Thu, 23 Jul 2026 10:03:29 -0400
X-MC-Unique: 90EOFRNsO5m7afYvqyKmUA-1
X-Mimecast-MFC-AGG-ID: 90EOFRNsO5m7afYvqyKmUA_1784815409
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475e540a0ffso437448f8f.3
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 07:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815408; x=1785420208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KHv44vLStOGdeWCOIZDC6gv5b89UGcYrbfGwIxzvwo=;
        b=MNgXjqdUYBRN0vBKSkdPY3DJECvOY4d19jk6tq/hyCa007fAD/cwiBN7bMHJhu/JR3
         s7hXu7+LsxvSLCfXtWdtMHF1YcDrOTVM8kVCmg2jlqXuU5o2/UXhCaMrBi6OCv8SjhxT
         QIrmT80WnFyn67bAm6tMd50rnDCpVc8+2rl1TfMWi5Nz/RRogGPgwtpgSoI4izTxYOr2
         X79QlyVNANIZQTEES7HAeFEMCmqEJrPuGlRb1qUZm1syewx6UJ1fJDUB4ohI51QqXSww
         1jqHImSNVeR7VfwqorXrvEYExkh4MPgbLVRy6Z+YvcuCqOQYT2S7GC1nsPxsIF5S8ltz
         0Jew==
X-Forwarded-Encrypted: i=1; AHgh+Ro7bX5whdr4gb8wUAbJJ2bBtRQQvrpKO/0TNNknekipCiLtDDDBXb1eu34p0NKOkyQG9Uos1xIwYxnENRmf3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQjDic316oHpn4A/yidpnRGU8gmPaLz0Zm5TiZm1+W53TM4usO
	pqmRK38IuOIOXphCTsiafZYJ/S4qD7MhU9mb8KeePKc88nAqO2YEbxhoW9AYhOVEYcoMc515iz+
	mgO3r0BZEAEmc1hc8JvafHGNtuy2fg1OI0NDKJGZjFYF83HzoU+hanH8zagYO2V/suz97
X-Gm-Gg: AR+sD11zu9bwLvwBFZgmNEQlTJp+X2vIOqJhSbOXzlQnAzh/YajTIBDoxUq9z+zdsYT
	xZWPWKtMNxwUSvxeyqTCeaQ6ZrnL9pOJncX+7ZvX8j3DvZgYvOiZDu/jGvZarW5QZ1e208Qf50i
	MmFALdz/w0dHlmTo8N/bzFABkn0+cZJ8faOthibP70OXz5Q1OKLltfZ3oSjTcvi+swUMR8qOoJB
	Hq7NeUGm/QtluALSQ1/rIjsX9U1eZu4rOo5GcfHey6XNVsmCwG0GZgNMflgBfQLGejEOvKLGHck
	AKwU43BOiKkSxWSaSIVX8xUAxAL7jxM8qdrSLXJ3mkZP4kkWpGWrkA0WYCg86wG6F7jzejEJCHp
	z8ZnDYPdFvrVwxpEFiFzTWU6ikKfzBMr7G2uz6gbuiPCG8xE1Cw==
X-Received: by 2002:a05:600c:8b83:b0:495:515a:dad9 with SMTP id 5b1f17b1804b1-49573cf8131mr35830775e9.37.1784815408559;
        Thu, 23 Jul 2026 07:03:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8b83:b0:495:515a:dad9 with SMTP id 5b1f17b1804b1-49573cf8131mr35829775e9.37.1784815407871;
        Thu, 23 Jul 2026 07:03:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-65.retail.telecomitalia.it. [82.53.135.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956536870esm228444165e9.3.2026.07.23.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:03:26 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:03:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v5 4/5] vhost: synchronize with RCU readers when freeing
 workers
Message-ID: <amIe79X3j7GxDBdO@sgarzare-redhat>
References: <20260720102241.371610-1-andrey.drobyshev@virtuozzo.com>
 <20260720102241.371610-5-andrey.drobyshev@virtuozzo.com>
 <amCPLOrnpYmr5n0p@sgarzare-redhat>
 <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <82066fcb-150f-47ef-86a7-0df0f9eb41c5@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KzknfmBCxNxvAbS_XkAhvlbNkmUFLzTvMKRn3Cb156s_1784815409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 23, 2026 at 04:57:47PM +0300, Andrey Drobyshev wrote:
>On 7/22/26 12:43 PM, Stefano Garzarella wrote:
>> On Mon, Jul 20, 2026 at 01:22:40PM +0300, Andrey Drobyshev wrote:
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
>>> Fix this by clearing the vq->worker pointers, waiting for a grace
>>> period, and then flushing the workers so any work the last readers
>>> queued runs before the workers are freed.
>>>
>>> Fixes: 228a27cf78af ("vhost: Allow worker switching while work is queueing")
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> drivers/vhost/vhost.c | 11 +++++++++++
>>> 1 file changed, 11 insertions(+)
>>
>> Sashiko reported some potential issues here:
>> https://sashiko.dev/#/patchset/20260720102241.371610-1-andrey.drobyshev@virtuozzo.com?part=4
>>
>> IMO the first one is pre-existing, but not really sure it is a real
>> issue since happening when the worker/vmm is going to be killed.
>>
>
>Sashiko claims:
>
>> Will this leave the queued work unexecuted and permanently break the
>virtqueue by leaving VHOST_WORK_QUEUED set?
>
>I agree this issue is pre-existing and doesn't have much to do with our
>series here.  It looks real, but in reality should be harmless since we
>may only hit it while the device already dying.  Means there's no VQ
>state to be saved.  The only potentially observable artifact I guess is
>a warning here:
>
>vhost_workers_free()
>  vhost_worker_destroy()
>    WARN_ON(!llist_empty())
>
>So more of a cosmetic noise on a dying device.  Again, not relevant to
>this series.  But one optional way to make it go away would be to clear
>vq->worker under vq->mutex in vhost_workers_free() (mirroring
>vhost_worker_killed()).
>> The second one also not sure if it's an issue since the sender is not
>> lockless IIUC.
>>
>
>The term 'sender' is confusing here:
>
>* vhost_transport_send_pkt() is the .send_pkt() method of struct
>virtio_transport.  It only stores skbs into the queue, doesn't process
>them. It indeed is lockless as it doesn't take vq->mutex.
>
>* vhost_transport_send_pkt_work() is the .fn() method of send_pkt_work.
>It's called by the worker thread to process skbs in the queue, calls
>vhost_transport_do_send_pkt() which does in turn take vq->mutex.
>
>I think sashiko points out to the former.  Still, I don't think it's an
>actual bug.  Look:
>
>1) By invoking flush, we wake the worker thread:
>vhost_dev_flush()
>  __vhost_worker_flush()
>    vhost_worker_queue(flush.work)
>      worker->ops->wakeup()
>
>2) Then woken worker does:
>vhost_run_work_list()
>  llist_for_each_entry_safe(work) {
>    clear_bit(VHOST_WORK_QUEUED, &work->flags)
>    work->fn(work) // for send_pkt_work = vhost_transport_send_pkt_work
>  }
>
>3) And then in work->fn() (vhost_transport_send_pkt_work):
>vhost_transport_send_pkt_work()
>  vhost_transport_do_send_pkt()
>    if (!vhost_vq_get_backend(vq))
>      goto out;
>
>As you can see, we return early in case backend was unset.
>
>So after doing this flush, we have: 1) QUEUED bit is unset; that makes
>send_pkt_work re-queueable. 2) But the queue doesn't actually get
>processed, and VQ state isn't actually touched here - so I guess
>Sashiko's conclusion is incorrect and there's no actual bug.
>
>> But, please can you double check them?
>>
>
>In general I'd leave this patch as-is as Sashiko's complaints aren't
>very convincing so far.  If you want I can add another patch which wraps
>NULLifying workers in vhost_workers_free() in vq->mutex.
>
>WDYT?

Yeah, I agree, about the other patch, up to you, but I'll eventually 
send it separately.

Thanks,
Stefano

