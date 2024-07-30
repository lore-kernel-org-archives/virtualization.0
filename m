Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A4189B86
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362222; cv=none; b=VdFv//mb+SvuuR1FrLK9KJ0YWXL2XehKwC2ZsZ5+6cKH11ll2/xS64Em3gE2AQqtWB+LmhpvohqVvYitFRU57gqXjuvN35cAk/cMtK6LSSR/A1pJcNzc4AtcqlCwV4KZZO3EWKi3JawUDSdbhIBf8xjvbexuGuXVDBfrMmbtMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362222; c=relaxed/simple;
	bh=Yq/ggOUNW+hktq+nK4p6E6tkRE5rk8sFRRmqvpaJpcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7J5Oc068mctlhKCENiatp2YF4h/a+ii5DgNDqK6bLSLdQ53ZbE/iQ1BDkJKWm6M+PFbWtvmCg6bMyogQngb2wLkTUuRJg4Xinf3NEj2Zw93qmQg2BcWEsZDThYFrdA0s+9zDwV8AljM8FxxMSYkyZx3zoiMgMW2OP8osMaVl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPnrM3H5; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPnrM3H5"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F2DD812CB
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 17:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpWz8ZFDMSz3 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jul 2024 17:56:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2d; helo=mail-yb1-xb2d.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 68F62812C8
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68F62812C8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kPnrM3H5
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 68F62812C8
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 17:56:59 +0000 (UTC)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-e05ef3aefcfso3571755276.2
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jul 2024 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722362218; x=1722967018; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tJ9LmFr+EeYpInIUds90yt7v1m8/2stEKp9e7T6m1w=;
        b=kPnrM3H5WG+Tz8nnwvE0PugrQLosImrz/W91XkaCFafJb10PYv0DfjJaZb8g14owhY
         aaJX60Fy9u+PYcUY09Qs4dAAMOOEJTALzRw8k9yCiusYO8xvPJlf4qIRqKokz60rmEmx
         wodNXZ2xDZtaHRh3KxBMQEVVSlmXR6ubbA3Q9VobJ9JwAK2dKMMymWkm/MW/mmzV9EdT
         vRvsQ9gMEtuetpdS3XDvRRTFHlF7w2IoYAfq4cWpWIN3EyxBQC5JOVWi08ldDP5wgQaZ
         sSTIlMKnbS6+9kcPWPoHySgPUr/N/8Zc4l+gFpAGWQIU9AvcstN0/JMugam++2uzI1d/
         Ya7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362218; x=1722967018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tJ9LmFr+EeYpInIUds90yt7v1m8/2stEKp9e7T6m1w=;
        b=HcgdI3zxOg2sgAx1bqX6Y8CBhPaFnabZtoqW7UG5qLc5tpH5VKyoSZ194ujxyeOmdO
         O/qcvxcLc88tjZ2Z8VtYHK9bmukk5enU1UxpCBX3CUA1Ayi/XTqud8A6Ig4o15kHe8Bp
         C7DeajyMf8xanmxHIl1la4FpABZfPGNlCCcrnNLusfFyZG+pzCeTCDpAvomacLydPGOJ
         b/lb7bEklRyn9vWYkKqIBcC3YbgV8VT/wfGZR0t3wjrs38buq+jCPXLm1EJJERycLhsv
         SY4JehFhAxTtGLQGgAeefhE8lO7qvCupqYncg0mR4yL7VrLXaUqnXQpm0+Bc6SMivoFE
         1OCg==
X-Forwarded-Encrypted: i=1; AJvYcCX/C+rb6H555diJ76ktBTyUjYXnclMvXZV1f5JoQIZHo71ew/dPYT1zEiFtSWtJuM5N2N+bSDrMkGTxcVw1bUyZa2l4/42hE79bJbztJvOibwb0fa1EbrJTDw==
X-Gm-Message-State: AOJu0Yw85rMQcEVq3h3LzfDcUpKdEaPSFLEApenlcJonmy8957rd4MFU
	sdtOYBhERqSFxInthUkbgeUeeYnXVBGuy7CVcL563gqWIjkSzRiwZXIXK6zhYY11Tk13stkZJB7
	m2O2obdz+ek9EN7IDuFaxK/NrSUE=
