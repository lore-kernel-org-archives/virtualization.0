Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF426AF6
	for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017840; cv=none; b=HE+eKWMIg641IjhNM2F485LV+ULCqys4CbZyNBRhEzNI1xog9W0pz+KOtdvJFx+cdv+haIuVm6RXSxf74s3c3VDDbZwUvU2IREb9nHuqFxtv7FdJCrEDaRxsfmgvTGUWlRDuLkWYXiJVGuUxa5eJw1qtK/1kENmYg3cdSZV32AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017840; c=relaxed/simple;
	bh=PtUhQynYgZLYfz9e+zHBnnH2YW9fJ84gqLC9SnFqqqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CEQWXVcN23B73NIlrVjTv5ssO0quW+gp/acJcw7j4iDRGAyt2fKWVioqI9Xe/NlNdDzX2mj5sfVddSdXFV5Gn55snRdd5HWlN5py1OZdORNKOBn5N3uPD/c0i4mmpv3HPZD17dVQw18GBR+eskKzgJAdi4Ln0AlMQhUXKGiYXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+iUGFTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+iUGFTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737017838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmkLmsyIcPYmFuaESsfI5oPSmcbmJsLv+8kU8eWcxJk=;
	b=b+iUGFTVAQTEESja0Q2tHSyjXymaEO+gM2Ow+H6WseVs4tQUCnDgSieFrf4N99ZynKKZV/
	JEGAuo6h4Ezc12u+ghHLDJxbnukg91t+dQec10P4JMiod1j4Nbx3lnRjKtlV+JS2BaYWRj
	QsgiPERHC2isFLHuBUfd1p/B/WckPKM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-PEtxEfh9OqWQpLN_vpwhgg-1; Thu, 16 Jan 2025 03:57:16 -0500
X-MC-Unique: PEtxEfh9OqWQpLN_vpwhgg-1
X-Mimecast-MFC-AGG-ID: PEtxEfh9OqWQpLN_vpwhgg
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-46dd46d759eso13175821cf.2
        for <virtualization@lists.linux.dev>; Thu, 16 Jan 2025 00:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737017836; x=1737622636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmkLmsyIcPYmFuaESsfI5oPSmcbmJsLv+8kU8eWcxJk=;
        b=ZlFsHGr+8jrMmCnmkFamswzgGJNxHsIaEchFq3jM6lCa7o4HN0JLA2/rqN7oCKnUh6
         BSH/2/5gvbrW6EzI9hhvxmFX4CusFVYEdmZhit4ObCFAD4sa6mvooOXTlyntAPNbKDFq
         q9krYPySFaZvTIHT42OZWFICed/308MmX4PaHKO/monreJvN9OmViteIVrM+aiHIdNiG
         SIqoWuw7i+Bu8wFrlprst3ZfyV4seRVMTsUC1w6jg0zu6SFE8j3u0MKP2QrHN22eu5ag
         uWC76dXlAIjcVMgXqxyvCu7xpXuqWD7Fnj3JjqsK0IinqtwqGOsSmuFE3wJAKfNL5SX1
         S+iw==
X-Forwarded-Encrypted: i=1; AJvYcCVFw/9DxrTSVphGI55Cblnlfy5W5Fqm+cK6QvWwCx1dSXCyXTW7hyKawD6AIsFXECwNU1eT43jRhGF8gbIQTw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3z68eHpdlGNH7m/HvsDa2fpEOVms/DuWtR6XL1Cmq+YPaDOa2
	JoRwwrp0v1tEKemWLi4UkkE4Hdx9aCmloXsZZlCoE/KOxZGbA5tG7E1pRvEQyMxcylpBDZww7uu
	ts53ulNgcg2Dh3hdZSWQEpctAaQnFpypyjDN9GlQ78/4IZra3kNjn+2ma6Rje4rEFrxaCYFE9
X-Gm-Gg: ASbGnculPWHgoGLI+eNRxLmwWrO46uwVw8fwswzYrP2NxfoeHBDDGfu5aGnUYfS86Z6
	bonVgwWg7Rm20sJr84e5U8GkuxnueP+xSJpodUaiHU5C2L1/UzrzRNFsBiqGuOEIPRhgtQ9Vlm0
	aweC1cxyFn5JvhNxF+y04ELn3V19pZjNuzqEGA+4VshGk6qM9SvEsYnOruQ5XY43+IQyhwlezF3
	3UChobU9uuaFIbEJL7PT5iD4kOyAlcxmLAfi7SWD+vrxF//eFpY+VH+IMJcR+nBVA+Dy4vG5rjr
	PdOgY6wlipN27CXw2/qzHAKIZhEc+S9P
X-Received: by 2002:ac8:5813:0:b0:466:aee5:a5b with SMTP id d75a77b69052e-46c70fd1faemr467248121cf.10.1737017836162;
        Thu, 16 Jan 2025 00:57:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO29yrvkRyeFaWTkkTVXxmLbJIQYKA6Cnx5MRQ30jCm4qRaBjl6Z9IlhJpdMAezqnYQnnKAw==
X-Received: by 2002:ac8:5813:0:b0:466:aee5:a5b with SMTP id d75a77b69052e-46c70fd1faemr467247821cf.10.1737017835757;
        Thu, 16 Jan 2025 00:57:15 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873216dbsm73689241cf.7.2025.01.16.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:57:15 -0800 (PST)
