Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65365285C8B
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768260876; cv=none; b=N9LIG7TB8p+2QcVYIe9pa3jx14VUV/t8U1z48C1snXTtrjJFB7IBHiplDkG31S8d1zy4ZAETxoBs1cMKeCpfqCOqoYlk8+zSTI/3Z4dAv6vHH4FlRLdW+baSBqq7TRUdphR9Fxb5AWmFrSpiTULKBL9vtr9dCoQ8V1fbV1fmca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768260876; c=relaxed/simple;
	bh=ciALBiXpEllKNFFriaJFGexCh1jC8WmBZIOo2yR764A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDvZLlAlmu63XOmG3iS/ejo2TDA+5E4k7Hl1jUoFOqOkhI1XmGOrkNeH+XEX0zJdZLFvGiL4E8kzOw8JKTXE2pI0mCOjjcRMbrLNb3Azr1Qso0AUh/zwqXH/3E6RVb9l3iS7NqBVw+Pe8ED4JutPT+0ok3f39A1OeqDx2z7VeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx8MdzGd; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx8MdzGd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78e7ba9fc29so73978937b3.2
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 15:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768260873; x=1768865673; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lU3GpweyZ8RZOMAzOI1qx6iERtUR7NcEkRCk8jZG9C4=;
        b=Zx8MdzGdNncoXj2lztK6FITMwmKpXMROQLOfeG8Ue1uP9u6ABBa5eKreVrWXKamKGU
         yABH0vsDbRvq9pYMF+VCXsseA2HLUbd8KKbcNeuehVevXHzFUzmnL6oXdRInoZ6w2z1I
         rpv9CLrMvpmxOT+KKowqez6V8YT6BIAVMQdH/bQwttV8ZzciLgNEqeDHKWcB5FuMnVOX
         Nsa1OOLwP+XBjHFf9W1IgFHyuA/Buvvc2+HWow0A1TekhXLLGQViB4EFXjadNOYlP3ZU
         EC35Xwutdf6Gnn/wFYdLuoSX/zq2eRPNwK2JN0wfYqyfTtroTI1nQYDxpSEAUbmluQpH
         BV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768260873; x=1768865673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU3GpweyZ8RZOMAzOI1qx6iERtUR7NcEkRCk8jZG9C4=;
        b=nj6gCcB4VDf0PkVHKBeMi1pzOjcmau5rlF36mIwquJg/OnwWxwJqVbcLo1T4m8vvws
         8IFYvfG1+j6uoZVgP85DGSo+5vuyNq3YywMkZT0TACM6l1Ea5IN2eXvywzIFE6A6SU00
         0JpwXCC0ZkwKyNBSw1jzKq8j/iC000a4vx4lMt/D+aNWAy51NtO5XqEPMUJQlUeLzYE/
         ETJciFMAwpMLCNZ8pPbGqLIKCRktiwSTiUALPjmL2JdLeXsmnoH6dMz9AqkJuB+WAc4O
         Y45TbTKjphfy7WrC5oy3OmWd1poQgH9kd/cjKqMsp7CG5nv/dkHBZl9HfAXToag3QnzK
         qsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdS0HVLJdSmvsEjEsNkL/RYydDmAPos45L3JhJK6syW2HPmtmnbgRIFbWwY/uGpS7INVcZGqUKm11yaZykLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcvhfQ7y6JXy8Nj7UbcIVXOhoAouCkqp5W8BuXfOgn7RuGDGq8
	7pXYka/w6p5kmCqj2dB9rW9yWgRSA2EN2YTRyWFKphKnTiRPwAABnx+i
X-Gm-Gg: AY/fxX7dCG9UqGbLBOKrGFCn4olmbMiZRvHKPn3WXFs5WllbwykpZHV3TEVQ9qW7jSC
	ziasGas82KQpr8Lu8U2C00AsloqfRSz4cplw3fpXMC8XWebFdsGfQ3ed8KmTymhC2+fudi5Xcrn
	gB2NOFbNQzVwWebwF4Ntv3B/Ao4w4bOF4vI/gtXuQGis3wnN836Mf1NHFhDdYRSPVpGD/6LeQ6c
	ECwpYASKGeGyTTjsE7DnS9ZElNSPr3380ziFK+uvicJiN18d26bzaL8rbRQX+15dVEZZhvO3X0/
	2/Xjd63JJeEwvUJYDTeysbdd1zO8blCre3fNp6JQ9pQubAs/0bg4XdRfo90FIkE5QdbaGHs1Vzb
	mx66n9r5TMAdsvpnRzZ7FYoxhJt0GGMoweDlP+TPDGNQe8GUITgsRBE0GehabCbMh/4nOjE6WU7
	Z5nA1xBAGhVOc140LbyFjZaczByIiPQP3gjQ==
