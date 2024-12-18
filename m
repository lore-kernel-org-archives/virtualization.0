Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740C481B3
	for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535874; cv=none; b=CUx90OzF8UN7PgxmgmtkOv4eAu3+YojNXkZv3ddW3S1cctlPJU7fwXvUqk90YSBjnEcBv1r8Fuw5QbciQnJi0Tc7axYWMRRv2LBJ/zgsYNoGz13xZJvlUK3VB1xGJLOXqVNFn8ajZYZsCdsdhQydLujBDY0NFQf+3Obf187xnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535874; c=relaxed/simple;
	bh=r3XUVXoTJXySn8j6M/I5ggNYgQbkFXVfuxSN+4AJWE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TFcfUCoXLWSlgpLsltBmdxNyoLA6lMpBfNcO/F0UwLJEj/06UsuEGs3vZa3Igb+dztfbGxW5kn5MXwWSWsgMzgN1u3ajgWGdd/O09M7u2fzJoXFiL8xZ7r/e9+1RwUCEJoXnEoFsweu2RrrcXnhWvpVhgKs5cbtlxdLKWMwHwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VPcd4BGd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPcd4BGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734535871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zP6jpPRpC9DNILLQoSAYB9QA64lMMdKrQX15yrk9XVE=;
	b=VPcd4BGduBTTpPJZt5cab6CQLVOvHwHh+IHt6N/rNSDaYRv12H7nOf59iebDCMILdIsnQ5
	LGPN+Ldwuy0CO5HeVAQbK/B4ADER1WKEVZIZnlxt7nQE/MUsq4CGiLYtpeMtgSCWjwBvsA
	F2AWB6UGQ6M9ZmWeQor4wZCCuTiF/zc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-e5QHn5sVOz6sgEYElTOaNA-1; Wed, 18 Dec 2024 10:31:10 -0500
X-MC-Unique: e5QHn5sVOz6sgEYElTOaNA-1
X-Mimecast-MFC-AGG-ID: e5QHn5sVOz6sgEYElTOaNA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e1339790so3940769f8f.2
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 07:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734535869; x=1735140669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP6jpPRpC9DNILLQoSAYB9QA64lMMdKrQX15yrk9XVE=;
        b=YFIgSd4Abgwq5GNsa6f9fFjJjRjUWJpO1zSGr3OtZKQB2qR9flxOYr0wxCIJIYcwq+
         QyZY7hHC5hH2tPjDOmURIfirowr+KvnBg/QQ17Zlb7N62huMoikHZf0E3H2os7QkqCCJ
         6VtUqUbIn0MlpuMIGRrhRsLOgnpedSxRttkK4eBde6d9Fcog8sdE26kW2EbWKx6/AZhE
         uwfMNrnyzfPXI4Mm2m9EbQvASdnvjsH1TPowJrQx7dgMmW/d2VObD/QNfNevFJ+1fHKX
         DH3UpadBNN5Qy+n0dIo8OR9cY74CWSsl5zFUCgg/FqJafjH02e0hpOBCk5KkY3f0qBoP
         oWDA==
X-Forwarded-Encrypted: i=1; AJvYcCVrp0FPj1LbP9K2pBD0uzu2jwSU2JsFhDRXlcs/MXoCqcxKwdEYm9tkD8MJXl2sEtgch9F5Wvfvmk4nmJqO9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNHn7qNQZIYkkuW11AZjWaxdrE3GDsEimQal6OdJiXohkQrkyP
	EPvWqnnfC41g0goOeXlONT9X1i4XiWoo4As33JRnR+Nzqhiv3Ecyb8f5w/rUtsqje6wcL1tp5uF
	P6UMd4KyRm13C78iiuiqafyNKJoxKYgU8QLMcRgY9QAJ7yn0ab3nbt5lNPvqlm0bd
