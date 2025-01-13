Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99211FBBCD
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780495; cv=none; b=uSJ+uKsnFklJK75DeX+LXOEdYtjBnLjjcnxlKqDiuMsBScsv9MLkfgEKFOPXvO/V/gN4JjX6+DN7OlFf2Fr/m0N2dd+yNG69nOJ8xlxvdnfx7CdDdoF4mzOiXcxdik3NS4djHk9yQq6x3lWPqdXkSjldvJCXwC3ZNMkKknj9pm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780495; c=relaxed/simple;
	bh=kRR1+QzVmvo3iRgs0Rx+6BPBHxGoHd17FoeRkxQMy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j1xv5LUqyyr/MLMuk0C4PVadsBtI0uCM8jZgtyjrYHS2tj/UILTSfZfb2qhvYx6k0Cdgpw50DS3kOyZsjXK3PBT6KXceqO3HCA0xZ66aHmp12gYe33puy/sysf7weVj2NZ5HYnfZOmOWvTl73XdLxlJagxPTdp6+x/KXTOmJhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akmVpkH2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akmVpkH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736780492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yf80rtmCXKEEVXHQYDbWk5EecSmCyvTI8cS1zfM35E=;
	b=akmVpkH2K8LXHcjOuib/3koNkJiQmjjlbI2PpV9i2ZHNCgRRhqLsQNh1V28ejcIGDwXhib
	2fcDFGFt/H2TURuEWzakYYGONrA/vP9JVK3OyobGBuN0B4c3Lj5IT5cc+wV2jLsmjRLBA7
	8MBdMwqqgHDALYJjqXpGsVIIyo8tyH4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-1ZR2cX6RM7KBHGQciIJ7Vg-1; Mon, 13 Jan 2025 10:01:31 -0500
X-MC-Unique: 1ZR2cX6RM7KBHGQciIJ7Vg-1
X-Mimecast-MFC-AGG-ID: 1ZR2cX6RM7KBHGQciIJ7Vg
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6c51069f5so732750685a.3
        for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 07:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780490; x=1737385290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yf80rtmCXKEEVXHQYDbWk5EecSmCyvTI8cS1zfM35E=;
        b=sX1iUpfjQIPfQ7i3Kc84U5y2WCPV9qcVddIA8I4v7Xq51EqGPL9ypXG/AT3PJZiY/H
         aXPR3Cx5NRw6SxeArq8ffbyIJQhDD+Gq2Ie04FQVgbydSG9UP3lsZYg4+n0ekN4Gc3Rj
         8sw6XP57zXQE7YBrutQTTR3FGiq3wSdKIHCIOu4tZOeI0R94c1b776B7L76WWmOdIKy8
         DfnyKShQt39SpFJpWVhF6eLt2QlYrpd9b4wcmH5p4ne2FZEqa3856g70Y06bn3zEBJC7
         +jSJrRriDcBpdzxYGiCUFTtcAMb5MaJSX8ZlnnlCBu+pd6oEOdUvbBTgmZFQRTgFBKGG
         ftCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRZiDt71N9i7E/6YyjDcr2IZ+jbLgoPCW0n6hlv++q4JG1oMC107kSwr8atVigUx90Ak1zM9GUXRS3v2oqjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSpH7mKoQ3k0gdwu27+ScNF/+wUhvk4PYK0mdhP6DToPpkThre
	EHs4GxkEs+Ea1xaCJqqVN3/aCJ3zqRmq+C5HcdYCw5qGuYpS0kv5CT/M3verNYqEuzLmIIHIqPk
	cvBdBnf9I234yf+Db0DLCEg7jH8gLU5xY6GHF9sHwsrKsOn4hrJNn93sY66/x1pag
X-Gm-Gg: ASbGnctLBj8C6IpPtGQ+fHZctT1QqJN9qFE3+60ikbGviggRnYWwz4ZfuECCEEpYk4l
	1OkL59tpkAo5DEj386Xt9WIIJOLndxNX60izWkq6W3bHRfk6aiDUt1zzCT5gPc+rit5nQflQBNc
	+N/IUla0r1kuGzHyZ7WdI4elas+NwbxQeoSIe+dxUYxCDTKiB3TDpsJJgIWO+L9x8Fpd+V42jXK
	cIK7nKgAYjD5zgKhzmEe7Wp7DdAIFGxrdn4wx6KQJMP65V8la4156AErdX+F4K6N2RqNtniqemd
	GtoJEWu6yLuwYsKKjJkJGx/ixeriBOdD
X-Received: by 2002:a05:620a:3726:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bcd9759b5cmr3148821285a.45.1736780490410;
        Mon, 13 Jan 2025 07:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmhCA+6joXrA0wKVaaHTe7fd/trt2RKjBSiBo73zD2W/+WWXHhQD1dIWKITENXxjV/Gx6S4g==
