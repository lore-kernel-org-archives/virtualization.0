Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA563559EF
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569883; cv=none; b=Sl5LJ/Njd6su/Dobn6osC66/2Hxbj/TN4XYXA26CXpAVDvPs3XfMP6IG1pf7al/QtLJSIB2BGsrnfk5VdkqRAWEuhriIJHbM3/xcYxYIMXwjRyoeMvy/IXJ5caF9TErPKw6nJ48DnIa6tH7orFNEn+0UTF9u8E3AcCJcD2NDtdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569883; c=relaxed/simple;
	bh=FqqvmkUPgSq7OZp9nrgzHtuk68f2+rkXNRL8blqM5Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tHzPZ6j3c+TThhtbZry9AVOju0ooFYQBkBmKSyY1u1302hjZx0GcIAvtlKubJKGKqwh+z0zCrMApo7qFRuP5vrIll18P5CJR9Q46Ob04tgV9OgL5ApfsCOSHJQ1oI4bMZejh8r+4wKya5ZarRPKwSnBUZnX535EzzYY1zxDMMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+IuFxL1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+IuFxL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763569880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3kVindzkKJ+KF8jM/3D9z51CP303MCzFh5WHNehWDM=;
	b=W+IuFxL103b9qfxcYxqiukdb0etq0QGH4+reTZusaRmR5nISnOF41xnwLtghkWq8oSoke3
	orF6GrC7XdUq37dy7XpOXyjml6TZ08FDe7oMsrtW7fsx7NQy4kZRPTBJp0ZZEUcwVm6xfy
	SzunlznbkcglgxYwFN1SiKuaAzTj5Rg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-j6-7wVtUMZq3vhgU3cRQDA-1; Wed, 19 Nov 2025 11:31:17 -0500
X-MC-Unique: j6-7wVtUMZq3vhgU3cRQDA-1
X-Mimecast-MFC-AGG-ID: j6-7wVtUMZq3vhgU3cRQDA_1763569877
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8804b991976so194861256d6.2
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 08:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569877; x=1764174677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3kVindzkKJ+KF8jM/3D9z51CP303MCzFh5WHNehWDM=;
        b=h/2q0f0B0dk/uHP88e92r4tuRXzcgpJcwCN8HaOMaz8eDe8SsHXfF6tlnhuV5/05GA
         bIJ+8XMu8l6Wk93jS4nG4TQ3+FnvWVimnQnIvhLnfnmsir0elNLpKjuCxro6H54kTis/
         27yEwFQKZyOFuyNwnGsFtMZFbEQ3HAi5JbOwvpxAjozaKWMquoud68brcB+qtzGpbZRf
         bn4LiX8nIw/hP3jhiH/Skbd5coH04FyyrkqQp8jzfYJ43Lyh4xYzagNwSkl5lqkcenIY
         TUgSzuO6VIuSA3LyxuMDkg+c3Asgvxg+2eYSAt3xLdIIOYlhpv8QFEO/ZGOumK1IC/il
         LiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRE0BEOXGrPJFi4HCxAKUiz3Ja51MvBpJGt2jPOuCal92oxCnAo0TyR9BqipwXPfoshGlXOHDdqk3Dh5giDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlFZzVu7jjTViYRmvQNUqJKypPkyGI+eSyfKfJ2XhufJoFKUk6
	0HyJdbRVDqqGaDdFTvw7jLs//MXU8VD73upfOZD0ritIUZWqm+2CgbtNz6DzoRYJ3kpAYNUVEK6
	SbmspO03LzsNvQpoRXieD2V3hE4HUV8Dya2iWzixDOjSBOInUnZeNE21AIWgG1i3xBHhjPavywK
	aU
X-Gm-Gg: ASbGncsLmo4a2bckDtqHLUy4EpqanDQHbkRwqCW6XJpERicPKuKkxevijsQzxUXZ43y
	osulVzQfCdhk60LSD99qFe7xM9p0oD43ezObY+LXBVAq6mZFa5GCOJuAdonKs6YOQpXLGQYGvNI
	Klydjq6FQ7nyx6xJEjhF35b/6OgGjsHCSzt2Mr83osq1uaQHoivj32WogZXIWskB1uFzn29xM0W
	L9kK0hfBTJZMFthq8/INVosXiqv022idOWm60qlqA0+1YtXya93PZArR0G9rKNL95YI92blyo/e
	4WLv2CdY49kecaXfcPbbLvz8kxqapN5J+kb3MVU/Y9KfB5XI5pkyk2EwAgL/Jsf55XtwawXdM6Q
	vPvCZHAoWgfw2cdObIxEjQqsYNvbKqKhlDP1bxjeuPlSugm/w7NwAk3u8u6zLNA==
X-Received: by 2002:a05:6214:2246:b0:882:398d:3cf5 with SMTP id 6a1803df08f44-88292703764mr336989866d6.52.1763569876581;
        Wed, 19 Nov 2025 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlMoSDGo8RCC4ukLN3fwxkuNRsD7z+J9Dhyfp0NsIu40eZGeuMWPAwGp70A3xvg/lU9rghuw==
