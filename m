Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54950374745
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 12:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081238; cv=none; b=ic0Z0+kXtVgp315rdfrr16LHqhH9gPzebXZ68+s/NyZ43Qlal/4Fbrd/BVgUNO7rYbvlC60swUpGxjJAHgMS8fakZwYQN6pdyvjy3aXvyDXmTfYZFXYVkT/MjWoK5bFURN6om4qPW/aEzU8I7FumJ+tpx13ZKoFBWNvLqNFN2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081238; c=relaxed/simple;
	bh=jbQUTCe0ICwWOioxGPSxPQ50mAT7yEYTFcxWXz3Ogj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sFUVkJXuiJdj6C42bK+0D/KhGoRUQxSesn7uQiFkKBQiMPX1sXSoXQVJTYQxgaXhHp3UkbB/Q7eS0PYnJRSWo6a2NxhTAJZdSJwwy+Xc+ejdEoOGr1PPZILGaOHtomuH7aQfnmTi4jkOfFk8o+KB7noKy0q0euNmjn9Rx8JFt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1zuI4YW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1zuI4YW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790081234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cr6ub0HQ36E9YAIRyboF6gdXSYsRFPX75mape4tZPCw=;
	b=G1zuI4YWw6mbOIMfoky61H1svKlnni6e4/1Gq3JeNu/QrxM5tjwnG3OrcxRulgIURt4fLv
	/7vrtJ/xebvHnBDzVfqI6E+p52QJgn7fo6Ryt3XtUZtXira4RFlVj1kcWTcL8WR2csMJQF
	SLv0metlTnU9h/WM8joVruQU5n6h7zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-Gh_XpJnqMZOB3cZq9iPR5A-1; Tue, 22 Sep 2026 08:47:13 -0400
X-MC-Unique: Gh_XpJnqMZOB3cZq9iPR5A-1
X-Mimecast-MFC-AGG-ID: Gh_XpJnqMZOB3cZq9iPR5A_1790081232
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767b782so32518075e9.2
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081232; x=1790686032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cr6ub0HQ36E9YAIRyboF6gdXSYsRFPX75mape4tZPCw=;
        b=Ou03WSJ0h67UEEbxkdO4omV4jzq5eZp5YCvwVRvgDxSI0crd8bmVk1CFApaGCnbtV6
         xAh+ns3Z0Yz65A3RhkuuFq7Z7rd2f4osIcM3mwE9lZ0wsoE6z/9ufWg7cI2XxEDTph5b
         yaNH3YSAG655qKssbJbuzVPSKBd4v4UUU1DGgjagpG1dBfzAV2PfUBDR0A/TnuxBEMWD
         lan5tvGfdxh9jVBrlsJJkZvCDZVhShIr211cRrzWu60bv53cFyI36hTw0bkyqHtjO8Oz
         d9oTkEoILayc9vhl2QJZIFzAIVy/p7hT4Cjx11fQvQ2ylQp/Bu94dckLx7Rn0Jhu1Msu
         nfGg==
X-Forwarded-Encrypted: i=1; AKwUvByHTrx8pa/DoU1xpqyJPbt4PtUir/TPEEq75TJr71KNluoSDu7wvD/dGCupPRc+PAs1iU74dCFfAHgva2iVcg==@lists.linux.dev
X-Gm-Message-State: AFuF++mPEctbCj/vY84HpBu+VcRCowNbscqCd2uPB8gyFuqRsz0CRjcB
	pJWrqnd1I2PduuD5rNgR9YYbXhx5Yqxd+Dxl8881GVwZ9jXhhN9z77BI3+wbPmDGUICCVe0zjI0
	LiP1fhLYY1DPiY/cW+3HFYLf82RDrwZSOGo+uCimIhYlMBRcwDhRJ6s7ZYS0g5yE5FjdW
X-Gm-Gg: AYBFou1kCh6PMu/mXDiCDSF3kv7KZ/GoeyPCJPMRuqjw+iPvATs9lc3ZKS7Plgz7Cin
	YAKlaJu4G9qilLmgcLZAxwIcE+WLdOy+KzA+Cft/YXgxBuHDRG4L1DFVD7hBhnbLVNY72uAv2gt
	uN6DWB+Zv08VS36qmS6yuEA+ExSGoSc4Mo/RmJ/QFwBFBHtpM4l7oxPAeibSWtMxlAFi/s7/EYs
	zv7AXMkC5m+tEppi0WH6CfsU9SJ8Es63BqKgEbSCbs9j2gNEPo2rKKjY6JbF/6c5AZlFvAS5FPo
	93aDFgrgVyahgtK92x93KAwd5j8qJBedWrcaAxiS6p/7PcGIoEM3eW/t1vA0Mc3K4U+/gp0OCIH
	Uyjjmpp3SPfpQAfFFXneUuslV2PbMrvCMyWRONxxUPtLajiEUBUg=
X-Received: by 2002:a05:600c:4e0a:b0:49d:29ab:540b with SMTP id 5b1f17b1804b1-49fc5723f3cmr203501385e9.15.1790081231750;
        Tue, 22 Sep 2026 05:47:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0a:b0:49d:29ab:540b with SMTP id 5b1f17b1804b1-49fc5723f3cmr203500975e9.15.1790081231215;
        Tue, 22 Sep 2026 05:47:11 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fda8f3402sm37398835e9.0.2026.09.22.05.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:47:10 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:47:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej?= Dmitruk <bartlomiej.dmitruk@isec.pl>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vsock/vmci: make the cached_peer dgram decision
 race-safe