Date: Thu, 16 Jan 2025 09:57:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Wongi Lee <qwerty@theori.io>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <pl4mhcim7v3ukv6eseynh6x2r6nftf7yuayjzd3ftyupwy5r2h@ixmlevubqzb2>
References: <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
 <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
 <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
 <5nkibw33isxiw57jmoaadizo3m2p76ve6zioumlu2z2nh5lwck@xodwiv56zrou>
 <7de34054-10cf-45d0-a869-adebb77ad913@rbox.co>
 <n2itoh23kikzszzgmyejfwe3mdf6fmxzwbtyo5ahtxpaco3euq@osupldmckz7p>
 <fb6f876f-a4eb-4005-bd76-fff0632291b8@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fb6f876f-a4eb-4005-bd76-fff0632291b8@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bVAZ0zcv66i0n_RSzGvY54QtWrWvGParc9ogxShxdBc_1737017836
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 14, 2025 at 05:31:08PM +0100, Michal Luczaj wrote:
>On 1/14/25 11:16, Stefano Garzarella wrote:
>> On Tue, Jan 14, 2025 at 01:09:24AM +0100, Michal Luczaj wrote:
>>> On 1/13/25 16:01, Stefano Garzarella wrote:
>>>> On Mon, Jan 13, 2025 at 02:51:58PM +0100, Michal Luczaj wrote:
>>>>> On 1/13/25 12:05, Stefano Garzarella wrote:
>>>>>> ...
>>>>>> An alternative approach, which would perhaps allow us to avoid all this,
>>>>>> is to re-insert the socket in the unbound list after calling release()
>>>>>> when we deassign the transport.
>>>>>>
>>>>>> WDYT?
>>>>>
>>>>> If we can't keep the old state (sk_state, transport, etc) on failed
>>>>> re-connect() then reverting back to initial state sounds, uhh, like an
>>>>> option :) I'm not sure how well this aligns with (user's expectations of)
>>>>> good ol' socket API, but maybe that train has already left.
>>>>
>>>> We really want to behave as similar as possible with the other sockets,
>>>> like AF_INET, so I would try to continue toward that train.
>>>
>>> I was worried that such connect()/transport error handling may have some
>>> user visible side effects, but I guess I was wrong. I mean you can still
>>> reach a sk_state=TCP_LISTEN with a transport assigned[1], but perhaps
>>> that's a different issue.
>>>
>>> I've tried your suggestion on top of this series. Passes the tests.
>>
>> Great, thanks!
>>
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index fa9d1b49599b..4718fe86689d 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -492,6 +492,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>> 		vsk->transport->release(vsk);
>>> 		vsock_deassign_transport(vsk);
>>>
>>> +		vsock_addr_unbind(&vsk->local_addr);
>>> +		vsock_addr_unbind(&vsk->remote_addr);
>>
>> My only doubt is that if a user did a specific bind() before the
>> connect, this way we're resetting everything, is that right?
>
>That is right.
>
>But we aren't changing much. Transport release already removes vsk from
>vsock_bound_sockets. So even though vsk->local_addr is untouched (i.e.
>vsock_addr_bound() returns `true`), vsk can't be picked by
>vsock_find_bound_socket(). User can't bind() it again, either.

Okay, I see, so maybe for now makes sense to merge your patch, to fix 
the UAF fist.

>
>And when patched as above: bind() works as "expected", but socket is pretty
>much useless, anyway. If I'm correct, the first failing connect() trips
>virtio_transport_recv_connecting(), which sets `sk->sk_err`. I don't see it
>being reset. Does the vsock suppose to keep sk_err state once set?

Nope, I think this is another thing to fix.

>
>Currently only AF_VSOCK throws ConnectionResetError:
>```
>from socket import *
>
>def test(family, addr):
>	s = socket(family, SOCK_STREAM)
>	assert s.connect_ex(addr) != 0
>
>	lis = socket(family, SOCK_STREAM)
>	lis.bind(addr)
>	lis.listen()
>	s.connect(addr)
>
>	p, _ = lis.accept()
>	p.send(b'x')
>	assert s.recv(1) == b'x'
>
>test(AF_INET, ('127.0.0.1', 2000))
>test(AF_UNIX, '\0/tmp/foo')
>test(AF_VSOCK, (1, 2000)) # VMADDR_CID_LOCAL
>```
>
>> Maybe we need to look better at the release, and prevent it from
>> removing the socket from the lists as you suggested, maybe adding a
>> function in af_vsock.c that all transports can call.
>
>I'd be happy to submit a proper patch, but it would be helpful to decide
>how close to AF_INET/AF_UNIX's behaviour is close enough. Or would you
>rather have that UAF plugged first?
>

I'd say, let's fix the UAF first, then fix the behaviour (also in a
single series, but I prefer 2 separate patches if possible).
About that, AF_VSOCK was started with the goal of following AF_INET as
closely as possible, and the test suite should serve that as well, so if
we can solve this problem and get closer to AF_INET, possibly even
adding a dedicated test, that would be ideal!

Thank you very much for the help!
Stefano

