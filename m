Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F81333730
	for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497361; cv=none; b=o2xC5qoSo3XdTpPWdHTExuAg/lPGOyTv1jwwIVtMyUvv6PVYPMUtgsqZ9JoTHYwFWPLNs+3aXjKioPU/OSVL8f5GML3GWU4scFP8dvPxzg0DOUQqvyDSUd+4f03NMcDWbxsqULkqzcfITD6HocSfDjuOS0aST5tNaqVyNtHC1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497361; c=relaxed/simple;
	bh=eTIUgii0YmaylqM4iVI/YNV+QeRj+PKWD6nx1b8Mkvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lBI3hciN//SZf2qvTSYu97TDQSmFWDnQLitj0hVOnHdiB/UW+RE4pdTya7CNxaBb2TaDPoedW3QBwScGQLEv4oqzAozw6gmPcNdMPqJ+vpHAfVtCzN6ReYStUMJUBX2i9qcEc65tM4uv073X53qGY8VIHLFkzcZuemqnsJXpa0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2+XBM19; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2+XBM19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771497358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bEmwL6W5pHYJ3lHWdTPnl0swpUbILrk1rjryh3uy/K8=;
	b=K2+XBM19I+KizmBkkdMXF1d0Cdzkof3nJMvtW0IdFOnBnEyNLEZPb1VVoAyfXIO6a84Y3H
	toyuvA7aU7xuM4+YFc42/eFAnnVBVIfyQItyZbrRlbfu2+ujrbSwsEzMpR3IRS9cK90IpA
	+eJ8MQzAYnO7waoECfSfnTEckUuF468=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-KOEewulTOLeTugDB2QAMHA-1; Thu, 19 Feb 2026 05:35:57 -0500
X-MC-Unique: KOEewulTOLeTugDB2QAMHA-1
X-Mimecast-MFC-AGG-ID: KOEewulTOLeTugDB2QAMHA_1771497356
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4832c4621c2so9623585e9.3
        for <virtualization@lists.linux.dev>; Thu, 19 Feb 2026 02:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497356; x=1772102156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEmwL6W5pHYJ3lHWdTPnl0swpUbILrk1rjryh3uy/K8=;
        b=TWcsjsVXbqO0MNa7fQc0C8cVfgwVlrx5g1Jbzg43DfOWSJWGhJtHIdWxo48u5lwVRn
         iJWbSutQHWvEQ0oF9pPVZvGYcjp4u0uY5Qjl8AKyfPXrUlrj36DyibyTXAcOYn30jxnJ
         lwLxv9ukykLcpIyBdknIq1PEUxmx1dKp3uYo987RFlzS0TYU9B8hUHZaPJNd8h5P6Pi5
         legKBtkHnKIZSM6Y1fWgPqrDhnOPKFbKWs/UWQBGiXm/YSiyh8N0+WxPBJFlexGu9/OU
         gURLbh/MEWaFmhQ3NBztDVYSmvzeUHOiWrptijzR1he71svIGwz+uSF4N2xe+PVT1912
         ohIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi83Xr1/COyf9yZfFLWYaERBPkeoGHWH8DEYp+wGjw4C4QOA3EubPbi/O16EVF2yq/UQzDZCfoS8Sfi/R6rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZv/icu9T0Td6fkYAq1CC2AzTEWwDfvzj0makZcBEMPwjoFmpn
	SpE60MYBCuOZ6IFDLOQ7HLoKQsP0EOdmmyjeltDUYkeZL6EFe+6nig/BIc6edgmvlk7R0f1O69j
	3nizz4jtTQo81SliMIpGCREqCj3s0J/sBM1v/OrSyf0FacUvws7jh39Sr6QcCJ2BGemD5
X-Gm-Gg: AZuq6aJuSauMsKWicTRdN7dsgDicB2MbX468e2a5mkA3rbOlARgYj2Af2UpFxreAGMK
	DpTe1/rUW2R90CYNWvBSWhC+lJnLzbH5vxPTaj0e1NCTe9XMb3KdZtUu4un9F/+kK2O3zVWjzD5
	tncBeYWD/b2Y6UciTpMqGh+1ytigFc8sCDkOOKZfk65KN0MC0ZSVvoCvlh9kwbBEJJXDCbuAPzP
	+pp3k2zJki/7N2p8xvW33KT3WEGBoX+NuEh+j51KUeGXRyNhkHeq52wkVTYDSt7jyAlAy8dGhQs
	IsWXaMagWDSH2Uk+j20fdp1RezyoNbT235vlneZ+Fpvob0HUdxV0TEejFSDRIg+pgw79oNz6H4q
	tjpHlw1gWe81+0T03sbaJBxzKrH5Rs8+A9T6gHHgovGZv7l1Cs5ga0wM2vBZS62kDV1LBprA=
