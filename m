Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A0303C87
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873978; cv=none; b=XDonKlRQViU2ZGpfyQFzfgU3i8I9W6CEwKqukD9c1P29jjdVzLnS2UsyMjja9LSFG+zS/FOpW46yHBlUrZvhRsOnBMdcwN8ygqjXMzdTrq79VZfgk4keXTuuxrzE9OjqKGPB0F6qyhABnXMK57pyzTFUpiiFgRKN79prHNHcuCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873978; c=relaxed/simple;
	bh=YoKBwChJ+3xW3h6BPHuy3j58QdbXaYmPRXH0i1a8SEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iCBbhw6QoVQ2wNIQs0dIyzm46WOvEgIB+SKIpi0hzcKWoe+VNuqVUjB28PMeLuRbJy6LdeOaDg9Y+5QuDp4JXzuqeZ4UI32a9FPXsnXY5qa03c/NlDpxCBcP3lRKX89iBqfD/CKa7Fr0vyOvp+SHqTcmgwVudN9670Zzk4Zo3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wnpdzi/d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wnpdzi/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cUBrswfhXMKxoiMbjs/2E/mwb0mfQw6thKgxG+Tr0W8=;
	b=Wnpdzi/dWzCOVjcU5qifooBRbYJTgf+22twK3HnQUL2max2FkPBXsjMvlAJxS4bM/udAJb
	yQWbKia2Qn+EaT/1C6Xx/PCUWF/f/vKe3q6GdWNmFZq+S0kI/GkaCtRMW3/v7wnbDVt0mM
	ReUGXPmzGHP3Qm7WNPArercaBexDuS0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-aUAJAXrNM5qmnI9h5LhHPg-1; Thu, 04 Dec 2025 13:46:13 -0500
X-MC-Unique: aUAJAXrNM5qmnI9h5LhHPg-1
X-Mimecast-MFC-AGG-ID: aUAJAXrNM5qmnI9h5LhHPg_1764873972
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779edba8f3so8143205e9.3
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873972; x=1765478772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUBrswfhXMKxoiMbjs/2E/mwb0mfQw6thKgxG+Tr0W8=;
        b=isnwbIYYSj5EQnXJACZdTwBl+NqBvf+HCYPiPaRdpp/ZBRFXf2IGAhlD3VEVk+SR9w
         fT7rtgHfuDaZLSXvtPrbopXqLicY69CDHp5wZpjoZ2IwDyFkobe2y6gY2D4SeCM5wrAJ
         HiUuPhH/khy0ypOVqDKOQGK1+MVml4AjIZIDCKMhty8EoVipC+W2artOjqLcR1SbInm6
         a4++jfrTDozORO75lHy6ucsObKxjegNAL4bUrZvaz6gmEGuVNI9WEcmyOVNv5kvRoJf8
         2KhYlmWKztMW9ayAeUOWNkQWFx95j9D0ebbFDm4C2Dh/pbrnZuMKCLmv9rW6+LLWeWB+
         UIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1uQmMQs3bi2Meu2RLls3aDKrC+Ln8+O3uGNoO40rawrVXoNdaoCXb9jNK5blOJzwKSMlB6eXvo25yIp+iZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvE4yTLONj8/PAaD3AglUEO6a6Qu6i7oh4FSWNQYAiye3lGQ/g
	E4XXaX8c42UgyKggoM8SviT7Yr4oH+WIZoqAPJmb+1o5WkXxn/G/uNptwgVq2/7lbaJYpl4KUT6
	3RUsXANQloyE8ylljoJ+cTjAtCUgBMSy/fmsFTeyQW2ycwPOBnpW4hVCUoqYZJ3XhZdl0
X-Gm-Gg: ASbGncsw9QxApn6/04Y+vOCD1L/EtPNF5SJES++G6LRAT6oT2oQu48D8PzwLQM2Qrk8
	9MH2gRAUHEt04wVpNCZGpRHhlV6Gt/h2aHWBp1YZbi4bEZc2oifGfJBBdlgGSGjeetO7oo3xSqe
	utcT6WPznvW1v7SQ4/WkjUKpv66vvag88sQGSokGHiWyGUxZ/CFAlMWh5oNAK3kyvxC1pz7INNI
	3uOMR9gvhXgRGuTk9DZohT7ceLMiwLl8zSECEYRY2iul8yMn5gcV6vTaskkoOJ/xOi55lf7fJrE
	eW/+KkBq7c6OsTVDphZcwOTK6bIgyXPkCpsEp+Vo/uhbl7PRmAzSUJ1QJizMOCecB+RYzKmoD3A
	=
X-Received: by 2002:a05:600c:19ca:b0:477:94e3:8a96 with SMTP id 5b1f17b1804b1-4792af30f85mr73641175e9.20.1764873971682;
        Thu, 04 Dec 2025 10:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMck1b/7j9CdSKQv88fkbZO+GSbbhnNzlp8eUH6kZUz5Q3+ty9Hi9EvFEywbY3mm9ClJPG+w==
X-Received: by 2002:a05:600c:19ca:b0:477:94e3:8a96 with SMTP id 5b1f17b1804b1-4792af30f85mr73640925e9.20.1764873971098;
        Thu, 04 Dec 2025 10:46:11 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d331df0sm4744049f8f.36.2025.12.04.10.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:10 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 04/14] tools/virtio: add struct module forward declaration
Message-ID: <c01b8d24159664cc8c49354088efa342ae9e7321.1764873799.git.mst@redhat.com>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h4tj8NQdXF2nZ89GEAuvbAX5AmAH62uR6pMx-fl5DOs_1764873972
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Declarate struct module in our linux/module.h stub.

Created using Cursor CLI.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/module.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
index b91681fc1571..b842ae9d870c 100644
--- a/tools/virtio/linux/module.h
+++ b/tools/virtio/linux/module.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/export.h>
 
+struct module;
+
 #define MODULE_LICENSE(__MODULE_LICENSE_value) \
 	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
 		__MODULE_LICENSE_value
-- 
MST

