Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35B86352
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734596398; cv=none; b=ZmOIA2+xyNi09FlXdag9SbpQEfhef7F9H6ZlxMsLF/yYIsRn/l6UjnxsbU8CmQlLnidEp0IPhTMxdeS1pQ7BHmznp+j1HZC7msVCcU+IpWxYUU9tlqrWxyrIxY76fFpRG6aWzjWpWJeOOXncFA6DkRknOXEMGlE6w4+V9B6M8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734596398; c=relaxed/simple;
	bh=eJUkN9ilHcw1SnkVlgtb32oUI9TlDttRegj5MNnKna4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Wuw7Y2XNXugvCLfAGSdUSypYGFYhmqesl2WGEN5wzr6Ib6iPpNFa7+kbRoj1gjNTJwRkI2oE0xtUxt5itPClOdLE4PyMRWFjkTOew6ym9mTRXirdiAaoN8OYXcFZNsEU55hUJwRUq7B0wnh9R3OZSSam8VyA/HB5UDieEKih86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SG2R36o3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SG2R36o3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734596394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbdOr6aQNDsdO5CKQMhPyCwxIDtzeBIbnye+AambmwI=;
	b=SG2R36o3rVhvatDdc81SMYn+FCK/ruZ0/w2chZqAZM13wFfgVkZjsFoszOHUsg2LSBpKKe
	vbY13FfB9kfvufHQn+n/UHaWCrFU/bokJ7XojgC3OkhtZLwpXd4TRI5F4DoW8p67cq7UJE
	7F3GZ+g3Kqmf6B91iBX8xjNZB0GHfBY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-eD8xo-GPPdWl9QQS3xSw5g-1; Thu, 19 Dec 2024 03:19:52 -0500
X-MC-Unique: eD8xo-GPPdWl9QQS3xSw5g-1
X-Mimecast-MFC-AGG-ID: eD8xo-GPPdWl9QQS3xSw5g
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa66ab24344so47667266b.3
        for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 00:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734596391; x=1735201191;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbdOr6aQNDsdO5CKQMhPyCwxIDtzeBIbnye+AambmwI=;
        b=m2uNjZuvKRJXKm8wcOpb9IGQxBIy4VoBmPB6J1tMAuRNer/s/StIOEJlsALcbSwALh
         YxkXDoQSKlPCL4u9y9xWfK5rt66LRAiyepA1rcpnfWNtgCse5gzTWf1VjjpMh2BTQs3A
         Wu0DDPCCTqILfu2WD01QirXeNh/HgWDvwZ4UTTFtsuJy6w9rsrdXvY0vnhjTRsfBTsot
         HSVNmUuqWujG3wSLSOrlz+zX+1XGGi4qvCB68yx31G58iSq9nE/6eAqv3Itjl7l8ebkk
         djXXaeSVMH7DM0kSOtwBsVoWvVKAOTOPSsLpADkvT6akTXi65Q5RHte1SPD34cP06mnt
         pfvA==
X-Forwarded-Encrypted: i=1; AJvYcCXeSLuUOlbGh8q3nsdmV/esqqHOArJhVZlNMd5Gf1bahXNFrEO03OAZZFkDHbEeKed41S4T+xqWQ+tRHFRfCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqIjPvFZN7siNeEqUbmUFsLX34yp5d9rj6OTvpZU81rw4qNZsM
	nWvgip7af/km344ATsKG3qAL9Zle+XDYGm24NiM4+Ghfc8gkrskP5HsGl0qXKjT/gign1+WeTH5
	bCt0pv+zz16CtiolwXR7tnN1Hj8IEqZJB984Ik/R+ukir5mOhuVqOy45APyRdtz6z
