Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D47C6CE
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722202661; cv=none; b=BuESym2Cl358bVQuEUGjlxMHSvNGsf4FgXnSRbmRLQhn0d/N0d1c2+MROA9gs865+wO5FbqZzDKVCkLWcdTCwju+cYV3BF+gtFFfCLVrUpl+fgxFGhdRO7WXDiAvtV1sjmaGLApXMJvVFURsRB82mCGDIoZGn+SVP7W/XPq7dBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722202661; c=relaxed/simple;
	bh=2Sn68X7uDls3sP1EZexTSLlGYbfSYXNz2o7k80QTDUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0LvxFHKy4r17I0NEhrJQO7KZBHW0muDmw3E4jjdCLCHhq3DMWo0rwCQ14OqIpreAHoO0oV1YlMMtRUIDv5rNPkTphVPqgshP53H5bzXzQTjLLbEJ9KZog+PhtsPVu3Z7tB6ZqWRP43pVTrwo9EcA6W3KxTdfhajN8E2TSEtoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz8TPLFF; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz8TPLFF"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69B54403A9
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 21:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kJEGegeX50kE for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jul 2024 21:37:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b31; helo=mail-yb1-xb31.google.com; envelope-from=ameryhung@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C051F401D8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C051F401D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Dz8TPLFF
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C051F401D8
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 21:37:36 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e04196b7603so1158903276.0
        for <virtualization@lists.linux-foundation.org>; Sun, 28 Jul 2024 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722202656; x=1722807456; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9cFCXNlBUwwoGYk4agpmfzd90AIjSqmRZ4wGHZIvL4=;
        b=Dz8TPLFFRrLzcHunrfgzMhc65twqTKfLcNhFQwacZA2Ebya/CpIOdi7BMakp5G6BIX
         D6lE+d+02GOaX19IxTTwRhiumlGKqIFEgt9OqVTfiLEhuoyXSora/yWqS/FCc/x6E4PL
         b8re8hb3u20/x3xx8LIy8QhorwKBstO7TZMxobS9lZp6JOmDkKhZ4h2hzUlSH6V2nLoI
         NEFsJMPtgX7VQVZ9KWYYvCWWIBPFwogjTcLpDsQuFDhuzlK+NooQ18mv1Iq4qQmEzBLx
         hE9f3n+vZpAlSBJHZ7nVGgAQw/URLSpbbZVoV+f60hxwkuo7dy55+4WvAmUc4FqJGgyE
         WoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722202656; x=1722807456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9cFCXNlBUwwoGYk4agpmfzd90AIjSqmRZ4wGHZIvL4=;
        b=ZlfWUkcWZB6R+mVCF9vf6MhUjAJZEw8ioXrK85+/JCcnJBomUtRjB7E278gLrZbcqZ
         p+FZdtQpm8eQW/qno629YAAwqG11r+5wYCDW/qmBZFJPM95qgTLZBo2G6mDXg74YD8f4
         c+nQnqleCCE2UBmpyCI5ePD/LAR9MwIPCQi4JUyG+jcwpcjq35QuDcWZ7yDQD1qUHuUI
         uq6fVJV015ogq6vw8oBBhMIMnmrrda+UilA4G0f1qRejYacARelnc+zoERoTX4LgNARi
         +g5n86QStdouk2vHlHTOvDynnd5dqEXesSmQji8vN5gOwGha8SMAO1Xa4eNMP9Uz4vbs
         X3gg==
X-Forwarded-Encrypted: i=1; AJvYcCU4XgyuQpRUWUQ1BTkqTgSgs5rZv/5UYFS+4ZON7wLonN/ez+UvTzntsyuv399i5mvakbWm59Qb0LQSfGqGmC9BAS6AKpGvN5CNtUL/pU0/ZJ3inrivA4zFxA==
X-Gm-Message-State: AOJu0YyRG/5IWZPnzsy/xrApEzXWjEoKiYB/vDs7rQtcGjyZ75BZfYnG
	eN0q3MtIHBWjzMdCVpiBfyZiE1mTrl8d2yIKsEkqepqNpuUFhx/CeUrJJWZ41q9SPasmARpb8aw
	/AeDZWPblLGECV2akKBPwtbAEyKo=