X-Google-Smtp-Source: AGHT+IFhnnLo9DObqpMPdGqLw+yvW/DLOUbdTMJjsPRgCKmDKj2orYWmy7Hu/cmK9w1YD06BNt4rZg==
X-Received: by 2002:a53:c0c9:0:b0:63f:9928:3f85 with SMTP id 956f58d0204a3-64716c61192mr12174478d50.62.1768260873367;
        Mon, 12 Jan 2026 15:34:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80d2c2sm8665513d50.8.2026.01.12.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:34:33 -0800 (PST)
Date: Mon, 12 Jan 2026 15:34:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 02/13] vsock: add netns to vsock core
Message-ID: <aWWFB2K5H5OXGWP8@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
 <20260111013536-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111013536-mutt-send-email-mst@kernel.org>

On Sun, Jan 11, 2026 at 01:43:37AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add netns logic to vsock core. Additionally, modify transport hook
> > prototypes to be used by later transport-specific patches (e.g.,
> > *_seqpacket_allow()).
> > 
> > Namespaces are supported primarily by changing socket lookup functions
> > (e.g., vsock_find_connected_socket()) to take into account the socket
> > namespace and the namespace mode before considering a candidate socket a
> > "match".
> > 
> > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> > for new namespaces.
> > 
> > Add netns functionality (initialization, passing to transports, procfs,
> > etc...) to the af_vsock socket layer. Later patches that add netns
> > support to transports depend on this patch.
> > 
> > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > modified to take a vsk in order to perform logic on namespace modes. In
> > future patches, the net will also be used for socket
> > lookups in these functions.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> ...
> 
> 
> >  static int __vsock_bind_connectible(struct vsock_sock *vsk,
> >  				    struct sockaddr_vm *addr)
> >  {
> > +	struct net *net = sock_net(sk_vsock(vsk));
> >  	static u32 port;
> >  	struct sockaddr_vm new_addr;
> >
> 
> 
> Hmm this static port gives me pause. So some port number info leaks
> between namespaces. I am not saying it's a big security issue
> and yet ... people expect isolation.

Probably the easiest solution is making it per-ns, my quick rough draft
looks like this:

diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index e2325e2d6ec5..b34d69a22fa8 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -11,6 +11,10 @@ enum vsock_net_mode {
 
 struct netns_vsock {
 	struct ctl_table_header *sysctl_hdr;
+
+	/* protected by the vsock_table_lock in af_vsock.c */
+	u32 port;
+
 	enum vsock_net_mode mode;
 	enum vsock_net_mode child_ns_mode;
 };
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9d614e4a4fa5..cd2a47140134 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -748,11 +748,10 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 				    struct sockaddr_vm *addr)
 {
 	struct net *net = sock_net(sk_vsock(vsk));
-	static u32 port;
 	struct sockaddr_vm new_addr;
 
-	if (!port)
-		port = get_random_u32_above(LAST_RESERVED_PORT);
+	if (!net->vsock.port)
+		net->vsock.port = get_random_u32_above(LAST_RESERVED_PORT);
 
 	vsock_addr_init(&new_addr, addr->svm_cid, addr->svm_port);
 
@@ -761,11 +760,11 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
 		unsigned int i;
 
 		for (i = 0; i < MAX_PORT_RETRIES; i++) {
-			if (port == VMADDR_PORT_ANY ||
-			    port <= LAST_RESERVED_PORT)
-				port = LAST_RESERVED_PORT + 1;
+			if (net->vsock.port == VMADDR_PORT_ANY ||
+			    net->vsock.port <= LAST_RESERVED_PORT)
+				net->vsock.port = LAST_RESERVED_PORT + 1;
 
-			new_addr.svm_port = port++;
+			new_addr.svm_port = net->vsock.port++;
 
 			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
 				found = true;



Not as nice, but not necessarily horrid. WDYT?

Best,
Bobby
