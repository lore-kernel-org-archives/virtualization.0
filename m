Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589614;
	b=kbIeTfUAmIwBcIPPsS9T4UbfHyiXxoMN713QLKvjyE8RgEOIVn5t0ARyuQd0j8CR8tji
	 NpMB5/iorblSa6wqrKoIDU0acLxtkuqEmpWdR/JOTgBMFPoWlsBk4spzWrpWlvFr1zGzx
	 hNtVWPuw7w9FuIjmorjxZZrnnprOuc8COnHhLLV8GP9V97S6qvcfmUbhzBzoaiRe14wc+
	 iMlV5a2TH7NIPglvp8f9efgXJ1LsZntAtM3L4eKbamW/sFoTcrAPHHvFC9k2EV20cqRHH
	 XKtXlmXxB0fq+2Nh5e3GiwWjeBPZIsPO5s3f0Ye9y7ql5SQb11utLZlnhdhi1gvmdmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589614;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
	b=3ShmVqjZpS/lBY/s17S+aU6zN8hzHh0zq/oy95zLJB9YNHnnCxKJRQzIWcKq66Qqyj+L
	 Cv5evhiYU+9Wr6aplcdobo8rCIwJaKl3uTO6ALeNe0jPd/iUQPlbC3HNvuFOuIT+ZowyA
	 DdQ1/K2hkWmMRew/MW262eiBb9rejpkBYUp9fbgPDecK0fGfn3BBmalhWpba4fo7PwMgz
	 Lr2+0wzUGa+iZR6JSbFj0LA5e1uHf/80RGAZlOD7Mu3kJSWGSA4A8B2N6kSNw7BYBVjJc
	 QowXJWMFpklxFnKkHLGvutkyeGYVYWF3XLYc/+Nm061DNYfGJlFAfYh+ft3kThmJ8Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTwIU9jp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F81606A32D
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 17:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12F81606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YTwIU9jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
	b=YTwIU9jp1H10/trgxoH529RJD//rDcGtE/KAHUwAzqP+nffumFcQFMYAHwZ0FDQQXW10US
	n6Ddv5SnAAQhK87ICTIY3r7JinhINqywi3mk2UwUdm+LYDmJSHFeOiuWSrhYMSUhvYOYEI
	DQE18t5VK5D9lcaFhulAmIpiIhXdNJ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-qbn60bnLPti1Y18qu_Ariw-1; Fri, 13 Nov 2026 12:06:50 -0500
X-MC-Unique: qbn60bnLPti1Y18qu_Ariw-1
X-Mimecast-MFC-AGG-ID: qbn60bnLPti1Y18qu_Ariw_1794589609
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso6349675e9.3
        for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589609; x=1795194409;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Kki3X4dpm9KxQ2mH9Sq8u46jfClQkMQattSavxbdrg=;
        b=CpxclvUCRjqiHtJ/7YwjNrTC2UEusiFG++iKpA++sfe1CftxM1qmSfefn2DNKdjS8c
         6rRcWE4Y2IFdkcxFp5g+dJXhyCfLhWsy0UhJytO+lWYyPlX7FgaIDNQMzagBbf46Ukr5
         eiMsYsgpAGOA02DJmWVDHBIubwPgG/Tb6Bfs3imrJ1WG/VWlZ/RBEjxx915QlzaaYM4L
         VMhbVpbii8urHZUBTBys38pb1mh+7gMK02mXptjN9OZ3ChL1LJiS7ydn71zGI+YJ1TXv
         uOKrtISU+yjKZawiwaKyJ5kmxY9w2Wp60gtBK4oFFPs8a0pVovO20RC9bRapEhZhWjs3
         JpEQ==
X-Forwarded-Encrypted: i=1; AL+hErFxCu5f4fQ7PPebNgo24kBdhxcspKH71Dxy+G+fmMZ1t3ZeqMDXladleQpE1Ti7gtvrMDCk+VHKITAiONmcAw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/WziTlnraT0XT4TgmKSJZXNIek5K4+WY7aVvzumbJI03Wq84WG
	c8o1xh6N7HOiUeJKvOoMSlBgdQYwREZTr1hOTBxztNsR7DZuFA4vs6Lm4TEglH2R6y1ukQI1f+r
	3vXi3VCzKvJhB/+8iM17SaZu9ng5W1VPkG7MomxhAG4KNqK3K5FjYS2hFj0nJxcVtq4VO
