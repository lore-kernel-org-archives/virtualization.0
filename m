Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AD330315
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366685; cv=none; b=ZXCk3YuGNVUuGCifggOzgfHsjhLE9DyQmqr9Dg87tGasy8ZTrbArzOao4jMmYhnj0pso1esESQm305Z2b1u5B8em6Bo8u0On+J92/4hXpIYOuiyp5+pbeuJ288SRYtQyTdoqeOCtJSp7Nm/uYgUQ7u7DQVnWzf4wKVwFPD8KY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366685; c=relaxed/simple;
	bh=uRW8e72Rqzipki+9LHRLNLqQmu5KdCJEOG4HG3wjS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WsT9SV1xFrHjkhKPqZbznGoHvABWN5gDtf8QaE8WP/Yx4VR7NE6choSb2eLtL03dYT4F4TuHMRY+K2G9ydsKTHelB3kRU2Kg07tKVW6Ou0F4HJLIpxuFjMrAqIbXe40sio/zd5V//2DN8UVAlFADJsrbXUYSOF0fcz3ckukv/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3wtYt3e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3wtYt3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777366682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
	b=E3wtYt3eUxBGj12tW/gIcz50/XmiZPJMM0HzbpTs3U7o5qgwidg+7DAfBSV6siDD0Fi8Gc
	FnflyB0U9xEIiTOQof7fTtKlG09VTJytbYGkZHT0xcumbzFFCR41j4w/vxWJxp7rckVqsB
	/OWxwKlpx1xmzcNHjGCmdSCT996c5+M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-TCKZxdFXMX6ZF-oUtBV8pw-1; Tue, 28 Apr 2026 04:58:01 -0400
X-MC-Unique: TCKZxdFXMX6ZF-oUtBV8pw-1
X-Mimecast-MFC-AGG-ID: TCKZxdFXMX6ZF-oUtBV8pw_1777366680
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43efc93e4f6so9028893f8f.3
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 01:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366674; x=1777971474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq86QjeYlD20o4XVhJa8zSjeSJAedvnhgfqIHlBbJ8s=;
        b=q1TTSpBz0qEaOFQ+UwX9y6Az0wTjVV883ObntuXfHKXBVw+0KNWVDJcGAw2T8OBgm1
         4Hc6ItJ050GZWpLUJyjGa07OI/IK0uoE0gNZ7zFEo/g8B2f8vI98DTK5mPFTY1+KERUI
         XCW7HDoAYzT3oyO5ei0Gzt7KgU+foglwzUnA+S418ubcYD0H0RgsjVUqxwYtV8I1uTWv
         b6LrSWRmG+lONqfQnqTp1W6InoBBxv8NWU5nUUiAoP0hT5vTUa+BM7gX9Oi8cwvzKKnW
         iYYuPZG4VfWy7i+Z+tOv9loTLg1aFd6VM/hrFkQXRwfMYfSW5OzP/B6QodCxrY2kfilg
         S12Q==
X-Forwarded-Encrypted: i=1; AFNElJ9I1OxACPN9sYeAbvnCmjZ6dGrQw2UFFjst/hZrK7XEJt7PI9HKcx+nmJ1urXI6uI8UTW48LUuA2Lb8qT3zPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaiewKjjfX0wGOVbX+URiKUDd3F03KZ4RWr4c5ABNXdFDHICzu
	KGo7qPF/593G5UOkE41UQgLKLzkeKaDaTXMujAvXU9rbJ5Yc2S5PfRu8KVH/gjHLBEQ9Hr1iAR9
	Y4oeHByPvmx4OXMOBg8NmKOXDlkG3ZRKQLtoOFXaJOuRzOlv69JZeAZh+uh+2dZGY5BUv
