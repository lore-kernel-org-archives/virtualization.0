Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386E2AE94
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 01:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572266; cv=none; b=Sw+ssOWbsdsb0jnU83QS7dQNK1eP3+ClFUSG25c4pxUt68hGvC5uED64Y79UkHidyUyDg8sox/v4jedQiNcyMMDxpdpLDtjfBC9BC+dEjFJbrTZzM7xEtrzkbif6t/sRczoQbNNIp9MCP1nUZ1zj8xrStFfCSEncNBAKnI9BtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572266; c=relaxed/simple;
	bh=2MH3hb/vnxAt2cr/+GBXqIaW4LQ0kOSeINzvUf+smao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRh7d62ZbxSGGu37jzQ7Mz9bYU3BKPkdoYDoPu+IWlu2cy9pvDtOlcv+oNFK586kPXXf2z2V7I1+7Yrtqndf+T+w2e2a6kR4BgJK8VC0P1wD7bMFkdxhLtaktk3HM0LVIJzdrbgnnZms5zrk2v399YPFnJkhDAJbgykPFvc2dN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=Z/p9zdn9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="Z/p9zdn9"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21680814d42so2691135ad.2
        for <virtualization@lists.linux.dev>; Wed, 18 Dec 2024 17:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1734572263; x=1735177063; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8XW1JhCMRj4QLLPyPYIDr5vx1FRS6A08nnoLsnH56s=;
        b=Z/p9zdn9xi4qCJ1metaMogFMyiImq2LOffm/ip+lDVGsQ1U6lLXL66zucDegPJUXuU
         sy8rX0xBH5WBcMvL2ueGBlesLEDwHPuKtx8+Objs9/m4LQX0e+0/VUHI5ZB0/ostm92O
         1uHeO5uPoHtpyiC8NXI3rzCF5UQBr1gDulURQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572263; x=1735177063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8XW1JhCMRj4QLLPyPYIDr5vx1FRS6A08nnoLsnH56s=;
        b=Oqfiowx0B9pcdMt0bECSJZigTH0jvhZ9rnZ+rvBvL0iUPV6/eYiRly1V0A+pHjXISo
         0BZACtKtUjbHlpiUE3am2HK3py4AIbh1bo4LwxLjsdN6eoIxYwwHz6UPFGHsCflhv0r8
         nDOnSrVKrK3uoqGoiNjSwRXzqAiiYrqzHy3++2gwEae8qK5eZOx0FMluz6+Ht42HW4Dm
         VNoOTUD8EcJT/I3ZJxMfjHK588UoJoKTMICOiHQ6X2NnM87VNTRdyzG7qaXkX7Ya8Lfk
         FL/XecoFi0CgKP0J1l2us+nPLACfSh7HnaRr27JnCF3lBoIW/JsUXzV0UnUiqY2VGZzY
         pb/A==
X-Forwarded-Encrypted: i=1; AJvYcCVa/+8fjRfLCMtkimi4uuE/uEySYd6YqZQZQ6pYJSbmG/2NzQNkPz/Q7L4zQX8QA1XlgQoFme9+K/lN+wnAAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9Y24g0ifRGESUiA5G1N3qCwI7MnXa6CpoeA3W2GrbPuud+td4
	qo01Y/OiZTnL0NXAmGgdJGkIwGmQPzpXweQnclY5m6Ff4UQr0AJN/bMl7Rtq+SQ=
X-Gm-Gg: ASbGnctI8TLmgGCZuBY15vv9yBmNxsHpy9Pf1DeQ+9IhfSN8AZ+1mqF2XiPVnPbVSFl
	8+L3em9zNCUY8dH2ZJ7+WN5VT1UjA3IWWMQNwIAmignYHdPlUeCanF+67OXYwkkfb14uC82GfC3
	RgP6gM817LcTmb3dImg0xSP6pKlk7YlKdbcv3DKsEfI1YWGuMFihHNKdCwcJ2hWO6vPRc2qJA39
	quK72IyXuI24234zXcGvQeCW5DRgEpHfQ/acPJ3GuAm9RvykBt2u9kNhse5ik3vhg4ijw==
X-Google-Smtp-Source: AGHT+IGN+U/XHfdeOdvjD0jPoU/EW16k1bTXzLvORJgsd5bkg6p1guU0fPkT3mIdRTdgV6T+kYz4/w==
X-Received: by 2002:a17:903:124f:b0:215:a039:738 with SMTP id d9443c01a7336-218d6fd5ee3mr78255185ad.5.1734572263160;
        Wed, 18 Dec 2024 17:37:43 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962d0asm1821915ad.53.2024.12.18.17.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:37:42 -0800 (PST)
Date: Wed, 18 Dec 2024 20:37:38 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	qwerty@theori.io
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
Message-ID: <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
 <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>

