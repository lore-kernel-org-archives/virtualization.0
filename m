Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2EB1EFF8D
	for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507322; cv=none; b=Qa+mn3fUN0wnOR5oy0WPgKn5SPwX/AFaP9OirDO0gimqgZ7NmAUf7LvGonV+NNOG/tGWpHagmIf4c4C+cmYnawmtI+yVdiNv+9Wh19+t5cvurLHgpKVoea7umQYMkwraRcnLYEbdmzhBXKMaf+8iwWrtrXODLo/zPQx1rRD+X9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507322; c=relaxed/simple;
	bh=aQnEowviS7u6YwT57tVELBPdQu0vg525IJt3iX1yNcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jUWg+S/uT5hVRvqE57OvZeAQ2S9FJq0b+ABJWivhapc6atjCdJEyhJz3LcRhrzeqreixQnFnCzzlMauaT1OAa3bS2vsGaw+W1u5r4nT7zb4sSByk5Gk3C5tNWrejXYN+2dUttnGX1hBFEnmkFsV2e8vxwSh75mM2cn5PYqvCprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKVYku7B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKVYku7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763507319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=i6yT4obi+FNIhZl5y+fxUjMFnFjvdbzrrL/2Ij5ccl8=;
	b=UKVYku7BUidjzJF/1MJf0RtTOm0nUTY7uGWJOYaM9lGKLskBEaLOegtburGwtaWeVGa3Qc
	NTMdK0UBbglmDLw0CAA/F5AJbEhz2/+PiseOAo1ZxvlJOjcFhw9gvgJJTWFfXujZWFREhS
	FMewqtaJA80anrm7CQlV5iL5jNwfdmU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-U_8igXayNtuNUrfGvTmQ3w-1; Tue, 18 Nov 2025 18:08:38 -0500
X-MC-Unique: U_8igXayNtuNUrfGvTmQ3w-1
X-Mimecast-MFC-AGG-ID: U_8igXayNtuNUrfGvTmQ3w_1763507317
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477939321e6so26716175e9.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 15:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763507317; x=1764112117;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6yT4obi+FNIhZl5y+fxUjMFnFjvdbzrrL/2Ij5ccl8=;
        b=b/uX9mJgr2ApVg464kuGWOd//YtyQw6rnHXugrnUv8GJFQp+p5STpbq+G8mJ2YZZi3
         RUDr8H/Lumlx4GxCAhYGxy8y+82dabr5nxahFlM/RSW1RG2tDkoeA6ZdjE0TTySjuvMj
         kKge5F0POMjQFLoZ+Uunnhwu+JoQXfJZEefiWq2wZq+rnY6L97N8xMSoJwZasiNJn2KX
         kA1tk6u3lPGKTra/PA8mup/XixV2pYHw5O2Z8G3SECw91ti3ccvp6xQwL9jtfmmJNohq
         7RU09zBe9j8Ub6733AFy/G+MA4KLLqB6OZyCRu4uq/2s+Qy0dBO9oY00JMXToQ85eKaH
         Gciw==
X-Forwarded-Encrypted: i=1; AJvYcCXXV7JfcY6CtTApnBcNZmCEJEs4fuLy63L22HBI+gL1C558bto4plyFAGmKitGtwG4gg6WPV7f970Kwg65kqw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9lrYIFZolxTCtK42gYvlvIITcMBvjol9D+2nbdUQlXPJENqph
	8KmQPAL+hxX8exRt37go4p4pWchQRDyUNBtqD+ef4VHsq4KW7WJHk6BcpmHI2n6WONBp1Bfj6Ud
	Dp4a4jRIqqhbfSZtQwsM0nIwGGu5cTvoL0hBSH4bpcNfEChHHw32EHqeSEW4Ivy5dzrYa
X-Gm-Gg: ASbGncuRIs/6xfQbFcEOXYTl/tdRuQ5fGb3uIT5/Hf3ROsepIQCnNlozukSOlf6sTct
	G1ymVr9Ln9U5T9cPcdJgtBihkQE3xc4Dyh5FDfHtFpw/U1Yy222xeZIfVQbSqTJIqLKf/1yfIby
	ALzmAS+Tv4ydz254BXE0yh9phTNhs5lAiua6RwMzJoMxT9dfkKq1E3mqJuwKnfedLcDuZbVA+tG
	c9qSalaTkaBBvkB4ay+gzuCDu9bcrg0KB2GBH0XWkyg0R05webL84ZeJNt6TDma+Yw5wSk95UJp
	GNnTD8f8Q7ulflkPJLOSK89USyELqCWjNEHU6LhBFb/CQUiACVx72/i39tzXk77t7lkBo+FamKD
	tXhZwyM7BOFsPXfPM6+sEcXLYGFdWyQ==
X-Received: by 2002:a05:600c:a49:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-4778fe6822fmr166083915e9.9.1763507317432;
        Tue, 18 Nov 2025 15:08:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTsZFSsu9d/ndmrdWUsASjzpQ5UHFiJl6A1+Br09arFn68dS1NKqMqV059/e95+lw50UIfTg==
X-Received: by 2002:a05:600c:a49:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-4778fe6822fmr166083725e9.9.1763507316963;
        Tue, 18 Nov 2025 15:08:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b103415asm14409415e9.10.2025.11.18.15.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:08:36 -0800 (PST)
Date: Tue, 18 Nov 2025 18:08:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>, virtualization@lists.linux.dev
Subject: [PATCH] virtio_pci: drop kernel.h
Message-ID: <a1efb550481fc67973c0a86860e0724c8f5b9957.1763507303.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V70bMbIL8uZZuAYXTyx_w23NEscbLej2IQ5NB1UXavA_1763507317
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

UAPI headers really have no business pulling in kernel.h
Drop it - it does not seem to be needed, either.

Fixes: 7c1ae151e812 ("virtio_pci: Introduce device parts access commands")
Cc: "Yishai Hadas" <yishaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index c691ac210ce2..d1b31efc4d7d 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -40,7 +40,6 @@
 #define _LINUX_VIRTIO_PCI_H
 
 #include <linux/types.h>
-#include <linux/kernel.h>
 
 #ifndef VIRTIO_PCI_NO_LEGACY
 
-- 
MST

