Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B22D0614
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666446; cv=none; b=CvRzFvNNW8x4rKNaC6RFtFCLaBDyd97FQsWb1qKhY1QHxSjo+20PBD3AzOy6Z7tgw7zOj9wmD73ojFhvZlFWHQxIS5S2tBlJcOea+F2QSAcy81QKKa+z88kop4kBn/PBD1WvCtRiXpu9buW7eJ6q6MgOOKnGSYsKinexcn9i24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666446; c=relaxed/simple;
	bh=JFm9q5MHFWvo/CMc0shtVH4Yt0n17LPmzfEtHqz8xTw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J5K3UvClTQBCTggdidOFkMAlx2SVeeONgHK9xoHd02aZaTLeImoK0xOfJboJ55OfKG8VqB8OEsrpURW+7sVOiCKxJPeysf8lbFg+4C1aqYWmpiDblrDk6ALdIj+7cuaAxHFFSZ9NMVe1xm8CU+g7j57vky9U+LYeFpfq1K2qoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ic1VCgo+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ic1VCgo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757666444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=PvsOvjK7iiT9XUkiykze+uFI53RNvUT/umyb7XIvWRc=;
	b=Ic1VCgo+YWHG6lAchFt7f02CXtcSxcy/n0rAKtztdt+G9r8CRu7rUWbbmmCDSyTe0xBV54
	CkMjWHuyF/3DqaCa0kgyX1Nx8IfPzaUJ4U9Pw314YWoXN5mMFr141JYtYanXdV5JJ9foHC
	NY6iZvgI3kGinWJcC9VH5v1WYAz5pmk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-HdoBqJrIME6b2eTHT31xOA-1; Fri, 12 Sep 2025 04:40:42 -0400
X-MC-Unique: HdoBqJrIME6b2eTHT31xOA-1
X-Mimecast-MFC-AGG-ID: HdoBqJrIME6b2eTHT31xOA_1757666441
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45d6c770066so8579055e9.0
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 01:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666441; x=1758271241;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvsOvjK7iiT9XUkiykze+uFI53RNvUT/umyb7XIvWRc=;
        b=qhwcvw3fWvbyZ+C81cIuCFMI1PzViK2YYZ50f0F83caQsVxYs9H4AjDms63+XL1tCK
         EHo5HEzIUaLSIFkfNvRQiOLgf7Hlq8XriAhCnc7jlACXPmRN4QKyZc+DwvXsb5V+4975
         BTwU3BLRz1SeTlsTW0bA3MBX5SDQzYvY3f4PHJIXIVrbsunv+f3vDDlY+rT4VSkHhk4+
         IO/IfkwuA6LAxsGilT5KbDXFqlf+huMf9Wymoc62k+aQeczRg2eajVmr3ksk3zDjxSNH
         y2CHm0sMSfk8c6dq/nGu7nKpXQDtrGZUx82zQQnk3juSa0uCmsEMHVB8hJwxNJyrRgEs
         Y7jg==
X-Forwarded-Encrypted: i=1; AJvYcCUlrJi1CtwftnOx6wX8GblKG/kYaBqBrvjwgXf15Ca+Lzp2/44gcx+nna2v4CYUIbP7NaqNigSPEXQEQIRSwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJaxuWRdIewE1BNF0KquGtnHWmodPY9x1Yp8XSkWYx58RbZJ0+
	pb78oTmbwXWtCjvVpvn4FeTArb53V25SnoCa9+lV3UyJ3mAf2COIgunYrk1RMIONwucQRjPuGw5
	M9n7aGEvHLl06/KuX6BjPFubvuhKFHWP2m+K2irmG3YPr0Zkm0/EKWyLBXuoxnDVEbDDA
X-Gm-Gg: ASbGncuxMFFzOIfQWESX9ZZaN/NJKpgaU8uOJXSmIs36v1EfP/aqE3PmbHVLD5nORMd
	KZhM26lHnNHL59Ng6EJHJbo7GcCOtzn9Pl7NsxIN+gBVd/e9Fwe+q006MFHlQ0BqvU33rgGqCE6
	sq7lPP5SumpMVCW74TB4k6ZtEtzqyYVxkE7Og4/ZIn4s3oIYzPCKdquibXDb0akqWwurbxLRFVL
	rnSA+l073aXhc258TUNs3Ro0Dte3t4pRLbKq+3AFenD/Rl+TjS/3AU+rojzDYcvPBZq09HlaCjb
	/2Y6wSrGZ8M91HeEyxV5NIJw0nn7Ci1Z
X-Received: by 2002:a05:600c:1c9b:b0:45d:dd47:b465 with SMTP id 5b1f17b1804b1-45f211c8395mr18631685e9.7.1757666441049;
        Fri, 12 Sep 2025 01:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpABu+JYhUlWvQU7+IMiPKX/l2FbW8SOSOf9lAUj55zctSTxUjYZ6Qb1tuKOdhGKXoNOk0oQ==
X-Received: by 2002:a05:600c:1c9b:b0:45d:dd47:b465 with SMTP id 5b1f17b1804b1-45f211c8395mr18631505e9.7.1757666440626;
        Fri, 12 Sep 2025 01:40:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0153fbd5sm29710965e9.5.2025.09.12.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:40:40 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:40:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: [PATCH] Revert "virtio_console: fix order of fields cols and rows"
Message-ID: <7ebfa9a5ec3f07506b3d8f01cd4f2a35e2135679.1757666355.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xEdpxetmC_ubrsh3rYfSdse16XYDBCYJl2FlBBYSqdw_1757666441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This reverts commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.

The problem is that for a long time, the
Linux kernel used a different field order from what was specified in the
virtio spec. The kernel implementation was apparently merged around 2010,
while the virtio spec came in 2014, so when a previous version of this
patch series was being discussed here on this mailing list in 2020, it
was decided that QEMU should match the Linux implementation, and ideally,
the virtio spec should be changed.

There are about 15 years' worth
of kernel versions with the swapped field order, including the kernel
currently shipped in Debian stable. The effects of the swapped dimensions
can sometimes be quite annoying - e.g. if you have a terminal with
24 rows, this will be interpreted as 24 columns, and your shell may limit
line editing to this small space, most of which will be taken by your
prompt.

NB: the command structures really should move to the UAPI header so it
is easier to notice when a change is breaking the guest/host ABI.

Reported-by: Filip Hejsek <filip.hejsek@gmail.com>
Fixes: 5326ab737a47 ("virtio_console: fix order of fields cols and rows")
Cc: "Maximilian Immanuel Brandtner" <maxbr@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54deb..216c5115637d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1576,8 +1576,8 @@ static void handle_control_message(struct virtio_device *vdev,
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__virtio16 cols;
 			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
-- 
MST

