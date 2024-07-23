Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFAE155739
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745608; cv=none; b=udAUAjhIcV74haGZjTIcFhUZJuz2nx2rwQih4FuSc1Z8gCKH6VBz9YJ1B8GB4DYxoF1r2ghI7Kdp0d5e2RflvNOJkFVKL33HwIZJ/+OAMqfGhCrCYhtb/8FeUFHBaZjZl09T5T71J16AYrSh4RfiiSRLxO87wKbcjAKQ6VNUvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745608; c=relaxed/simple;
	bh=Vx994ZBr7B2D6O1BQBny1VeJblQKimuyws1bzs1/KJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VJ2lHqcBD7XxSFaoiF146wK82VWeAiqEqN3fG4hWqeGrCNG9sJuEr4iAA7nHCFfaWeU0L5HJSRTfCOvbvL8VoJGAMK0ocwYdh2U/VlvhObpM0gNeJgG46emP9Vb4ZR5oJoHhCdF5q/KwermVKMxqEpDlMI92UcvQtjZzV4GmWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyPaJmWu; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyPaJmWu"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE12C40304
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 14:40:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umZ-aaHHPA50 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 14:40:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9CFC240491
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9CFC240491
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VyPaJmWu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9CFC240491
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721745604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uNxU/3bNa0j4H+fhGmWX47X5Nrds4z8nYGKNg8PjixM=;
	b=VyPaJmWu3Db99Plh4iEauR9ikiIvIicNhKysRL9buKBPA8ZN0F2OoJjXXDXYVL5+n8QRj2
	uzlQDZrcNPcNcEEOT++w6a/w0lU4PH2IcjQa3DQY5c36fLS9T5kGU4/2dZSK9ITCMCQHmI
	Xi7VySu3s4HOETnF/Ahb4PTm00VuvYY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-jm0pLutQPo2-2vv6AHxX3g-1; Tue, 23 Jul 2024 10:40:00 -0400
X-MC-Unique: jm0pLutQPo2-2vv6AHxX3g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44f76198e97so95035571cf.0
        for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 07:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745600; x=1722350400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNxU/3bNa0j4H+fhGmWX47X5Nrds4z8nYGKNg8PjixM=;
        b=LUgNV1j0MXTThccZcp8ZVaEr3Zl6ktCtKPaSmL5ugrkszqwhS7HJe9gIO+4sfU0G+8
         plGmKMfolSCBE8iV1xQWIqLkoZy2464S1zskyg+OJIGTgKGcQtd7ODpmzV1BlpZCu38B
         HJwI/OWx3Uc9h50L6Zc7RvOx9uYoeFa29M4ZcXwRpchpDbic+f2bAJZ1J0BUdiolCHon
         UPXjOtQYkngTyEmj13lwqzl7aasqBZWeGMxFGKuATeaPkNLBlqVm3UvvA8LfYe4cB29a
         3w40b+9oe1JI6wk0joO8l1zYeQDcHBcj/acDnc8Kqa8bzr72ey+ahp3rr1B2qWAF4Czk
         RIDg==
X-Forwarded-Encrypted: i=1; AJvYcCWmzKt3fj5Il0W2S3hKzEDEVBfTm5M/0D3HTgI07qxRFZLM2ysSfhpNVwy3JUbYVoulRCONIXiDA04vQh0OZ3FPiEQgSzW7OKphS+AYTZumrfvzHDSiszOqyw==
X-Gm-Message-State: AOJu0YzWclMjkP9LGX77CSkAKWlf8Ay63OOKHMGZqgksASDHjpu2JS8S
	YXjjE5BDjViUI0i08esMrll7fxAnqlPrXIoieUHghThGIUMhE5gf7wEPFQPlGUwJ0RByRw1A471
	RwAVQyQEJFY/NhWnUkIDS85YnIDQOO8NgZVZHupLBy4HGtS2Gf3TSH7oaAvAnpGCDTk6dfcrUGK
	Ht6NY=
X-Received: by 2002:ac8:5907:0:b0:447:e1ea:ef7 with SMTP id d75a77b69052e-44fc7f5fdd3mr32125451cf.9.1721745600392;
        Tue, 23 Jul 2024 07:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiMZj0dsaL52oy96COzOxwC33HyqPV0AzPadJvk/DwDmZBHiZG8Nq4+kUIoA7ql1zFm7LEkw==
