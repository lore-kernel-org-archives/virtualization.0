Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471E1C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 13:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E134940576;
	Thu, 10 Mar 2022 13:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ye2_umAHDsTa; Thu, 10 Mar 2022 13:17:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EE8E440195;
	Thu, 10 Mar 2022 13:17:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD4D6C001D;
	Thu, 10 Mar 2022 13:17:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90042C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 794A24167C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8VPxvEBEM2UB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:17:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4945D4161A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646918229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipKGAsfvx4KvpIaltnSTRpTCF3Z+heVHYCt28YT0aF0=;
 b=MjiK7V/PK/wsj785pj1t2C218eqemqT1Q+VbGD+cUMuLL3ny+ug/k0dxf7q/2MkCdM0aXk
 xVM+ycRF8k23UVx1QtBQEVmslEg7jkCnjRZUYl8pP55MZYRN1nkgPve2cUUvC+U08gJ/e3
 NBQF24EaptJbCRd5SFYbMOnIFVhMH40=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-O5MOHiKvMAW8ntkMrHobRw-1; Thu, 10 Mar 2022 08:17:06 -0500
X-MC-Unique: O5MOHiKvMAW8ntkMrHobRw-1
Received: by mail-wm1-f71.google.com with SMTP id
 v67-20020a1cac46000000b00383e71bb26fso2085086wme.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 05:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ipKGAsfvx4KvpIaltnSTRpTCF3Z+heVHYCt28YT0aF0=;
 b=oI7tmDyPBCw27rAxqGVk22npJZhbAN/OVAHLKGTRL+458D6aG/Pf1aLS37vSTp7twB
 YTNDrtXqSy37eCVBIO31Fg6/sFwEhZCaGvVRsTJjqBf6H1FmZywVktCwS5UWVylR7Gdq
 Qp6RbFB/+4/wv0ahsQRExsmdKi45mH92xq9BC7ZbFt0lihKymqwd2j1cGSqT5vYVoaDE
 PFmEeZ/j9/lMKAXwBoAkKSLpKLsz2HCCFIumyn0ozR2/epPKoYNYnh4CGkuvhHC5GoNX
 9RTmbbG96A/5OipS3HBvPpH4XmZUWH5gltuwK33wTJCT3JrC7PZfYe0EdHiOq1iaHkLs
 AovA==
X-Gm-Message-State: AOAM5325MybyEgI39eEEGezyYpIelJeml3EordvupsbehPgpaJrgSEDr
 Z9Mcp4MUKfHS1kY1Ax3cQYYiPRWcm5CxB1wfz8lo3IuBDebkPsQ933zvhnIHpPtZvFEeHB8NtSw
 YPRFVlF+VNT2edwnSG7D98Z2eFo6frZO73Va0CurZLw==
X-Received: by 2002:a5d:4dc4:0:b0:1ef:7aa9:5a8e with SMTP id
 f4-20020a5d4dc4000000b001ef7aa95a8emr3512626wru.168.1646918224896; 
 Thu, 10 Mar 2022 05:17:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnYu6RJxPUA0EkhT6wRJxsIiquTBvA0erpSRnIdz5JOuNjFwG8/Nf2GIWfELU/w+shXdZ1mw==
X-Received: by 2002:a5d:4dc4:0:b0:1ef:7aa9:5a8e with SMTP id
 f4-20020a5d4dc4000000b001ef7aa95a8emr3512596wru.168.1646918224550; 
 Thu, 10 Mar 2022 05:17:04 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 d8-20020a056000114800b001f045f3435asm5758437wrx.108.2022.03.10.05.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 05:17:04 -0800 (PST)
Date: Thu, 10 Mar 2022 08:16:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH 1/2] vsock: each transport cycles only on its own sockets
Message-ID: <20220310081458-mutt-send-email-mst@kernel.org>
References: <20220310125425.4193879-1-jiyong@google.com>
 <20220310125425.4193879-2-jiyong@google.com>
 <20220310075933-mutt-send-email-mst@kernel.org>
 <CALeUXe4V=6WhavV5d0XN_EjtZ9=0_5rD9ZfvQ77M1W4HpYh_2Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALeUXe4V=6WhavV5d0XN_EjtZ9=0_5rD9ZfvQ77M1W4HpYh_2Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, kuba@kernel.org, davem@davemloft.net
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Mar 10, 2022 at 10:11:32PM +0900, Jiyong Park wrote:
> Hi Michael,
> 
> Thanks for looking into this.
> 
> Would you mind if I ask what you mean by incomplete? Is it because non-updated
> modules will still have the issue? Please elaborate.