X-Gm-Gg: AeBDieueknsvpP1OGj0MhpU9UM+FfBbdMQuzAWmsyUa0uehFzEgFbt6q8kRd8283hiM
	+KHOr0kQltHjqThYsvRP8qDTpXQ1vmF7O4YqbAZcc1aj+zjvVR2oqUufyjX6T/Jso8yQC+afRjx
	t/T2QQ5qYE/i1dExU9ZaCxyJ4+Ml8up7ERR0liKnBPeWC+a1Oln5fQpfOOrmmEbKz6t1mjRYY0n
	+nRoOhIKOmBPq443xUa4MfPyWm4x1T8o+68g+QKQCV1odF7A1AT8o9a/vm7D2oDg3ers1pZr2Fq
	7gpxEoFniiJlOLWyDPcNvmg7XfzTEiqJ/j1kCk1KDt+0PielEW3/Tt81m1bMrK0r76s5SCn+VoY
	BgrsiNhxpyrm7/zSN4PzqACOb2ioGykRlxf95yzY3Pt+BcjZyFFLx26b2BEcpxdPAAkxfrC0jbm
	GCYRe0TA==
X-Received: by 2002:a05:6000:2481:b0:441:362c:39c1 with SMTP id ffacd0b85a97d-4464a913403mr3894578f8f.33.1777366674230;
        Tue, 28 Apr 2026 01:57:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:441:362c:39c1 with SMTP id ffacd0b85a97d-4464a913403mr3894514f8f.33.1777366673658;
        Tue, 28 Apr 2026 01:57:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-83.retail.telecomitalia.it. [87.16.204.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463fb7e2afsm4634086f8f.28.2026.04.28.01.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:57:53 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:57:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, stefanha@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: Re: [PATCH] vsock/virtio: fix memory leak in
 virtio_transport_recv_listen()
Message-ID: <afB2QCHtoREOV6ml@sgarzare-redhat>
References: <20260424150310.57228-1-kartikey406@gmail.com>
 <ae9ilWoZI_-EMdWQ@sgarzare-redhat>
 <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CADhLXY6APdmMQLSxN9b66pV5mp5sDwJRR7_BJAh13BaK-qoa=w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lc8nZnvEommIf7RiUFVCv7KvqiYjZZSlyAbVMUgug7s_1777366680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 28, 2026 at 01:54:36PM +0530, Deepanshu Kartikey wrote:
>On Mon, Apr 27, 2026 at 7:15 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Apr 24, 2026 at 08:33:10PM +0530, Deepanshu Kartikey wrote:
>> >Two bugs exist in virtio_transport_recv_listen():
>>
>> Two bugs, two fixes, two patches usually.
>>
>> >
>> >1. On the transport assignment error path, sk_acceptq_added() is called
>> >   but sk_acceptq_removed() is never called when vsock_assign_transport()
>> >   fails or assigns a different transport than expected. This causes the
>> >   parent listener's accept backlog counter to be permanently inflated,
>> >   eventually causing sk_acceptq_is_full() to reject legitimate incoming
>> >   connections.
>>
>> Wait, I can't see this issue. sk_acceptq_added() is called after the
>> vsock_assign_transport(), so why we should call sk_acceptq_removed()
>> in the error path of vsock_assign_transport()?
>>
>> Maybe I'm missing something.
>>
>> >
>> >2. There is a race between __vsock_release() and vsock_enqueue_accept().
>> >   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
>> >   the accept queue under the parent socket lock. However,
>> >   virtio_transport_recv_listen() checks sk_shutdown and subsequently
>> >   calls vsock_enqueue_accept() without holding the parent socket lock.
>>
>> Are you sure about this?
>>
>> virtio_transport_recv_listen() is called only by
>> virtio_transport_recv_pkt() after calling lock_sock(sk), so I'm really
>> confused.
>>
>> >   This means a child socket can be enqueued after __vsock_release() has
>> >   already flushed the queue, causing the child socket and its associated
>> >   resources to leak
>> >   permanently. The existing comment in the code hints at this race but
>> >   the fix was never implemented.
>>
>> Are you referring to:
>>         /* __vsock_release() might have already flushed accept_queue.
>>          * Subsequent enqueues would lead to a memory leak.
>>          */
>>         if (sk->sk_shutdown == SHUTDOWN_MASK) {
>>                 virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>>                 return -ESHUTDOWN;
>>         }
>>
>> In this case I think we are saying that we are doing this check exactly
>> to avoid that issue.
>>
>> >
>> >Fix both issues: add sk_acceptq_removed() on the transport error path,
>>
>> Again, better to fix the 2 issues with 2 patches (same series is fine).
>>
>> >and re-check sk->sk_shutdown under the parent socket lock before calling
>> >vsock_enqueue_accept() to close the race window. The child socket lock
>> >is released before acquiring the parent socket lock to maintain correct
>> >lock ordering (parent before child).
>> >
>>
>> We are missing the Fixes tag, and I think we can target the `net` tree
>> with this patch (i.e. [PATCH net]), see:
>> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>>
>> >Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> >Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
>> >Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
>> >Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
>> >---
>> > net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
>> > 1 file changed, 11 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> >index 416d533f493d..fad5fa4a4296 100644
>> >--- a/net/vmw_vsock/virtio_transport_common.c
>> >+++ b/net/vmw_vsock/virtio_transport_common.c
>> >@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> >        */
>> >       if (ret || vchild->transport != &t->transport) {
>> >               release_sock(child);
>> >+              sk_acceptq_removed(sk);
>>
>> Ditto, are we sure about this?
>>
>> >               virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>> >               sock_put(child);
>> >               return ret;
>> >@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
>> >               child->sk_write_space(child);
>> >
>> >       vsock_insert_connected(vchild);
>> >+      release_sock(child);
>> >+      lock_sock(sk);
>>
>> IMO this is a deadlock with the lock_sock(sk) called by the caller.
>>
>> Also a comment would be helpful here to explain why we're doing this.
>>
>> >+      if (sk->sk_shutdown == SHUTDOWN_MASK) {
>> >+              release_sock(sk);
>> >+              sk_acceptq_removed(sk);
>> >+              virtio_transport_reset_no_sock(t, skb, sock_net(sk));
>> >+              sock_put(child);
>> >+              return -ESHUTDOWN;
>>
>> Since this is very similar to the error path of
>> vsock_assign_transport(), I think it would be better to start by
>> defining a common error path for the function and use labels to exit, so
>> we can avoid duplicating the code multiple times.
>>
>> >+      }
>> >       vsock_enqueue_accept(sk, child);
>> >+      release_sock(sk);
>> >       virtio_transport_send_response(vchild, skb);
>> >
>> >-      release_sock(child);
>> >-
>>
>> TBH I'm really worried about this patch since both fixes are completely
>> wrong IMO.
>>
>> Thanks,
>> Stefano
>>
>> >       sk->sk_data_ready(sk);
>> >       return 0;
>> > }
>> >--
>> >2.43.0
>> >
>>
>
>
>Hi Stefano,
>
>Thank you for the detailed review!
>
>You are correct on both points. I apologize for the confusion — I was
>looking at an older version of the code where sk_acceptq_added() was
>called BEFORE vsock_assign_transport(), which made the
>sk_acceptq_removed() fix appear necessary. In the current kernel,
>sk_acceptq_added() is already moved to after vsock_assign_transport(),
>so that issue no longer exists.
>
>Regarding the lock_sock(sk) fix — you are also correct that
>virtio_transport_recv_pkt() already holds lock_sock(sk) before calling
>virtio_transport_recv_listen(), so our second fix would indeed cause a
>deadlock. I missed that completely.
>
>I am still investigating the root cause of the memory leak reported by
>syzbot. The backtrace points to the vsock loopback path
>(vsock_loopback_work), so I am looking there next. I will send a v2
>once I have a correct analysis and fix.

Okay, thanks for looking into that issue, feel free to chat here, or in 
reply to the syzbot report if you have some new findings.

Thanks,
Stefano

