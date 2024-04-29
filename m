Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534392E405
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432744; cv=none; b=LyBSrSv2v7NraseOI1pdo0iKzbMg187109iYP+3Qb8g5QU86EFlkVpZ4luRmOBCQjQlk5fQWpxPm/AU0Vq+dAISBHIrPY/9a3tFOaRYpdmkb78UTDUywGZsQne4t8u4CODwep7VqPHBdZGTDBIcxKHq5IYFpvYVyzx2Xy2/jmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432744; c=relaxed/simple;
	bh=vTOF2vd+rQrUGIhh7UEzUMLPWMR8fkCMvvrnq0ZgmVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3Gr2fEDzQBsisJDq3h66/NKXBgtRyaK27RANnLgAdhxl30MgYrlzSlBnYSC+WKs/jj1HxODjO2u8bOBXAZFuOjXwboqDn2IlwSperx7d1xCreBYtx/fpMwzTKJeTW9/Cg3jCEGC+KUQAItEEnfFwjo7kDW0m9fKyYILyVJTBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUJnefPH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUJnefPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714432741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tm/mt/mgLve3JP468fwkI7uFCs6gMusulckDrbVSUAE=;
	b=hUJnefPHOD/D2kQ4I9i1kTS7aImL3KXDAMlLiD/m8wxAQRqatffqtOYFqHHKUtiP5pHUGh
	Z5Lvkqk1clmjFOLwbMHVK1PkQcIRsGV5jmPq9OpIIhMbhYdWLXmoPS0qV3vXtfdt4yBzTa
	Og59JyzMMzpCgGvrQij6DzBooLAfRZI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Sryxey2hMymNuMOQUQRvIw-1; Mon, 29 Apr 2024 19:18:59 -0400
X-MC-Unique: Sryxey2hMymNuMOQUQRvIw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e417e43c13so55330525ad.2
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 16:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714432738; x=1715037538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm/mt/mgLve3JP468fwkI7uFCs6gMusulckDrbVSUAE=;
        b=Ago5bS1/ltu9vLZCSE1kqsyAPhGtqIUc8JhKbHK7+fx5h3rB6khhtIx7K5NVfEuXmm
         pKAymS8vkOqW7HhQnDseRPBoKi2ahbRXxU/+Ary2nJHhDVV8tf+jPL/aKKJiz+WSfoas
         +wv7sj1Gzl6EjZA719VVHIOkAjXiBGeKkGIOwHahF+V0aFECjzW2U8oLK/w7MMWicOKe
         TqzrhBrOwnHvTCpsa0IOlvdLrrUbBp4WsNhahRztTloK6MxloteCGB+m/Vc54fsHze0Y
         lawr2bjykvjUmqG7lrJG1bEwKjXO4SWy8ndiVUQKJz03quHlq89bijZTmzUPWnakxUoj
         +Dxw==
X-Gm-Message-State: AOJu0YwKwFYAP8kkiVBGkF09lBmj47M+hhESo8DtLE8u4VYgGNoaiEVZ
	fdqDM8F2DSXY862dKvRel2pQ6huOGJUmFiu/A8Qf5pUG8mS07I7fInwSGKdNRm61ZIFwPkDyc0+
	s4hEbHchKVHkOyOfyuWIp4Rv/o6hrWi/QI+tIwnFt90Iig/ZKkcluXOVApvNnRuhU
X-Received: by 2002:a17:902:c402:b0:1e9:cf94:5bea with SMTP id k2-20020a170902c40200b001e9cf945beamr1264895plk.35.1714432738455;
        Mon, 29 Apr 2024 16:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9/SgTgBVXwsl5jd/hA/icQFiNotVAktlKm2qRyT8gzrh/lVa9R4syl6JuX6SKKSLzX98Ptg==
