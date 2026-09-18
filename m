Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7933D509
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735524; cv=none; b=G936mQTDQy6nUUtyQ1Dhj3fQNHYML3Aa2s/nBc1UJqZTHC4PZps3gPX8E525zrAzHKPrs6jRLUgjaQgb6Clfo0wm9Xbyz2ej9bB9NhPWg5ln35/pD4M3hOzpNINx0k7Vb9vCKfCi+JfPcnKscMcFOGDjSHlBZ44+qQyOFU/SQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735524; c=relaxed/simple;
	bh=EUXyf5mwwMyFeXqt+QNbeLD5iU2yeBaCs9BxvRnFt6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tifsHzb1r+z2wmlKi6zZwFMQo8Y4DaDLqAcV/dBgVqjevRucJtl+TB/i0Dz9s+aP7mzBSBSfGJiB3SbY3imdHK1MtfAYiykFPFodG+l+SHtNkLJ8h3G+FlQyqxwr2jQhAHlQpKzlliiPRbsL1ytYvx77E+GYAHbIHa4x7IaMT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7e8O5QH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7e8O5QH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789735515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNHbAwEuVi2IzpLwoXGz7v+aIL/8hFsG5BvN11sltgw=;
	b=R7e8O5QHLcw0ZmESRz2iqv4lrdIUbfHVEUlQ3uvDWBVu5SXmQuA0j9gx2lUyVRKEtJZTzB
	Ty+iJITxGzzKE730EEejXHFrBzCUNvXlUtwlb7nGYa6baKns89zDBCdOO7EGttlpz7dVCx
	pNpElBkkZBpC6vXajxuEpiT/2vbqlHg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-GsUc4NzSNH-ARBYvppAjpA-1; Fri, 18 Sep 2026 08:45:11 -0400
X-MC-Unique: GsUc4NzSNH-ARBYvppAjpA-1
X-Mimecast-MFC-AGG-ID: GsUc4NzSNH-ARBYvppAjpA_1789735511
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f18da958so460284f8f.0
        for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 05:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735511; x=1790340311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gNHbAwEuVi2IzpLwoXGz7v+aIL/8hFsG5BvN11sltgw=;
        b=KrfvTFUGUhkeBLwiMCNAvJ4dYmRMkc7FYIRkfUidzAhDBolQlIjEKfCsis6uIqIXsS
         HSmXGhBd049McfPhGt1ONAKXZP4AtbXlTI7XaQbSdx+JVq6daGWBjV3514fsisCbofD3
         XwHO7iK9y932iTX9Xp4rxLc+HtkIWuvzqkuBq4gBI1CPhRI59SEhaYE+azBklsj/DYpQ
         uN7s44phDFegYxWVMpD4nFjRshpeUxfQfL7E89SLIiud9Geu3IfsXB/VdKmcBG8ncBqJ
         ktqVZoUo8AB4M4EuSpNJqDV9YrrAwRIt5pVpdplEYcvixCB3cTl50A2cV5+6gCqE2ZyD
         OQ8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzftIV96LkwvsYxrDtHX0pbmXgt3SittcWemWfmuhAzyrg9Cx7dIiEcwKUZmzQnmoYSu9lKTkAjNLlu8BU0gg==@lists.linux.dev
X-Gm-Message-State: AFuF++lDiIdh6yP70zBI6yizZC4VwsUGaWR5QTCkW+4wGB3eXG26B4tr
	UDfOBlI8GnP0NDEwY2T7ZMNZENmjeKzD5/uIFGUJIEo8Z9p0nFa+KhkEaKA64fZ1MwdXWNiogeO
	tCpIhgwnTYV0QbooejLtrZBTV9gTIAbDZ/aNzNl2H/pvEm9+UrXIu7sCzYG/89dkyTFqWNH5dGl
	Oy
X-Gm-Gg: AYBFou0pRqR3uigiIfyyQTQZ0rE0BDiS5yO11QWxQRk54KATLUtZtj6Q0no2XHdJ5aW
	XaB0kbqXTc0bV9eUO2QOuPVMcpD3/46pq1XdHFBpbhXaaeH4PgS7quVL3hP1NTUJmNVTl8uZz9M
	aMRN3VCll4Mv7M/rI8gFecYU/g3oGucOoEkTPGYDjPHMNaoTjNsRxxTiCC9tLuHC7q0NJhWOWMz
	7mVBlmD3vnZGUJkJjHc0zpOFF69chwam/OJrVCr+r0GNpTaAXzM3k+nJFVC/i69Z28i3Q8Qgcar
	pBvZAgrNrEmvnDAbU0Ot4HdGLbciAgNG3wERp7XT332BfjJHjoAmY5dfFcj8Aal4n535rUYXSlJ
	k1DbAji2yp5zpnSvoU7iaTaXUW+dREjmAPwT+V4JwBAOrCg==
