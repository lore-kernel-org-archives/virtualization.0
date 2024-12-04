Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE820A5C8
	for <virtualization@lists.linux.dev>; Wed,  4 Dec 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316921; cv=none; b=gHicBxwjyrBodjJbMbD5C/+bHn7CS7ti1Oc+IZRUlqg1A99e+OmbFSyFTf2kWmJ3SFARh1dz20v4xO3VFDKVOs5cqOp+9VIiAl+D16VrO0wXP8PfSr+rGEY6wXoMh4IqxemAhDBWVQgKuY9QptBM8N5P2XYacHJ2xwZEkp6Xbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316921; c=relaxed/simple;
	bh=+kw0hVN/R7EKfAHQdf+parzKCkCR3tVH/e099GIq3Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=j+utqODq5yyKCxvh42SWb1QZ4xAIoxKAzc0vA0O3xYzkRUNeC4UoyRERHlavjVen/5lrEayJUg8i0HLaE3Gcqg3ftcPG83cxepor/7tLl6cTpD+wd3VkezLXnhSuqzX4KrHOjTgr8VFg9ubQ3f7zMhA9xXeaGiLMy3Ugk6o3agE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUrsgERq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUrsgERq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
	b=SUrsgERqY9fyu6gaalnXVg6vtfK2e3nTFV1mtgH+aGoVDwfQUj2ycFCD15Zevd9L1rBUQS
	GSUJxvWS6qnzvo2A4qZIomzC+rI53B128diHOFJq3nGhkOLRZ2oBY5XOAiB6Extz5kAORm
	RR0aHzlZ43y4hbPqx56/UbRuToGoDB4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-E58pSasONOu_U_DgJsRFHw-1; Wed, 04 Dec 2024 07:55:16 -0500
X-MC-Unique: E58pSasONOu_U_DgJsRFHw-1
X-Mimecast-MFC-AGG-ID: E58pSasONOu_U_DgJsRFHw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434a4ad78a1so55294035e9.0
        for <virtualization@lists.linux.dev>; Wed, 04 Dec 2024 04:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316914; x=1733921714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=na4vd6mThSkzeb6NVT06w3pd7mJ97fz8U44/x2n2hr0=;
        b=uWh6PWfdyd7MqAnCE9zyrK5ZdvIBlh3rMBIrjuwIGPDVMVVpVKokKYXZOz2xZC/Wlj
         KXp+0v1SeHRP3bXzlWnQuBJ0QnsMkUOfNcnj/f3DsfsQ1V3RfEy8P9nhH39KFXoiz97i
         NSKNaf4/aV/p46Vgy3+aunJIRpLrPXqKhPSmgRW6dhouZl8sqi3W1xyj+XnyEB1KMozg
         yN3UJLvNWz6vJADOgtki4AC5OR0MT72XS4peJdLdpgPG23CAI62GbQE6EeY9LJ5xf+d+
         gEG3prNCwMZ/gVKpMByKRitM6mRVG27r9JPZt4ZH8S783ThdSAakAmkr5djoTQHUKYBW
         EyAA==
X-Forwarded-Encrypted: i=1; AJvYcCV0DF3n/lXr4keV/RiiWoJqrnmA8UNEUnY8jJXT3J8eUdl3P8YoJ7wFsIsbxo63JRXFYwbBrpdeCP1gniKqAg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo4HV3KCNYZPL3lVhMM8zmPcdFeqOmWYuYZK9QCVihRH44s1BP
	hHkl2YhdT0ju0fAXr0eoT+4oYXgO9GmfBbOnOp0m4cjwSJ2OUaRP1SqzToqWggHH1OcJ2Ly4HDW
	oTYQ4GAwPzfmTdPnLpKlqXFkmNWn5PGgvuG7i3yFI37dCjsU7/9w7pgFrK4dBSQm6
X-Gm-Gg: ASbGnctZ2TCPox0D3clhMuhUXvV+v+/rzyoZhM6L/zC/6qR/PWJYeGAK5qlvtmgadp2
	7uWEu6UgMot8463lT2WmCsF0ArLupBy26aE8qysN2xoi9F3dqUWmB1IKCB8oSx5JM95rn1hm3YU
	U9ciGFraimnVVM+Wj3l/IUZCxvK/lpJAgBG8XDWSvI2GCXUVMk977N+IKPWat3PbX8yHd0FcOil
	eoKI1Jgwa8Ap1LQWcAw6khzJJ8D/cv7DcEnFAlTUSIhx4pyH5Xwdo9L/JPPZj1UTQ7/z7SZ4222
	Zbg4wZwbcEAJKSbzUoYMl2bEY4uFCzQIwXY=
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62644335e9.30.1733316913742;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdVB6YFjtubaQuZKYqVl7K3swrZVKNM9mWRen9YVYSXicgBrRTJ3zdugRU4fK2CCWYQJl/Fg==
X-Received: by 2002:a05:600c:3550:b0:434:a781:f5d5 with SMTP id 5b1f17b1804b1-434d0a15047mr62643915e9.30.1733316913375;
        Wed, 04 Dec 2024 04:55:13 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385df488559sm15210226f8f.63.2024.12.04.04.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:12 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 09/12] virtio-mem: mark device ready before registering callbacks in kdump mode
Date: Wed,  4 Dec 2024 13:54:40 +0100
Message-ID: <20241204125444.1734652-10-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ku6DW87-NSwx1s9HdtpOCyu546A7oH_HQ68UG8Sil0w_1733316914
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

After the callbacks are registered we may immediately get a callback. So
mark the device ready before registering the callbacks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b0b871441578..126f1d669bb0 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2648,6 +2648,7 @@ static int virtio_mem_init_hotplug(struct virtio_mem *vm)
 	if (rc)
 		goto out_unreg_pm;
 
+	virtio_device_ready(vm->vdev);
 	return 0;
 out_unreg_pm:
 	unregister_pm_notifier(&vm->pm_notifier);
@@ -2729,6 +2730,8 @@ static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
 
 static int virtio_mem_init_kdump(struct virtio_mem *vm)
 {
+	/* We must be prepared to receive a callback immediately. */
+	virtio_device_ready(vm->vdev);
 #ifdef CONFIG_PROC_VMCORE
 	dev_info(&vm->vdev->dev, "memory hot(un)plug disabled in kdump kernel\n");
 	vm->vmcore_cb.pfn_is_ram = virtio_mem_vmcore_pfn_is_ram;
@@ -2870,8 +2873,6 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	if (rc)
 		goto out_del_vq;
 
-	virtio_device_ready(vdev);
-
 	/* trigger a config update to start processing the requested_size */
 	if (!vm->in_kdump) {
 		atomic_set(&vm->config_changed, 1);
-- 
2.47.1