X-Received: by 2002:a05:620a:3726:b0:7b1:880c:5805 with SMTP id af79cd13be357-7bcd9759b5cmr3148813685a.45.1736780489785;
        Mon, 13 Jan 2025 07:01:29 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35042eesm496383085a.86.2025.01.13.07.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:01:29 -0800 (PST)
Date: Mon, 13 Jan 2025 16:01:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Wongi Lee <qwerty@theori.io>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <5nkibw33isxiw57jmoaadizo3m2p76ve6zioumlu2z2nh5lwck@xodwiv56zrou>
References: <20250110083511.30419-1-sgarzare@redhat.com>
 <20250110083511.30419-2-sgarzare@redhat.com>
 <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
 <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
 <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2-qHE8RMRgfnCEcg-iAXHjyxiKuEG6iU93Tc7qBKFME_1736780490
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Jan 13, 2025 at 02:51:58PM +0100, Michal Luczaj wrote:
>On 1/13/25 12:05, Stefano Garzarella wrote:
>> On Mon, Jan 13, 2025 at 11:12:52AM +0100, Michal Luczaj wrote:
>>> On 1/13/25 10:07, Stefano Garzarella wrote:
>>>> On Mon, 13 Jan 2025 at 09:57, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>> On Sun, Jan 12, 2025 at 11:42:30PM +0100, Michal Luczaj wrote:
>>>>
>>>> [...]
>>>>
>>>>>>
>>>>>> So, if I get this right:
>>>>>> 1. vsock_create() (refcnt=1) calls vsock_insert_unbound() (refcnt=2)
>>>>>> 2. transport->release() calls vsock_remove_bound() without checking if sk
>>>>>>   was bound and moved to bound list (refcnt=1)
>>>>>> 3. vsock_bind() assumes sk is in unbound list and before
>>>>>>   __vsock_insert_bound(vsock_bound_sockets()) calls
>>>>>>   __vsock_remove_bound() which does:
>>>>>>      list_del_init(&vsk->bound_table); // nop
>>>>>>      sock_put(&vsk->sk);               // refcnt=0
>>>>>>
>>>>>> The following fixes things for me. I'm just not certain that's the only
>>>>>> place where transport destruction may lead to an unbound socket being
>>>>>> removed from the unbound list.
>>>>>>
>>>>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>>>> index 7f7de6d88096..0fe807c8c052 100644
>>>>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>>>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>>>>> @@ -1303,7 +1303,8 @@ void virtio_transport_release(struct vsock_sock *vsk)
>>>>>>
>>>>>>       if (remove_sock) {
>>>>>>               sock_set_flag(sk, SOCK_DONE);
>>>>>> -              virtio_transport_remove_sock(vsk);
>>>>>> +              if (vsock_addr_bound(&vsk->local_addr))
>>>>>> +                      virtio_transport_remove_sock(vsk);
>>>>>
>>>>> I don't get this fix, virtio_transport_remove_sock() calls
>>>>>    vsock_remove_sock()
>>>>>      vsock_remove_bound()
>>>>>        if (__vsock_in_bound_table(vsk))
>>>>>            __vsock_remove_bound(vsk);
>>>>>
>>>>>
>>>>> So, should already avoid this issue, no?
>>>>
>>>> I got it wrong, I see now what are you trying to do, but I don't think
>>>> we should skip virtio_transport_remove_sock() entirely, it also purge
>>>> the rx_queue.
>>>
>>> Isn't rx_queue empty-by-definition in case of !__vsock_in_bound_table(vsk)?
>>
>> It could be.
>>
>> But I see some other issues:
>> - we need to fix also in the other transports, since they do the same
>
>Ahh, yes, VMCI and Hyper-V would need that, too.
>
>> - we need to check delayed cancel work too that call
>>    virtio_transport_remove_sock()
>
>That's the "I'm just not certain" part. As with rx_queue, I though delayed
>cancel can only happen for a bound socket. So, per architecture, no need to
>deal with that here, right?

I think so.

>
>> An alternative approach, which would perhaps allow us to avoid all this,
>> is to re-insert the socket in the unbound list after calling release()
>> when we deassign the transport.
>>
>> WDYT?
>
>If we can't keep the old state (sk_state, transport, etc) on failed
>re-connect() then reverting back to initial state sounds, uhh, like an
>option :) I'm not sure how well this aligns with (user's expectations of)
>good ol' socket API, but maybe that train has already left.

We really want to behave as similar as possible with the other sockets,
like AF_INET, so I would try to continue toward that train.

>
>Another possibility would be to simply brick the socket on failed (re)connect.
>

I see, though, this is not the behavior of AF_INET for example, right?

Do you have time to investigate/fix this problem?
If not, I'll try to look into it in the next few days, maybe next week.

Thanks,
Stefano

