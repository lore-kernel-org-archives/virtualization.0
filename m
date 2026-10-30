Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370339;
	b=LNxmiFUWEXE/vXtv9Ysb61jULd4kGxaOHxBzeu+euCbs2pjJwHVxLXjL35uPNWp9zrTg
	 vGvpc8U8aW6TJa+CZOSII4+92KCcCON8KgPhr/CHiXXXZ7qvrSfb/VHSqKOtkttTYX4RO
	 ou8OEmU2YTwU+6b32uwVhaV0sJAqXQ540RTpUxvgbxRYuQHT2QAptiFKWJHT2jl43oGsB
	 tpeHqhrB50NSQq3T1SZYfljpBVwLe771TeAFhd1evnRqk0dpY6H9On1I2urxPR8cr675C
	 914vMkr0ueZWPeLZ8cWulxhd8kvdQoHu4252tYo88KU/XfjZCizPXB52WLMHgArH8DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370339;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=aLnPtHK687FMiRhGf2fkDTjbZs7yseTcdHjFjaHWPdw=;
	b=lo2uDmOPWBXvyFiO5fsbHC9zSXRcn7eUgND0lHxshkSSdwTiTLeqDBNgjOzRYQpcNjON
	 HUD39dwDEBdb21aik3fyga0O/xT0i2kZx8FMBSCs6y0dfTIolxiwbz0cPdoXAHmfKKjtw
	 Qt5Lvw6fFWZ7qn0ewZds03a5TiA2dY18mZY273gvp5jfB0sGfqGSrG6ASF1YLq6kKZOAv
	 HPx9+70+iaS0y4z+f0qgQ+f4/kCVmW57JLw56iBP0+ecHf5/sAB1jptl9pOLD+zPJ8Qm7
	 JNI3vG6AtvuHGMuXDF0mVX7Bds+0OqcuAXPxQf7+XQqZYxd2CeZ1U+PFpp11WTRo5SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JzYW0hoY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E1606A31E
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 14:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 737E1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JzYW0hoY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793370337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLnPtHK687FMiRhGf2fkDTjbZs7yseTcdHjFjaHWPdw=;
	b=JzYW0hoYfGbUsXkfhbYLFQQ81WLE0ZIHS46hGeV7vozhHFaB+JyMBMq4yMhW/hHTFOxhOE
	V+t4NKr+X3Oy736pURNhuqPd6yt9X1JySm5mkGLg8UTfg5U1eym0XkyEq4Tvcee+jvCsjC
	Vj7ZZJfdxR/B/nW3jZXutBVDql8CzVo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-PVr0fDSYP8C4tLVJ3jbkfw-1; Fri, 30 Oct 2026 10:25:36 -0400
X-MC-Unique: PVr0fDSYP8C4tLVJ3jbkfw-1
X-Mimecast-MFC-AGG-ID: PVr0fDSYP8C4tLVJ3jbkfw_1793370335
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a214a5f8a1so7482965e9.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 07:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370335; x=1793975135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLnPtHK687FMiRhGf2fkDTjbZs7yseTcdHjFjaHWPdw=;
        b=SeoBBBW0rRRCe7rCTagivkNaHtql7bSaxcnlI8731nQqx32aRO/VHrZAMZ78VfP9I/
         lnl2kH+wyR//08jh5BVDTmFcQDrHTlnuzt08Q9nLIikL8xPBT7eGzv0yH1rrEgYiLDTw
         t9zsteC3QmSy13Xa3hUFKR7OwIPWgON45xq6pBx+SV3qHMZd6xOUhzpjJ9CY7iajqnjF
         LPwb9KEsnI9ALWnWI3hSLwy8JhpyghZ8hdPuIB4pbe2ey3rs/I8BNmBIokU8qXgwALwQ
         j8xLaET7rUlmBymOGbT2i8QwihXPBu3M1iOz4popJ+eXf3QjBjtwbH9rLrmRTlp/7est
         ZBAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbTkTYOzdxudHiqD91W0z2WuSDSTglPf+hBIPxdmp0GfT3eo2S7/qGpGSzxlDwvZUAu4NUUvFh2oA6GNzT3w==@lists.linux.dev
