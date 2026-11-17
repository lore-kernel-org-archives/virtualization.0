Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942173;
	b=jyppPv6ReyMH/AEWYg+Z91C/tOHCoBuqVtwqfL07XzZurVUzZ0nilh7xT3H7rudg45Ld
	 cKX/P4zGyW8yYQ6KvRW8LjhFWG7jceY9yFfqY1DE3pfFgDF2H1vRkLffaf+Nrb5DlF3ch
	 dLzaLiIqk/FhWZgMFdobAealBHobaXYT9g3/f5dXT+Ltt/XdQ2etRUm4+a5a6nH46TWTB
	 QwP2UnqthL3hD5ZHKIBnOksK7Ypx+QSI91nXh9DEJHBL48ldGvVgZ9kbUW21DkQzs24GT
	 oVxRI66hsH7DrlbBmjsQDNe3pdO3CAOGsJStMkfL7P0zHKWYdfANG7Z1IrVbn1+qpXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942173;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=EhI5TLOlL+9vNzhu+UAy+2REBUSKFNqlNp3HDll8Qkg=;
	b=JNejmBvJhYFleQCrua8xbtkF3BKgtxm9HmDNQI/z6IgyQvLeSDmexPrN3FqEb8Y0QMet
	 Y37CUtEKGlaYAdYmducnob9rWNhio84VjPLCC4vSwP1zbjBTZHcfH975Kb/5g3QNvEPr5
	 O545hmGgboNybDK/61HS1txJ0S9vApqzqXwFlvld3i7iPzf2OciT4a1aUCbtMdDQGa7HJ
	 BVqAOqDt3QaPLElEr1I8twVOSnoXc0+am/Q2R3cLhTZNSiWUpU0FLCXBe3EHpZibYyYpe
	 N9yRqKjlCwMctiOGeYEDJ/gXGoAyO/IxJjLEzzncpfrg2Hokv+wQQYVDroC65D1rwag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsowI7XI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21939606A32A
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 19:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21939606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsowI7XI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794942172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EhI5TLOlL+9vNzhu+UAy+2REBUSKFNqlNp3HDll8Qkg=;
	b=NsowI7XI6ymOWDlsWIhcnM7dAlecGxLi/s9P1vVi4/Pf3kHsxoIecAhTCVscUMc5o/c4Jk
	7ZvFm/UVqzPuwHQsUDZg6NSzqTwQoOGsE87Z8mnMk8izjGUPrQ7qnX47dPr0P/2olAFp5q
	XepyrxZ44C8vFPIZcSZ7gkIGh5/6884=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Yk0T0CjzPI-74OcTCOe8Cg-1; Tue, 17 Nov 2026 14:02:51 -0500
X-MC-Unique: Yk0T0CjzPI-74OcTCOe8Cg-1
X-Mimecast-MFC-AGG-ID: Yk0T0CjzPI-74OcTCOe8Cg_1794942170
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so56093f8f.1
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 11:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794942170; x=1795546970;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EhI5TLOlL+9vNzhu+UAy+2REBUSKFNqlNp3HDll8Qkg=;
        b=Jjf2s6QpBfX0t39EC6A11g72r312/EJs4ueQ9oLXNgkdIVAjbqK1eP+GIwrX0wmHFp
         xOngzykDT5s1p1qcPN0kiCrURIzU5Rm///1ANHYx5wBwESu4BhH128aE/MWTNFhv5bDQ
         Naw9GXclR5x7mKaSPDHrJZxAD+R0HN7+37k0ic6U95KmJT2qGc1+J115p0IPCCz8dNyt
         LrLs9qkm5O9lYFkd6h7jQAqBg0ENGl5bNNsQczmLNOUJEeMTPF/00c+PhTqW+CKuPCvq
         H0bTobtBSB9xgeK8hUBywgb5QyQ6/nvUdQztzMiTGNXWt47KS1B0TZJy968nXs+OBq/j
         LlyA==
X-Forwarded-Encrypted: i=1; AL+hErG6v9xMkk0fruc4zIznRjAr6szMoGb2NNb2XS6VopcjhCvW7DuU4e+W3Dpc9NTatThYE+0iEMFtV45Xwo3zRw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ZB3H9KQRMAphVB6Gov4AQ7rYQRry+GDJm1FsN19Kn9SLeFMYb
	tmacFOdgXy1pLJeUqrIVLHbAifqc9fNXoB/BNiJBdZGA0M8nXGm5DRzLLj5Ts8ewza4u5mvZxaB
	K/F31RK5eQj91TGj33OgQluMOlPi2R7kqc3Ed9LcHX+qzzDxgmg9x9uYPv99kQ0VZqY5f
X-Gm-Gg: AZFdTZcJ6Mdq0qV+Op0OFPPSdy5VNBgFKVcvmNXWH4HZ+qnYWeoGk2Hp4PN4G0yw0Gw
	Qkx7zX4VBz8HmWygiPpw9/TzjkpSFMT2MBfP+NIas/XySKnoehIZwitbn0EQR7NBe73zRPlszuY
	Wb/R+wDuiNWmNBEed1LvRKEvz16vbRWm5UEmhWHYWBRwvlWjRdlHdTsUAGXjWOF0ZZbIFq2RECj
	31Px3yxtFyNmIr7NNxZdyHyCe6pSazUx4FqcFg/KVEyyaN/n67/dFn+8PKH+krHwaVA9KGht4Jz
	695wDzvS5Ajqp0f4wqw1gyBNiDvKfOPje/n9nFXHXZEpKoVa1ImxM/lob9BcVia10k+52lYuuNK
	7J9xGom4VOV8eFzFBTZrukX6il0Zx9gGSLkm8f00vWPpG3Kw69n+sgOn4b3xC/6FBByZsQ8gv8G
	1nXkvPXYXqdIw=