X-Gm-Gg: ASbGncsuQW+Nk8X+5HwgDhLQHnQ7yqadD1c7ZfQnhETVXSg9LKMdZK4yxlvDk2vBBcG
	OrE+oCqKaU19OgkDXZgOt0kPpkomhZXkGLwbP6R8IVb5yfQsYV6ltGrIxnrCVrmQhsTVE5sLzUI
	LBS5u9Rur66rODLP34gYF0WdzJiLu6CoeVd/JrUxb+EH6TIgUsHRMwP50hnzC6js1otdnULKr3X
	uHNkLi5TWxOqVtG1he/IwFVZTO/TpY3FauEDOV709u82zkf0yEzLtFh/z1Oz8iyYf7A2Cu+htpl
	68GAG3igm63I0+3mYqSNE20pwjs0QOzH
X-Received: by 2002:a5d:59a5:0:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-38a19b34cfemr2220f8f.39.1734535868960;
        Wed, 18 Dec 2024 07:31:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDDdXPUZnVUVG+84ipcndh/cFh9e/6HZbYw/dYlro0c6HYQ/SQobmD1ixPZyJDlF01VybrxQ==
X-Received: by 2002:a5d:59a5:0:b0:385:dc45:ea22 with SMTP id ffacd0b85a97d-38a19b34cfemr2154f8f.39.1734535868295;
        Wed, 18 Dec 2024 07:31:08 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804a2f9sm14540515f8f.77.2024.12.18.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:31:07 -0800 (PST)
Date: Wed, 18 Dec 2024 16:31:03 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io, imv4bel@gmail.com
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jFGGSjlIy3zeRH0jQ7vglnab4x8U9YgTNU36B_Q3Lqo_1734535869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 18, 2024 at 03:40:40PM +0100, Stefano Garzarella wrote:
>On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
>>On Wed, Dec 18, 2024 at 02:40:49PM +0100, Stefano Garzarella wrote:
>>>On Wed, Dec 18, 2024 at 07:25:07AM -0500, Hyunwoo Kim wrote:
>>>> When calling connect to change the CID of a vsock, the loopback
>>>> worker for the VIRTIO_VSOCK_OP_RST command is invoked.
>>>> During this process, vsock_stream_has_data() calls
>>>> vsk->transport->stream_has_data().
>>>> However, a null-ptr-deref occurs because vsk->transport was set
>>>> to NULL in vsock_deassign_transport().
>>>>
>>>>                     cpu0                                                      cpu1
>>>>
>>>>                                                               socket(A)
>>>>
>>>>                                                               bind(A, VMADDR_CID_LOCAL)
>>>>                                                                 vsock_bind()
>>>>
>>>>                                                               listen(A)
>>>>                                                                 vsock_listen()
>>>>  socket(B)
>>>>
>>>>  connect(B, VMADDR_CID_LOCAL)
>>>>
>>>>  connect(B, VMADDR_CID_HYPERVISOR)
>>>>    vsock_connect(B)
>>>>      lock_sock(sk);

