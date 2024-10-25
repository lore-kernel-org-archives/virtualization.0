Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95371F7568
	for <virtualization@lists.linux.dev>; Fri, 25 Oct 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865719; cv=none; b=XtpjfOW4ayBO8MDzPOUAnbdAp2tXaMKRCvPPYitoTpYegD7V/MmSxRPUTJcubqbNyH/pqZJ7dIwbW+/79CgqKQkMAWmfKt+mHV3t+kE7NlVs4Vs4YK/CacPA7RPfpYQ8Q7AuBdfJSapTjHeWoDp/JS4FV5Ni+aJT/W4N/AAKPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865719; c=relaxed/simple;
	bh=I9NMJ19LAZGd8lwkfkrPWKiA82Yio12NcORWUrZNZqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLJCRexWoq8r9v9w1ev3g6LsA/fLXB2GukHMMQOBYlYweNVZdyszZoUe5zyU4oGooV9hH0dozB/oIwhOQ6Y+/drRfpqScdQ/BWb77hPktZwNwYziqGNIGSqo3w4oeSCvo6AxY//frOxFpqde+71WWYVHpyDZnjbvyksCDy0ySMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ji8SCkuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ji8SCkuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729865717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c02jmCltsV6yISoJOqxBYZsRrdNBar2VI+HnnpDo3Tk=;
	b=Ji8SCkuPQz/v9qfGaUEDfTrnYrE8j0PN1REG3B5XiKBvtsL9WuH2RQ2FIEnzSUTh2egMPH
	CWwsKRrfE0iYzMW8coJA2M+8I3zF9Hh/iUKyurCfLbFpQMjieRnOgtCj62ikezKWRMytuL
	22TXNl/E0PwtpbwBjiYmqNtYcHgqWjc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-tzlcknbTOoqc6cAii0r6cA-1; Fri,
 25 Oct 2024 10:15:13 -0400
X-MC-Unique: tzlcknbTOoqc6cAii0r6cA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B750C1955D47;
	Fri, 25 Oct 2024 14:15:10 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44BD01955F3B;
	Fri, 25 Oct 2024 14:15:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 1/7] Documentation: s390-diag.rst: make diag500 a generic KVM hypercall
Date: Fri, 25 Oct 2024 16:14:46 +0200
Message-ID: <20241025141453.1210600-2-david@redhat.com>
In-Reply-To: <20241025141453.1210600-1-david@redhat.com>
References: <20241025141453.1210600-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Let's make it a generic KVM hypercall, allowing other subfunctions to
be more independent of virtio.

While at it, document that unsupported/unimplemented subfunctions result
in a SPECIFICATION exception.

This is a preparation for documenting a new hypercall.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/virt/kvm/s390/s390-diag.rst | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/s390/s390-diag.rst b/Documentation/virt/kvm/s390/s390-diag.rst
index ca85f030eb0b..48a326d41cc0 100644
--- a/Documentation/virt/kvm/s390/s390-diag.rst
+++ b/Documentation/virt/kvm/s390/s390-diag.rst
@@ -35,20 +35,24 @@ DIAGNOSE function codes not specific to KVM, please refer to the
 documentation for the s390 hypervisors defining them.
 
 
-DIAGNOSE function code 'X'500' - KVM virtio functions
------------------------------------------------------
+DIAGNOSE function code 'X'500' - KVM functions
+----------------------------------------------
 
-If the function code specifies 0x500, various virtio-related functions
-are performed.
+If the function code specifies 0x500, various KVM-specific functions
+are performed, including virtio functions.
 
-General register 1 contains the virtio subfunction code. Supported
-virtio subfunctions depend on KVM's userspace. Generally, userspace
-provides either s390-virtio (subcodes 0-2) or virtio-ccw (subcode 3).
+General register 1 contains the subfunction code. Supported subfunctions
+depend on KVM's userspace. Regarding virtio subfunctions, generally
+userspace provides either s390-virtio (subcodes 0-2) or virtio-ccw
+(subcode 3).
 
 Upon completion of the DIAGNOSE instruction, general register 2 contains
 the function's return code, which is either a return code or a subcode
 specific value.
 
+If the specified subfunction is not supported, a SPECIFICATION exception
+will be triggered.
+
 Subcode 0 - s390-virtio notification and early console printk
     Handled by userspace.
 
-- 
2.46.1

