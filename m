Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237D37C927
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619992; cv=none; b=mxg89HZu2H+V6+GHnIktBu+NmR8cyIhFncjAPBfYfakddftn0gadUTOrIbLIaYyl9grb47JolyIsSdWK3A0z041f6IhaubXiyEimvFa1wxNkILUTo4tX/j21dpLo/fwVzI0KESg+IDNMlbM/ehB1mYdaLAxnxbSYrVuyUpTIZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619992; c=relaxed/simple;
	bh=2FtnmkA6sYVjNf1cUAA6sjpblaIDR9OLH/SC1eJdstY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HRgtbujgOcaLRG376eFIJrXM/krK+eTcn2tAkdgep3acQc90wxfV5BypqyZdomCZ7a5DcVH/6xGqBtUQZ9wgpr1zLyerwqFQYJofPoqGIq8y+E0M1KpXM1m2j6jimVd38ZouNzspMyWMP1xOgM0uOv22DFWkp+POr4OiA7D0nck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjrODjGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjrODjGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781619989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
	b=ZjrODjGbDmscU3fYScasS8s8tRrustSwzLSDpR+edx8oCrOKkovnNJ4huGkbUb9j62k2ps
	rsAII1nO5EnaZoc4idI26TdAaFPGDr4OXCdhIbWSv0jb7LmN+2QILwnE7tg4YHrpPFgxOd
	PywaSQGrFGhFLkqiVHifKlNa/caILM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-__Z1w_lhOuG7vS4J4YT-7A-1; Tue, 16 Jun 2026 10:26:25 -0400
X-MC-Unique: __Z1w_lhOuG7vS4J4YT-7A-1
X-Mimecast-MFC-AGG-ID: __Z1w_lhOuG7vS4J4YT-7A_1781619984
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef63d1214so3007778f8f.3
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619984; x=1782224784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhl41uHQlhSDcthFJy4ATeZ9aIkqmiVNQn4jmxc+ZZI=;
        b=h7v00S2Z5JZornzRsp3CnPdTA6TsegceNN1GZPMNs44+hqqwHhwMEk552xhxVqsAjH
         YI0ohYOvdStA3fYqRhV4KVHZ4L9/IDtYGWBH/0Jpn9rODppTjtT+2wN7PPboaxP4l629
         YG43rTp8qd0NFzcPDlVdY64FrdXecBoE+7r7hOLJA9l1RDAthfHuSmzBupcIQecdaSoY
         hJ7jmaB7y3m3+5BAIrzVJ3uYJphpuIc7tC97FetmkiN2PklT+faaPNPNVIDtIDfAWfkZ
         r6Mv1FH/uZ3R3YsH2rjGT/9H8Xj+yTmr6jAOvMEK7zTGBCS4APIIYPs+FexTJwE7xbRM
         GMog==
X-Forwarded-Encrypted: i=1; AFNElJ/W4eMBKw/acEmx+V0TBk3CoWQLoH4egsqpQiQFOab7khT0lOzSbPdyQP2Oq/sOn70mEkrZKrEynaBzNF6ebA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLPUOskUWZ6WzJXF193pVn4koxd+PkmVijXzTvyHcSQoCoxrZL
	QqUoI0zKumhHD1rsZ/HJCJyfqfOpKiXFFOVDkwaQN5rQ7AV69FZqabG4y+Il9aLkdKRzpDQ6GP4
	LWkYpuEC9Z8t4lCxdg2b6lac2j6JcPxKT8X0AuH2TKgE4V9rlq43ruGldF4z7stpI6TS3
X-Gm-Gg: Acq92OHv8bE7v+9kU2qcxYiN5CHpuCaudCUup4dnLEtosWAF3ZRgGfK2f7wyRgOrJUk
	2/WO11jd4ilAAuf6HhxFnF36Kem7jbBylvkUvGEVDLxCjetgAreIBU4r++zPVBreyLccD8J6RGC
	ep8hxfzwSX4DFRNPWXF7AMYJyPav2/ldlkJfN1PbDgK/da/X7XTb91dPC6bNj2pDXJMo4u1vzfG
	x3+cyEa7HNCNL0yQMvRnKv9BUHN4ZToDAEur0Mp+Yvg84kjR2Xfl+t+CBXUuWLX3LymXeq/tfdN
	mrG05sH54r5omKw0PzAk3TZuuxJPuW1h/kv4/XZ8hYovBYItOKW2auSNOBPSG9oBQZH0NNcX9qs
	p3qwri9dIyaDWUH42zum0miy2jJSXd+k+uUVyYcYmeFwYPM38xQ8NFTdXf0LWJfNTGFDDXdg=