It shouldn't go on here anyway, because there's this check in 
vsock_connect():

	switch (sock->state) {
	case SS_CONNECTED:
		err = -EISCONN;
		goto out;


Indeed if I try, I have this behaviour:

shell1# python3
import socket
s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
s.bind((1,1234))
s.listen()

shell2# python3
import socket
s = socket.socket(socket.AF_VSOCK, socket.SOCK_STREAM)
s.connect((1, 1234))
s.connect((2, 1234))
Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
OSError: [Errno 106] Transport endpoint is already connected


Where 106 is exactly EISCONN.
So, do you have a better reproducer for that?

Would be nice to add a test in tools/testing/vsock/vsock_test.c

Thanks,
Stefano

>>>>      vsock_assign_transport()
>>>>        virtio_transport_release()
>>>>          virtio_transport_close()
>>>>            virtio_transport_shutdown()
>>>>              virtio_transport_send_pkt_info()
>>>>                vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>>>>                  queue_work(vsock_loopback_work)
>>>>        vsock_deassign_transport()
>>>>          vsk->transport = NULL;
>>>>                                                               vsock_loopback_work()
>>>>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_SHUTDOWN)
>>>>                                                                   virtio_transport_recv_connected()
>>>>                                                                     virtio_transport_reset()
>>>>                                                                       virtio_transport_send_pkt_info()
>>>>                                                                         vsock_loopback_send_pkt(VIRTIO_VSOCK_OP_RST)
>>>>                                                                           queue_work(vsock_loopback_work)
>>>>
>>>>                                                               vsock_loopback_work()
>>>>                                                                 virtio_transport_recv_pkt(VIRTIO_VSOCK_OP_RST)
>>>> 								   virtio_transport_recv_disconnecting()
>>>> 								     virtio_transport_do_close()
>>>> 								       vsock_stream_has_data()
>>>> 								         vsk->transport->stream_has_data(vsk);    // null-ptr-deref
>>>>
>>>> To resolve this issue, add a check for vsk->transport, similar to
>>>> functions like vsock_send_shutdown().
>>>>
>>>> Fixes: fe502c4a38d9 ("vsock: add 'transport' member in the struct vsock_sock")
>>>> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
>>>> Signed-off-by: Wongi Lee <qwerty@theori.io>
>>>> ---
>>>> net/vmw_vsock/af_vsock.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>>> index 5cf8109f672a..a0c008626798 100644
>>>> --- a/net/vmw_vsock/af_vsock.c
>>>> +++ b/net/vmw_vsock/af_vsock.c
>>>> @@ -870,6 +870,9 @@ EXPORT_SYMBOL_GPL(vsock_create_connected);
>>>>
>>>> s64 vsock_stream_has_data(struct vsock_sock *vsk)
>>>> {
>>>> +	if (!vsk->transport)
>>>> +		return 0;
>>>> +
>>>
>>>I understand that this alleviates the problem, but IMO it is not the right
>>>solution. We should understand why we're still processing the packet in the
>>>context of this socket if it's no longer assigned to the right transport.
>>
>>Got it. I agree with you.
>>
>>>
>>>Maybe we can try to improve virtio_transport_recv_pkt() and check if the
>>>vsk->transport is what we expect, I mean something like this (untested):
>>>
>>>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>>index 9acc13ab3f82..18b91149a62e 100644
>>>--- a/net/vmw_vsock/virtio_transport_common.c
>>>+++ b/net/vmw_vsock/virtio_transport_common.c
>>>@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>>>
>>>        lock_sock(sk);
>>>
>>>-       /* Check if sk has been closed before lock_sock */
>>>-       if (sock_flag(sk, SOCK_DONE)) {
>>>+       /* Check if sk has been closed or assigned to another transport before
>>>+        * lock_sock
>>>+        */
>>>+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != t) {
>>>                (void)virtio_transport_reset_no_sock(t, skb);
>>>                release_sock(sk);
>>>                sock_put(sk);
>>>
>>>BTW I'm not sure it is the best solution, we have to check that we do not
>>>introduce strange cases, but IMHO we have to solve the problem earlier in
>>>virtio_transport_recv_pkt().
>>
>>At least for vsock_loopback.c, this change doesn’t seem to introduce any
>>particular issues.
>
>But was it working for you? because the check was wrong, this one 
>should work, but still, I didn't have time to test it properly, I'll 
>do later.
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 9acc13ab3f82..ddecf6e430d6 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>        lock_sock(sk);
>-       /* Check if sk has been closed before lock_sock */
>-       if (sock_flag(sk, SOCK_DONE)) {
>+       /* Check if sk has been closed or assigned to another transport before
>+        * lock_sock
>+        */
>+       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
>                (void)virtio_transport_reset_no_sock(t, skb);
>                release_sock(sk);
>                sock_put(sk);
>
>>
>>And separately, I think applying the vsock_stream_has_data patch would help
>>prevent potential issues that could arise when vsock_stream_has_data is
>>called somewhere.
>
>Not sure, with that check, we wouldn't have seen this problem we had, 
>so either add an error, but mute it like this I don't think is a good 
>idea, also because the same function is used in a hot path, so an 
>extra check could affect performance (not much honestly in this case, 
>but adding it anywhere could).
>
>Thanks,
>Stefano
>
>>
>>>
>>>Thanks,
>>>Stefano
>>>
>>>> 	return vsk->transport->stream_has_data(vsk);
>>>> }
>>>> EXPORT_SYMBOL_GPL(vsock_stream_has_data);
>>>> --
>>>> 2.34.1
>>>>
>>>
>>