X-Google-Smtp-Source: AGHT+IEeFCqCt/8oTNqAY4RtLq00QVkD5Ag05gXDYxk2tQVY/F4tyERpQH8H3d42Bd+DygSbMlFnsnAzg7VIuPpEhJA=
X-Received: by 2002:a05:6902:2742:b0:e0b:b2d6:f528 with SMTP id
 3f1490d57ef6-e0bb2d701c8mr529006276.38.1722362218035; Tue, 30 Jul 2024
 10:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-5-amery.hung@bytedance.com> <CAGxU2F7wCUR-KhDRBopK+0gv=bM0PCKeWM87j1vEYmbvhO8WHQ@mail.gmail.com>
 <CAMB2axNUZa221WKTjLt0G5KNdtkAbm20ViDZRGBh6pL9y3wosg@mail.gmail.com> <ba2hivznnjcyeftr7ch7gvrwjvkimx5u2t2anv7wv7n7yb3j36@dbagnaylvu6o>
In-Reply-To: <ba2hivznnjcyeftr7ch7gvrwjvkimx5u2t2anv7wv7n7yb3j36@dbagnaylvu6o>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 30 Jul 2024 10:56:46 -0700
Message-ID: <CAMB2axPfz0kOFau0tX2=87e=2EPSLxX1AXHPpsv3QyaLYaBvoA@mail.gmail.com>
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

