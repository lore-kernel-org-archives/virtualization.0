Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0931F63D5
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532851; cv=none; b=gjLr+qvD3K01eI0yjsgOjVBnocU7QxrQcngKcONjjiYwW0ow2tdOgy/e/+aiHyA2FTTiqykRaHec4cnKZ32fV4of1hk+jcKAXYRKXt5SQ6TVXYRsXYvKQfEL1SpS+vGEPm+OcGHbc6XUR0cVihqxDQpeM4BYHkPsEt5A08L+2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532851; c=relaxed/simple;
	bh=MwPLENdg+Ia1pv5QVH281sJkOLiWbrHIz5j4P5RgxZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ulge+/i+OP0Sk/RVZVBYRHYWmWgHq06U82PuH3HkePxHO1+z3uM0tun8thQDUvFypzZkoJpBBC1oPcF5O6GFb92IjyGnLVS4i3HvkxsHD6RFh8htLyv2XMcLnZuJwH/OeRYzYvbOLKxQU7q55rtgr9A21CAc00Zh8mybDAEkU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HptT0ILL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HptT0ILL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734532849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/ln2iWwg3W1VlQ55SosBWfePkjE7g7a7xlkcFCzw0E=;
	b=HptT0ILLZk/TwXRs32qCGtGBiMMnhp3jdaEfWYVsqs12oIwo7iXO1SspZfPo0G39YN5BVj
	q2HGG/7utuLtSNEDX1FNQrwP6IWrClsly6QOcQ1dFTV11ocIddlOWZAeDKAKNWERM1CD4j
	vE0wt+BLpqkB/ou6ZbbV+ArpUTs2Hhg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-APJf-j_2PaGqiKyX3bVKLA-1; Wed, 18 Dec 2024 09:40:47 -0500
X-MC-Unique: APJf-j_2PaGqiKyX3bVKLA-1
X-Mimecast-MFC-AGG-ID: APJf-j_2PaGqiKyX3bVKLA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-467919046fbso18189431cf.0
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 06:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734532847; x=1735137647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/ln2iWwg3W1VlQ55SosBWfePkjE7g7a7xlkcFCzw0E=;
        b=ZZefUHTJKT9Zu7N2jhSP1siviD9VxdNUXFygvup4bOyvtWB/oHYDP+orzYze94jMvb
         5MQNI6qwJYIbbjIK5kB+WmfhReL/WjcMv6AVHzfJ+LzlZdx6apAEqz4AsmVEUHduB2J7
         5pmae1YtquoP8kKJJ0475sm8zI0pSzws7MvWnfsyAj8Yo+OyB4A9Mr/OAFQVCeKBlLcs
         TZda3wpIVlEI7z5rcMxkJa4aN35bkKukNgI7FVatHaY0saOBIQcycmxgkS5wRwBo7alB
         OdGCquxRsumWLcFTY2Nkq/nyiyzWR9Nh+nv4Rm+OJPusB5pwN21fwTanHy353U3IAoRN
         YXDA==
X-Forwarded-Encrypted: i=1; AJvYcCW81x/EOnO6w4HiazNvPG4CAbIrm1crXlGlMmznHJ+CDJ0NUTVpF7n50TAzjz0h24qHQs88PKsML+ArkUf0Ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlloguijrazVJimjll26zMkxnlXza5Zc/kp/aRQu/Gwpn0nHD8
	Ue97mZqeENQgTBlN48L+ani6/2g+RZKHBf+B1M3v4DSVbRyIYAkAsGg4YqeLF6RbdEzTz1/nqop
	OEK+bDkRB9nWyKjjyXy64iL4jLlwG39xfHniDaRhAv5ksV5lRPdl/Y6QiF20+JEUB
X-Gm-Gg: ASbGncsPpvm/N647fv1Y3o4X6VBVXa1QS6UrqLPNUYCYxeyKB6DSf2AzRmc4T62/pBp
	vJ4kONHYmgBXC8Ms45ofrlQMeE//XTUUXVlhcEYWvM1KM7RaK/e/lI57K+3HI2VtuA6ozMwxbBW
	HXFXnje6nVSiprkmu9XUEx9C8C82nByaps98NibEoPlbAguCWlZln5LmbaaBlab4N+AGJwP6Dza
	OblTFIf9bPHt4dvqxftE6pnQ2UQIFS8yi86V/nRFU/z9CUdx4y1gcxNPprNH3FfDuTKngxfS6S4
	uHF3gb48VB6q9y2UUK8msC1P2A6xdGSy
X-Received: by 2002:ac8:7d4c:0:b0:466:93f3:5bf1 with SMTP id d75a77b69052e-46908f47101mr48585881cf.1.1734532847222;
        Wed, 18 Dec 2024 06:40:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ/MvaBfuDYs6BY9Cd4MpRj7KOAGySX61kha03o1FHj3J7vm9jIZZgayAzE8kcfJ0nF3xjFw==
X-Received: by 2002:ac8:7d4c:0:b0:466:93f3:5bf1 with SMTP id d75a77b69052e-46908f47101mr48585361cf.1.1734532846753;
        Wed, 18 Dec 2024 06:40:46 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e99c02sm51225531cf.67.2024.12.18.06.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:40:45 -0800 (PST)
