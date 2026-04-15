Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A33D3CE8
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265785; cv=none; b=Jmp5I4mqMVWqjHlWYhPV1GNTskwimlWLjxoYW7ur1yk1OjS5OX/8OxTOKTy6vA7M6yGs+TH4QXvBLEKfUyIWgxsQUmKo/j6uCVJth03dbsmM+K9BjPNhPcKMFTeBexGO7OrnVLrnhVbAKeiOvKFrkxd8IMFe1RW7s5JFbgQlCB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265785; c=relaxed/simple;
	bh=B5WKSuazSjYIg6pXvSVj3VKZEuyDVABRTNFWpy0TJsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=A+P8jS/WBc5XqUT2h31RQf/9L+iVU+UUthJ2bQog0pXQdKqEO+rPi75tQ9fFuXX+1iHOHAemIEKleu6+qhLmcQYSVD7CMgOfrIM1iIBc/3HWG0xun/dyYoQox9f2Dlju6r8C6QTORIDjG3JtVRYkhBtPTDE0vG4JlWAjpRuPhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrGg9Jb+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrGg9Jb+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
	b=QrGg9Jb+XofV/2WXVRRL3Uvjf2ZVn0c+vg4Ii8C39aule0y3je859puq4xgfucnx2mr8CN
	gcvLmHBqS2JoZXKfGqHwi5RwTQet45iRagYdakPToV4G2giRC+dsuB6sNWOPVWVlr65NNN
	nj4WsiLGqnrBmrrWOqq22FvL/qTA5u4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-DHWLeTX5PU60q0ZEq-W9fA-1; Wed, 15 Apr 2026 11:09:42 -0400
X-MC-Unique: DHWLeTX5PU60q0ZEq-W9fA-1
X-Mimecast-MFC-AGG-ID: DHWLeTX5PU60q0ZEq-W9fA_1776265780
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so7329477f8f.0
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265780; x=1776870580;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
        b=TO1kkwpkq5iwG1f7agxsThdUJ/7sScOEJMDoFWM5BtBuzHSM6+Pa81q5UHxrNZ+yM/
         UI5HPEBvvFzE+nYzpl3HNSjiIu8avafGZEPDkeyUPk8VxOFtC+aySpzYBap0fPqkfZ4X
         Q+SDa4HvELjFstHSzLQ+03cGTKNpNipJgPaC54EUPUAStKMixP4mfIvDv3+IvWcW1VA1
         Gk9jAjiW2o3k8iocoaiCbhkZFUYaf9FSc7mrNCCUOt5B50zFEonwLhPUoJBwk2RT3ojt
         WNkj4uZjbCEzXbM10mTSm74ATRz+wyamVlSEAClep2QrGIUDqqN/5MbLnHOG8iciXeGf
         w1eA==
X-Forwarded-Encrypted: i=1; AFNElJ+we6KGw4u7Cah18EFfUYnAdr9Nm8vUoOYIbIYJufpVjZKSEujSAmHXDJzHo98Yka1hQvVAyUyqGo7X8GTxBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOGj3m4SfvU+JgSxN5mqZp8/jcV7TojXqfuJpXlms/FiI4JK+c
	4E5YhqDmVuzpTn45G1FRooH53jjUAOJ/+mQc2+jciivyF///c8jcn1N8KiZFXsa98G6W+ZK8jcu
	PW7UdfoCzLaqB/VJmVoevr7bGTAhYLIJlhj63tXAvlpIzMBWrhZzy5esmsplXL/eWTYpn
X-Gm-Gg: AeBDietvAs+6gy9RwdY1jo0PrKfP/zRV9L6AZLa26VXhB0gfs9FruElRZdYbGa8VYWy
	5LF457CypqDtu/tK+ax2F+1tvEtlFIRIto+GMvYzhcFzLzee1SU1O4C96TdxIMI/kqeg+YHctsJ
	7EtiRBpjS0HpoAakjMZA64KuzBz06kYXC9Mps+M6FuJ/ItKbgu2t+zSDLMFa/+15oy4A231R6su
	Nv06OKQdqPY9xay75HzFVUBOq7dPbDl1mm0XpK9L3ozJKlU6tBuqOOxyxm9TuaZvFp7kSjTRjge
	3qTJUMpaXqARAOg9Xw+xJIquYjM5E//ozJudMYcc6f4ToFenC2VIa8TLkQ0um5ao6ugruxYdOTb
	GkoTwH3mCKlpYbJ1+Ar2zGYG4xqMuV+t+qfUT5PfDvW3uSVZgawtBl7SQ3knK
X-Received: by 2002:a05:6000:1a8d:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d642cd287mr33797812f8f.37.1776265780098;
        Wed, 15 Apr 2026 08:09:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8d:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d642cd287mr33797739f8f.37.1776265779553;
        Wed, 15 Apr 2026 08:09:39 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:38 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v4 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Wed, 15 Apr 2026 17:09:27 +0200
Message-Id: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XM3QrCIBiA4VsZHmf413QddR8R4fSzSbQNHVKM3
 XsiQUaH38/zrihC8BDRsVlRgOSjn8Y8iF2DzKDHG2Bv84wYYS0RhGLnn9cZ4I5bxWWvuGg74Ci
 /zwHyraTOaIQFXfJy8HGZwqvkEy2nT4l9S4ligrVlUjgDTsr+FMAOetmb6VEqidVSVpJlyYAdF
 LVG9dL8SV5JKirJswRpNWgrOqf4j9y27Q3PqHqgGgEAAA==
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
X-Mimecast-MFC-PROC-ID: Bj9GodbCoWRlF2vfcyvZQj8krQa83OpXtPR8s0NPYs0_1776265780
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

For disclosure: this bug was found initially by claude opus 4.6, I then analyzed
it and worked on the fix and the test.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v4:
- Picked up RoB
- Increased sleep time from 10 us to 10 ms
- Minor changes to commit messages and comments as suggested by Stefano.
- Link to v3: https://lore.kernel.org/r/20260414-fix_peek-v3-0-e7daead49f83@redhat.com

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
base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

