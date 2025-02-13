Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF7210F4D
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440749; cv=none; b=vC0VVVe3pb52gGQ8nVrZ/WUNtFqNgGb9Imuy8ZdP/9QVw2M0Ri6hYc4oQp3/R47/nka7W+eBzjBj+p2ds1xeV1UhAP3rL83JKB4T0hWaRcpQbKz27IRP4HM3Qe++m68fhFdEzemkYVvtY8atJrSPmEmJQfYiQ9KL8OvYFvR6Vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440749; c=relaxed/simple;
	bh=mBlhcPbs/4AtW9iUm1sJpj2/mUf5xyUFvoRw2xJsEeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YCj4Rejlo5aSmwG+iIuud8/q1Kch2S30HOCi8L7ihWUnu/suXZhtDDQ0spmdDZCHY6KlbRE/pJuiRAHJEj6ID3XOtRs7DLEaYLvAXOfWEtnN2SvZWxMcvbOKy7bRYgIfXicAn1/CtaptyAGPTo32N8UC4WEZK1dQT+DJC1de0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cj5KMLqI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cj5KMLqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739440746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VF9gmqLLZEfjcpfDgykC+OwEPvzUo3jEbA07776aV5k=;
	b=cj5KMLqIHYW+kM7N7iacHuW22a1bLtm1xTTHodNlr6MMhaUO5XiLpOzTy4wRXNFC9U2Kz4
	yYyWRWcqMzskNsq8L0jp2sNoZYcmHISdoQ9nkPwlIqXnWqorAoV5bfFGwA424tLNJVY1k/
	eOVzH/qxUt9M2WVuhMiowSHJOPi6P2M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-8mXlgVkNNP-s6SGgg-OxUQ-1; Thu, 13 Feb 2025 04:59:03 -0500
X-MC-Unique: 8mXlgVkNNP-s6SGgg-OxUQ-1
X-Mimecast-MFC-AGG-ID: 8mXlgVkNNP-s6SGgg-OxUQ_1739440742
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947a0919aso5138805e9.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 01:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739440742; x=1740045542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF9gmqLLZEfjcpfDgykC+OwEPvzUo3jEbA07776aV5k=;
        b=nhZGVRAm2iA/0k0cWvIICbLDhLPTJOnVUh3cEV56dy5MhFyoxTcDKCh/NiqoTJsE1J
         RSy4/yvdhGYNP6GYls5WSprw4g9R3VrdZ8f1BKnp7cJHIVsXEbNUOexBCeL1O3Bb6jlU
         GbYGJIPUcoQ7gS0ifh/yD2AzIMhRZ/QpMtzHVgoxsUoxiMkSxThgrW8WAHR5fbX4Adyd
         OkZ8US0oempOYp/Wl2g70p0dUr9BJR5WKzBnA1TRJrxyjPtlR/i+iDC3L1MHqrw2DOJg
         3kz2hXQ0iBrJdISNFjCVXKK0wPcPkxkjcch8oPxLnAl+0vpNj7gL0Nu/3y1swi+pgyaf
         hiyg==
X-Forwarded-Encrypted: i=1; AJvYcCV3R+Mm8CKA6hAFvE7Amn73uD0yZIlkdKHAJ72c32oYfkXb57WaEoi9l+EWmlU2nIpsfUO5CtiqEmQyLrv5Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA8qowLTiRWYNmX3mzrIdtvnZ/YQI3P1MbdFIHc+IBWygfhOPR
	X+Wj9ego7mWsqBvYdgu+iDlLGKzjEFXLNOPYfRdsxfM3mFehErTA1roBRrd85WLEbV8Pf3PC/K8
	ybdqUeRT7eC5jLUz9H2kahuJheWNAZTcrwZNoJSyITi0D5ZyTQbPI85uRjtphxOV5
X-Gm-Gg: ASbGncsYB44XjYFwzgLHonBxiC63/QvDUyMWk11UDYUv1bqUS0xtBaJcJVoxao5iweD
	lGtLrUkx0tlv+Z5iCNgw5neRokNFjzlOCqILc8ZJaMLtaHvx7tlEzvTM1XwdiahwBd5OH8MROcc
	p+Pc/+s39ilK3/pY71pvHU1Mi5k4N9JcNscp+6pYNMzcf/AOks16agFlg2FJxuU8fVB1MSqBnXB
	wy3Ib33j19qFI+hdKoJWGH2khXWdamOoVRfvEaO4+5QjaIqwGSg2qCx34jQBGFVW7Q2G2y3//HB
	9W0E1Bvd6XNxmiGrb0VRpVPTR6kxTFjJk1XAOSRam3+gyhdm7h7fRQ==