X-Gm-Gg: AYBFou26hxkAssAWEdkxeyIwNpOxM2uO5WFMbUGd9Ihc2qoTrlnJyaOVsl08nswvCAG
	ca5saHI3svR27w1JVWQ3eNo6k0zqgwIovrBAbkQw6Tm0RotFVA8n6G/BsNOsuIZPOGWzcVRH30T
	RGzRznnEqXpYz6qgMVQ2b9aYbvzruCVA+WD6/rqpCYGZmfmOrCy+UDIUBHNLLxKFlJWRSlQ1PFW
	qz8lqsauTpli3BbPwxyZsnWrmDoLwK8TfBG7iAkphfmUtd0D4p9Clp1psipWdk1QPx6GY57N5SD
	io0ifXjix/oN+Z/LVZw32M5rGwxFfF9fbxfGpAA+UOvouIgcQLhCh39hsHGaW3RTGNZRpobViE8
	fyXyxcCZEa0KoGq0ChmvMyeqyVTw1VQXh4lFvv5SXMvqoV9Fsf3wjy8E8xTlg6arYOIuZsomNeV
	7byk9AYI4dRRc=
X-Received: by 2002:a05:600c:c84:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb55aa3a2dmr71557465e9.31.1794589609292;
        Fri, 13 Nov 2026 09:06:49 -0800 (PST)
X-Received: by 2002:a05:600c:c84:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb55aa3a2dmr71556725e9.31.1794589608889;
        Fri, 13 Nov 2026 09:06:48 -0800 (PST)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm6409906f8f.23.2026.11.13.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:06:47 -0800 (PST)
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 13 Nov 2026 18:04:40 +0100
Subject: [PATCH] vsock/vmci: reject datagram binds in local network
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
Message-Id: <20261113-vsock-vmci-netns-isolation-v1-1-ced02054ea61@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBtIjYSuEi1CpxoqDSckiO6et
 HyL/x8QSkwCffVAoszCMRSougK3TmEhZF8MutGdUspglug2zIdjDHQFQZa4T1fJ0FLbWaO989Z
 AGZyJZr7/+TC+7we3RtBCbAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2143; i=slp@redhat.com;
 h=from:subject:message-id; bh=KbQnqpP7rtV1X6O9hhQI+C1Zj1a1cacc8D6sCunHM3M=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq90Ol4hWRYE7DbdCG5kDAinIgd4TLSotKXr8+l
 VPEwubE0OiJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCavdDpQAKCRD0aSeNLwwC
 NTBrEACV2PMED4/7MyILMjnxuQfgS6QtiXtgSOjXHHrW3NfewioLlE1yJq6GEI03bNZP+lqKNQR
 AccWn/H2lR3qiABFWlijCpj1bJ6X26crcqVK0PEnG0KLdQkz356ogEpbDZtka1wFJR8w2JDhbRh
 Ys3iF93SvftH8KvSXnk+4rtMnbeUgKgHuL36L9XydhATObsweqMwrKlFJsNMdNpfOAJcpnxaAYg
 OqRFXGGO7Os0d1wmnsJL1uW/b/rMPdDxqWa6DTa1fPo4y4eqlIeWBO7HN7/pkHF7/tyUN+1DH/3
 MQkWZwr+IHTEuF7W29ASzuHcYsauRC2kn9sOFhkT/sEIRAo2exPo7Z9R/WQujO5VG2ZyhvFeWMg
 ymJ2iO2YcbzSPwiuXvjCBEPbht32xQmpRGvFMC/Cc7ZLvKZ0h+62sIROMdWZdi+keTkFZfCLn7O
 hHs6bbahrRf96RF/J30sUH/2kZ5Jkq6gROnToNOk1HJK3bjL/CyMOoTohBR3sR0+uZOaH69RTRl
 8ZSXuy0vIkwZM68jjduCnqtEMeMi8JT2yvpqyV6cq/IXhBqvQ7Jw/1Ik9hioviwwfvY5KyGML9i
 tK5qfhNnseLN7nPGYt4cCJRlBOfE7RajO1maGZq0JO+9wSiQa49D/53RC5VP+bmBLvPGjbT7C05
 ixnW7xHwBAI1d5g==
X-Developer-Key: i=slp@redhat.com; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bv133GOnb7wfgUkyuGTaFJofENC9N-OZxUzTFOzV46U_1794589609
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
paths. The receive callback also rejects any local-mode socket as a
defensive check.

In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
delivery and the global port collision before the fix. After the fix,
local bind returns EOPNOTSUPP, the global bind succeeds, and a global
VMCI datagram still reaches the global socket.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 net/vmw_vsock/vmci_transport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 1f186e8f8364..282131544c42 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -627,6 +627,8 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
 	 * outside of the create and destruct socket functions.
 	 */
 	vsk = vsock_sk(sk);
+	if (!vsock_net_mode_global(vsk))
+		return VMCI_ERROR_NO_ACCESS;
 	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
 		return VMCI_ERROR_NO_ACCESS;
 
@@ -1697,6 +1699,10 @@ static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
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