X-Received: by 2002:a05:6000:1ac9:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-4619f33afc1mr6376236f8f.0.1781619984264;
        Tue, 16 Jun 2026 07:26:24 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac9:b0:45e:eaed:afd2 with SMTP id ffacd0b85a97d-4619f33afc1mr6375916f8f.0.1781619981390;
        Tue, 16 Jun 2026 07:26:21 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c5266sm51566784f8f.29.2026.06.16.07.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:26:20 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:26:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Message-ID: <ajFcf00nmUcfqofx@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
 <ajFRRmA9req1muX6@sgarzare-redhat>
 <129f5833-3a7f-4b2d-a965-20903e4e2fb5@virtuozzo.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <129f5833-3a7f-4b2d-a965-20903e4e2fb5@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kKmuPjJdAUE0UuUzhME8NZU3HxGMYe8RZg3SZWjXaGY_1781619984
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 16, 2026 at 05:10:38PM +0300, Andrey Drobyshev wrote:
>On 6/16/26 4:48 PM, Stefano Garzarella wrote:
>> On Fri, Jun 12, 2026 at 07:57:16PM +0300, Andrey Drobyshev wrote:
>>> From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>>
>>> This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
>>> the guest with vhost-vsock device.  For this to work, we need to reset
>>> the device ownership on the source side by calling RESET_OWNER, and then
>>> claim it on the dest side by calling SET_OWNER.  We expect not to lose any
>>> AF_VSOCK connection while this happens.
>>>
>>> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>>> ---
>>> drivers/vhost/vsock.c | 28 ++++++++++++++++++++++++++++
>>> 1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>>> index b12221ce6faf..e629886e5cf8 100644
>>> --- a/drivers/vhost/vsock.c
>>> +++ b/drivers/vhost/vsock.c
>>> @@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
>>> 	return -EFAULT;
>>> }
>>>
>>> +static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
>>> +{
>>> +	struct vhost_iotlb *umem;
>>> +	long err;
>>> +
>>> +	mutex_lock(&vsock->dev.mutex);
>>> +	err = vhost_dev_check_owner(&vsock->dev);
>>> +	if (err)
>>> +		goto done;
>>> +	umem = vhost_dev_reset_owner_prepare();
>>> +	if (!umem) {
>>> +		err = -ENOMEM;
>>> +		goto done;
>>> +	}
>>> +	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
>>> +	vsock_for_each_connected_socket(&vhost_transport.transport,
>>> +					vhost_vsock_reset_orphans);
>>
>> In vhost_vsock_reset_orphans() we have:
>>
>> 	rcu_read_lock();
>>
>> 	/* If the peer is still valid, no need to reset connection */
>> 	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))) {
>> 		rcu_read_unlock();
>> 		return;
>> 	}
>>
>> IIUC we are not removing the guest cid from the hash table, so this
>> check will be always true, and nothing is done.
>>
>> So, is this call really useful?
>>
>
>You're right, and it's most probably an artifact from mimicking the
>vhost_vsock_dev_release() implementation, as mentioned in the comment.
>In our case this whole iteration is a no-op, we better remove it.
>
>BTW earlier I received some feedback from Sashiko AI reviewer, which
>also spotted that same issue (and some more interesting races):
>
>https://sashiko.dev/#/patchset/20260612165718.433546-1-andrey.drobyshev@virtuozzo.com

Oh they seems similar to claude comments I included in my comment on 
patch 3.

Yeah, we should takes a look, they seems real issues.

>
>Apparently it only CC's its reviews to kvm@vger.kernel.org so you can't
>see them right away.  Just wanted to let you know to save your time
>here.  I'll send a v2 with respect to Sashiko remarks.  But of course
>would be great if you spot some more issues here.
>

Thanks for pointing that out, but in general I try to do my reviews 
before looking at AI reviews (both sashiko or claude locally) to avoid 
to be too much biased.

Thanks,
Stefano

