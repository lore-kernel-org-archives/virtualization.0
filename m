Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC52C178E
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006909; cv=none; b=P6IO4scap9aTeXxSwulbobt0JuRgyQwsnwx8PXk0tQroGLk+hi1YxGuddHqIj48IoNbYFYoRnRux9P8MrE4KAsSXGzrP1jloCkGMyIbwfeRxt856z5R+LZEnFGYfuaaQT5fofv+/4calvuI0Lud6S/9e91RAzdzuBBwgrskOXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006909; c=relaxed/simple;
	bh=wgpVnEJcnomKN/oNfPAgd5k9GgyVHMXvOCPZyfz69j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XgrRtwOKc+43A/Hdk1ItH5Rw1gU8bz00vIc2WoL9D4RS65pI9lJ4H9w2CBBonsU2q29bheRIbQ7a3dFww9Z1tR52PvwFUXLqfdSYplkRFQdj4Qfqe9Q0FJBZqK4YQsFwLUp9ujUjMM07vi0cZD2Qs1OqljIGXBrOTlyzDP/47sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6HJCLDM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6HJCLDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764006906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWaaNkWE0gvkjn8TKglV+j77gDxp+Cag+Z34d+Rk28I=;
	b=Q6HJCLDMOlrdtfPbeRujjJKmF++Zy5I75wZfeJIMnA0MGe4ED/J+ksj/+7sr/nB8ZQ3PbE
	RPQ3w7eRKC8SSU4GZ7VRCKCee+cvOfP3XocnTjwzP8hv+m1xICNwijdZG8I4r1lE7PONRu
	svNYXFLtT8WsM7OPfXssY7sUEUGPR2Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-kmhXOwHoMOSgrmqJAHqqlg-1; Mon, 24 Nov 2025 12:55:05 -0500
X-MC-Unique: kmhXOwHoMOSgrmqJAHqqlg-1
X-Mimecast-MFC-AGG-ID: kmhXOwHoMOSgrmqJAHqqlg_1764006904
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee2fd41c2aso62050801cf.2
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 09:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006904; x=1764611704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWaaNkWE0gvkjn8TKglV+j77gDxp+Cag+Z34d+Rk28I=;
        b=b5ErvvHIdMjTRq26jeEB/HWzHcKTTYaJIavaaeqBqQBeOCtEiCo4wPwNP0KhF/qTzM
         NuhUjYsuwUUzo9YH730QCiVP2fGz/CpFzW2Qd5BtiGcuAraJh34pf3BAjIJcbuDtDUeu
         QhWsI86Uhj/GNyq8gvdW/wX1nhtBYV5L5e0W172tkpkQqFgcwdSFf3+T8PwBgyhbMx4p
         W7wlee9JIxt3gmL3uPIkTONQ3AigwqRh68DxbBqOnZByCywKfoyZobPeEHANg9a8Eiys
         bKjUVGC2FoZIlFzVErU6YshAsZS2iI7ayGW2QQzoPJwTRQ7/ZpDes6l2E9gYvkHHQYbr
         BuvA==
X-Forwarded-Encrypted: i=1; AJvYcCWwAkX9CgQh5qFlHvOJvZrIPs2gXydGQWhQvz2tI4XjKRg7ejqieZXZGL+Q3xFxfS0wMPHjUg92qIsT0axhQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+Ui1E5SDtek/X8G1kd73T/S77L55PNZw/xQofgbqZiUKEiFWL
	7RmU41O3vywuYK3JV1GyvtwcHX5TDuZtOih3lkVDrev02qG/KTRbxFT/UEUwVy+urKU5rJzuhL2
	z8/lknFXgdNwrMH0K5iq9e4oncELHRAkiepZtZUrWT78spICbcV+xvC5qbLxYYG9FVsMZ