X-Google-Smtp-Source: AGHT+IFVP55gj+sT0MrYRVitmwH+mCztNmVoK2xGhUz6Qlhx2dO5zlQtp2zqP2YBKFY/JMujHOiS1/r6Ulhctp/0vN4=
X-Received: by 2002:a05:6902:240e:b0:e06:6e0c:5e0 with SMTP id
 3f1490d57ef6-e0b5459ca5dmr5791170276.38.1722202655671; Sun, 28 Jul 2024
 14:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240710212555.1617795-1-amery.hung@bytedance.com>
 <20240710212555.1617795-6-amery.hung@bytedance.com> <pghfa4vh7vb7sggelop5asuyj6bqtq4rbgm2q3bdslcoeicihj@6arcanemghjo>
In-Reply-To: <pghfa4vh7vb7sggelop5asuyj6bqtq4rbgm2q3bdslcoeicihj@6arcanemghjo>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 28 Jul 2024 14:37:24 -0700
Message-ID: <CAMB2axNL_O3Twksi+ROUz0B298A-xQ_EYsgYzc2jLRbpikrdJQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 05/14] af_vsock: use a separate dgram bind table
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

On Tue, Jul 23, 2024 at 7:41=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Wed, Jul 10, 2024 at 09:25:46PM GMT, Amery Hung wrote:
> >From: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >
> >This commit adds support for bound dgram sockets to be tracked in a
> >separate bind table from connectible sockets in order to avoid address
> >collisions. With this commit, users can simultaneously bind a dgram
> >socket and connectible socket to the same CID and port.
> >
> >Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> >---
> > net/vmw_vsock/af_vsock.c | 103 +++++++++++++++++++++++++++++----------
> > 1 file changed, 76 insertions(+), 27 deletions(-)
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index d571be9cdbf0..ab08cd81720e 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -10,18 +10,23 @@
> >  * - There are two kinds of sockets: those created by user action (such=
 as
> >  * calling socket(2)) and those created by incoming connection request =
packets.
> >  *
> >- * - There are two "global" tables, one for bound sockets (sockets that=
 have
> >- * specified an address that they are responsible for) and one for conn=
ected
> >- * sockets (sockets that have established a connection with another soc=
ket).
> >- * These tables are "global" in that all sockets on the system are plac=
ed
> >- * within them. - Note, though, that the bound table contains an extra =
entry
> >- * for a list of unbound sockets and SOCK_DGRAM sockets will always rem=
ain in
> >- * that list. The bound table is used solely for lookup of sockets when=
 packets
> >- * are received and that's not necessary for SOCK_DGRAM sockets since w=
e create
> >- * a datagram handle for each and need not perform a lookup.  Keeping S=
OCK_DGRAM
> >- * sockets out of the bound hash buckets will reduce the chance of coll=
isions
> >- * when looking for SOCK_STREAM sockets and prevents us from having to =
check the
> >- * socket type in the hash table lookups.
> >+ * - There are three "global" tables, one for bound connectible (stream=
 /
> >+ * seqpacket) sockets, one for bound datagram sockets, and one for conn=
ected
> >+ * sockets. Bound sockets are sockets that have specified an address th=
at
> >+ * they are responsible for. Connected sockets are sockets that have
> >+ * established a connection with another socket. These tables are "glob=
al" in
> >+ * that all sockets on the system are placed within them. - Note, thoug=
h,
> >+ * that the bound tables contain an extra entry for a list of unbound
> >+ * sockets. The bound tables are used solely for lookup of sockets when=
 packets
