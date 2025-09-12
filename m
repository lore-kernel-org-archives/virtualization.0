Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55EB26E70E
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667394; cv=none; b=bzpvkNYJAq8vxgozs/91Y8ibe3ZY2NyIMycp+u3p6ThRaoX4nAYCzL27hgDONo9Mw6XrWiqhz8lM8MpXNNjTWoR3M0S60v4mAxaSSYMK/CiZTt/e8Ul7BzssE0Quc5Sfl58UAD4FsCzYGT+vb/T75zeANV1Od/pVGP3ICLMVYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667394; c=relaxed/simple;
	bh=9TuQEBjmdDLinHayo5DYGUW8uac4nJfA7tkt5ck069Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=S+CrwyJ+jdGOmQqlZ+gknJF6lbQcLIrlM7gxo3nb8EdbDAWQYs2gAjoyWFQVume/Q4kU2vY4iIimuIz1JjiwL9rLOThTRCzzo6ixiB3jjTHJvA7ujEm94kQbgH/ZXn2SIb6z2Jy1urAqAg0z/eAKWwvt6f6ELDf83O1og6CoSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gViCPQA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gViCPQA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=IRz7gJ5evnxzZdOz9ZURRFhBrrpzY6w4PcJfSteWFao=;
	b=gViCPQA22jBBKyEumIkDfmmm9D4pPDAA61s5qJzjohWha7ul+s+PivwQbD//Y0MTg2GERX
	44LkVCYLBSMRhRHbL4YKPffJX4HY/tu0gYMvCVWD8npa15uFstmsu462ERnHIIcweBwEWV
	knkZ00STHG29lgTA+EQYnNsWhOv8S8s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-oPBD2IckPASQJ6B_iuXmew-1; Fri, 12 Sep 2025 04:56:30 -0400
X-MC-Unique: oPBD2IckPASQJ6B_iuXmew-1
X-Mimecast-MFC-AGG-ID: oPBD2IckPASQJ6B_iuXmew_1757667389
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd62a0dd2so7615755e9.1
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 01:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667389; x=1758272189;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRz7gJ5evnxzZdOz9ZURRFhBrrpzY6w4PcJfSteWFao=;
        b=ReNf9YvcotOZ+KcfALiFFmoEVR60ab2y+mnlRY4OM2lo7UkfWixAoW3C6uoHHZ1vDh
         S195PsIZlzc1lEcZaL/wQ2Zl3CkhEPYZzhxSQyoyJlmBOCKF/+O8/IID4oQDXj1wsLoC
         RAqEkxg3vMeQ+v+bXwIsRAK+3hyfsA8B+TdwA2qjXw1HxfwBIFgArPs5owphLvR0VYjf
         R0P62vRn+GHOU9hD2h2nBlAaiw5KkDxFFSm9kQmeCR/2cUK4cqngkeqDhK/kJUwHehSZ
         k2d7LV1LcalQL660miBW5KjzmvE72TE2tumUMf6ow/Q+AuhUDFo0COiQiJNgdLd+SMD4
         /q2A==
X-Forwarded-Encrypted: i=1; AJvYcCVb0f9Ca1f5D21TV/jaS2YwaZQcoIehYx/aGsAtca4VvdzZP6J0N6Ex3OO3CH2SN0D62RJMZ/1O9FskB43raw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxL646/aub9AJ5rLKZz0yEkYLG36gNzmfcoUoxwTKpG5xqZNnX4
	U+iT6SEd7uYN2932m+5yLMEAvAK+DAV3vngve94z8tFg8vSo2WC+9VX2H6EjvoelQqWY3AVg/4Q
	5sA+7MlaVAZjVsfwU2K6TvAsImx2jZzh+GLO+MD7w8wGty9PML18POYay80ypGY9e+zVu
X-Gm-Gg: ASbGncuixaYdOh15gtP8+noZKgX4sQpWh6uHX7eWuPOgKrSfWln080p9qNA1JGrCHEU
	l3AH6uZYenvFSvlGFUQx/5UQ6ttc13kNg8AVYaGwJ8AN88SV7Jks45tY5kwTMxjYiO/LDKuJkMW
	SXhGoB+q0uloV0oR1vxxw6OX/OQOSHw37bJAlDFGzvQdqx2PQDkUjgiIsZ47KSYeoNDCPXdB4M/
	YvsJueIKLYQafffEieXxA5RkUOmCkwWrzfKLKVEXMMoIdWhawU83qNVF/2/u57tuOXzTPmaXMZ1
	g3c4eD23RPpqDONIvncKkTimJA641i0w
X-Received: by 2002:a05:600c:c112:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45dfd5fa22amr49076825e9.16.1757667389392;
        Fri, 12 Sep 2025 01:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT97SrCYae/KHK1SjWMxo7ctidNkypzXX3y27/RMu/mOH/TwU0NXoK5V3noVbuk8Wle3HkFw==
X-Received: by 2002:a05:600c:c112:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-45dfd5fa22amr49076635e9.16.1757667388938;
        Fri, 12 Sep 2025 01:56:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372ae57sm53442645e9.8.2025.09.12.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:56:28 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:56:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev
Subject: [PATCH] Revert "virtio_console: fix order of fields cols and rows"
Message-ID: <601edd0a61e9a31d3d4f525a7c0648dbb4baa603.1757667309.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gqDHQZiPE-E9qfnxfESfTQ_gGNhM9iJkIwB_A2WyQUY_1757667389
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

It seems better to just drop the change (it was only in 2 releases so
far), going back to the status quo.

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