X-Gm-Gg: ASbGncvkjb00SOhKyBID4tsrxY6XQnGY7aP/WgwO1QZ0OfNfNdny2ZT5UWcymCjWOtS
	5HkANNjWQkMYrzbGcrNaxkhJiFpBEqjyq7Bma7jXMcz3lfMiyrYnteoGME7BPbaYB9k7cXmwC8/
	K4LvNkiiIuaLmV62LWNGzO15/rx23jDLtoNUEVq5f3w7ECyudv5xk/DUhwc7yIdX/Ke4GY0aSx5
	fgAZppU99l6CvvigNtEIaw2KThnDQPyzMCaauaTRmjCmle8uRpU4GVGZ2W1MJ1b4RkAl0DFbkc1
	fRj+OvAjo70MzB04Mwgx/pixe2GdFnaFKwsRfdepZMsloEfIf/k70/H9ZfH1Nw2N11c7RQP9kSG
	3uXLf79Usx4uMPhE8EHvGK/QFQgUA4zVli96OeQtR0MokldcCfShM2eOarVuArg==
X-Received: by 2002:a05:622a:1b86:b0:4ee:87a:56b3 with SMTP id d75a77b69052e-4ee588cb923mr177167281cf.48.1764006903611;
        Mon, 24 Nov 2025 09:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Gf4NTZ93wIDY4fTFcgjXQPdtoiRJrv+CLpyDvCPlHjnxTw3P0ZMr3a2DgpcLW7S43lbwhw==
X-Received: by 2002:a05:622a:1b86:b0:4ee:87a:56b3 with SMTP id d75a77b69052e-4ee588cb923mr177166801cf.48.1764006903119;
        Mon, 24 Nov 2025 09:55:03 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e65e3bsm90774671cf.17.2025.11.24.09.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 09:55:02 -0800 (PST)
Date: Mon, 24 Nov 2025 18:54:45 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 03/13] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <qvu2mgxs7scbuwcb2ui7eh3qe3l7mlcjq6e2favd4aqcs52r2r@oqbrlp4gxdwl>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-3-55cbc80249a7@meta.com>
 <swa5xpovczqucynffqgfotyx34lziccwpqomnm5a7iwmeyixfv@uehtzbdj53b4>
 <aSC3IX81A3UhtD3N@devvm11784.nha0.facebook.com>
 <g4xir3lupnjybh7fqig6xonp32ubotdf3emmrozdm52tpaxvxn@2t4ueynb7hqr>
 <aSSV4RlRcW+uGy+n@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aSSV4RlRcW+uGy+n@devvm11784.nha0.facebook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RLD_JC1MZsEYegWZueFb7RwWMu2yJqJhxdjIpbO43Pk_1764006904
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Nov 24, 2025 at 09:29:05AM -0800, Bobby Eshleman wrote:
>On Mon, Nov 24, 2025 at 11:10:19AM +0100, Stefano Garzarella wrote:
>> On Fri, Nov 21, 2025 at 11:01:53AM -0800, Bobby Eshleman wrote:
>> > On Fri, Nov 21, 2025 at 03:24:25PM +0100, Stefano Garzarella wrote:
>> > > On Thu, Nov 20, 2025 at 09:44:35PM -0800, Bobby Eshleman wrote:

[...]