Date: Wed, 18 Dec 2024 15:40:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3o2upHSm6oAu6Xg3-MUyATc8zmMHWQ0LwJpb0wY8Gls_1734532847
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
>On Wed, Dec 18, 2024 at 02:40:49PM +0100, Stefano Garzarella wrote:
>> On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
>> > When calling connect to change the CID of a vsock, the loopback
>> > worker for the VIRTIO_VSOCK_OP_RST command is invoked.
>> > During this process, vsock_stream_has_data() calls
>> > vsk->transport->stream_has_data().
>> > However, a null-ptr-deref occurs because vsk->transport was set
>> > to NULL in vsock_deassign_transport().
>> >
>> >                     cpu0                                                      cpu1
>> >
>> >                                                               socket(A)
>> >
>> >                                                               bind(A, VMADDR_CID_LOCAL)
>> >                                                                 vsock_bind()
>> >
>> >                                                               listen(A)
>> >                                                                 vsock_listen()
>> >  socket(B)
>> >
>> >  connect(B, VMADDR_CID_LOCAL)
>> >
>> >  connect(B, VMADDR_CID_HYPERVISOR)
>> >    vsock_connect(B)
>> >      lock_sock(sk);
>> >      vsock_assign_transport()
>> >        virtio_transport_release()
>> >          virtio_transport_close()
>> >            virtio_transport_shutdown()
>> >              virtio_transport_send_pkt_info()
>> >                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>> >                  queue_work(vsock_loopback_work)
>> >        vsock_deassign_transport()
>> >          vsk->transport = NULL;
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>> >                                                                   virtio_transport_recv_connected()
>> >                                                                     virtio_transport_reset()
>> >                                                                       virtio_transport_send_pkt_info()
>> >                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>> >                                                                           queue_work(vsock_loopback_work)
>> >
>> >                                                               vsock_loopback_work()
>> >                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>> > 								   virtio_transport_recv_disconnecting()
>> > 								     virtio_transport_do_close()
>> > 								       vsock_stream_has_data()
>> > 								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>> >
>> > To resolve this issue, add a check for vsk->transport, similar to
>> > functions like vsock_send_shutdown().
>> >
>> > Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
>> > Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>> > Signed-off-by: Wongi Lee <qwerty@theori.io>
>> > ---
>> > net/vmw_vsock/af_vsock.c | 3 +++
>> > 1 file changed, 3 insertions(+)
>> >
>> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> > index 5cf8109f672a..a0c008626798 100644
>> > --- a/net/vmw_vsock/af_vsock.c
>> > +++ b/net/vmw_vsock/af_vsock.c
>> > @@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>> >
>> > s64 vsock_stream_has_data(struct vsock_sock *vsk)
>> > {
>> > +	if (!vsk->transport)
>> > +		return 0;
>> > +
>>
>> I understand that this alleviates the problem, but IMO it is not the right
>> solution. We should understand why we're still processing the packet in the
>> context of this socket if it's no longer assigned to the right transport.
>
>Got it. I agree with you.
>
>>
>> Maybe we can try to improve virtio_transport_recv_pkt() and check if the
>> vsk->transport is what we expect, I mean something like this (untested):
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9acc13ab3f82..18b91149a62e 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>
>>         lock_sock(sk);
>>
>> -       /* Check if sk has been closed before lock_sock */
>> -       if (sock_flag(sk, SOCK_DONE)) {
>> +       /* Check if sk has been closed or assigned to another transport before
>> +        * lock_sock
>> +        */
>> +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
>>                 (void)virtio_transport_reset_no_sock(t, skb);
>>                 release_sock(sk);
>>                 sock_put(sk);
>>
>> BTW I'm not sure it is the best solution, we have to check that we do not
>> introduce strange cases, but IMHO we have to solve the problem earlier in
>> virtio_transport_recv_pkt().
>
>At least for vsock_loopback.c, this change doesn’t seem to introduce any
>particular issues.

But was it working for you? because the check was wrong, this one should 
work, but still, I didn't have time to test it properly, I'll do later.

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9acc13ab3f82..ddecf6e430d6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
  
         lock_sock(sk);
  
-       /* Check if sk has been closed before lock_sock */
-       if (sock_flag(sk, SOCK_DONE)) {
+       /* Check if sk has been closed or assigned to another transport before
+        * lock_sock
+        */
+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
                 (void)virtio_transport_reset_no_sock(t, skb);
                 release_sock(sk);
                 sock_put(sk);

>
>And separately, I think applying the vsock_stream_has_data patch would help
>prevent potential issues that could arise when vsock_stream_has_data is
>called somewhere.

Not sure, with that check, we wouldn't have seen this problem we had, so 
either add an error, but mute it like this I don't think is a good idea, 
also because the same function is used in a hot path, so an extra check 
could affect performance (not much honestly in this case, but adding it 
anywhere could).

Thanks,
Stefano

>
>>
>> Thanks,
>> Stefano
>>
>> > 	return vsk->transport->stream_has_data(vsk);
>> > }
>> > EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>> > --
>> > 2.34.1
>> >
>>
>

