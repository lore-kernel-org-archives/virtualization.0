Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8574076
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 18:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722192789; cv=none; b=E9wg3OxV7tyGcJlX2y1BEN5pgXTBaL1RvtXYrIZNAHQtJd/SQ4w41MlB+E8ZPWiqLVMp0n0yaorcKsAxxqplcPyx2EKjzhHiXkNEspHlD97o962+MP60LhQe707fnRLaCSTDifDichgXQXgddbfN+MBLCNDIZglxRzgpk/K8vro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722192789; c=relaxed/simple;
	bh=PPREMhC5736ADe8UjUj7yOVHwR1uO6w7vYqpo8l6SzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+yJaZhi3KYGtUsFOvNDmjdBretYOtujBjct/Wyx0lT/LIMcm/P8n4MIfXcwdcArWyjWnHA1fl6EJdNyCF4H02N/N6m+YFGtJiUhgSOL/NSnuDrcLMabW+DrJr8AosBFsVsZPdQgT01wmfO1nHew9LRxfFX7u2wFWSJ9FoicPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmsa0w1H; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmsa0w1H"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E534740357
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 18:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7yXnT7e60HJz for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jul 2024 18:53:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2b; helo=mail-yb1-xb2b.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CC24740352
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC24740352
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fmsa0w1H
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CC24740352
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 18:53:06 +0000 (UTC)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-e0857a11862so1407173276.1
        for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 11:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722192785; x=1722797585; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WaFwUhUy7huwacOsYHZwdSyihUsKnDhkCHGxr+gg2M=;
        b=Fmsa0w1HBjcUOb0H/0o9O4x9cgbmPFuZ44UJywMBuReSVJsXSCGUfp31+KM1qlETQk
         vRX4HJsWyz0sF9tHdzkwF375EdmdbkZScJtB/BRVJ4cbjWWq4Bsx33RMAO0kyxxxH6dh
         dgj9dXNai2GdJfG3sG3164heCmcOtogczSzJkwpJ5YgxD+wQpefNZEOZULSUDBH7ZucB
         m3UEG4Ai8DO1C4lUQxQAQryRcMYyeeVClW291/6RiqjqIq8vKlApOwGXUP+r4iJk2Mn8
         Rhr20O0QI2zpskFjnKMc0gBwplL6D/xcIKbzU8zt224mTknEgsgQ6HvLY0TXn7xB8647
         zqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722192785; x=1722797585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WaFwUhUy7huwacOsYHZwdSyihUsKnDhkCHGxr+gg2M=;
        b=gcqCp+i3nOlH+6866qu9j4anW2bY3DDW3kHbKt4zcrDauwySrkX5dtc6RfJQ/me2Hx
         nc2xOT2VLXoz0k4/FQiORGwZrdmHbAhZH+0UDWQ6LcGBJnNermMNM4FBVK9ScFfTuUsx
         Ax7ptSBstKdpXNxEiDePKQLwnJ+Kq0zGzXnpBUi7gjY5EEmr8prLC7RJxyjmXRFoF8xT
         yjmEPGbh+S/vwBEOxUdTCkuwqdRe9Jae56LUrGdSs8e0eb9WgEcuuL9l9hLfDG90KHn+
         vZPj9TIa+wYEo1t5bfGpy5Pk0kP9CcPZ/kWeQSxrFLOMxll5Oq3JuPgwp047rwc+sbgW
         yaow==
X-Forwarded-Encrypted: i=1; AJvYcCWEh3RFrsb7ETg5/+MquV01MxjweCx1dhQ3KpdZJIpZDwatNAZvev87tC+xoVThdpXEzoUgw5v9SnsX+qFTDFEBjc9keOysAAXszikkU6uBNd4+Hw7+T3UgFg==
X-Gm-Message-State: AOJu0YwkBWcAiK9JUXkKsGm35PRUHJdO29OtqGZxMXbT0hHUMCt4gybx
	DeFy3tc/cyCu+iBNrY2jBpLRjBDkTUpIsYa9P2S0ms4Ygu3a03RQKyvoIIkAp9NLwYC2zimlf/R
	S7FK8wrqDm6/P8bgSTqAu68Y96lk=
X-Google-Smtp-Source: AGHT+IFTRoCPd34HHWfTgIQNU+sTEkr3o4CgrkzGKLra2JgW08IJHV2eZgSUAorTK4dr8M4YsaVo8uy6TqxmtUJfv/0=
X-Received: by 2002:a25:854f:0:b0:e08:70e7:91d3 with SMTP id
 3f1490d57ef6-e0b546070aamr5384474276.56.1722192784965; Sun, 28 Jul 2024
 11:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-5-amery.hung@bytedance.com> <CAGxU2F7wCUR-KhDRBopK+0gv=bM0PCKeWM87j1vEYmbvhO8WHQ@mail.gmail.com>