X-Received: by 2002:a05:600c:1d1d:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-439601c5066mr27870575e9.28.1739440741761;
        Thu, 13 Feb 2025 01:59:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkTmfUjduSY7E+Nry3MwnwedjswLGL+/ZdG16hsINMqSePv8Ea4KoXOATlChPRGWbJhBy8nw==
X-Received: by 2002:a05:600c:1d1d:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-439601c5066mr27870035e9.28.1739440741082;
        Thu, 13 Feb 2025 01:59:01 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04ee48sm44195805e9.3.2025.02.13.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:59:00 -0800 (PST)
Date: Thu, 13 Feb 2025 10:58:55 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, 
	ying123.xu@samsung.com
Subject: Re: [PATCH 2/2] vsock/virtio: Don't reset the created SOCKET during
 s2r
Message-ID: <vxz37vz262nujwe6qfyorblpkuvol3ix6ikzv7lpyx5pilx76e@s2wixscnvvuu>
References: <iv6oalr6yuwsfkoxnorp4t77fdjheteyojauwf2phshucdxatf@ominy3hfcpxb>
 <CGME20250212044758epcas5p244c3add904f0ee06f669cd4c53a9e594@epcas5p2.samsung.com>
 <20250212044843.254862-1-junnan01.wu@samsung.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250212044843.254862-1-junnan01.wu@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UVrw9IbMR7yBeBeTa0TGPUa7cyib1UqGobcu_ipaBg0_1739440742
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Feb 12, 2025 at 12:48:43PM +0800, Junnan Wu wrote:
>>On Mon, Feb 10, 2025 at 12:48:03PM +0100, leonardi@redhat.com wrote:
>>>Like for the other patch, some maintainers have not been CCd.
>>
>>Yes, please use `scripts/get_maintainer.pl`.
>>
>
>Ok, I will add other maintainers by this script in next push.
>
>>>
>>>On Fri, Feb 07, 2025 at 01:20:33PM +0800, Junnan Wu wrote:
>>>>From: Ying Gao <ying01.gao@samsung.com>
>>>>
>>>>If suspend is executed during vsock communication and the
>>>>socket is reset, the original socket will be unusable after resume.
>>
>>Why? (I mean for a good commit description)
>>
>>>>
>>>>Judge the value of vdev->priv in function virtio_vsock_vqs_del,
>>>>only when the function is invoked by virtio_vsock_remove,
>>>>all vsock connections will be reset.
>>>>
>>>The second part of the commit message is not that clear, do you mind
>>>rephrasing it?
>>
>>+1 on that
>>
>
>Well, I will rephrase it in next version.
>
>>Also in this case, why checking `vdev->priv` fixes the issue?
>>
>>>
>>>>Signed-off-by: Ying Gao <ying01.gao@samsung.com>
>>>Missing Co-developed-by?
>>>>Signed-off-by: Junnan Wu <junnan01.wu@samsung.com>
>>>
>>>
>>>>---
>>>>net/vmw_vsock/virtio_transport.c | 6 ++++--
>>>>1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>>>>index 9eefd0fba92b..9df609581755 100644
>>>>--- a/net/vmw_vsock/virtio_transport.c
>>>>+++ b/net/vmw_vsock/virtio_transport.c
>>>>@@ -717,8 +717,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>>>>	struct sk_buff *skb;
>>>>
>>>>	/* Reset all connected sockets when the VQs disappear */
>>>>-	vsock_for_each_connected_socket(&virtio_transport.transport,
>>>>-					virtio_vsock_reset_sock);
>>>I would add a comment explaining why you are adding this check.
>>
>>Yes, please.
>>
>
>Ok, I left a comment here in next version
>
>>>>+	if (!vdev->priv) {
>>>>+		vsock_for_each_connected_socket(&virtio_transport.transport,
>>>>+						virtio_vsock_reset_sock);
>>>>+	}
>>
>>Okay, after looking at the code I understood why, but please write it
>>into the commit next time!
>>
>>virtio_vsock_vqs_del() is called in 2 cases:
>>1 - in virtio_vsock_remove() after setting `vdev->priv` to null since
>>     the drive is about to be unloaded because the device is for example
>>     removed (hot-unplug)
>>
>>2 - in virtio_vsock_freeze() when suspending, but in this case
>>     `vdev->priv` is not touched.
>>
>>I don't think is a good idea using that because in the future it could
>>change. So better to add a parameter to virtio_vsock_vqs_del() to
>>differentiate the 2 use cases.
>>
>>
>>That said, I think this patch is wrong:
>>
>>We are deallocating virtqueues, so all packets that are "in flight" will
>>be completely discarded. Our transport (virtqueues) has no mechanism to
>>retransmit them, so those packets would be lost forever. So we cannot
>>guarantee the reliability of SOCK_STREAM sockets for example.
>>
>>In any case, after a suspension, many connections will be expired in the
>>host anyway, so does it make sense to keep them open in the guest?
>>
>
>If host still holds vsock connection during suspend,
>I think guest should keep them open at this case.
>
>Because we find a scenario that when we do freeze at the time that vsock
>connection is communicating, and after restore, upper application
>is trying to continue sending msg via vsock, then error `ENOTCONN`
>returned in function `vsock_connectible_sendmsg`. But host does not realize
>this thing and still waiting to receive msg with old connect.
>If host doesn't close old connection, it will cause that guest
>can never connect to host via vsock because of error `EPIPE` returned.
>
>If we freeze vsock after sending and receiving data operation completed,
>this error will not happen, and guest can still connect to host after resume.
>
>For example:
>In suitaion 1), if we do following steps
>    step 1) Host start a vsock server
>    step 2) Guest start a vsock client which will no-limited sending data
>    step 3) Guest freeze and resume
>Then vsock connection will be broken and guest can never connect to host via
>vsock untill Host reset vsock server.
>
>And in suitaion 2), if we do following steps
>    step1) Host start a vsock server
>    step2) Guest start a vsock client and send some data
>    step3) After client completed transmit, Guest freeze and resume
>    step4) Guest start a new vsock client and send some data
>In this suitaion, host server don't need to reset, and guest client works well
>after resume.