On Tue, Jul 30, 2024 at 1:00=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Sun, Jul 28, 2024 at 11:52:54AM GMT, Amery Hung wrote:
> >On Tue, Jul 23, 2024 at 7:40=E2=80=AFAM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> >>
> >> On Wed, Jul 10, 2024 at 09:25:45PM GMT, Amery Hung wrote:
> >> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >> >
> >> >This commit makes the bind table management functions in vsock usable
> >> >for different bind tables. Future work will introduce a new table for
> >> >datagrams to avoid address collisions, and these functions will be us=
ed
> >> >there.
> >> >
> >> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >> >---
> >> > net/vmw_vsock/af_vsock.c | 34 +++++++++++++++++++++++++++-------
> >> > 1 file changed, 27 insertions(+), 7 deletions(-)
> >> >
> >> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> >index acc15e11700c..d571be9cdbf0 100644
> >> >--- a/net/vmw_vsock/af_vsock.c
> >> >+++ b/net/vmw_vsock/af_vsock.c
> >> >@@ -232,11 +232,12 @@ static void __vsock_remove_connected(struct vso=
ck_sock *vsk)
> >> >       sock_put(&vsk->sk);
> >> > }
> >> >
> >> >-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *ad=
dr)
> >> >+static struct sock *vsock_find_bound_socket_common(struct sockaddr_v=
m *addr,
> >> >+                                                 struct list_head *b=
ind_table)
> >> > {
> >> >       struct vsock_sock *vsk;
> >> >
> >> >-      list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_tabl=
e) {
> >> >+      list_for_each_entry(vsk, bind_table, bound_table) {
> >> >               if (vsock_addr_equals_addr(addr, &vsk->local_addr))
> >> >                       return sk_vsock(vsk);
> >> >
> >> >@@ -249,6 +250,11 @@ static struct sock *__vsock_find_bound_socket(st=
ruct sockaddr_vm *addr)
> >> >       return NULL;
> >> > }
> >> >
> >> >+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *ad=
dr)
> >> >+{
> >> >+      return vsock_find_bound_socket_common(addr, vsock_bound_socket=
s(addr));
> >> >+}
> >> >+
> >> > static struct sock *__vsock_find_connected_socket(struct sockaddr_vm=
 *src,
> >> >                                                 struct sockaddr_vm *=
dst)
> >> > {
> >> >@@ -671,12 +677,18 @@ static void vsock_pending_work(struct work_stru=
ct *work)
> >> >
> >> > /**** SOCKET OPERATIONS ****/
> >> >
> >> >-static int __vsock_bind_connectible(struct vsock_sock *vsk,
> >> >-                                  struct sockaddr_vm *addr)
> >> >+static int vsock_bind_common(struct vsock_sock *vsk,
> >> >+                           struct sockaddr_vm *addr,
> >> >+                           struct list_head *bind_table,
> >> >+                           size_t table_size)
> >> > {
> >> >       static u32 port;
> >> >       struct sockaddr_vm new_addr;
> >> >
> >> >+      if (WARN_ONCE(table_size < VSOCK_HASH_SIZE,
> >> >+                    "table size too small, may cause overflow"))
> >> >+              return -EINVAL;
> >> >+
> >>
> >> I'd add this in another commit.
> >>
> >> >       if (!port)
> >> >               port =3D get_random_u32_above(LAST_RESERVED_PORT);
> >> >
> >> >@@ -692,7 +704,8 @@ static int __vsock_bind_connectible(struct
> >> >vsock_sock *vsk,
> >> >
> >> >                       new_addr.svm_port =3D port++;
> >> >
> >> >-                      if (!__vsock_find_bound_socket(&new_addr)) {
> >> >+                      if (!vsock_find_bound_socket_common(&new_addr,
> >> >+                                                          &bind_tabl=
e[VSOCK_HASH(addr)])) {
> >>
> >> Can we add a macro for `&bind_table[VSOCK_HASH(addr)])` ?
> >>
> >
> >Definitely. I will add the following macro:
> >
> >#define vsock_bound_sockets_in_table(bind_table, addr) \
> >        (&bind_table[VSOCK_HASH(addr)])
>
> yeah.
>
> >
> >> >                               found =3D true;
> >> >                               break;
> >> >                       }
> >> >@@ -709,7 +722,8 @@ static int __vsock_bind_connectible(struct vsock_=
sock *vsk,
> >> >                       return -EACCES;
> >> >               }
> >> >
> >> >-              if (__vsock_find_bound_socket(&new_addr))
> >> >+              if (vsock_find_bound_socket_common(&new_addr,
> >> >+                                                 &bind_table[VSOCK_H=
ASH(addr)]))
> >> >                       return -EADDRINUSE;
> >> >       }
> >> >
> >> >@@ -721,11 +735,17 @@ static int __vsock_bind_connectible(struct vsoc=
k_sock *vsk,
> >> >        * by AF_UNIX.
> >> >        */
> >> >       __vsock_remove_bound(vsk);
> >> >-      __vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vs=
k);
> >> >+      __vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)]=
, vsk);
> >> >
> >> >       return 0;
> >> > }
> >> >
> >> >+static int __vsock_bind_connectible(struct vsock_sock *vsk,
> >> >+                                  struct sockaddr_vm *addr)
> >> >+{
> >> >+      return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HA=
SH_SIZE + 1);
> >>
> >> What about using ARRAY_SIZE(x) ?
> >>
> >> BTW we are using that size just to check it, but all the arrays we use
> >> are statically allocated, so what about a compile time check like
> >> BUILD_BUG_ON()?
> >>
> >
> >I will remove the table_size check you mentioned earlier and the
> >argument here as the arrays are allocated statically like you
> >mentioned.
> >
> >If you think this check may be a good addition, I can add a
> >BUILD_BUG_ON() in the new vsock_bound_sockets_in_table() macro.
>
> If you want to add it, we need to do it in a separate commit. But since
> we already have so many changes and both arrays are statically allocated
> in the same file, IMHO we can avoid the check.
>
> Stefano
>

Okay. I will not add the check.

Thanks,
Amery
