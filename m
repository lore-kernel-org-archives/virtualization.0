Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A536681F
	for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584305; cv=none; b=B7yDrKjG04T8E8EDUDsenSz7z9JnBwNfWkvG2l/uuglyoyJxNMP6AsKx3i2gSrwCfmeicY4TxMnKw35QX8Svfc17gfOcGtnSor3ufZ0zgucJu2H9LnCFYmVgU7BI663Y9fy+Tz67k5lQqS2uyXpTsDecV8LQtIO9rw8p7Rmn0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584305; c=relaxed/simple;
	bh=Y8fUBbvyzMQviIAW9sd4PkX24w/Vd0VYkVpKNberqqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LrmBWOzeMh3TovSii8KH8Eqpnm9MRHU7M8118iphw9u7L72to52/t++tStzUmB46Epr7D3iLs6i7XdvHyGThOZtOwP3jiuBiGJATirP0lDAFX9ys3JlsnPF51G4EFcpnQ6hO8npuYs86jdGVzfrvEXSEHpQQ+DOOFh6pb0DhFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com; spf=pass smtp.mailfrom=openresty.com; dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b=doAtnTNI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openresty.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b="doAtnTNI"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829b2019b39so1947770b3a.3
        for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openresty.com; s=google; t=1773584303; x=1774189103; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fnEVg49IYI7HJLp/yxY4lgc89fYbkbBOZ6L8Tars9Cg=;
        b=doAtnTNI43XdeP964DnYBbyVPylku8ygeXLrIZ+qy//iIg5OGFP3RYEURM4TBGAAzs
         i5g1ilf9IvAQbMhkpbw4RS2r5KqzvHO97NwUW135SqrHCIPUVLrx4DbUbs4yuKDrd637
         9ep8BpcRPtNlJHGjU6wtgBD5IGZqUI+4OihpA8yHfsc9rUB6k2VbQOffAXfPk3oUS084
         CRx7piToxPsisbRfcMDUa0IlbeNxYSSyragsNIh+c6jIxZnRD2lgLV5SEZBzBF4pqTeX
         PwaQc3IpSZL3PfJFv7SCV2BBSIrFKh6eJi0SgmxPb+QnMQK11ovj6U0Yi93yBqwEOpll
         s+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584303; x=1774189103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnEVg49IYI7HJLp/yxY4lgc89fYbkbBOZ6L8Tars9Cg=;
        b=Ed3L6hNzTWaeqXkxadwcX3EHrtNTXb+7KDUv9f8HU5tvC3yiuAZX4HKcC8JHFAl98v
         EwMvq5e/fb4d1GQyj37X+MCULfr1BWAyptyRKtRldXHAZXXM2cMr8lzsGp1i22yWL45X
         wFdPgmiWI8e8XGpLp872YqeAhZXRsGkQ54Q4nqYQszZUiIDEiB27r5yyfR9lxz9rggJd
         yxmrVd4LJJwRJqAh5qGGpO17fBV8l1ikwVbF3PKLsLlp5Feix8BGXHKhhJdn5zh9S5Vm
         VpP0blf1op2sbzdoYHKQM/g9AGSCKrzwFjeA8fVPKArrW21qeOlvejgV6WtAny5o3Wvn
         dOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtufYUM3bUsgQkMWjMtvO7XRmoKBzdZQ932riM4TzIg0iFC12RHRnZHbksWxjWCjv6PEPG6aw7/izO3F6V0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv+h0Y/LNr6x3R0L9BG1KgHi99Wqo+/c6BZL2JFxs6mi0An0j8
	FlA6ogogI0bLw9ff+zoi8SGqDi4Vgr7JfHd+nbEd9VrTwQ/+hTU5yoXTRtaCTuiyUZ8=
X-Gm-Gg: ATEYQzxNkHxKijpjIpHxjNw5+uS+fZ+1Z+KRd1S1jpA0MZ1fxraA53vVIiyXRuYev09
	OGshabwAATiVrF/cmPOdN5Q3eQ0bLubbfDPksRZvWi/TGUQYFH2qo0EqXw88js8FjMIotbQJzN8
	rIi2IHbFJKmvIIHo2Dqnh6yN1u0yZ96MPzZ3pz96SY+SiHTco1hT/xLwN9jFRjtWKye7Nsq68dw
	eAK+uFTFhxhqwG89SfCZhkHn4haIl2owllyt1U9a1urGSBLBZwNYagjV1Q+GkVyhKCtNU3Y4jhy
	gVDQTRxVU+g6g+sL48qDiJ/CinsKP5eJYN6TpnO3dOLrWVZ0HqcYfn4vrq0lzEmLy1oWtp/XBI7
	exmyOLmxqzpYqRBP/98u7tPHLsf3LsTQ1lTHIGvfnwdHOAZfp0M9bAUybSV02FbA8IYVCkblPYX
	HvUhEK1XDr8ev7BtKq+rPo5mifp4lMJf7GVWHe47pi6F2d8cI=