On Thu, Dec 19, 2024 at 01:25:34AM +0100, Michal Luczaj wrote:
> On 12/18/24 16:51, Hyunwoo Kim wrote:
> > On Wed, Dec 18, 2024 at 04:31:03PM +0100, Stefano Garzarella wrote:
> >> On Wed, Dec 18, 2024 at 03:40:40PM +0100, Stefano Garzarella wrote:
> >>> On Wed, Dec 18, 2024 at 09:19:08AM -0500, Hyunwoo Kim wrote:
> >>>> At least for vsock_loopback.c, this change doesn’t seem to introduce any
> >>>> particular issues.
> >>>
> >>> But was it working for you? because the check was wrong, this one should
> >>> work, but still, I didn't have time to test it properly, I'll do later.
> >>>
> >>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> >>> index 9acc13ab3f82..ddecf6e430d6 100644
> >>> --- a/net/vmw_vsock/virtio_transport_common.c
> >>> +++ b/net/vmw_vsock/virtio_transport_common.c
> >>> @@ -1628,8 +1628,10 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> >>>        lock_sock(sk);
> >>> -       /* Check if sk has been closed before lock_sock */
> >>> -       if (sock_flag(sk, SOCK_DONE)) {
> >>> +       /* Check if sk has been closed or assigned to another transport before
> >>> +        * lock_sock
> >>> +        */
> >>> +       if (sock_flag(sk, SOCK_DONE) || vsk->transport != &t->transport) {
> >>>                (void)virtio_transport_reset_no_sock(t, skb);
> >>>                release_sock(sk);
> >>>                sock_put(sk);
> 
> Hi, I got curious about this race, my 2 cents:
> 
> Your patch seems to fix the reported issue, but there's also a variant (as
> in: transport going null unexpectedly) involving BPF:

Yes. It seems that calling connect() twice causes the transport to become 
NULL, leading to null-ptr-deref in any flow that tries to access that 
transport.

And that null-ptr-deref occurs because, unlike __vsock_stream_recvmsg, 
vsock_bpf_recvmsg does not check vsock->transport:
```
int
__vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
                            int flags)
{
	...

        lock_sock(sk);

        transport = vsk->transport;

        if (!transport || sk->sk_state != TCP_ESTABLISHED) {
                /* Recvmsg is supposed to return 0 if a peer performs an
                 * orderly shutdown. Differentiate between that case and when a
                 * peer has not connected or a local shutdown occurred with the
                 * SOCK_DONE flag.
                 */
                if (sock_flag(sk, SOCK_DONE))
                        err = 0;
                else
                        err = -ENOTCONN;

                goto out;
        }
```

> 
> /*
> $ gcc vsock-transport.c && sudo ./a.out
> 
> BUG: kernel NULL pointer dereference, address: 00000000000000a0
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 12faf8067 P4D 12faf8067 PUD 113670067 PMD 0
> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 15 UID: 0 PID: 1198 Comm: a.out Not tainted 6.13.0-rc2+
> RIP: 0010:vsock_connectible_has_data+0x1f/0x40
> Call Trace:
>  vsock_bpf_recvmsg+0xca/0x5e0
>  sock_recvmsg+0xb9/0xc0
>  __sys_recvfrom+0xb3/0x130
>  __x64_sys_recvfrom+0x20/0x30
>  do_syscall_64+0x93/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> */
> 
> #include <stdio.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <sys/syscall.h>
> #include <linux/bpf.h>
> #include <linux/vm_sockets.h>
> 
> static void die(const char *msg)
> {
> 	perror(msg);
> 	exit(-1);
> }
> 
> static int create_sockmap(void)
> {
> 	union bpf_attr attr = {
> 		.map_type = BPF_MAP_TYPE_SOCKMAP,
> 		.key_size = sizeof(int),
> 		.value_size = sizeof(int),
> 		.max_entries = 1
> 	};
> 	int map;
> 
> 	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
> 	if (map < 0)
> 		die("create_sockmap");
> 
> 	return map;
> }
> 
> static void map_update_elem(int fd, int key, int value)
> {
> 	union bpf_attr attr = {
> 		.map_fd = fd,
> 		.key = (uint64_t)&key,
> 		.value = (uint64_t)&value,
> 		.flags = BPF_ANY
> 	};
> 
> 	if (syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)))
> 		die("map_update_elem");
> }
> 
> int main(void)
> {
> 	struct sockaddr_vm addr = {
> 		.svm_family = AF_VSOCK,
> 		.svm_port = VMADDR_PORT_ANY,
> 		.svm_cid = VMADDR_CID_LOCAL
> 	};
> 	socklen_t alen = sizeof(addr);
> 	int map, s;
> 
> 	map = create_sockmap();
> 
> 	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
> 	if (s < 0)
> 		die("socket");
> 
> 	if (!connect(s, (struct sockaddr *)&addr, alen))
> 		die("connect #1");
> 	perror("ok, connect #1 failed; transport set");
> 
> 	map_update_elem(map, 0, s);
> 
> 	addr.svm_cid = 42;
> 	if (!connect(s, (struct sockaddr *)&addr, alen))
> 		die("connect #2");
> 	perror("ok, connect #2 failed; transport unset");
> 
> 	recv(s, NULL, 0, 0);
> 	return 0;
> }
> 
