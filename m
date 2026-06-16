Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758C3BE650
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626419; cv=none; b=VxONjnxkgaGxeJ4GNZWO6HkAWDB2Kifb86+1oa9BCEnVGt064eOkJZzB9MEKeIDrf57GpJsPFCGOPnOwBP5l86PadOMr/HP7GUEWqFcSSaVGlCMwFqDnNj4NIDmr+N89BqDlMDWCm5NMMf1xUXZYEY4VytNI0cqQt0OBPQCsppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626419; c=relaxed/simple;
	bh=I6hDshcql7hu2jZUKkXZROC4LwQYUnvoGKyBIzxyt6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dnf18pInYoqNIAzOEYLbt19aLac2scmnfH6DQicwxfkx4T0rsKudWwbx1aOmhi4Ga7A0YQV8ypgz7NtkXb3Yu4C9mauuwDuXebMBpUJ1H5dZDBK05wBIRN77gpKUB9DALKkSQ8rSHaHGjkQXje4qmLOUYmisnP5FUFM2BU1yg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQLf2Ege; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQLf2Ege"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781626417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
	b=UQLf2Ege9yUzBKsA+m8rL2dhB+sOqKVpfX0jnbM0r4QO6dpAiQxh5qnnFmC2Cgmz3ELBQw
	EUsgUUSRYeKyCZty4mVp4TGfmhcJflJN3g1NfTHE6MkadchS6TNdOwmyk6oDuCIY3FGIrH
	aUPuWUA/Rc6tYLuEWB5hENrS1lBAVhc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-x3eA5towMH-9xOqLXm5dmg-1; Tue, 16 Jun 2026 12:13:34 -0400
X-MC-Unique: x3eA5towMH-9xOqLXm5dmg-1
X-Mimecast-MFC-AGG-ID: x3eA5towMH-9xOqLXm5dmg_1781626413
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490afe64f26so122405e9.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 09:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626413; x=1782231213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcm9nGjfceIF2EHrZZqsS5ZGgLaEGuCuXjnHMYeIjik=;
        b=KDQaqM8CuRJC+vhVS9J7HPgFtpkweBICbz1BqbhkCZ59FJuKDq9iQ6++H5eK1sdE/S
         E/7V6dRuhkfmyG+r58ZzddemcjQ1etVr1VFI5QkVQBVVOl6UwfIM424lgDdRTzFg7lvP
         9ObQTiw0KT8c9UozdfurrJ+oYI1rtVrJfPZ6YZtvw2m0xoNibiFE1WW2a/YQtFyMFSSI
         CoV6IVS2UZjKtOVQWVGayDzzNcBJYF5iilPQpKSp9vWGHRzjVac+3ZFH5k46RW/XFgla
         949qDC3rWMHNHXgaF8YPVEc69qGNAsI/+EbByWAZt1QZrCvXwZNwRS0BTKi5ek2MAWFG
         pTRw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZpiI5zePpGZliyzWWArDqRQ1STn2bh659AcI+I/DFsfF8kSH1Gf8xXBunRkn2mE4SzeNmpQqvA8fJpGP+uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyM3ZoJM8Y7o23YgeZufsPXUYauKU2fMSwUPeGeSCKKcuBrIBcK
	wXRgIzLe4Hu0+J8PxiBYDs1XYAPd2i4d+bDzXbg2mi1eyLOMhKiMiidmeEc2Sir4xo2bnQg+KAM
	c2j8Meg9JgptCivmlzA0v8v0a8Q/Djc74OwKH+scJY14TzguvaCRLPFPldR1MWoTDUylDJQB3Ut
	tB
X-Gm-Gg: Acq92OGlSXx67XcIdbngi1piDZ5bsMIyH43S4MEuiWP/xjwH6SwMf0jL9u2pTSC8Fal
	BTkAFBlM2/MHYdJkLwVBx/TGhz8mxo6opxnJENG4o78HJSGDdWnZY/Z0CSB/X09IIKBmWcnMcBF
	Cn0jHXUA4rcppcNPo+jUUL4xER8xBb8WMNnL9zKy+qTG3f2XfiYZt0u89TVmjWSQgMTDgbzAysI
	CbHsFKo+zLhpnVYhRV5HoQx23dqPPUBwkrA1GEk0G1XyYFUqjQbQPFfycYdZkcdBNl7WGWH8Pew
	LDi/+SM99dtROIBv2lErvbgGjeKShS2EvWQdJwdozaNP38gGtH6lbK8zD12V+hMfo6CSPJ4/L4+
	TKQGeBNDEJh8Vg2RLNRJmyVmPQBf8cqQQN2b5LLG/qwnzmxW+l/x+i4FORsB4JisSLkm1SvY=
X-Received: by 2002:a05:600c:19cc:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-492332c11dfmr4760595e9.2.1781626413350;
        Tue, 16 Jun 2026 09:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:19cc:b0:490:9dc3:3483 with SMTP id 5b1f17b1804b1-492332c11dfmr4759895e9.2.1781626412794;
        Tue, 16 Jun 2026 09:13:32 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c4240sm41852524f8f.27.2026.06.16.09.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:13:31 -0700 (PDT)
Date: Tue, 16 Jun 2026 18:13:19 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 3/4] vhost/vsock: suppress EHOSTUNREACH fast-fail during
 CPR pause
Message-ID: <ajF0To9N3yc2NlIr@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-4-andrey.drobyshev@virtuozzo.com>
 <ajFUk7quPhbI7Te-@sgarzare-redhat>
 <021a6604-289c-4dd8-a0be-33c7812c0105@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <021a6604-289c-4dd8-a0be-33c7812c0105@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aWa1HyVC5GYpU4sMm4DOjLneSj0u6I884Pp5fccPfGg_1781626413
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 16, 2026 at 06:58:40PM +0300, Andrey Drobyshev wrote:
>On 6/16/26 5:18 PM, Stefano Garzarella wrote:
>> On Fri, Jun 12, 2026 at 07:57:17PM +0300, Andrey Drobyshev wrote:

[...]

>>> static u32 vhost_transport_get_local_cid(void)
>>> @@ -311,11 +312,17 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>>> 	 * the mutex would be too expensive in this hot path, and we already have
>>> 	 * all the outcomes covered: if the backend becomes NULL right after the check,
>>> 	 * vhost_transport_do_send_pkt() will check it under the mutex anyway.
>>> +	 *
>>> +	 * Don't fast-fail if cpr_paused is set, keep queueing skbs instead.
>>> +	 * The kick in vhost_vsock_start() will drain them on resume.
>>> 	 */
>>> 	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
>>> -		rcu_read_unlock();
>>> -		kfree_skb(skb);
>>> ]		return -EHOSTUNREACH;
>>> +		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
>>> +		if (!READ_ONCE(vsock->cpr_paused)) {
>>
>> Can we avoid this which is not really readable and maybe add a single
>> variable to control the fast-fail at all?
>>
>> I mean replacing both cpr_paused + backend-pointer with a single
>> `started` flag: set it to false at open, true on start via
>> smp_store_release(), back to false on normal stop, and leave it true
>> during CPR pause.
>>
>> The reader in send_pkt can do just:
>>
>>      if (!smp_load_acquire(&vsock->started))
>>          return -EHOSTUNREACH;
>>
>> WDYT?
>>
>
>I don't think it's gonna work as suggested.  As I understand, the order
>during CPR migration is:
>
>1) SET_RUNNING(0)
>       -> vhost_vsock_stop()
>           -> vhost_vsock_drop_backends()
>2) RESET_OWNER
>       -> vhost_vsock_drop_backends()
>3) SET_OWNER
>4) SET_RUNNING(1)
>       -> vhost_vsock_start
>           -> for (...) vhost_vq_set_backend()
>
>(Btw I just noticed backends are already NULL at step 2), but that's
>just our CPR case, for any potential RESET_OWNER users it might not be
>the case).
>
>So the race windows starts from 1) (not from 2)).  We have no way of
>differentiating whether device is actually being stopped for good, or
>we're in the middle of CPR.  If we set the flag to false on stop as you
>suggested, we'll still hit the -EHOSTUNREACH case eventually, and
>avoiding it is the whole purpose of this patch.
>
>The fast-fail with -EHOSTUNREACH relies on the presence of backends.
>IIUC the backend will only become set after initial SET_RUNNING(1),
>which will only happen once the guest driver writes smth to virtio
>config register, QEMU catches it and calls SET_RUNNING(1).  So we have
>ordering with the guest's actions here, which is logical.  But for our
>issue that means that the only true marker of paused/not paused is the
>presence of backends - and that's why the flag is set in
>vhost_vsock_drop_backends().

Okay, so what about avoiding to set `started` to false in 
SET_RUNNING(0)? I mean use it just to track the first SET_RUNNING(1).
(And maybe changing the name to that variable).

Apart from CPR, when can SET_RUNNING(0) occur?

At the end that was just an optimization, if we queue the packet is not 
a big issue IMO.

>
>>> +			rcu_read_unlock();
>>> +			kfree_skb(skb);
>>> +			return -EHOSTUNREACH;
>>> +		}
>>
>>
>> That said claude here is reporting a potential issue that I think we
>> should consider:
>>      After VHOST_RESET_OWNER, the guest CID stays in the hash, so
>>      vhost_transport_send_pkt() can still find the vsock, skip the
>>      fast-fail (cpr_paused=true), and call vhost_vq_work_queue() while
>>      vhost_workers_free() is freeing workers without a synchronize_rcu()
>>      — risking a use-after-free. Also, any send_pkt_work queued between
>>      the last flush and worker teardown gets its VHOST_WORK_QUEUED 
>>      bit
>>      stuck (the vhost task exits without draining), deadlocking
>>      host→guest traffic after restart.
>>
>>      A synchronize_rcu() in vhost_workers_free() between the
>>      rcu_assign_pointer(NULL) loop and the destroy loop would close the
>>      use-after-free, and reinitializing send_pkt_work via
>>      vhost_work_init() after vhost_dev_reset_owner() returns would clear
>>      the stuck QUEUED bit.
>>
>>
>
>Yes, this looks real indeed.  Though I couldn't hit the UAF issue while
>testing host->guest transfer under KASAN.
>
>>> 	}
>>>
>>> 	if (virtio_vsock_skb_reply(skb))
>>> @@ -640,6 +647,9 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>>> 		mutex_unlock(&vq->mutex);
>>> 	}
>>>
>>> +	smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>>> +	WRITE_ONCE(vsock->cpr_paused, false);
>>> +
>>> 	/* Some packets may have been queued before the device was started,
>>> 	 * let's kick the send worker to send them.
>>> 	 */
>>> @@ -671,6 +681,11 @@ static void vhost_vsock_drop_backends(struct vhost_vsock *vsock)
>>>
>>> 	lockdep_assert_held(&vsock->dev.mutex);
>>>
>>> +	if (vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])) {
>>> +		WRITE_ONCE(vsock->cpr_paused, true);
>>> +		smp_wmb();	/* pairs with smp_rmb() in send_pkt */
>>> +	}
>>
>> Why here and not in vhost_vsock_reset_owner()?
>>
>> Also having this here will set it to true also with
>> VHOST_VSOCK_SET_RUNNING(0), is that right?
>>
>
>That was added here precisely to cover the vhost_vsock_stop() case (see
>above).

I see now, a comment or something in the commit would have helped.

Thanks,
Stefano