Message-ID: <arJ3bKG7vRjMI5Bo@sgarzare-redhat>
References: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260919123208.29032-1-bartlomiej.dmitruk@isec.pl>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RZh-nHSgG1b54YHYr04Dp523-ySC3DRqyrI32UAi7Y0_1790081232
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sat, Sep 19, 2026 at 02:31:56PM +0200, Bartłomiej Dmitruk wrote:
>vmci_transport_allow_dgram() cached its result in vsock->cached_peer and
>vsock->cached_peer_allow_dgram with an unsynchronized check-then-set. The
>function runs both in the lockless receive tasklet
>(vmci_transport_recv_dgram_cb(), no socket lock) and in the lock_sock() send
>path; lock_sock() does not exclude bottom halves, so the two contexts race on
>those fields and can return a stale 'allow' for a VMCI_PRIVILEGE_FLAG_RESTRICTED
>peer. It is also a plain data race. The in-code comment claiming the fields
>are never modified outside create/destruct is contradicted by the send path.
>
>Keep the O(1) cache -- it avoids an O(N) vmci_ctx_get() lookup on every
>datagram in the bottom-half receive path -- but pack the peer CID and the
>decision into a single word accessed with READ_ONCE()/WRITE_ONCE(). A race
>then only forces a recompute and can never return a stale allow.

I honestly don't understand this part...

>
>This was found by code inspection; I do not have VMCI hardware to test on
>(compile-tested only).
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>
>Assisted-by: Claude (Anthropic)
>---
>v2: keep an O(1) cache made race-safe rather than dropping it entirely; an
>    earlier revision removed the cache, which the Sashiko AI review flagged as
>    an O(N)-per-datagram fast-path regression. Split out per Stefano
>    Garzarella; independent of namespace support.
>v1: https://lore.kernel.org/netdev/20260917220225.56200-1-bartlomiej.dmitruk@isec.pl/
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 5549298c1..97968ac53 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -39,10 +39,13 @@ struct vsock_sock {
> 	 * modified outsided of socket create or destruct.
> 	 */
> 	bool trusted;
>-	bool cached_peer_allow_dgram;	/* Dgram communication allowed to
>-					 * cached peer?
>-					 */
>-	u32 cached_peer;  /* Context ID of last dgram destination check. */
>+	/* Cached dgram access decision for the last peer, packed as
>+	 * (cid << 32) | VALID | ALLOW and accessed via READ_ONCE()/
>+	 * WRITE_ONCE() so the lockless receive tasklet and the
>+	 * lock_sock() send path cannot race to a stale decision.
>+	 * See vmci_transport_allow_dgram().
>+	 */
>+	u64 cached_peer_access;
> 	const struct cred *owner;
> 	/* Rest are SOCK_STREAM only. */
> 	long connect_timeout;
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -524,23 +524,38 @@
>  * only if it is trusted as described in vmci_transport_is_trusted.
>  */
>
>+/* Packing for vsk->cached_peer_access. */
>+#define VMCI_DGRAM_ACCESS_VALID		BIT_ULL(0)
>+#define VMCI_DGRAM_ACCESS_ALLOW		BIT_ULL(1)
>+#define VMCI_DGRAM_ACCESS_CID_SHIFT	32
>+
> static bool vmci_transport_allow_dgram(struct vsock_sock *vsock, u32 peer_cid)
> {
>+	u64 access;
>+
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
>+	/* Cache the trusted/restricted decision for the last peer to avoid the
>+	 * O(N) vmci_ctx_get() lookup on every datagram.  Read/update it through
>+	 * a single word so a race between the lockless receive tasklet and the
>+	 * lock_sock() send path only forces a recompute -- it can never 
>return a

Is this a real issue?

We have this in the code:

	 * NOTE: We access the socket struct without holding the lock here.
	 * This is ok because the field we are interested is never modified
	 * outside of the create and destruct socket functions.
	 */
	vsk = vsock_sk(sk);
	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
		return VMCI_ERROR_NO_ACCESS;


>+	 * stale allow for a restricted peer.
>+	 */
>+	access = READ_ONCE(vsock->cached_peer_access);

How this will work on 32-bit systems?

Stefano

>+	if ((access & VMCI_DGRAM_ACCESS_VALID) &&
>+	    (u32)(access >> VMCI_DGRAM_ACCESS_CID_SHIFT) == peer_cid)
>+		return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
>
>-	return vsock->cached_peer_allow_dgram;
>+	access = VMCI_DGRAM_ACCESS_VALID |
>+		 ((u64)peer_cid << VMCI_DGRAM_ACCESS_CID_SHIFT);
>+	if (vmci_transport_is_trusted(vsock, peer_cid) ||
>+	    !(vmci_context_get_priv_flags(peer_cid) &
>+	      VMCI_PRIVILEGE_FLAG_RESTRICTED))
>+		access |= VMCI_DGRAM_ACCESS_ALLOW;
>+
>+	WRITE_ONCE(vsock->cached_peer_access, access);
>+	return !!(access & VMCI_DGRAM_ACCESS_ALLOW);
> }
>
> static int
>