Okay, but this is not what this patch is doing, right?
Or have I missed something?

>
>>If you want to support this use case, you must first provide a way to
>>keep those packets somewhere (e.g. avoiding to remove the virtqueues?),
>>but I honestly don't understand the use case.
>>
>
>In cases guest sending no-reply-required packet via vsock,
>when guest suspend, the sending action will also suspend
>and no packets will loss after resume.

You can try this simple example to check if it works or not:

guest$ dd if=/dev/urandom of=bigfile bs=1M count=10240
guest$ md5sum bigfile
e412f2803a89da265d53a28dea0f0da7  bigfile

host$ nc --vsock -p 1234 -l > bigfile
guest$ cat bigfile | nc --vsock 2 1234

# while sending do a suspend/resume cycle

# Without your patch, nc should fail, so the user knows the
# communication was wrong, with your patch should not fail.

host$ md5sum bigfile


Is the md5sum the same? If not it means you lost packets and we can't do 
that.

>
>And when host is sending packet via vsock when guest suspend and Vq disapper,
>like you mentioned, those packets will loss.
>But I think those packets should be keep in host device side,
>and promise that once guest resume,
>get them in host device and continue sending.

The host will stop using virtqueue after the driver calls 
`virtio_reset_device()`, so we should handle all the packets already 
queued in the RX virtqueue, because when the host put them in the 
virtqueue it doesn't have any way to track them, so should be up to the 
driver in the guest to stop the device and then check all the buffer 
already queued.

But currently we also call 
`virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);` which will 
discard all the packets queued by application in the guests that weren't 
even queued in the virtqueue.

So again, this patch as it is, it's absolutely not right.

I understand the use case and it's clear to me now, but please write it 
in the commit description.

In summary, if we want to support your use case (and that is fine by 
me), we need to do better in the driver:

- we must not purge `send_pkt_queue`
- we need to make sure that all buffers that the host has put in the RX 
   virtqueue are handled by the guest
- we need to make sure that all buffers that the guest has put in the TX 
   virtqueue are handled by the host or put back on top of send_pkt_queue

Thanks,
Stefano

>
>Thanks,
>Junnan Wu
>
>>To be clear, this behavior is intended, and it's for example the same as
>>when suspending the VM is the hypervisor directly, which after that, it
>>sends an event to the guest, just to close all connections because it's
>>complicated to keep them active.
>>
>>Thanks,
>>Stefano
>>
>>
>>
>>>>
>>>>	/* Stop all work handlers to make sure no one is accessing the device,
>>>>	 * so we can safely call virtio_reset_device().
>>>>--
>>>>2.34.1
>>>>
>>>
>>>I am not familiar with freeze/resume, but I don't see any problems
>>>with this patch.
>>>
>>>Thank you,
>>>Luigi
>>>
>

