Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943CB3EAC68
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183030; cv=none; b=rbDTb3SKWG/Pmw6TaOSvByIsnHcYo7hUuZ0DA8KQekUjlgezxBryd6kj1Zdc5fschi7S0coQ8lLLa9Cf/KLOHRi2eJE8nTihpMb0e2qQWBErj5wHHMEoSBXoh/yCOg0ebfhbfjk6rK4UmWFZ5zpD1njw97c1AsKjyjpntCFsltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183030; c=relaxed/simple;
	bh=2xDcIT3f78H7eKHRPribLJ8e2LZJl4ii3oNMP2ytE+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=re9HluEpJgVHebbRXa6C0HfxJaymkO9PW6qEIhGUtrw50FhCXy22AYhvyTEDbIeGZHlwPHg61LaL2Bu9WsA0NMS8T02AzcTUAU1urIlyJISQALMmxTMzPFeY4yzDQDX667nTbVEijexECJ5MleLyhjZhcQrqqCkWkCL5T0fiF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TxFx3XK+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxFx3XK+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
	b=TxFx3XK+H7CxAj0fPQCvS6rLNFkeoUnw9PMEXl8FdZtj3LUqNu8Jz4zliQoJd+3iUNlRiQ
	LHq9T4hG4DejCoQihKvq0/G//IvvxVz+YRxPNcc3Gq2vRfOoXg7X5erpOSpPlCoSrdrXSr
	/tVofu7aZaxmAcnZsyNg5eisLYWsdhU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-AtqF4DFtPTC9kxrXqGQC3g-1; Tue, 14 Apr 2026 12:10:26 -0400
X-MC-Unique: AtqF4DFtPTC9kxrXqGQC3g-1
X-Mimecast-MFC-AGG-ID: AtqF4DFtPTC9kxrXqGQC3g_1776183025
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d00dd913cso6299392f8f.1
        for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183025; x=1776787825;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
        b=lCjwwcY14pYnhsLSouVLgRgiBnwt17NQMWQHK2TrMTxivOBweVck2hXqMJ2iqK51ov
         b2J2WJXyoCt0qgPzE1ettJmdndD2Uyx+4vaarrj9i09MhyEJ0TyE6gJ/B8sXlLMA5Zbs
         7NOsYpSpOsNgoQ92LXBZ1JjXwyLu9DwXblFRKjixi89E5ACzFLXVFuxx+rTEHYGt3TIQ
         VFik9InaYg7m5ajNVjReTuRLhMNjEczZC+21m284lABRZtf8s1arBZw/ZQLxDGd3xFNe
         Q354IQH/cNYNjAGuauHPD+aKqSzU/NKEVYNOpOepk8Zc02s0KWPTLd88RRB8xHbwaT+y
         gpfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JT5NRzr2SFIJgVe3VP1xo5aIgZGhmwhaF1kY7y/g7J0VDL5Eua5ds95M4bAgCAL1g/2YFb9i1hW7aQ7Y9ig==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzeLNuECu01l6FgjB0DXZGit4lHUqk3R9ahqa3yJLWsMKBMeK5
	kJYflVZt9FBb5i+YbcgLnF1jJgXVf34MUGhJzJ/++rk5hgVEdRHuxBuhVajtEcyu3InIsU2ym5r
	XSDwLq211ls36RhZBwZKgIM1rtynuo7atjY7acpyeDmOdVoEHhYw0IZI4G/sZzWler4rS
X-Gm-Gg: AeBDievkmH1s6tMz1JelstXamVxpoiH6CPjI+Qi/2SbeDuqSRxSYCAJ12sKeUAANHIs
	kxl/uj1RZRHZlcz4k3HOj1Qxm4ILr3FU2v7OI0rEm9/6ZtJG5PlRjau3mJNK4gady3sJNoEhGiI
	kKYzV0vK7FB6TkTlYk1rz+mV+8hycU5tc7lSSIDMMMINYvNNS04u+zF1bhHIKEpSyd54p60HdVd
	OMeB5lraHjmkHxpoyPvHKEirKza7qZ874JADgMJVjUrVvzc/aCTXOLML2tZIqGh3ouUXJnMw5cZ
	17pqfbZsXioQM1HT7Du10ScKY3UPdCqm4XuIbfGtVYWxLrGJBH+geWFgPt3oRnUIIJo6DU6amMm
	tG0ccs/S8ZK/OFCZCbjJps+q72G2XGnHmv/l92qRiDoBdDK/6mzoaxhB2y6nx
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr26523569f8f.23.1776183024764;
        Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr26523479f8f.23.1776183024220;
        Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:23 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v3 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Tue, 14 Apr 2026 18:10:20 +0200
Message-Id: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WM3wrCIBSHX2Wc6ww9rmld9R4RselZk2gOHVKMv
 XsiQevy9+f7FogUHEU4VQsESi46P+YgdxWYoR3vxJzNGZBjw2suWO9et4nowRotVadl3RxJQr5
 PgfJWVBcYaYZrLgcXZx/eRZ9Emb4m/JmSYJy1FlXdG+qV6s6B7NDOe+OfxZJwS6oNiZlEwoMW1
 uhOmT9yXdcPjfM9XuAAAAA=
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lhk3IuK_XkoKFkgBPYM-eULR01CsicPzKoDf04zJgO0_1776183025
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_stream_do_peek`, when calculating the number of bytes to
copy, didn't consider the `offset`, caused by partial reads that happened
before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commits.

Commit 1 introduces the fix
Commit 2 introduces some preliminary work for adding a test and fixes a
problem in existing tests.
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

For disclosure: this bug was found initially by claude opus 4.6, I then analzyed
it and worked on the fix and the test.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v3:
- Addressed reviwers omment
    - Dropped test client, reusing the one already existing
    - Minor changes: added comment, improved commit messages
    - Rebased to latest net-next
- Link to v2: https://lore.kernel.org/r/20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com

Changes in v2:
- Addressed reviewers comment
    - Test now uses the recv_buf utils.
    - Removed unnecessary barrier
    - Checkpatch warnings.
- Added new commit that allows to use recv_buf with MSG_PEEK
- Picked up RoBs
- Link to v1: https://lore.kernel.org/r/20260402-fix_peek-v1-0-ad274fcef77b@redhat.com

---
Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: fix MSG_PEEK handling in recv_buf()
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++--
 tools/testing/vsock/util.c              | 15 ++++++++++
 tools/testing/vsock/vsock_test.c        | 50 +++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 15 deletions(-)
---
base-commit: bc28831d7a09f7058cdca4658d81e5faf635bed7
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

