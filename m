Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBD8C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 12:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 608DF84374;
	Thu, 10 Mar 2022 12:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kd2Wv02ve3BC; Thu, 10 Mar 2022 12:55:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B6DFB813F0;
	Thu, 10 Mar 2022 12:55:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D647C0012;
	Thu, 10 Mar 2022 12:55:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 949BCC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 736984027F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E2eg53SbUjqE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:55:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23BEE40195
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646916901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o3uuvO9y1xNAcrDjYnTtQsNYybnuLDe1nLYUIuWqefY=;
 b=giRJgdnZqIrOqDyol01UxaRzuHjzUCatyT3fvGYgnpT88HZbz9T2utfIblqUKGJuOeUdTs
 cvA4D4i5qtSMBmZQqF589IW+r7QR1sNqyXLDAI0MLcdKCeD3QnvSJlbYFIb18btVXNyOuZ
 Mlc7E9qsQ82Ra71feU+TNdXLw6qqfN4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-EcUAevEvNGOC7eq7TS-o6g-1; Thu, 10 Mar 2022 07:54:59 -0500
X-MC-Unique: EcUAevEvNGOC7eq7TS-o6g-1
Received: by mail-wr1-f72.google.com with SMTP id
 q14-20020adfea0e000000b002036c16c6daso1660836wrm.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 04:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o3uuvO9y1xNAcrDjYnTtQsNYybnuLDe1nLYUIuWqefY=;
 b=fe7GCR2dGhvKMR0W5yLJ3TsYHEXKT2s0CBAdO6OKfLf4yQ9IgkvIEKzA+XrCLonPJR
 85Z1X/HMdJW2627jr7y3JpeggUCFzjFaUJIABIwcZMyDto7vmWxrsuRY6/AAdHKp5GoE
 gkZLsQwq9IQAQANVUte3kTretS1L/Ilas2gpvWwfln4wAZlwVN+v++XbsAp0TbrcsCuL
 JdNeXXBABJovgEA3+lqCDerjEzbnti8/tB7mUilxmfL5sfC//EcMaO/kKK9bmbhbUd+1
 vZGYQiAx5+sF8o5i4rrJlJEJifalpk8ViFrxGGnfpnHWKCjtuLaJssbpdKqD8RXWJ59t
 JBiQ==
X-Gm-Message-State: AOAM533gJyflreUY8bKBwWaEXXTgxrifufsJVlMrYzYVFZjwt7EyeE25
 0IsCsT0JVuTvobLZAF0x1X764T2U0YrYhb3mmOUDAT2XiQU86waoTFGYuLNTYfs299DcNQP5u30
 +XM87wt+JKZouErxqSyVouWqs0QkqFPuqYYoR3NEt5w==
X-Received: by 2002:a05:600c:4307:b0:389:4f8f:f189 with SMTP id
 p7-20020a05600c430700b003894f8ff189mr3482142wme.29.1646916898728; 
 Thu, 10 Mar 2022 04:54:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4WtRMs4j8svdlHofO6NAwGUbSGfyjsdL481HZnIQ0bv2WpthcFijpLxcYQbLbVdijnTUBRA==
X-Received: by 2002:a05:600c:4307:b0:389:4f8f:f189 with SMTP id
 p7-20020a05600c430700b003894f8ff189mr3482124wme.29.1646916898425; 
 Thu, 10 Mar 2022 04:54:58 -0800 (PST)
Received: from redhat.com ([2.53.27.107]) by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c2c4c00b003816932de9csm7606078wmg.24.2022.03.10.04.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 04:54:58 -0800 (PST)
Date: Thu, 10 Mar 2022 07:54:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiyong Park <jiyong@google.com>
Subject: Re: [PATCH 1/2] vsock: each transport cycles only on its own sockets
Message-ID: <20220310075421-mutt-send-email-mst@kernel.org>
References: <20220310124936.4179591-1-jiyong@google.com>
 <20220310124936.4179591-2-jiyong@google.com>
 <20220310075217-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220310075217-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: adelva@google.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Thu, Mar 10, 2022 at 07:53:25AM -0500, Michael S. Tsirkin wrote:
> This message had 
> In-Reply-To: <20220310124936.4179591-1-jiyong@google.com>
> in its header but 20220310124936.4179591-2-jiyong@google.com was
> not sent to the list.
> Please don't do that. Instead, please write and send a proper
> cover letter. Thanks!
> 


Also, pls version in subject e.g. PATCH v2, and include
full changelog in the cover letter. Thanks!

> On Thu, Mar 10, 2022 at 09:49:35PM +0900, Jiyong Park wrote:
> > When iterating over sockets using vsock_for_each_connected_socket, make
> > sure that a transport filters out sockets that don't belong to the
> > transport.
> > 
> > There actually was an issue caused by this; in a nested VM
> > configuration, destroying the nested VM (which often involves the
> > closing of /dev/vhost-vsock if there was h2g connections to the nested
> > VM) kills not only the h2g connections, but also all existing g2h
> > connections to the (outmost) host which are totally unrelated.
> > 
> > Tested: Executed the following steps on Cuttlefish (Android running on a
> > VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
> > connection inside the VM, (2) open and then close /dev/vhost-vsock by
> > `exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
> > session is not reset.
> > 
> > [1] https://android.googlesource.com/device/google/cuttlefish/
> > 
> > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > Signed-off-by: Jiyong Park <jiyong@google.com>
> > ---
> >  drivers/vhost/vsock.c            | 4 ++++
> >  net/vmw_vsock/virtio_transport.c | 7 +++++++
> >  net/vmw_vsock/vmci_transport.c   | 5 +++++
> >  3 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index 37f0b4274113..853ddac00d5b 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -722,6 +722,10 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> >  	 * executing.
> >  	 */
> >  
> > +	/* Only handle our own sockets */
> > +	if (vsk->transport != &vhost_transport.transport)
> > +		return;
> > +
> >  	/* If the peer is still valid, no need to reset connection */
> >  	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
> >  		return;
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index fb3302fff627..61b24eb31d4b 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -24,6 +24,7 @@
> >  static struct workqueue_struct *virtio_vsock_workqueue;
> >  static struct virtio_vsock __rcu *the_virtio_vsock;
> >  static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
> > +static struct virtio_transport virtio_transport; /* forward declaration */
> >  
> >  struct virtio_vsock {
> >  	struct virtio_device *vdev;
> > @@ -357,11 +358,17 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
> >  
> >  static void virtio_vsock_reset_sock(struct sock *sk)
> >  {
> > +	struct vsock_sock *vsk = vsock_sk(sk);
> > +
> >  	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
> >  	 * under vsock_table_lock so the sock cannot disappear while we're
> >  	 * executing.
> >  	 */
> >  
> > +	/* Only handle our own sockets */
> > +	if (vsk->transport != &virtio_transport.transport)
> > +		return;
> > +
> >  	sk->sk_state = TCP_CLOSE;
> >  	sk->sk_err = ECONNRESET;
> >  	sk_error_report(sk);
> > diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> > index 7aef34e32bdf..cd2f01513fae 100644
> > --- a/net/vmw_vsock/vmci_transport.c
> > +++ b/net/vmw_vsock/vmci_transport.c
> > @@ -803,6 +803,11 @@ static void vmci_transport_handle_detach(struct sock *sk)
> >  	struct vsock_sock *vsk;
> >  
> >  	vsk = vsock_sk(sk);
> > +
> > +	/* Only handle our own sockets */
> > +	if (vsk->transport != &vmci_transport)
> > +		return;
> > +
> >  	if (!vmci_handle_is_invalid(vmci_trans(vsk)->qp_handle)) {
> >  		sock_set_flag(sk, SOCK_DONE);
> >  
> > -- 
> > 2.35.1.723.g4982287a31-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