X-Received: by 2002:a05:600c:46cf:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48373a58867mr322370725e9.29.1771497356205;
        Thu, 19 Feb 2026 02:35:56 -0800 (PST)
X-Received: by 2002:a05:600c:46cf:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48373a58867mr322370165e9.29.1771497355597;
        Thu, 19 Feb 2026 02:35:55 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d8334a8sm680068285e9.12.2026.02.19.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 02:35:54 -0800 (PST)
Date: Thu, 19 Feb 2026 11:35:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net v2 2/3] vsock: lock down child_ns_mode as write-once
Message-ID: <aZbR2H2oDyIAxDef@sgarzare-redhat>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
 <20260218-vsock-ns-write-once-v2-2-19e4c50d509a@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260218-vsock-ns-write-once-v2-2-19e4c50d509a@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FfNZqAcAyCn9GnsYj0LQo26UJjCzeBsugVni4wJF6zc_1771497356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Feb 18, 2026 at 10:10:37AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Two administrator processes may race when setting child_ns_mode as one
>process sets child_ns_mode to "local" and then creates a namespace, but
>another process changes child_ns_mode to "global" between the write and
>the namespace creation. The first process ends up with a namespace in
>"global" mode instead of "local". While this can be detected after the
>fact by reading ns_mode and retrying, it is fragile and error-prone.
>
>Make child_ns_mode write-once so that a namespace manager can set it
>once and be sure it won't change. Writing a different value after the
>first write returns -EBUSY. This applies to all namespaces, including
>init_net, where an init process can write "local" to lock all future
>namespaces into local mode.
>
>Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

nit: usually the S-o-b of the author is the last when sending a patch.

>---
> include/net/af_vsock.h    | 20 +++++++++++++++++---
> include/net/netns/vsock.h |  9 ++++++++-
> net/vmw_vsock/af_vsock.c  | 15 ++++++++++-----
> 3 files changed, 35 insertions(+), 9 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d3ff48a2fbe0..9bd42147626d 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -276,15 +276,29 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
> 	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
> }
>
>-static inline void vsock_net_set_child_mode(struct net *net,
>+static inline bool vsock_net_set_child_mode(struct net *net,
> 					    enum vsock_net_mode mode)
> {
>-	WRITE_ONCE(net->vsock.child_ns_mode, mode);
>+	int locked = mode + VSOCK_NET_MODE_LOCKED;
>+	int cur;
>+
>+	cur = READ_ONCE(net->vsock.child_ns_mode);
>+	if (cur == locked)
>+		return true;
>+	if (cur >= VSOCK_NET_MODE_LOCKED)
>+		return false;
>+
>+	if (try_cmpxchg(&net->vsock.child_ns_mode, &cur, locked))
>+		return true;
>+
>+	return cur == locked;

Sorry, it took me a while to get it entirely :-(
This overcomplication is exactly what I wanted to avoid when I proposed 
the change in v1: 
https://lore.kernel.org/netdev/aZWUmbiH11Eh3Y4v@sgarzare-redhat/


> }
>
> static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
> {
>-	return READ_ONCE(net->vsock.child_ns_mode);
>+	int mode = READ_ONCE(net->vsock.child_ns_mode);
>+
>+	return mode & (VSOCK_NET_MODE_LOCKED - 1);

This is working just because VSOCK_NET_MODE_LOCKED == 2, so IMO this 
should at least set as value in the enum and documented on top of 
vsock_net_mode.

> }
>
> /* Return true if two namespaces pass the mode rules. Otherwise, return false.
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index b34d69a22fa8..d20ab6269342 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -7,6 +7,7 @@
> enum vsock_net_mode {
> 	VSOCK_NET_MODE_GLOBAL,
> 	VSOCK_NET_MODE_LOCAL,
>+	VSOCK_NET_MODE_LOCKED,

This is not really a mode, so IMO should not be part of `enum 
vsock_net_mode`. If you really want it, maybe we can add both 
VSOCK_NET_MODE_GLOBAL_LOCKED and VSOCK_NET_MODE_LOCAL_LOCKED, which can 
be less error prone if we will touch this enum one day.

> };
>
> struct netns_vsock {
>@@ -16,6 +17,12 @@ struct netns_vsock {
> 	u32 port;
>
> 	enum vsock_net_mode mode;
>-	enum vsock_net_mode child_ns_mode;
>+
>+	/* 0 (GLOBAL)
>+	 * 1 (LOCAL)
>+	 * 2 (GLOBAL + LOCKED)
>+	 * 3 (LOCAL + LOCKED)
>+	 */
>+	int child_ns_mode;

Sorry, I don't like this too much, since it seems too complicated to 
read and to maintain, If we really want to use just one variable, maybe 
we can use -1 as UNSET for child_ns_mode. If it is UNSET, 
vsock_net_child_mode() can just return `mode` since it's the default 
that we also documented, if it's set, it means that is locked with the 
value specified.

Maybe with code is easier, I mean something like this:

diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d3ff48a2fbe0..fcd5b538df35 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -276,15 +276,25 @@ static inline bool vsock_net_mode_global(struct vsock_sock *vsk)
  	return vsock_net_mode(sock_net(sk_vsock(vsk))) == VSOCK_NET_MODE_GLOBAL;
  }
  
-static inline void vsock_net_set_child_mode(struct net *net,
+static inline bool vsock_net_set_child_mode(struct net *net,
  					    enum vsock_net_mode mode)
  {
-	WRITE_ONCE(net->vsock.child_ns_mode, mode);
+	int old = VSOCK_NET_CHILD_NS_UNSET;
+
+	if (try_cmpxchg(&net->vsock.child_ns_mode, &old, mode))
+		return true;
+
+	return old == mode;
  }
  
  static inline enum vsock_net_mode vsock_net_child_mode(struct net *net)
  {
-	return READ_ONCE(net->vsock.child_ns_mode);
+	int mode = READ_ONCE(net->vsock.child_ns_mode);
+
+	if (mode == VSOCK_NET_CHILD_NS_UNSET)
+		return net->vsock.mode;
+
+	return mode;
  }
  
  /* Return true if two namespaces pass the mode rules. Otherwise, return false.
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
index b34d69a22fa8..bf52baf7d7a7 100644
--- a/include/net/netns/vsock.h
+++ b/include/net/netns/vsock.h
@@ -9,6 +9,8 @@ enum vsock_net_mode {
  	VSOCK_NET_MODE_LOCAL,
  };
  
+#define VSOCK_NET_CHILD_NS_UNSET (-1)
+
  struct netns_vsock {
  	struct ctl_table_header *sysctl_hdr;
  
@@ -16,6 +18,13 @@ struct netns_vsock {
  	u32 port;
  
  	enum vsock_net_mode mode;
-	enum vsock_net_mode child_ns_mode;
+
+	/* Write-once child namespace mode, must be initialized to
+	 * VSOCK_NET_CHILD_NS_UNSET. Transitions once from UNSET to a
+	 * vsock_net_mode value via try_cmpxchg on first sysctl write.
+	 * While UNSET, vsock_net_child_mode() returns the namespace's
+	 * own mode since it's the default.
+	 */
+	int child_ns_mode;
  };
  #endif /* __NET_NET_NAMESPACE_VSOCK_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9880756d9eff..f0cb7c6a8212 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2853,7 +2853,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
  		    new_mode == VSOCK_NET_MODE_GLOBAL)
  			return -EPERM;
  