X-Received: by 2002:ac8:5907:0:b0:447:e1ea:ef7 with SMTP id d75a77b69052e-44fc7f5fdd3mr32125021cf.9.1721745599845;
        Tue, 23 Jul 2024 07:39:59 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd04062sm45383271cf.40.2024.07.23.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:39:59 -0700 (PDT)
Date: Tue, 23 Jul 2024 16:39:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com, 
	dan.carpenter@linaro.org, simon.horman@corigine.com, oxffffaa@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH net-next v6 04/14] af_vsock: generalize bind table
 functions
Message-ID: <CAGxU2F7wCUR-KhDRBopK+0gv=bM0PCKeWM87j1vEYmbvhO8WHQ@mail.gmail.com>
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-5-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240710212555.1617795-5-amery.hung@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 09:25:45PM GMT, Amery Hung wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This commit makes the bind table management functions in vsock usable
>for different bind tables. Future work will introduce a new table for
>datagrams to avoid address collisions, and these functions will be used
>there.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/af_vsock.c | 34 +++++++++++++++++++++++++++-------
> 1 file changed, 27 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index acc15e11700c..d571be9cdbf0 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -232,11 +232,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
>       sock_put(&vsk->sk);
> }
>
>-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
>+                                                 struct list_head *bind_table)
> {
>       struct vsock_sock *vsk;
>
>-      list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>+      list_for_each_entry(vsk, bind_table, bound_table) {
>               if (vsock_addr_equals_addr(addr, &vsk->local_addr))
>                       return sk_vsock(vsk);
>
>@@ -249,6 +250,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>       return NULL;
> }
>
>+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+{
>+      return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
>+}
>+
> static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
>                                                 struct sockaddr_vm *dst)
> {
>@@ -671,12 +677,18 @@ static void vsock_pending_work(struct work_struct *work)
>
> /**** SOCKET OPERATIONS ****/
>
>-static int __vsock_bind_connectible(struct vsock_sock *vsk,
>-                                  struct sockaddr_vm *addr)
>+static int vsock_bind_common(struct vsock_sock *vsk,
>+                           struct sockaddr_vm *addr,
>+                           struct list_head *bind_table,
>+                           size_t table_size)
> {
>       static u32 port;
>       struct sockaddr_vm new_addr;
>
>+      if (WARN_ONCE(table_size < VSOCK_HASH_SIZE,
>+                    "table size too small, may cause overflow"))
>+              return -EINVAL;
>+

I'd add this in another commit.

>       if (!port)
>               port = get_random_u32_above(LAST_RESERVED_PORT);
>
>@@ -692,7 +704,8 @@ static int __vsock_bind_connectible(struct
>vsock_sock *vsk,
>
>                       new_addr.svm_port = port++;
>
>-                      if (!__vsock_find_bound_socket(&new_addr)) {
>+                      if (!vsock_find_bound_socket_common(&new_addr,
>+                                                          &bind_table[VSOCK_HASH(addr)])) {

Can we add a macro for `&bind_table[VSOCK_HASH(addr)])` ?

>                               found = true;
>                               break;
>                       }
>@@ -709,7 +722,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>                       return -EACCES;
>               }
>
>-              if (__vsock_find_bound_socket(&new_addr))
>+              if (vsock_find_bound_socket_common(&new_addr,
>+                                                 &bind_table[VSOCK_HASH(addr)]))
>                       return -EADDRINUSE;
>       }
>
>@@ -721,11 +735,17 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>        * by AF_UNIX.
>        */
>       __vsock_remove_bound(vsk);
>-      __vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
>+      __vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
>
>       return 0;
> }
>
>+static int __vsock_bind_connectible(struct vsock_sock *vsk,
>+                                  struct sockaddr_vm *addr)
>+{
>+      return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);

What about using ARRAY_SIZE(x) ?

BTW we are using that size just to check it, but all the arrays we use
are statically allocated, so what about a compile time check like
BUILD_BUG_ON()?

Thanks,
Stefano


>+}
>+
> static int __vsock_bind_dgram(struct vsock_sock *vsk,
>                             struct sockaddr_vm *addr)
> {
>--
>2.20.1
>