X-Received: by 2002:a05:6000:3108:b0:48f:bcf0:2026 with SMTP id ffacd0b85a97d-4a6389ed16amr883017f8f.13.1794942169604;
        Tue, 17 Nov 2026 11:02:49 -0800 (PST)
X-Received: by 2002:a05:6000:3108:b0:48f:bcf0:2026 with SMTP id ffacd0b85a97d-4a6389ed16amr882975f8f.13.1794942169208;
        Tue, 17 Nov 2026 11:02:49 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095e98sm276159f8f.42.2026.11.17.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 11:02:48 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Tue, 17 Nov 2026 20:01:52 +0100
Subject: [PATCH v2] vsock/vmci: reject datagram binds in local network
 namespaces
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQrCMBBFr1Jm7UgnrS248h7SRUhGO2gTyYSgl
 N7d2BO4fA/++ysoJ2GFc7NC4iIqMVQwhwbcbMOdUXxlMK0ZiKjDotE9sCxOMHAOiqLxaXOd4cj
 9MHbGOz92UAOvxDd57/HrVHkWzTF99q9CP/tXthASOvataU8924Euif1s89HFBaZt277ToLM+x
 QAAAA==
X-Change-ID: 20261113-vsock-vmci-netns-isolation-7e46732dcd73
To: Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, stable@vger.kernel.org, 
 Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=slp@redhat.com;
 h=from:subject:message-id; bh=TprLl35HMOZ700RHSD7wldVyF8nfQtfAOCm+aXiPq8I=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq/KTKg78yHHA1T+U5q33lvKFKhEHajCHacKczx
 gRFaBZa1/uJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavykygAKCRD0aSeNLwwC
 NZmaD/9qZAz5FLYTpTVOASrTHfMHxQjA4+DunomqrpVGDSV+BIUU2Ro4t/zHcZhv9m3tc0lx8s0
 FimzrAPcFwIDyWn12MetCnXqsav6Up6oXDk8BTuKWa0wGZbEBoBnlQ25ywTodqur3XXTnkYP+Ls
 VCCJCeNA0vfttrII+qqFdAHIXDfxPQefp2MFrsplHJQEIrWw6ZUKQ6m9oUDUFmr8PGKhJ0zlnA6
 b0F6nHW0nyX+mHPh8vVOfpDE1hQIwtxb5IKnpYVpzgBGFAufVfbvl31VzykbyGMJ9bECmhZZ9yN
 CAIBHlb3PzFNXUT8tHPcpL+jqUC8roU6si7hcqfEiOynAFoiSq0w5lu0HKWxbdwk+thKngd8jzY
 z3Y6eHNWdUSbdWABZalFGN1yuUe0gp4AyjGlxzvF2AqmhtpvFHGeCehA0WfJEgEDi+pfaNWoJCP
 mEwSJMxhOKxpfCXAjRK5d/PI0fD0B9TOLxR5JDKUs3CWhc39NTXYxZ5WRAQS2sw27SS8/VLVjF7
 t3MtOExaHVigSx0R20rRWKNucV7t9gZOFktQXvOYYpKRyOov8EFHkDA1lGlLtaBLn+k++acUzSR
 Fktu3CdnHDFv9AWIl8hgc1PTbBJhizS50YTN+u1bvIVXMcvV9t5Yufk0RGOKinb0zt6X8293phK
 vVURjCf2xVn2qNg==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ypeLFZRN8eIJKXpX-lvyx7gbmYWZ2PFqexiPHNRiN88_1794942170
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

VMCI already rejects datagram sends from local network namespaces, but a
datagram bind still creates a receive handle in VMCI's global port space.
A VMCI sender outside the namespace can therefore deliver to the local
socket. Its handle also prevents a global-namespace socket from binding
the same port.

Reject VMCI datagram binds in local namespaces. No namespace-local
datagram transport exists, so EOPNOTSUPP reflects the available receive
paths. Unbound datagram connect() and sendmsg() also return EOPNOTSUPP
because both call vsock_auto_bind(). The receive callback rejects any
local-mode socket as a defensive check.

In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
delivery and the global port collision before the fix. After the fix,
local bind returns EOPNOTSUPP, the global bind succeeds, and a global
VMCI datagram still reaches the global socket.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Changes in v2:
- Combine the VMCI receive checks and clarify the auto-bind effects on
  datagram connect() and sendmsg() (thanks to Stefano Garzarella).
- Carry Bobby Eshleman's Acked-by.
- Link to v1: https://lore.kernel.org/r/20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com
---
 net/vmw_vsock/vmci_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..d53704e31af3 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -627,7 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	 * outside of the create and destruct socket functions.
 	 */
 	vsk = vsock_sk(sk);
-	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
+	if (!vsock_net_mode_global(vsk) ||
+	    !vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
 
 	size = VMCI_DG_SIZE(dg);
@@ -1697,6 +1698,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
 	u32 flags;
 	int err;
 
+	/* VMCI handles are global and cannot serve local namespaces. */
+	if (!vsock_net_mode_global(vsk))
+		return -EOPNOTSUPP;
+
 	/* VMCI will select a resource ID for us if we provide
 	 * VMCI_INVALID_ID.
 	 */

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261113-vsock-vmci-netns-isolation-7e46732dcd73

Best regards,
-- 
Sergio Lopez <slp@redhat.com>