X-Gm-Message-State: AFq9FYI75GkFET6DurfD2I/BTaAwwnF4eI8dapHbpA9oWlzg6EKRCCvs
	1x91OKbwcYhxlynO8TdyW3GzQ0A+egQPa6t8PlY5//LOBrjHJz2TZnFNYaOQpeWnRRkZRgswTh0
	AObPHEM//7CYeoTcnuE5+2CWWDlLwHn4SJteNeG66T4/NYcthhTlBcLpt2dwI/vieYSzH
X-Gm-Gg: AYBFou15fj1zwqDZ/x1bZTpMdKPxOnse5QSXxv0Wb0P88B2ee6tIn0xz7Qk8biJ2PSu
	mHVOeLseGDVE5nSCb0m5Y+RInRO/EPKgH4ZI1QEkCpzXaxwUi9db4v2j0dhRYDU31dplT8tRBw6
	8Q5+SezJrV7LZqkkdsrtTfdnhg99WDTjwJ9t0tuL8XgeNnshQjXXU0G5JVhS4X5gAxNgVdJrgMm
	E7tNRUOlLwPbSSFGJzpFh5ghbOB6jvr+SekF2zT6idPZ5L5z6qlqM3AHmliKDGCrG5BOFq/Jv9w
	Fq7c7W2BOwPwlXDX0J3Zf9kLz8//qHPkVIHcVaLD2i8GmfSV/I5I4Vtqd7wRFncPLXOebNo7biA
	ihM3eyZEfc375luKSlrQy+6+b5qPvHxz9ht/ITz1RFWeD+tdBHKvuu/VxTcl8M8VUiVQo1fiB1k
	cJAq7K5vAPXGmGDaE=
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4ac17e10ac3mr56533815e9.19.1793370334645;
        Fri, 30 Oct 2026 07:25:34 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:4a3:5a55:f454 with SMTP id 5b1f17b1804b1-4ac17e10ac3mr56533065e9.19.1793370334072;
        Fri, 30 Oct 2026 07:25:34 -0700 (PDT)
