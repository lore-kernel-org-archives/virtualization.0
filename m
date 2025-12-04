Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964D2FF669
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873972; cv=none; b=ZgGQDURbHgALmkkuXUynCm+/7H3l2rDgoPYxQbdaqRsbcZhKX40j6mhDTPo2OCe2qyAlUf3+sVQrM2sNDtiqtnlxuZ6aVfqeGrvFDp+RkWGqUsldamZYNGSpxUaIXOG27q9s2hJZ1b/heDckEM5ZZDA4bhB5qDdwtGXhZnsD2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873972; c=relaxed/simple;
	bh=XOvFcvXWHbbIZiYga991Ws6FE79FAxnpaQqR3UetRiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZLh+1kr9Fr+syJ7BK9jrboOLiMUoLvjrlCc/i7M5MYBV6a0i142o2NgcpKmA7TyVGhG2KkFhAEyF1IbUUgZFQgOPBie4Zi6sH66kLLTMWqsEte5izt4Y7ZKS3dkBj0ElUMetIDTwCrkSFZRilsXfNUPqrwL6h3EhhtrxpJqLk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3MubnOo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3MubnOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764873969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2bO62dhGLwejL+h82rjog5nZZiQ4P34iBuwcHHX4kxQ=;
	b=a3MubnOowFL9BD8UDXn7Tmg12uoKAmHdke13dXWByr5dgzHF2hi07stOSmarRpqz8zyS8g
	6XnmQMC7Aod2OhgahpjKbPwKZq7hhW6XhimywE5ft2yRZAslMZ0EzD7CiPuvI6LoOSjOz4
	II8nt+ZeVcwiBdJRBfumJqctVjUwCRw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-F_pVLRqAMRewsDQgNWBsjg-1; Thu, 04 Dec 2025 13:46:08 -0500
X-MC-Unique: F_pVLRqAMRewsDQgNWBsjg-1
X-Mimecast-MFC-AGG-ID: F_pVLRqAMRewsDQgNWBsjg_1764873967
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so7894855e9.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 10:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764873967; x=1765478767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bO62dhGLwejL+h82rjog5nZZiQ4P34iBuwcHHX4kxQ=;
        b=dqFWHn+Wta51F9Z0P0P25FBhc+K4r7Ee2VeKHJIM1VDTRpLWNP2v1BGjwb4W3jqwZU
         CmDRneHn8SoFB42zVaClaR+8tZljum0SBSO5+8vsRI9c0viAzjHSUq3yx849tF1/69dK
         Z+sF05lUx9Q4btvVzbxQslSt/giE7TE0HfoAtnoS3DCiItDwHfweYR87BnImyhxCtnXh
         QKgS+HDeAiaDpzD0OE5LKAQvxJWhrO49CVGkU48x5m8m4xe5F7un0brOTDCWv0zfisPZ
         W8hkfpaKDtmsf0xQi+u1qBbSGIN+VoYiSDI4Mlb6rkC4MLlfJUvNwKBQEi5Wm7mC6Vw3
         2pUw==
X-Forwarded-Encrypted: i=1; AJvYcCVdce8YNt5IuAOo9nJb7A9MISf08KkQ6uT6yvG2MAHoCYbDx/RWUUCB2pej2C1/VfsOspQ4T6dfL4+E2MWxKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLY2g2Gfif5IfboMx3fCNQeFrmADEjvVla/p02fU08ARmnpSvy
	+z5mvmzdkvVvCTMh5r8BUTUVhWF6frSTP2QEj7sUpoWR2W7rF7QpYzf2rg35L+kZdS8kWk3tG9S
	h3Pfrk4qUqEART//r/NXPGILT7a6ojwtH0FljAU2AfqXFCn41s/j1X/iD30Nxg5NRSBW1/DN17l
	eI
X-Gm-Gg: ASbGnctdqEmNyLLH9AsREgUqXw8B3qKvvcLKbCWzvgxLkCWfIhOG24I0uLSzHDhfPlJ
	QrKabvfAcDTef2KzTaJ9J9dD1NjIKjcxH5CEoiGzpmBxTVH5m1AdPllH882rG4K/w8Do27k9rdA
	MeY8tDKbW86CMeDOG+grmSNlHEFDSTr14HQXWtd4CL+PkOm1V9icV0OzWI0oIZE6F2I2yTuxtNi
	MG6zKmYvvZ8hm1NGQdkwVvtPGfVC4YpBEmkIKJss9rGXO7aIuOuurCPUqRwck4G7ykYX9Ni4GcU
	Bync7yKTIKFe2r7g6WYYgavnBnJiv2RoAQCqCqLj9XTZCxbpy3fh+WdzAK2Gwy0pBlFs99d5vss
	=
X-Received: by 2002:a05:600c:1c0d:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-4792aedecf6mr82009555e9.4.1764873966666;
        Thu, 04 Dec 2025 10:46:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP0gDv4wVR+hz/ewsHvf5Y0f/iEBUayPg9Yadkr1yyJv/LA/EfgN5XPvfNHZhBNUXCLl+L5Q==
X-Received: by 2002:a05:600c:1c0d:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-4792aedecf6mr82009265e9.4.1764873966171;
        Thu, 04 Dec 2025 10:46:06 -0800 (PST)
Received: from redhat.com ([31.187.78.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930c90e67sm44952945e9.12.2025.12.04.10.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:46:05 -0800 (PST)
Date: Thu, 4 Dec 2025 13:46:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH 02/14] virtio: make it self-contained
Message-ID: <9171b5cac60793eb59ab044c96ee038bf1363bee.1764873799.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4uJWfEb9URwkLuHHgVZSuxtRzY3bI3mCBljAH64ubEA_1764873967
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

virtio.h uses struct module, add a forward declaration to
make the header self-contained.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 132a474e5914..3626eb694728 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -13,6 +13,8 @@
 #include <linux/completion.h>
 #include <linux/virtio_features.h>
 
+struct module;
+
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
  * @list: the chain of virtqueues for this device
-- 
MST