X-Received: by 2002:a05:6000:40c9:b0:487:a87:24c9 with SMTP id ffacd0b85a97d-4871d98cc80mr4209371f8f.3.1789735510720;
        Fri, 18 Sep 2026 05:45:10 -0700 (PDT)
X-Received: by 2002:a05:6000:40c9:b0:487:a87:24c9 with SMTP id ffacd0b85a97d-4871d98cc80mr4209343f8f.3.1789735510256;
        Fri, 18 Sep 2026 05:45:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it. [79.53.30.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48720078bfcsm3821644f8f.28.2026.09.18.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:45:09 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:45:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, pv-drivers.linux@broadcom.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, "Michael S . Tsirkin" <mst@redhat.com>, bobbyeshleman@meta.com
Subject: Re: [PATCH] vsock/vmci: harden datagram receive access check (netns
 bypass + cached_peer race)
Message-ID: <aq0xcAKg1snndtdX@sgarzare-redhat>
References: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260917220225.56200-1-bartlomiej.dmitruk@isec.pl>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CoqoaT3XZLhgIxpkIAcnZ2lDX4Aj6Gr8kNshDTTBPxw_1789735511
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 18, 2026 at 12:02:24AM +0200, Bartłomiej Dmitruk wrote:
>vmci_transport_allow_dgram() gates delivery of incoming VMCI datagrams. It
>has two problems, both in this one function, fixed together here.
>
>1. Namespace bypass: the send hook vmci_transport_dgram_allow() refuses
>   datagrams when the socket's netns is not in global mode
>   (vsock_net_mode_global()), but the receive path never checks it. A socket
>   bound in a non-global (local) netns therefore receives datagrams from
>   peers it could never send to, defeating namespace isolation.

Is the VMCI transport supporting namespaces? (CCing Bobby)

>
>2. Data race / stale ACL: the decision was cached in vsock->cached_peer and
>   vsock->cached_peer_allow_dgram with an unsynchronized check-then-set.
>   The function is called both from the lockless receive tasklet
>   (vmci_transport_recv_dgram_cb(), no socket lock) and from the lock_sock()
>   send path; lock_sock() does not exclude bottom halves, so the two contexts
>   race on those fields. An interleave can return a stale 'allow' for a
>   VMCI_PRIVILEGE_FLAG_RESTRICTED peer (and it is a plain data race
>   regardless). The in-code comment claiming the fields are never modified
>   outside create/destruct is contradicted by the send path.

2 issues -> 2 fixes, no?

In this case mainly to backport them properly, since for example we 
added namespace support only recently.

Please also add the right Fixes tag and all maintainers in CC.

Stefano

>
>Add the symmetric net-mode check and drop the cache, evaluating the decision
>on every datagram; there is no shared mutable state left to race. The now
>unused cached_peer{,_allow_dgram} members can be removed in a follow-up.
>
>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>---
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -529,18 +529,25 @@
> 	if (VMADDR_CID_HYPERVISOR == peer_cid)
> 		return true;
>
>-	if (vsock->cached_peer != peer_cid) {
>-		vsock->cached_peer = peer_cid;
>-		if (!vmci_transport_is_trusted(vsock, peer_cid) &&
>-		    (vmci_context_get_priv_flags(peer_cid) &
>-		     VMCI_PRIVILEGE_FLAG_RESTRICTED)) {
>-			vsock->cached_peer_allow_dgram = false;
>-		} else {
>-			vsock->cached_peer_allow_dgram = true;
>-		}
>-	}
>+	/* Enforce the per-netns mode on the receive path, symmetrically with
>+	 * the send hook vmci_transport_dgram_allow(): a socket in a non-global
>+	 * (local) netns must not receive datagrams it could never send.
>+	 */
>+	if (!vsock_net_mode_global(vsock))
>+		return false;
>
>-	return vsock->cached_peer_allow_dgram;
>+	/* Evaluate on every datagram instead of caching the decision in
>+	 * vsock->cached_peer{,_allow_dgram}: those fields were an
>+	 * unsynchronized check-then-set shared between the lockless receive
>+	 * tasklet and the lock_sock() send path, which could return a stale
>+	 * 'allow' for a restricted peer.
>+	 */
>+	if (!vmci_transport_is_trusted(vsock, peer_cid) &&
>+	    (vmci_context_get_priv_flags(peer_cid) &
>+	     VMCI_PRIVILEGE_FLAG_RESTRICTED))
>+		return false;
>+
>+	return true;
> }
>
> static int
>