X-Received: by 2002:a05:6214:2246:b0:882:398d:3cf5 with SMTP id 6a1803df08f44-88292703764mr336988236d6.52.1763569875387;
        Wed, 19 Nov 2025 08:31:15 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314656sm136478176d6.21.2025.11.19.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:31:14 -0800 (PST)
Date: Wed, 19 Nov 2025 17:31:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sgUgsCIxtmvyBRsQQ25Pbjv-NfdoaEhRLVPAesPlzy8_1763569877
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 19, 2025 at 03:09:25PM +0100, Michal Luczaj wrote:
>On 11/19/25 11:36, Stefano Garzarella wrote:
>> On Tue, Nov 18, 2025 at 11:02:17PM +0100, Michal Luczaj wrote:
>>> On 11/18/25 10:51, Stefano Garzarella wrote:
>>>> On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>>>>> ...
>>>>> +static void vsock_reset_interrupted(struct sock *sk)
>>>>> +{
>>>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>>>> +
>>>>> +	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>>>>> +	 * transport->connect().
>>>>> +	 */
>>>>> +	vsock_transport_cancel_pkt(vsk);
>>>>> +
>>>>> +	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>>>>> +	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>>>>> +	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>>>>> +	 */
>>>>> +	sk->sk_state = TCP_CLOSE;
>>>>> +	sk->sk_socket->state = SS_UNCONNECTED;
>>>>> +}
>>>>> +
>>>>> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>>> 			 int addr_len, int flags)
>>>>> {
>>>>> @@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>>> 		timeout = schedule_timeout(timeout);
>>>>> 		lock_sock(sk);
>>>>>
>>>>> +		/* Connection established. Whatever happens to socket once we
>>>>> +		 * release it, that's not connect()'s concern. No need to go
>>>>> +		 * into signal and timeout handling. Call it a day.
>>>>> +		 *
>>>>> +		 * Note that allowing to "reset" an already established socket
>>>>> +		 * here is racy and insecure.
>>>>> +		 */
>>>>> +		if (sk->sk_state == TCP_ESTABLISHED)
>>>>> +			break;
>>>>> +
>>>>> +		/* If connection was _not_ established and a signal/timeout came
>>>>> +		 * to be, we want the socket's state reset. User space may want
>>>>> +		 * to retry.
>>>>> +		 *
>>>>> +		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>>>>> +		 * vsock_connected_table. We keep the binding and the transport
>>>>> +		 * assigned.
>>>>> +		 */
>>>>> 		if (signal_pending(current)) {
>>>>> 			err = sock_intr_errno(timeout);
>>>>> -			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>>>>> -			sock->state = SS_UNCONNECTED;
>>>>> -			vsock_transport_cancel_pkt(vsk);
>>>>> -			vsock_remove_connected(vsk);
>>>>> +			vsock_reset_interrupted(sk);
>>>>> 			goto out_wait;
>>>>> -		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>>>>> +		}
>>>>> +
>>>>> +		if (timeout == 0) {
>>>>> 			err = -ETIMEDOUT;
>>>>> -			sk->sk_state = TCP_CLOSE;
>>>>> -			sock->state = SS_UNCONNECTED;
>>>>> -			vsock_transport_cancel_pkt(vsk);
>>>>> +			vsock_reset_interrupted(sk);
>>>>> 			goto out_wait;
>>>>
>>>> I'm fine with the change, but now both code blocks are the same, so
>>>> can we unify them?
>>>> I mean something like this:
>>>> 		if (signal_pending(current) || timeout == 0 {
>>>> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>>>> 			...
>>>> 		}
>>>>
>>>> Maybe at that point we can also remove the vsock_reset_interrupted()
>>>> function and put the code right there.
>>>>
>>>> BTW I don't have a strong opinion, what do you prefer?
>>>
>>> Sure, no problem.
>>>
>>> But I've realized invoking `sock_intr_errno(timeout)` is unnecessary.
>>> `timeout` can't be MAX_SCHEDULE_TIMEOUT, so the call always evaluates to
>>> -EINTR, right?
>>
>> IIUC currently schedule_timeout() can return MAX_SCHEDULE_TIMEOUT only
>> if it was called with that parameter, and I think we never call it in
>> that way, so I'd agree with you.
>>
>> My only concern is if it's true for all the stable branches we will
>> backport this patch.
>>
>> I would probably touch it as little as possible and continue using
>> sock_intr_errno() for now, but if you verify that it has always been
>> that way, then it's fine to change it.
>
>All right then, here's a v2 with minimum changes:
>https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/
>

Thanks!

>Note a detail though: should signal and timeout happen at the same time,
>now it's the timeout errno returned.
>

Yeah, I thought about that, but I don't see any problems with that.
I mean, it's something that if it happens, it's still not deterministic,
so we're not really changing anything.

Thanks,
Stefano

