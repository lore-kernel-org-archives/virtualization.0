Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED01F3B83
	for <virtualization@lists.linux.dev>; Mon,  3 Mar 2025 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991971; cv=none; b=rqgUbzXz9q96LXYXcwQiGF+9brzvtfofpGleFgpYNni/pbciIaHYCYwmr9rImI0f7LdTl1d747IBPmevudsFMqrNB5i/r/lqZ71My+cktpfnXHD9Oh+oI6/Mdn2yyNeRCq0VTp0of6cIvXcolr5HnWxBWYre31LO8Ohpiv6k10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991971; c=relaxed/simple;
	bh=7BJ75VnqDYEbE9e13G+MCHppvDrRT82moH7VLX3ZmAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=CK8anvoiKlWVwfq2RuX8DA2xiwaNK1Hcy9e94GKtrQcD+WV9Umj3r/+ChIPMCFhxcvc5A62uKlveybA35Rgvx3FZjfZPH1gwtbOdir/LYaRNB/vAwHrC8VdPFqIH5Z6i/IQ/nPp2orT34aGlQEexdSU6mu1u3iAMURxEmMErhJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ct84cqYJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ct84cqYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740991968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x5f0Ge/u6HApn0cHLmrjeezLoP0KdtHv+tljpLM2u/w=;
	b=Ct84cqYJM6llmoVaHLmF8yUPj0yvRaCgfeRBA2gKGahgt2hX6SI6fLvj/Qq08g74lWzS6n
	/s5Q2CS0QlcynMXXH3gJAdv7FvKSGwOH3h6J4HZpEFjFmXiyEfqhvJYcfJIaGvGm/x4jjC
	SQicoAby0Yigs5Mpcmgu567MX3HmcQw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-_nwY3b34NfC74ds2f1O6jQ-1; Mon, 03 Mar 2025 03:52:47 -0500
X-MC-Unique: _nwY3b34NfC74ds2f1O6jQ-1
X-Mimecast-MFC-AGG-ID: _nwY3b34NfC74ds2f1O6jQ_1740991966
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e4c5225b64so3959760a12.2
        for <virtualization@lists.linux.dev>; Mon, 03 Mar 2025 00:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991966; x=1741596766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5f0Ge/u6HApn0cHLmrjeezLoP0KdtHv+tljpLM2u/w=;
        b=A7c1HNq4zZTGSI30tFX1QcfU5p+YdAvfKkDWUUU40tcYBtzHwDJDUy6iek6uAbDCQn
         uDi51c42+tWK3+Aw8+a1p/y748M7KcYHSGtvyfhFG/bpIaeG0sDhkBZe8IvG+ylbNp3G
         RtKhqxQDSmTFOAxVUVhSR+X2SA5pxoYBuSBXyfN6b60shBP1CEc6YOPdJtibzZkKCJdv
         pEogslcSwrfO/Z+lNa2r5ydGqfxU7iTnWPg3VD3ZTVkzkhwzTYxiKFeiao1vSqwpOeGG
         wpBIh2moEBs3kJKpabt/O+SKITHNI2v3ux5dqxayKA+nzO/xldmoamJQFDHTCn9kg5ze
         Z+CQ==
X-Gm-Message-State: AOJu0YzrBOaBhHDN3fsgJ4genCYrPJEBoILbUQpI8ZLr834zWRvz5Ryt
	LgphJlSnFS7YSeSsXOglYkoxgkTJA9yKgeyIsPT0BA9Wn22+M4G4LurMZJ4aTpdw5gatsLPaOjd
	qI7DkAYJn6+RayIJ9lF0QHfQKTaTOKh/yeRrqR4ZZfRUOgPLyHzpbKTWRlw72LlDMZ4X+JfXC9P
	f1xOxBRdPG7EeoL3NBwQ2Yc41t3PEMYrY5qiYU6lnQIlj6k01/
X-Gm-Gg: ASbGncuAtmzja2Y4UyL46hNM1tZjVBH9UiS3CswamQAu2OInbVU0upmMxhjGKH8Huq1
	I4tAEtFOyJpUmKbGOP1jiVKIfhXcO8fMpt/5YGJmIGUGubGRXVUcwn7EiVMFpAlvLQPm6vbH0p3
	AzplVDgoi4UQ4c5lLXp4NoXX5btNKnoU/9r8NZXzROD9pLdM6Qn87KVC/TJhQCxyC+243byQbYy
	7SwcRMq4m0xaLqGEBNGssx74FNJvCeB/Ekip/ca1o7duq3G0wkLSxmJj5m9eo9TMyMvOMtJzaGJ
	14+IoHeEsP30LBa39TuKS3OCw5qVLgrIqq3nVsIqUFgcN8Dj2BNPTLO1lUvW2cigrCOFmOFE
X-Received: by 2002:a05:6402:270d:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5e4d6adec08mr13660775a12.12.1740991965991;
        Mon, 03 Mar 2025 00:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo44UCmf/nhSiQ3s6omsM4aVzpmAfPARCDmTuHp0dZeSeSv2Z6WHtZA+hKBPUeIaCokWugDw==
X-Received: by 2002:a05:6402:270d:b0:5de:5263:ae79 with SMTP id 4fb4d7f45d1cf-5e4d6adec08mr13660741a12.12.1740991965384;
        Mon, 03 Mar 2025 00:52:45 -0800 (PST)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb5927sm6466076a12.53.2025.03.03.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:52:43 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost: fix VHOST_*_OWNER documentation
Date: Mon,  3 Mar 2025 09:52:37 +0100
Message-ID: <20250303085237.19990-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aqujyi5rGn2qwmRUt6QWT1ht6Cxyaqh_FzyqfUM2XUQ_1740991966
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.

To avoid confusion, let's use the right names in the documentation.
No change to the API, only the documentation is involved.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/uapi/linux/vhost.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index b95dd84eef2d..d4b3e2ae1314 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -28,10 +28,10 @@
 
 /* Set current process as the (exclusive) owner of this file descriptor.  This
  * must be called before any other vhost command.  Further calls to
- * VHOST_OWNER_SET fail until VHOST_OWNER_RESET is called. */
+ * VHOST_SET_OWNER fail until VHOST_RESET_OWNER is called. */
 #define VHOST_SET_OWNER _IO(VHOST_VIRTIO, 0x01)
 /* Give up ownership, and reset the device to default values.
- * Allows subsequent call to VHOST_OWNER_SET to succeed. */
+ * Allows subsequent call to VHOST_SET_OWNER to succeed. */
 #define VHOST_RESET_OWNER _IO(VHOST_VIRTIO, 0x02)
 
 /* Set up/modify memory layout */
-- 
2.48.1