>> >
>> > > Since I guess we need another version of this patch, can you check the
>> > > commit description to see if it reflects what we are doing now
>> > > (e.g vhost is not enabled)?
>> > >
>> > > Also I don't understand why for vhost we will enable it later, but for
>> > > virtio_transport and vsock_loopback we are enabling it now, also if this
>> > > patch is before the support on that transports. I'm a bit confused.
>> > >
>> > > If something is unclear, let's discuss it before sending a new version.
>> > >
>> > >
>> > > What I had in mind was, add this patch and explain why we need this new
>> > > callback (like you did), but enable the support in the patches that
>> > > really enable it for any transport. But maybe what is not clear to me is
>> > > that we need this only for G2H. But now I'm confused about the discussion
>> > > around vmci H2G. We decided to discard also that one, but here we are not
>> > > checking that?
>> > > I mean here we are calling supports_local_mode() only on G2H IIUC.
>> >
>> > Ah right, VMCI broke my original mental model of only needing this check
>> > for G2H (originally I didn't realize VMCI was H2G too).
>> >
>> > I think now, we actually need to do this check for all of the transports
>> > no? Including h2g, g2h, local, and dgram?
>> >
>> > Additionally, the commit description needs to be updated to reflect that.
>>
>> Let's take a step back, though, because I tried to understand the problem
>> better and I'm confused.
>>
>> For example, in vmci (G2H side), when a packet arrives, we always use
>> vsock_find_connected_socket(), which only searches in GLOBAL. So connections
>> originating from the host can only reach global sockets in the guest. In
>> this direction (host -> guest), we should be fine, right?
>>
>> Now let's consider the other direction, from guest to host, so the
>> connection should be generated via vsock_connect().
>> Here I see that we are not doing anything with regard to the source
>> namespace. At this point, my question is whether we should modify
>> vsock_assign_transport() or transport->stream_allow() to do this for each
>> stream, and not prevent loading a G2H module a priori.
>>
>> For example, stream_allow() could check that the socket namespace is
>> supported by the assigned transport. E.g., vmci can check that if the
>> namespace mode is not GLOBAL, then it returns false. (Same thing in
>> virtio-vsock, I mean the G2H driver).
>>
>> This should solve the guest -> host direction, but at this point I wonder if
>> I'm missing something.
>
>For the G2H connect case that is true, but the situation gets a little
>fuzzier on the G2H RX side w/ VMADDR_CID_ANY listeners.
>
>Let's say we have a nested system w/ both virtio-vsock and vhost-vsock.
>We have a listener in namespace local on VMADDR_CID_ANY. So far, no
>transport is assigned, so we can't call t->stream_allow() yet.
>virtio-vsock only knows of global mode, so its lookup will fail (unless

What is the problem of failing in this case?
I mean, we are documenting that G2H will not be able to reach socket in 
namespaces with "local" mode. Old (and default) behaviour is still 
allowing them, right?

I don't think it conflicts with the definition of “local” either, 
because these connections are coming from outside, and the user doesn't 
expect to be able to receive them in a “local” namespace, unless there 
is a way to put the device in the namespace (as with net). But this 
method doesn't exist yet, and by documenting it sufficiently, we can say 
that it will be supported in the future, but not for now.

>we hack in some special case to virtio_transport_recv_pkt() to scan
>local namespaces). vhost-vsock will work as expected. Letting local mode
>sockets be silently unreachable by virtio-vsock seems potentially
>confusing for users. If the system were not nested, we can pre-resolve
>VMADDR_CID_ANY in bind() and handle things upfront as well. Rejecting
>local mode outright is just a broad guardrail.

Okay, but in that case, we are not supporting “local” mode too, but we 
are also preventing “global” from being used on these when we are in a 
nested environment. What is the advantage of this approach?

>
>If we're trying to find a less heavy-handed option, we might be able to
>do the following:
>
>- change bind(cid) w/ cid != VMADDR_CID_ANY to directly assign the 
>transport
>  for all socket types (not just SOCK_DGRAM)

That would be nice, but it wouldn't solve the problem with 
VMADDR_CID_ANY, which I guess is the use case in 99% of cases.

>
>- vsock_assign_transport() can outright fail if !t->supports_local_mode()
>  and sock_net(sk) has mode local

But in this case, why not reusing stream_allow() ?

>
>- bind(VMADDR_CID_ANY) can maybe print (once) to dmesg a warning that
>  only the H2G transport will land on VMADDR_CID_ANY sockets.

mmm, I'm not sure about that, we should ask net maintainer, but IMO 
documenting that in af_vsock.c and man pages should be fine, till G2H 
will support that.

>
>I'm certainly open to other suggestions.

IMO we should avoid the failure when loading G2H, which is more 
confusing than just discard connection from the host to a "local" 
namespace. We should try at least to support the "global" namespace.

Thanks,
Stefano