> >+ * are received.
> >+ *
> >+ * - There are separate bind tables for connectible and datagram socket=
s to avoid
> >+ * address collisions between stream/seqpacket sockets and datagram soc=
kets.
> >+ *
> >+ * - Transports may elect to NOT use the global datagram bind table by
> >+ * implementing the ->dgram_bind() callback. If that callback is implem=
ented,
> >+ * the global bind table is not used and the responsibility of bound da=
tagram
> >+ * socket tracking is deferred to the transport.
> >  *
> >  * - Sockets created by user action will either be "client" sockets tha=
t
> >  * initiate a connection or "server" sockets that listen for connection=
s; we do
> >@@ -116,6 +121,7 @@
> > static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> > static void vsock_sk_destruct(struct sock *sk);
> > static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
> >+static bool sock_type_connectible(u16 type);
> >
> > /* Protocol family. */
> > struct proto vsock_proto =3D {
> >@@ -152,21 +158,25 @@ static DEFINE_MUTEX(vsock_register_mutex);
> >  * VSocket is stored in the connected hash table.
> >  *
> >  * Unbound sockets are all put on the same list attached to the end of =
the hash
> >- * table (vsock_unbound_sockets).  Bound sockets are added to the hash =
table in
> >- * the bucket that their local address hashes to (vsock_bound_sockets(a=
ddr)
> >- * represents the list that addr hashes to).
> >+ * tables (vsock_unbound_sockets/vsock_unbound_dgram_sockets).  Bound s=
ockets
> >+ * are added to the hash table in the bucket that their local address h=
ashes to
> >+ * (vsock_bound_sockets(addr) and vsock_bound_dgram_sockets(addr) repre=
sents
> >+ * the list that addr hashes to).
> >  *
> >- * Specifically, we initialize the vsock_bind_table array to a size of
> >- * VSOCK_HASH_SIZE + 1 so that vsock_bind_table[0] through
> >- * vsock_bind_table[VSOCK_HASH_SIZE - 1] are for bound sockets and
> >- * vsock_bind_table[VSOCK_HASH_SIZE] is for unbound sockets.  The hash =
function
> >- * mods with VSOCK_HASH_SIZE to ensure this.
> >+ * Specifically, taking connectible sockets as an example we initialize=
 the
> >+ * vsock_bind_table array to a size of VSOCK_HASH_SIZE + 1 so that
> >+ * vsock_bind_table[0] through vsock_bind_table[VSOCK_HASH_SIZE - 1] ar=
e for
> >+ * bound sockets and vsock_bind_table[VSOCK_HASH_SIZE] is for unbound s=
ockets.
> >+ * The hash function mods with VSOCK_HASH_SIZE to ensure this.
> >+ * Datagrams and vsock_dgram_bind_table operate in the same way.
> >  */
> > #define MAX_PORT_RETRIES        24
> >
> > #define VSOCK_HASH(addr)        ((addr)->svm_port % VSOCK_HASH_SIZE)
> > #define vsock_bound_sockets(addr) (&vsock_bind_table[VSOCK_HASH(addr)])
> >+#define vsock_bound_dgram_sockets(addr) (&vsock_dgram_bind_table[VSOCK_=
HASH(addr)])
> > #define vsock_unbound_sockets     (&vsock_bind_table[VSOCK_HASH_SIZE])
> >+#define vsock_unbound_dgram_sockets     (&vsock_dgram_bind_table[VSOCK_=
HASH_SIZE])
> >
> > /* XXX This can probably be implemented in a better way. */
> > #define VSOCK_CONN_HASH(src, dst)                             \
> >@@ -182,6 +192,8 @@ struct list_head vsock_connected_table[VSOCK_HASH_SI=
ZE];
> > EXPORT_SYMBOL_GPL(vsock_connected_table);
> > DEFINE_SPINLOCK(vsock_table_lock);
> > EXPORT_SYMBOL_GPL(vsock_table_lock);
> >+static struct list_head vsock_dgram_bind_table[VSOCK_HASH_SIZE + 1];
> >+static DEFINE_SPINLOCK(vsock_dgram_table_lock);
> >
> > /* Autobind this socket to the local address if necessary. */
> > static int vsock_auto_bind(struct vsock_sock *vsk)
> >@@ -204,6 +216,9 @@ static void vsock_init_tables(void)
> >
> >       for (i =3D 0; i < ARRAY_SIZE(vsock_connected_table); i++)
> >               INIT_LIST_HEAD(&vsock_connected_table[i]);
> >+
> >+      for (i =3D 0; i < ARRAY_SIZE(vsock_dgram_bind_table); i++)
> >+              INIT_LIST_HEAD(&vsock_dgram_bind_table[i]);
> > }
> >
> > static void __vsock_insert_bound(struct list_head *list,
> >@@ -271,13 +286,28 @@ static struct sock *__vsock_find_connected_socket(=
struct sockaddr_vm *src,
> >       return NULL;
> > }
> >
> >-static void vsock_insert_unbound(struct vsock_sock *vsk)
> >+static void __vsock_insert_dgram_unbound(struct vsock_sock *vsk)
> >+{
> >+      spin_lock_bh(&vsock_dgram_table_lock);
> >+      __vsock_insert_bound(vsock_unbound_dgram_sockets, vsk);
> >+      spin_unlock_bh(&vsock_dgram_table_lock);
> >+}
> >+
> >+static void __vsock_insert_connectible_unbound(struct vsock_sock *vsk)
> > {
> >       spin_lock_bh(&vsock_table_lock);
> >       __vsock_insert_bound(vsock_unbound_sockets, vsk);
> >       spin_unlock_bh(&vsock_table_lock);
> > }
> >
> >+static void vsock_insert_unbound(struct vsock_sock *vsk)
> >+{
> >+      if (sock_type_connectible(sk_vsock(vsk)->sk_type))
> >+              __vsock_insert_connectible_unbound(vsk);
> >+      else
> >+              __vsock_insert_dgram_unbound(vsk);
> >+}
> >+
> > void vsock_insert_connected(struct vsock_sock *vsk)
> > {
> >       struct list_head *list =3D vsock_connected_sockets(
> >@@ -289,6 +319,14 @@ void vsock_insert_connected(struct vsock_sock *vsk)
> > }
> > EXPORT_SYMBOL_GPL(vsock_insert_connected);
> >
> >+static void vsock_remove_dgram_bound(struct vsock_sock *vsk)
> >+{
> >+      spin_lock_bh(&vsock_dgram_table_lock);
> >+      if (__vsock_in_bound_table(vsk))
> >+              __vsock_remove_bound(vsk);
> >+      spin_unlock_bh(&vsock_dgram_table_lock);
> >+}
> >+
> > void vsock_remove_bound(struct vsock_sock *vsk)
> > {
> >       spin_lock_bh(&vsock_table_lock);
> >@@ -340,7 +378,10 @@ EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
> >
> > void vsock_remove_sock(struct vsock_sock *vsk)
> > {
> >-      vsock_remove_bound(vsk);
> >+      if (sock_type_connectible(sk_vsock(vsk)->sk_type))
> >+              vsock_remove_bound(vsk);
> >+      else
> >+              vsock_remove_dgram_bound(vsk);
>
> Can we try to be consistent, for example we have vsock_insert_unbound()
> which calls internally sock_type_connectible(), while
> vsock_remove_bound() is just for connectible sockets. It's a bit
> confusing.

I agree with you. I will make the style more consistent by keeping
vsock_insert_unbound() only work on connectible sockets.

>
> >       vsock_remove_connected(vsk);
> > }
> > EXPORT_SYMBOL_GPL(vsock_remove_sock);
> >@@ -746,11 +787,19 @@ static int __vsock_bind_connectible(struct vsock_s=
ock *vsk,
> >       return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_=
SIZE + 1);
> > }
> >
> >-static int __vsock_bind_dgram(struct vsock_sock *vsk,
> >-                            struct sockaddr_vm *addr)
> >+static int vsock_bind_dgram(struct vsock_sock *vsk,
> >+                          struct sockaddr_vm *addr)
>
> Why we are renaming this?

I will keep the original __vsock_bind_dgram() for consistency.

>
> > {
> >-      if (!vsk->transport || !vsk->transport->dgram_bind)
> >-              return -EINVAL;
> >+      if (!vsk->transport || !vsk->transport->dgram_bind) {
>
> Why this condition?
>
> Maybe a comment here is needed because I'm lost...

We currently use !vsk->transport->dgram_bind to determine if this is
VMCI dgram transport. Will add a comment explaining this.

>
> >+              int retval;
> >+
> >+              spin_lock_bh(&vsock_dgram_table_lock);
> >+              retval =3D vsock_bind_common(vsk, addr, vsock_dgram_bind_=
table,
> >+                                         VSOCK_HASH_SIZE);
>
> Should we use VSOCK_HASH_SIZE + 1 here?
>
> Using ARRAY_SIZE(x) should avoid this problem.

Yes. The size here is wrong. I will remove the size check (the
discussion is in patch 4).

Thanks,
Amery



>
>
> >+              spin_unlock_bh(&vsock_dgram_table_lock);
> >+
> >+              return retval;
> >+      }
> >
> >       return vsk->transport->dgram_bind(vsk, addr);
> > }
> >@@ -781,7 +830,7 @@ static int __vsock_bind(struct sock *sk, struct sock=
addr_vm *addr)
> >               break;
> >
> >       case SOCK_DGRAM:
> >-              retval =3D __vsock_bind_dgram(vsk, addr);
> >+              retval =3D vsock_bind_dgram(vsk, addr);
> >               break;
> >
> >       default:
> >--
> >2.20.1
> >
>