In-Reply-To: <CAGxU2F7wCUR-KhDRBopK+0gv=bM0PCKeWM87j1vEYmbvhO8WHQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 28 Jul 2024 11:52:54 -0700
Message-ID: <CAMB2axNUZa221WKTjLt0G5KNdtkAbm20ViDZRGBh6pL9y3wosg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 04/14] af_vsock: generalize bind table functions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, bryantan@vmware.com, 
	vdasa@vmware.com, pv-drivers@vmware.com, dan.carpenter@linaro.org, 
	simon.horman@corigine.com, oxffffaa@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	bpf@vger.kernel.org, bobby.eshleman@bytedance.com, jiang.wang@bytedance.com, 
	amery.hung@bytedance.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:40=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Jul 10, 2024 at 09:25:45PM GMT, Amery Hung wrote:
> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >
> >This commit makes the bind table management functions in vsock usable
> >for different bind tables. Future work will introduce a new table for
> >datagrams to avoid address collisions, and these functions will be used
> >there.
> >
> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >---
> > net/vmw_vsock/af_vsock.c | 34 +++++++++++++++++++++++++++-------
> > 1 file changed, 27 insertions(+), 7 deletions(-)
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index acc15e11700c..d571be9cdbf0 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -232,11 +232,12 @@ static void __vsock_remove_connected(struct vsock_=
sock *vsk)
> >       sock_put(&vsk->sk);
> > }
> >
> >-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
> >+static struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *=
addr,
> >+                                                 struct list_head *bind=
_table)
> > {
> >       struct vsock_sock *vsk;
> >
> >-      list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) =
{
> >+      list_for_each_entry(vsk, bind_table, bound_table) {
> >               if (vsock_addr_equals_addr(addr, &vsk->local_addr))
> >                       return sk_vsock(vsk);
> >
> >@@ -249,6 +250,11 @@ static struct sock *__vsock_find_bound_socket(struc=
t sockaddr_vm *addr)
> >       return NULL;
> > }
> >
> >+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
> >+{
> >+      return vsock_find_bound_socket_common(addr, vsock_bound_sockets(a=
ddr));
> >+}
> >+
> > static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *s=
rc,
> >                                                 struct sockaddr_vm *dst=
)
> > {
> >@@ -671,12 +677,18 @@ static void vsock_pending_work(struct work_struct =
*work)
> >
> > /**** SOCKET OPERATIONS ****/
> >
> >-static int __vsock_bind_connectible(struct vsock_sock *vsk,
> >-                                  struct sockaddr_vm *addr)
> >+static int vsock_bind_common(struct vsock_sock *vsk,
> >+                           struct sockaddr_vm *addr,
> >+                           struct list_head *bind_table,
> >+                           size_t table_size)
> > {
> >       static u32 port;
> >       struct sockaddr_vm new_addr;
> >
> >+      if (WARN_ONCE(table_size < VSOCK_HASH_SIZE,
> >+                    "table size too small, may cause overflow"))
> >+              return -EINVAL;
> >+
>
> I'd add this in another commit.
>
> >       if (!port)
> >               port =3D get_random_u32_above(LAST_RESERVED_PORT);
> >
> >@@ -692,7 +704,8 @@ static int __vsock_bind_connectible(struct
> >vsock_sock *vsk,
> >
> >                       new_addr.svm_port =3D port++;
> >
> >-                      if (!__vsock_find_bound_socket(&new_addr)) {
> >+                      if (!vsock_find_bound_socket_common(&new_addr,
> >+                                                          &bind_table[V=
SOCK_HASH(addr)])) {
>
> Can we add a macro for `&bind_table[VSOCK_HASH(addr)])` ?
>

Definitely. I will add the following macro:

#define vsock_bound_sockets_in_table(bind_table, addr) \
        (&bind_table[VSOCK_HASH(addr)])

> >                               found =3D true;
> >                               break;
> >                       }
> >@@ -709,7 +722,8 @@ static int __vsock_bind_connectible(struct vsock_soc=
k *vsk,
> >                       return -EACCES;
> >               }
> >
> >-              if (__vsock_find_bound_socket(&new_addr))
> >+              if (vsock_find_bound_socket_common(&new_addr,
> >+                                                 &bind_table[VSOCK_HASH=
(addr)]))
> >                       return -EADDRINUSE;
> >       }
> >
> >@@ -721,11 +735,17 @@ static int __vsock_bind_connectible(struct vsock_s=
ock *vsk,
> >        * by AF_UNIX.
> >        */
> >       __vsock_remove_bound(vsk);
> >-      __vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
> >+      __vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], v=
sk);
> >
> >       return 0;
> > }
> >
> >+static int __vsock_bind_connectible(struct vsock_sock *vsk,
> >+                                  struct sockaddr_vm *addr)
> >+{
> >+      return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_=
SIZE + 1);
>
> What about using ARRAY_SIZE(x) ?
>
> BTW we are using that size just to check it, but all the arrays we use
> are statically allocated, so what about a compile time check like
> BUILD_BUG_ON()?
>

I will remove the table_size check you mentioned earlier and the
argument here as the arrays are allocated statically like you
mentioned.

If you think this check may be a good addition, I can add a
BUILD_BUG_ON() in the new vsock_bound_sockets_in_table() macro.

Thanks,
Amery

> Thanks,
> Stefano
>
>
> >+}
> >+
> > static int __vsock_bind_dgram(struct vsock_sock *vsk,
> >                             struct sockaddr_vm *addr)
> > {
> >--
> >2.20.1
> >
>