X-Gm-Gg: ASbGncvTTzVyF9ObefDwH13E6GjFt+Tf0jPQHY4ym9xRnT+bwBTnn5jtQSUf1c2AUwO
	stMCJ05SsZy/t4f2HhiNc5Pf7jlLYvnWV8YBZCAquqm1UhFPU9O1Z+fRoQ+GuG1f+xNl1lL62BQ
	ntz0ItgOme+tpeCmzHq1CzDeTW9HvPbzyy9UqENLqThVRTSPvxwaBfbqgf0AhAw3rNcnGG6Imwh
	Kcaz8ZTd2irOUSORryVhRQI4pLJjaB10oaOz/BDzGljovMMmnGdhNNVGEIrhOaI2MmhtvKZB2wD
	mEqdzHM0aB5IywuGFUQuP74D7oV0dsof
X-Received: by 2002:a17:907:2cc2:b0:aa6:6e10:61f1 with SMTP id a640c23a62f3a-aac078c92e2mr184820166b.1.1734596390884;
        Thu, 19 Dec 2024 00:19:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6AY4CH+pW6AjjnNaTPyzUaYWwgoFHV93tESaaZ5B1C3mKDdPQiYU8a/vc14wmkcmoeiztqA==
X-Received: by 2002:a17:907:2cc2:b0:aa6:6e10:61f1 with SMTP id a640c23a62f3a-aac078c92e2mr184815266b.1.1734596390021;
        Thu, 19 Dec 2024 00:19:50 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e896163sm39197566b.59.2024.12.19.00.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:19:49 -0800 (PST)
Date: Thu, 19 Dec 2024 09:19:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>, Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
 <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _DX-iSGw15cKrSxFyMU7PCsaBOehgWFn_t0pW5JClY4_1734596391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 18, 2024 at 08:37:38PM -0500, Hyunwoo Kim wrote:
>On Thu, Dec 19, 2024 at 01:25:34AM +0100, Michal Luczaj wrote:
>> On 12/18/24 16:51, Hyunwoo Kim wrote:
>> > On Wed, Dec 18, 2024 at 04:31:03PM +0100, Stefano Garzarella wrote:
>> >> On Wed, Dec 18, 2024 at 03:40:40PM +0100, Stefano Garzarella wrote:
>> >>> On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
>> >>>> At least for vsock_loopback.c, this change doesn’t seem to introduce any
>> >>>> particular issues.
>> >>>
>> >>> But was it working for you? because the check was wrong, this one should
>> >>> work, but still, I didn't have time to test it properly, I'll do later.
>> >>>
>> >>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >>> index 9acc13ab3f82..ddecf6e430d6 100644
>> >>> --- a/net/vmw_vsock/virtio_transport_common.c
>> >>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> >>> @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>> >>>        lock_sock(sk);
>> >>> -       /* Check if sk has been closed before lock_sock */
>> >>> -       if (sock_flag(sk, SOCK_DONE)) {
>> >>> +       /* Check if sk has been closed or assigned to another transport before
>> >>> +        * lock_sock
>> >>> +        */
>> >>> +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
>> >>>                (void)virtio_transport_reset_no_sock(t, skb);
>> >>>                release_sock(sk);
>> >>>                sock_put(sk);
>>
>> Hi, I got curious about this race, my 2 cents:
>>
>> Your patch seems to fix the reported issue, but there's also a variant (as
>> in: transport going null unexpectedly) involving BPF:

I think it is a different problem, to be solved in vsock_bpf.c