What stefano wrote:
	I think there is the same problem if the g2h driver will be
	unloaded (or a reset event is received after a VM migration), it will close
	all sockets of the nested h2g.
looks like this will keep happening even with your patch, though
I didn't try.

I also don't like how patch 1 adds code that patch 2 removes. Untidy.
Let's just squash and have downstreams worry about stable ABI.


> 
> On Thu, Mar 10, 2022 at 10:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Mar 10, 2022 at 09:54:24PM +0900, Jiyong Park wrote:
> > > When iterating over sockets using vsock_for_each_connected_socket, make
> > > sure that a transport filters out sockets that don't belong to the
> > > transport.
> > >
> > > There actually was an issue caused by this; in a nested VM
> > > configuration, destroying the nested VM (which often involves the
> > > closing of /dev/vhost-vsock if there was h2g connections to the nested
> > > VM) kills not only the h2g connections, but also all existing g2h
> > > connections to the (outmost) host which are totally unrelated.
> > >
> > > Tested: Executed the following steps on Cuttlefish (Android running on a
> > > VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
> > > connection inside the VM, (2) open and then close /dev/vhost-vsock by
> > > `exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
> > > session is not reset.
> > >
> > > [1] https://android.googlesource.com/device/google/cuttlefish/
> > >
> > > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > > Signed-off-by: Jiyong Park <jiyong@google.com>
> > > ---
> > >  drivers/vhost/vsock.c            | 4 ++++
> > >  net/vmw_vsock/virtio_transport.c | 7 +++++++
> > >  net/vmw_vsock/vmci_transport.c   | 5 +++++
> > >  3 files changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index 37f0b4274113..853ddac00d5b 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> > >        * executing.
> > >        */
> > >
> > > +     /* Only handle our own sockets */
> > > +     if (vsk->transport != &vhost_transport.transport)
> > > +             return;
> > > +
> > >       /* If the peer is still valid, no need to reset connection */
> > >       if (vhost_vsock_get(vsk->remote_addr.svm_cid))
> > >               return;
> >
> >
> > We know this is incomplete though. So I think it's the wrong thing to do
> > when you backport, too. If all you worry about is breaking a binary
> > module interface, how about simply exporting a new function when you
> > backport. Thus you will have downstream both:
> >
> > void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
> >
> > void vsock_for_each_connected_socket_new(struct vsock_transport *transport,
> >                                     void (*fn)(struct sock *sk));
> >
> >
> > and then upstream we can squash these two patches.
> >
> > Hmm?
> >
> >
> > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > index fb3302fff627..61b24eb31d4b 100644
> > > --- a/net/vmw_vsock/virtio_transport.c
> > > +++ b/net/vmw_vsock/virtio_transport.c
> > > @@ -24,6 +24,7 @@
> > >  static struct workqueue_struct *virtio_vsock_workqueue;
> > >  static struct virtio_vsock __rcu *the_virtio_vsock;
> > >  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
> > > +static struct virtio_transport virtio_transport; /* forward declaration */
> > >
> > >  struct virtio_vsock {
> > >       struct virtio_device *vdev;
> > > @@ -357,11 +358,17 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
> > >
> > >  static void virtio_vsock_reset_sock(struct sock *sk)
> > >  {
> > > +     struct vsock_sock *vsk = vsock_sk(sk);
> > > +
> > >       /* vmci_transport.c doesn't take sk_lock here either.  At least we're
> > >        * under vsock_table_lock so the sock cannot disappear while we're
> > >        * executing.
> > >        */
> > >
> > > +     /* Only handle our own sockets */
> > > +     if (vsk->transport != &virtio_transport.transport)
> > > +             return;
> > > +
> > >       sk->sk_state = TCP_CLOSE;
> > >       sk->sk_err = ECONNRESET;
> > >       sk_error_report(sk);
> > > diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> > > index 7aef34e32bdf..cd2f01513fae 100644
> > > --- a/net/vmw_vsock/vmci_transport.c
> > > +++ b/net/vmw_vsock/vmci_transport.c
> > > @@ -803,6 +803,11 @@ static void vmci_transport_handle_detach(struct sock *sk)
> > >       struct vsock_sock *vsk;
> > >
> > >       vsk = vsock_sk(sk);
> > > +
> > > +     /* Only handle our own sockets */
> > > +     if (vsk->transport != &vmci_transport)
> > > +             return;
> > > +
> > >       if (!vmci_handle_is_invalid(vmci_trans(vsk)->qp_handle)) {
> > >               sock_set_flag(sk, SOCK_DONE);
> > >
> > > --
> > > 2.35.1.723.g4982287a31-goog
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