X-Received: by 2002:a17:902:c402:b0:1e9:cf94:5bea with SMTP id k2-20020a170902c40200b001e9cf945beamr1264879plk.35.1714432738070;
        Mon, 29 Apr 2024 16:18:58 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b001e0bbd8d0b0sm20912144plx.189.2024.04.29.16.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 16:18:57 -0700 (PDT)
Message-ID: <15c57863-2cb7-45e8-8c89-efc080580660@redhat.com>
Date: Tue, 30 Apr 2024 09:18:53 +1000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 jasowang@redhat.com, shan.gavin@gmail.com
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-2-gshan@redhat.com>
 <20240429143732-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240429143732-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 04:44, Michael S. Tsirkin wrote:
> On Mon, Apr 29, 2024 at 08:13:57PM +1000, Gavin Shan wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>
>> All the callers of vhost_get_avail_idx() are concerned to the memory
> 
> *with* the memory barrier
> 

Thanks, will be corrected in v3.

>> barrier, imposed by smp_rmb() to ensure the order of the available
>> ring entry read and avail_idx read.
>>
>> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
>> the avail_idx is advanced.
> 
> accessed, not advanced. guest advances it.
> 

smp_rmb() is executed only when vp->last_avail_idx != vp->avail_idx.
I used 'advanced' to indicate the condition. 'accessed' is also
correct since the 'advanced' case included to 'accessed' case.

>> With it, the callers needn't to worry
>> about the memory barrier.
>>
>> No functional change intended.
> 
> I'd add:
> 
> As a side benefit, we also validate the index on all paths now, which
> will hopefully help catch future errors earlier.
> 
> Note: current code is inconsistent in how it handles errors:
> some places treat it as an empty ring, others - non empty.
> This patch does not attempt to change the existing behaviour.
> 

Ok, I will integrate this to v3's commit log.

> 
> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> [gshan: repainted vhost_get_avail_idx()]
> 
> ?repainted?
> 

It's just a indicator to say the changes aren't simply copied from
[1]. Some follow-up changes are also applied. So it needs to be
reviewed. I will drop this in v3.