Received: from sgarzare-redhat (ip190-139-192-82.pool-bba.aruba.it. [82.192.139.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm67431295e9.6.2026.10.30.07.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:25:32 -0700 (PDT)
Date: Fri, 30 Oct 2026 15:25:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] vsock/bpf: fix zero-length, MSG_OOB and
 MSG_ERRQUEUE reads in recvmsg
Message-ID: <auSngVsWiGI475J4@sgarzare-redhat>
References: <20261028-kbh3-1-022-fix-v2-v3-0-bc0752b2d3db@eldare.de>
 <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261028-kbh3-1-022-fix-v2-v3-2-bc0752b2d3db@eldare.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c6MMWyhSbKQlNRhCIrREcwWoRA2I8tmo5twch43oFFo_1793370335
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 28, 2026 at 06:55:41PM +0100, Jerome Mohm via B4 Relay wrote:
>From: Jerome Mohm <jrmmhm.kernel@eldare.de>
>
>vsock_bpf_recvmsg() sends every read that cannot be served from the
>transport's own queue through sk_msg_recvmsg() and its wait loop. Three
>kinds of read do not fit that path:
>
> - len == 0: with data queued in the psock ingress queue (for example
>   after an SK_PASS verdict), sk_msg_recvmsg() copies nothing and
>   returns 0, and the wait reports data ready at once, so the loop spins
>   with lock_sock() held. The vsock delivery worker then blocks on the
>   same lock and all rx on the transport stops (hung-task).
>   tcp_bpf, udp_bpf and unix_bpf return 0 early, and
>   __vsock_connectible_recvmsg() handles len == 0 too.
>
> - MSG_ERRQUEUE: the read only reaches sock_recv_errqueue() when the
>   native fallback happens to be taken. With empty queues a blocking
>   recvmsg(MSG_ERRQUEUE) waits for stream data instead of returning
>   -EAGAIN for an empty error queue. Route it to the native path first,
>   as tcp_bpf does, so it is also not caught by the len == 0 check.
>
> - MSG_OOB: vsock has no out-of-band data and the native path returns
>   -EOPNOTSUPP, but sk_msg_recvmsg() ignores the flag and consumes
>   ordinary stream bytes; with empty queues the read waits for data.
>   Reject it right after the MSG_ERRQUEUE route and, as
>   unix_bpf_recvmsg() does, before the len == 0 check.
>
>The len == 0 and MSG_OOB cases were reported by the netdev Sashiko AI
>review of earlier, single-patch versions of this fix; the MSG_ERRQUEUE
>case was found with the help of an LLM coding assistant (Anthropic's
>Claude). Each reproducer is a C program run as root in the guest: it
>adds one end of a vsock-loopback stream connection to a BPF sockmap
>(CAP_BPF and CAP_NET_ADMIN), for the queued-byte cases with an SK_PASS
>stream-verdict program, and issues the reads below. No kernel change or
>error injection is needed. The reproducers are available on request.
>
>Testing: on a private VM with a KASAN + lockdep kernel on net, with
>reproducers over vsock-loopback. Before this patch: recv(fd, buf, 0, 0)
>with a byte in the psock ingress queue spins and the delivery worker
>hangs (hung-task); a zero-length recvmsg(MSG_ERRQUEUE) blocks; and
>recv() with MSG_OOB waits for data or returns a queued ordinary byte,
>which a following plain recv() then misses. After: a zero-length recv()
>returns 0 and the next recv() returns the byte; MSG_ERRQUEUE returns
>-EAGAIN from the empty error queue; MSG_OOB returns -EOPNOTSUPP at once
>and consumes nothing. With both patches of this series applied, the
>three single-VM tests of tools/testing/selftests/vsock/vmtest.sh
>(vm_server_host_client, vm_client_host_server, vm_loopback; 44
>vsock_test cases each) pass, as on net; on both kernels the host-side
>runs skip the SO_INQ cases (SO_INQ not supported by the host kernel).
>The ns_* tests of vmtest.sh were not run (they need root on the host).
>The BPF test_progs sockmap_basic, sockmap_listen and sockmap_redir tests
>pass (767 of 767 subtests, among them the three vsock subtests of
>sockmap_basic and the 240 AF_VSOCK cases of sockmap_redir).

Ditto.

>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Cc: stable@vger.kernel.org
>Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
>---
> net/vmw_vsock/vsock_bpf.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
>index 5120911b8143..3edc01268c42 100644
>--- a/net/vmw_vsock/vsock_bpf.c
>+++ b/net/vmw_vsock/vsock_bpf.c
>@@ -111,6 +111,15 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	int copied;
>
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return __vsock_recvmsg(sk, msg, len, flags);

If the psock ingress queue is not empty, wouldn't recvmsg(MSG_ERRQUEUE) 
(e.g. a MSG_ZEROCOPY user reading completions) also consume stream bytes 
through sk_msg_recvmsg(), since it only looks at MSG_PEEK? If so, maybe 
worth mentioning in the commit message.

>+
>+	if (flags & MSG_OOB)
>+		return -EOPNOTSUPP;
>+
>+	if (!len)
>+		return 0;
>+

Is the order of the checks important? We should mention it in the commit 
description (if it's important or not and why).

Thanks,
Stefano

> 	psock = sk_psock_get(sk);
> 	if (unlikely(!psock))
> 		return __vsock_recvmsg(sk, msg, len, flags);
>
>-- 
>2.56.0
>
>