X-Received: by 2002:a05:6a00:4196:b0:82a:ea3:c172 with SMTP id d2e1a72fcca58-82a198f68f3mr8174011b3a.46.1773584303210;
        Sun, 15 Mar 2026 07:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:8780:1329:fe1:ca3e:1abc:522f:35d5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725e0cdsm10871428b3a.16.2026.03.15.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:18:22 -0700 (PDT)
From: Ammar Faizi <ammarfaizi2@openresty.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Ammar Faizi <ammarfaizi2@openresty.com>,
	Yichun Zhang <yichun@openresty.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Yuka <yuka@umeyashiki.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	David Hildenbrand <david@kernel.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	gwml@gnuweeb.org,
	stable@vger.kernel.org
Subject: [PATCH] virtio_pci: fix vq info pointer lookup via wrong index
Date: Sun, 15 Mar 2026 21:18:08 +0700
Message-Id: <20260315141808.547081-1-ammarfaizi2@openresty.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unbinding a virtio balloon device:

    echo virtio0 > /sys/bus/virtio/drivers/virtio_balloon/unbind

triggers a NULL pointer dereference. The dmesg says:

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    [...]
    RIP: 0010:__list_del_entry_valid_or_report+0x5/0xf0
    Call Trace:
    <TASK>
    vp_del_vqs+0x121/0x230
    remove_common+0x135/0x150
    virtballoon_remove+0xee/0x100
    virtio_dev_remove+0x3b/0x80
    device_release_driver_internal+0x187/0x2c0
    unbind_store+0xb9/0xe0
    kernfs_fop_write_iter.llvm.11660790530567441834+0xf6/0x180
    vfs_write+0x2a9/0x3b0
    ksys_write+0x5c/0xd0
    do_syscall_64+0x54/0x230
    entry_SYSCALL_64_after_hwframe+0x29/0x31
    [...]
    </TASK>

The virtio_balloon device registers 5 queues (inflate, deflate, stats,
free_page, reporting) but only the first two are unconditional. The
stats, free_page and reporting queues are each conditional on their
respective feature bits. When any of these features are absent, the
corresponding vqs_info entry has name == NULL, creating holes in the
array.

The root cause is an indexing mismatch introduced when vq info storage
was changed to be passed as an argument. vp_find_vqs_msix() and
vp_find_vqs_intx() store the info pointer at vp_dev->vqs[i], where 'i'
is the caller's sparse array index. However, the virtqueue itself gets
vq->index assigned from queue_idx, a dense index that skips NULL
entries. When holes exist, 'i' and queue_idx diverge. Later,
vp_del_vqs() looks up info via vp_dev->vqs[vq->index] using the dense
index into the sparsely-populated array, and hits NULL.

Fix this by storing info at vp_dev->vqs[queue_idx] instead of
vp_dev->vqs[i], so the store index matches the lookup index
(vq->index). Apply the fix to both the MSIX and INTX paths.

Cc: Yichun Zhang <yichun@openresty.com>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: stable@vger.kernel.org # v6.11+
Tested-by: Yuka <yuka@umeyashiki.org>
Fixes: 89a1c435aec2 ("virtio_pci: pass vq info as an argument to vp_setup_vq()")
Signed-off-by: Ammar Faizi <ammarfaizi2@openresty.com>
---
 drivers/virtio/virtio_pci_common.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index da97b6a988de..164f480b18a6 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -414,28 +414,29 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors, desc);
 	if (err)
 		goto error_find;
 
 	vp_dev->per_vq_vectors = per_vq_vectors;
 	allocated_vectors = vp_dev->msix_used_vectors;
 	for (i = 0; i < nvqs; ++i) {
 		vqi = &vqs_info[i];
 		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx, vqi->callback,
 					     vqi->name, vqi->ctx, false,
 					     &allocated_vectors, vector_policy,
-					     &vp_dev->vqs[i]);
+					     &vp_dev->vqs[queue_idx]);
+		queue_idx++;
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
 	}
 
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
 	vq = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
 				 avq->name, false, true, &allocated_vectors,
 				 vector_policy, &vp_dev->admin_vq.info);
@@ -476,27 +477,28 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	if (err)
 		goto out_del_vqs;
 
 	vp_dev->intx_enabled = 1;
 	vp_dev->per_vq_vectors = false;
 	for (i = 0; i < nvqs; ++i) {
 		struct virtqueue_info *vqi = &vqs_info[i];
 
 		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
+		vqs[i] = vp_setup_vq(vdev, queue_idx, vqi->callback,
 				     vqi->name, vqi->ctx,
-				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[i]);
+				     VIRTIO_MSI_NO_VECTOR, &vp_dev->vqs[queue_idx]);
+		queue_idx++;
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
 		}
 	}
 
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
 	vq = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done, avq->name,
 			 false, VIRTIO_MSI_NO_VECTOR,
 			 &vp_dev->admin_vq.info);
-- 
Ammar Faizi