-		vsock_net_set_child_mode(net, new_mode);
+		if (!vsock_net_set_child_mode(net, new_mode))
+			return -EBUSY;
  	}
  
  	return 0;
@@ -2922,7 +2923,7 @@ static void vsock_net_init(struct net *net)
  	else
  		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
  
-	net->vsock.child_ns_mode = net->vsock.mode;
+	net->vsock.child_ns_mode = VSOCK_NET_CHILD_NS_UNSET;
  }
  
  static __net_init int vsock_sysctl_init_net(struct net *net)

If you like it, please add my Co-developed-by and S-o-b.

BTW, let's discuss here more about it and agree before sending a new 
version, so this should also allow other to comment eventually.

Thanks,
Stefano

> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 9880756d9eff..50044a838c89 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -90,16 +90,20 @@
>  *
>  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
>  *     mode, which is set at namespace creation and immutable thereafter.
>- *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
>+ *   - /proc/sys/net/vsock/child_ns_mode (write-once) controls what mode future
>  *     child namespaces will inherit when created. The initial value matches
>  *     the namespace's own ns_mode.
>  *
>  *   Changing child_ns_mode only affects newly created namespaces, not the
>  *   current namespace or existing children. A "local" namespace cannot set
>- *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
>- *   from the parent's child_ns_mode.
>+ *   child_ns_mode to "global". child_ns_mode is write-once, so that it may be
>+ *   configured and locked down by a namespace manager. Writing a different
>+ *   value after the first write returns -EBUSY. At namespace creation, ns_mode
>+ *   is inherited from the parent's child_ns_mode.
>  *
>- *   The init_net mode is "global" and cannot be modified.
>+ *   The init_net mode is "global" and cannot be modified. The init_net
>+ *   child_ns_mode is also write-once, so an init process (e.g. systemd) can
>+ *   set it to "local" to ensure all new namespaces inherit local mode.
>  *
>  *   The modes affect the allocation and accessibility of CIDs as follows:
>  *
>@@ -2853,7 +2857,8 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
> 		    new_mode == VSOCK_NET_MODE_GLOBAL)
> 			return -EPERM;
>
>-		vsock_net_set_child_mode(net, new_mode);
>+		if (!vsock_net_set_child_mode(net, new_mode))
>+			return -EBUSY;
> 	}
>
> 	return 0;
>
>-- 
>2.47.3
>