>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>> Acked-by: Will Deacon <will@kernel.org>
>> ---
>>   drivers/vhost/vhost.c | 106 +++++++++++++++++-------------------------
>>   1 file changed, 42 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 8995730ce0bf..7aa623117aab 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1290,10 +1290,36 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
>>   		mutex_unlock(&d->vqs[i]->mutex);
>>   }
>>   
>> -static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
>> -				      __virtio16 *idx)
>> +static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>>   {
>> -	return vhost_get_avail(vq, *idx, &vq->avail->idx);
>> +	__virtio16 idx;
>> +	int r;
>> +
>> +	r = vhost_get_avail(vq, idx, &vq->avail->idx);
>> +	if (unlikely(r < 0)) {
>> +		vq_err(vq, "Failed to access available index at %p (%d)\n",
>> +		       &vq->avail->idx, r);
>> +		return r;
>> +	}
>> +
>> +	/* Check it isn't doing very strange thing with available indexes */
>> +	vq->avail_idx = vhost16_to_cpu(vq, idx);
>> +	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
>> +		vq_err(vq, "Invalid available index change from %u to %u",
>> +		       vq->last_avail_idx, vq->avail_idx);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* We're done if there is nothing new */
>> +	if (vq->avail_idx == vq->last_avail_idx)
>> +		return 0;
>> +
>> +	/*
>> +	 * We updated vq->avail_idx so we need a memory barrier between
>> +	 * the index read above and the caller reading avail ring entries.
>> +	 */
>> +	smp_rmb();
>> +	return 1;
>>   }
>>   
>>   static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
>> @@ -2498,38 +2524,17 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>>   {
>>   	struct vring_desc desc;
>>   	unsigned int i, head, found = 0;
>> -	u16 last_avail_idx;
>> -	__virtio16 avail_idx;
>> +	u16 last_avail_idx = vq->last_avail_idx;
>>   	__virtio16 ring_head;
>>   	int ret, access;
>>   
>> -	/* Check it isn't doing very strange things with descriptor numbers. */
>> -	last_avail_idx = vq->last_avail_idx;
>> -
>>   	if (vq->avail_idx == vq->last_avail_idx) {
>> -		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
>> -			vq_err(vq, "Failed to access avail idx at %p\n",
>> -				&vq->avail->idx);
>> -			return -EFAULT;
>> -		}
>> -		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> -
>> -		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
>> -			vq_err(vq, "Guest moved avail index from %u to %u",
>> -				last_avail_idx, vq->avail_idx);
>> -			return -EFAULT;
>> -		}
>> +		ret = vhost_get_avail_idx(vq);
>> +		if (unlikely(ret < 0))
>> +			return ret;
>>   
>> -		/* If there's nothing new since last we looked, return
>> -		 * invalid.
>> -		 */
>> -		if (vq->avail_idx == last_avail_idx)
>> +		if (!ret)
>>   			return vq->num;
>> -
>> -		/* Only get avail ring entries after they have been
>> -		 * exposed by guest.
>> -		 */
>> -		smp_rmb();
>>   	}
>>   
>>   	/* Grab the next descriptor number they're advertising, and increment
>> @@ -2790,35 +2795,20 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>>   /* return true if we're sure that avaiable ring is empty */
>>   bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>   {
>> -	__virtio16 avail_idx;
>>   	int r;
>>   
>>   	if (vq->avail_idx != vq->last_avail_idx)
>>   		return false;
>>   
>> -	r = vhost_get_avail_idx(vq, &avail_idx);
>> -	if (unlikely(r))
>> -		return false;
>> -
>> -	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> -	if (vq->avail_idx != vq->last_avail_idx) {
>> -		/* Since we have updated avail_idx, the following
>> -		 * call to vhost_get_vq_desc() will read available
>> -		 * ring entries. Make sure that read happens after
>> -		 * the avail_idx read.
>> -		 */
>> -		smp_rmb();
>> -		return false;
>> -	}
>> -
>> -	return true;
>> +	/* Treat error as non-empty here */
> 
> If you write the comment like that then put it before "return":
> that is where you treat an error like this.
> And I feel Note: is better in that the comment does not
> explain all of what is going on, just an aspect of it.
> 

Ok. Will do in v3.

>> +	r = vhost_get_avail_idx(vq);
>> +	return r == 0;
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>>   
>>   /* OK, now we need to know about added descriptors. */
>>   bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>   {
>> -	__virtio16 avail_idx;
>>   	int r;
>>   
>>   	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
>> @@ -2842,25 +2832,13 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>>   	/* They could have slipped one in as we were doing that: make
>>   	 * sure it's written, then check again. */
>>   	smp_mb();
>> -	r = vhost_get_avail_idx(vq, &avail_idx);
>> -	if (r) {
>> -		vq_err(vq, "Failed to check avail idx at %p: %d\n",
>> -		       &vq->avail->idx, r);
>> -		return false;
>> -	}
>>   
>> -	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>> -	if (vq->avail_idx != vq->last_avail_idx) {
>> -		/* Since we have updated avail_idx, the following
>> -		 * call to vhost_get_vq_desc() will read available
>> -		 * ring entries. Make sure that read happens after
>> -		 * the avail_idx read.
>> -		 */
>> -		smp_rmb();
>> -		return true;
>> -	}
>> +	/* Treat error as empty here */
>> +	r = vhost_get_avail_idx(vq);
> 
> If you write the comment like that then put it before "return":
> that is where you treat an error like this.
> And I feel Note: is better in that the comment does not
> explain all of what is going on, just an aspect of it.
> 

Sure, will do in v3.

>> +	if (unlikely(r < 0))
>> +		return false;
>>   
>> -	return false;
>> +	return r;
>>   }
>>   EXPORT_SYMBOL_GPL(vhost_enable_notify);


Thanks,
Gavin