With something like this (untested):

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 4aa6e74ec295..8c2322dc2af7 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -25,10 +25,8 @@ static struct proto vsock_bpf_prot;
  static bool vsock_has_data(struct sock *sk, struct sk_psock *psock)
  {
         struct vsock_sock *vsk = vsock_sk(sk);
-       s64 ret;

-       ret = vsock_connectible_has_data(vsk);
-       if (ret > 0)
+       if (vsk->transport && vsock_connectible_has_data(vsk) > 0)
                 return true;

         return vsock_sk_has_data(sk, psock);

Note: we should check better this, because sometime we call it without
lock_sock, also thi

>
>Yes. It seems that calling connect() twice causes the transport to become
>NULL, leading to null-ptr-deref in any flow that tries to access that
>transport.

We already expect vsk->transport to be null in several parts, but in 
some we assume it is called when this is valid. So we should check 
better what we do when we deassign a transport.

>
>And that null-ptr-deref occurs because, unlike __vsock_stream_recvmsg,
>vsock_bpf_recvmsg does not check vsock->transport:

Right.

So, thanks for the report, I'll try to see if I can make a patch with 
everything before tomorrow, because then I'm gone for 2 weeks.

Otherwise we'll see as soon as I get back or if you have time in the 
meantime, any solution is welcome.

I think the best thing though is to better understand how to handle 
deassign, rather than checking everywhere that it's not null, also 
because in some cases (like the one in virtio-vsock), it's also 
important that the transport is the same.

Thanks,
Stefano

>```
>int
>__vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>                            int flags)
>{
>	...
>
>        lock_sock(sk);
>
>        transport = vsk->transport;
>
>        if (!transport || sk->sk_state != TCP_ESTABLISHED) {
>                /* Recvmsg is supposed to return 0 if a peer performs an
>                 * orderly shutdown. Differentiate between that case and when a
>                 * peer has not connected or a local shutdown occurred with the
>                 * SOCK_DONE flag.
>                 */
>                if (sock_flag(sk, SOCK_DONE))
>                        err = 0;
>                else
>                        err = -ENOTCONN;
>
>                goto out;
>        }
>```
>
>>
>> /*
>> $ gcc vsock-transport.c && sudo ./a.out
>>
>> BUG: kernel NULL pointer dereference, address: 00000000000000a0
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
>> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
>> RIP: 0010:vsock_connectible_has_data+0x1f/0x40
>> Call Trace:
>>  vsock_bpf_recvmsg+0xca/0x5e0
>>  sock_recvmsg+0xb9/0xc0
>>  __sys_recvfrom+0xb3/0x130
>>  __x64_sys_recvfrom+0x20/0x30
>>  do_syscall_64+0x93/0x180
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> */
>>
>> #include <stdio.h>
>> #include <stdint.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <sys/socket.h>
>> #include <sys/syscall.h>
>> #include <linux/bpf.h>
>> #include <linux/vm_sockets.h>
>>
>> static void die(const char *msg)
>> {
>> 	perror(msg);
>> 	exit(-1);
>> }
>>
>> static int create_sockmap(void)
>> {
>> 	union bpf_attr attr = {
>> 		.map_type = BPF_MAP_TYPE_SOCKMAP,
>> 		.key_size = sizeof(int),
>> 		.value_size = sizeof(int),
>> 		.max_entries = 1
>> 	};
>> 	int map;
>>
>> 	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
>> 	if (map < 0)
>> 		die("create_sockmap");
>>
>> 	return map;
>> }
>>
>> static void map_update_elem(int fd, int key, int value)
>> {
>> 	union bpf_attr attr = {
>> 		.map_fd = fd,
>> 		.key = (uint64_t)&key,
>> 		.value = (uint64_t)&value,
>> 		.flags = BPF_ANY
>> 	};
>>
>> 	if (syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)))
>> 		die("map_update_elem");
>> }
>>
>> int main(void)
>> {
>> 	struct sockaddr_vm addr = {
>> 		.svm_family = AF_VSOCK,
>> 		.svm_port = VMADDR_PORT_ANY,
>> 		.svm_cid = VMADDR_CID_LOCAL
>> 	};
>> 	socklen_t alen = sizeof(addr);
>> 	int map, s;
>>
>> 	map = create_sockmap();
>>
>> 	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>> 	if (s < 0)
>> 		die("socket");
>>
>> 	if (!connect(s, (struct sockaddr *)&addr, alen))
>> 		die("connect #1");
>> 	perror("ok, connect #1 failed; transport set");
>>
>> 	map_update_elem(map, 0, s);
>>
>> 	addr.svm_cid = 42;
>> 	if (!connect(s, (struct sockaddr *)&addr, alen))
>> 		die("connect #2");
>> 	perror("ok, connect #2 failed; transport unset");
>>
>> 	recv(s, NULL, 0, 0);
>> 	return 0;
>> }
>>
>

