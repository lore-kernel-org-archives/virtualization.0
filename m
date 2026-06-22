Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCF3659FD
	for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161056; cv=none; b=NOYrxZ0XSmII9e8XzxKDxw3RSDMK0n2CdYe2PVJ3sqqtdeyML1WnsMB3jt7uzhS+y/GZDslhlkmBKL2Ttnk5c99QrMVIb5LWyGbjnWYqH9H99R3jgLhKYt0CkFCV2JsfTfLbnGx1zfqgboMqPjgrmkA/AUWIEZtVzIgo6FpV2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161056; c=relaxed/simple;
	bh=wjti8bknEcTX8FcniewZeDWvKL403gQyFz+BxaWi4QE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tVvUx35pGRiw0xzH1Kipv5rTRsQc02f9DpcZjxkvqTJF+UcEoHMZR6Pt3cyfvbyutib2/jGpEjaPwHBM4+NIE9riufpDj59gEGWN3s4CqbnHae+BarAvwzUdyXn7jhFBPyKb6s7tYMR8PjJMEq3OBdqe4uAcwULwVeiD9c01lgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b1q/8EaU; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--briandaniels.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1q/8EaU"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8dd2138633cso98241506d6.3
        for <virtualization@lists.linux.dev>; Mon, 22 Jun 2026 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782161054; x=1782765854; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oeY7Afs0lbHnR0QncCnTUELZnAVrZhoU3GxTUGfziYk=;
        b=b1q/8EaUGBpxKFOdz1/bg+VWECAPTp+MhE8V43/IUDzkZM/U4spbZhATLaxF00Ugzq
         eXZ0cFagfw4BROmF/YLRs1VclSQUwVElxC8nX7dh4bM2UWtshclVJCuIa9AOIISvjo04
         nZpRLN3szsNhfUF6BltyoYxA/0hTXuADyReYTVLlxrw2x2HdnuBqabTDG4DfSSD55vM8
         ea21lupMDlJRgMA1Pbqpmq9GbTO4Em7qUUrZShtSPrOcIwpZx3n2rv7XtVyeCvKRqYZt
         yNORDzF5caNB50Mogi/ohw0T1u9U+GV2oCl9/TC43veeRk/P7oOlRfX8UnaRuGVijwkX
         91aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782161054; x=1782765854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeY7Afs0lbHnR0QncCnTUELZnAVrZhoU3GxTUGfziYk=;
        b=WM9dntXypOehVkF2nBrLnYjNidEd/6hQ9cKHQxVeb8/ujRj0OUSwzDLiYbBTn8s4i6
         sfn1uEVW2k4ZU1NvXf/OraHiOKCczOUvUfh1g+4r3TkcDzm2/q0000rlg9dkdToF1rdA
         vr7uBNuzh6WLp5tZAj9gd8rONRxzcR8icUIeylaLoAgDjdA8VLS1DL0jAFbHv/9f9XOA
         OmuxomXSVfbMJpxa3suhgOUP/wCBG1HQbhMoWDUcBBDfw6or85B5EzdKZyCATh1MeI7P
         J1ToXmpt9bfoN5PBz5MTAVLkWQpD7ZVmDloF+opHvSliOs/MpsMiOnwdZabsCVVUp7eb
         Rrtg==
X-Forwarded-Encrypted: i=1; AFNElJ+ch8XsqZmF6jzJ8amZywOX7nZ5cZN6FWFHSG93LCg5wbfoogFRk1Scuk+gxrghdw5URzfFIReKE3lwJ4UmOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2M/l6TsJHzbp51ba1F1y79180IJI87CW/YE3couSapEfHBFPv
	VHrltvyjWWzKsbiYByg+xonMlFdXwKlbjQVk5C4WhDidD3dOjuEaj1JjmqtPvXsZETEjGi2NRxX
	zYTKEIjNh2+yeUPnCsEYFOGH1OvmV
X-Received: from qtwu5.prod.google.com ([2002:a05:622a:105:b0:514:c2a9:36f2])
 (user=briandaniels job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1923:b0:517:260f:8e95 with SMTP id d75a77b69052e-519e49155f4mr254690411cf.8.1782161054020;
 Mon, 22 Jun 2026 13:44:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:43:43 -0400
In-Reply-To: <20260622204343.1994418-1-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622204343.1994418-1-briandaniels@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622204343.1994418-9-briandaniels@google.com>
Subject: [PATCH v4 8/8] media: virtio: Add MAINTAINERS entry
From: Brian Daniels <briandaniels@google.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: acourbot@google.com, adelva@google.com, aesteve@redhat.com, 
	changyeon@google.com, daniel.almeida@collabora.com, eperezma@redhat.com, 
	gnurou@gmail.com, gurchetansingh@google.com, hverkuil@xs4all.nl, 
	jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mst@redhat.com, nicolas.dufresne@collabora.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, 
	Brian Daniels <briandaniels@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Alexandre Courbot <gnurou@gmail.com>

Add an entry for the new virtio-media driver.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
Co-developed-by: Brian Daniels <briandaniels@google.com>
Signed-off-by: Brian Daniels <briandaniels@google.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efbf80806..af370b787 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28327,6 +28327,12 @@ S:	Maintained
 F:	drivers/iommu/virtio-iommu.c
 F:	include/uapi/linux/virtio_iommu.h
 
+VIRTIO MEDIA DRIVER
+M:	Brian Daniels <briandaniels@google.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/media/virtio/
+
 VIRTIO MEM DRIVER
 M:	David Hildenbrand <david@kernel.org>
 L:	virtualization@lists.linux.dev
-- 
2.55.0.rc0.799.gd6f94ed593-goog

