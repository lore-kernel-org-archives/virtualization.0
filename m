Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891392;
	b=1cOBOQk7AD6ZufMRn8/dZCB77JdQEWiOJ/DjY/4yA6bA3qJmA1rmdr9Fye8RkjuCW1RS
	 aDC24fZ//1gia6waQpn6RpfabSnPF6V1O62bQHNjZT6kISeRvUXZ0a8VeyxRUP+Px1C6P
	 tLSBwk9pM4teffz6qasrR4Pc2gAsGq13U8uTyG+G0jj9uhGWzoMnVkqlG+pNHv67V6eJm
	 SnR7Zze5FGG0KC4gHOvCiJ5yzxFwiFFS5bVg/k8mu7ocdGPHmyr5jXyBh0SKrOA/pJZWM
	 kywR5ZOzVB1nYOHIcJcfD8nJv2MwTQwICBT4It/5a4gBgSJUNyyeem5E2nVq5YHw3dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891392;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=4ggaaPWZDNxL0DAiqx5vNcK9rDHloEyp1DjKsZE36cA=;
	b=yjjFHPhu9c48ow/e4Sig+zFjJ2A1lVOksLCNZXRY748aKQqlgb4l9gEF+lXEVeHSy+yJ
	 ZTaba01ztYnvl513diirQdEAk4jllHSrOLqNRKhY1SByhRJoK9elebZM3syvuXbAIwStC
	 wHczn0zCVtQvktgxswRbRUHSN/9199CnFJt4+hI7oIeySzl2uwlxktu5a5wSPuFqi9B11
	 ZnQgJVA+1Yl1OsF59Kz2b5AhysmkHBEXwKegYAVPXbsgkmuwGn1MoxU/2TWKxE2ZfK/pY
	 MnUi0JKW4pVS2anf1fAJ+JwL0FqCg/9CFNaOat58BXsDetC1SIHP4HpCyM2maPDbo/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uat4lrdh;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7B606D827
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F7B606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uat4lrdh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793891390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ggaaPWZDNxL0DAiqx5vNcK9rDHloEyp1DjKsZE36cA=;
	b=Uat4lrdhyxtA+zQSBvX5PjRTXJwZcEDkVel99qLNPbaAQW2n1nP4B4Whnn6okCCc2IuAQr
	TqlslBfC7KemwIF5k2tQfM+heGIVF3XFX0zzWe8xyfncFrocr5T8CsUCscurqO1YDoNpde
	QYuYV97T+TWvS9kYkS3eSg2y/ZXC5LE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-dqQfoMk6NDiAdgex183LNg-1; Thu, 05 Nov 2026 10:09:49 -0500
X-MC-Unique: dqQfoMk6NDiAdgex183LNg-1
X-Mimecast-MFC-AGG-ID: dqQfoMk6NDiAdgex183LNg_1793891388
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df02b91f9so493232f8f.1
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 07:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891388; x=1794496188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ggaaPWZDNxL0DAiqx5vNcK9rDHloEyp1DjKsZE36cA=;
        b=SliA0AiRq7lMKSJS62IfHDLVDPj/VIORrzTXIgY8dj9ikCw08rsAxc5kbP1osrHw3W
         FohnY9yeQTUtftlTMWAxY45QMJE5ThznozzxCMZA1rJvNtqsFdcuDrYke7tJJ4NMtI1J
         +Xl34tw3pTkPwIJq6VCIHbdDIDvDMxcJoE6r0ksjViqi5Qrvq06JCVfDslgfW0SE+c3q
         FYZCa4NTcmX0ecfpTwyw1QIAFQ35IfhEYoIosUYkaoDl0WUGEd3hv7ueSnqVyrXg6Qqg
         xh8SbyNtXv6rZfTl80QX5ABDxuR+71Ei3W00gXAS/EjeEFx6Uvf61kSdHYvo6z2rAvtR
         GtFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPfIDhv0kdRuXrQoZA20oCfEbDPpafvB6coOJHr0gPGMg8/ROUhSUlIIjpcditRC/FDaObxOo11pnP7ttl0A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+PYQQYfP3/mt2PvSg1E9cFiclPut3LNa2hR60H8hnvN+DzQsfB
	Qnx2KZrIxoxF0QaE9aCnNdpdnDNPuDwIp18/EcYTFXMSQW/1YyGLDcjw/dB1M6W7T1tjmJ2LHjr
	45yrR+PBACS4gewUdhzjf2JTnchpYRaytKCK+TsFpe9IVHbNoe7YusTVSEOhxIlKxuf7ZZTOOkD
	eL
X-Gm-Gg: AYBFou3qvxj8R9eL5KcXVOgodLc1CTM1PhybiTvDIosTodIsBnVsnLKkZEG+fMS+Xci
	f52QAxfo03dwYOGtLHwQEeGonp/bNLtQ4gwszp7CLa5RIdjC+07DRlhIWmOHnKPKM8XEf0gZvxb
	FGIv+5pCWWWqdGM8g5tIusAfZ3K1A9ABxTepyFYguBT+/ORBOP4URK0+GMXETUqhDtMejJie8Ou
	ZEo3z2Xf3M3Vdc9a0IGuGkdw5ePH7c08jVL8w3mZUgJQ/AeILbwPZEqgw9KdokRFTnZZ4+evtZS
	J6WcKUMPsbR5D79tOnj/nRdcveM6z89ZXBcdTxmCIAal5muzXO0d2t6glZdPdteR3U6Kgp/HkYG
	fLQtYu8YTLydl9rohZRHZJJVVvI1zXBh0nbKJt8HZYDOh+IyliunSQOY3pdZ4uXvEeZ/Ce/uJtc
	Xja8h9Cfbp9iud+ncylC9ItJpTbnPjsAgYC6auTKVk7vc=
X-Received: by 2002:a05:6000:4552:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-49115c978eamr3205041f8f.13.1793891387707;
        Thu, 05 Nov 2026 07:09:47 -0800 (PST)
X-Received: by 2002:a05:6000:4552:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-49115c978eamr3205007f8f.13.1793891387238;
        Thu, 05 Nov 2026 07:09:47 -0800 (PST)
Received: from mszeredi-thinkpadt14gen6.redhat.corp (188-142-154-142.pool.digikabel.hu. [188.142.154.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm9961340f8f.52.2026.11.05.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:09:46 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 1/3] virtiofs: fix use-after-free of fs->tag on device removal
Date: Thu,  5 Nov 2026 16:09:40 +0100
Message-ID: <20261105150943.86650-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105150943.86650-1-mszeredi@redhat.com>
References: <20261105150943.86650-1-mszeredi@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T7KRYFuOiZaafoouZiwqochzoxrctv9QsyH13bj_1qY_1793891388
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The virtio_fs object is refcounted via its kobject, so a mount can keep it
alive well beyond the lifetime of the virtio device binding.  The tag
string, however, was allocated with devm_kmalloc() and is therefore freed
by devres_release_all() as soon as the device is unbound, i.e. right after
virtio_fs_remove() returns (see device_unbind_cleanup() in
drivers/base/dd.c).

virtio_fs_get_tree() looks up the instance, takes a kobject reference and
then drops virtio_fs_mutex before doing the sleepable part of the mount
(allocations, fuse_conn_init(), sget_fc()).  A concurrent device removal
can complete in that window:

  CPU 0 (mount)                         CPU 1 (remove)
  -------------                         --------------
  virtio_fs_get_tree()
    virtio_fs_find_instance()
    // reference taken, mutex dropped
                                        virtio_fs_remove()
                                          list_del_init(&fs->list);
                                        // driver core unbinds device
                                        // devres frees fs->tag
  virtio_fs_fill_super()
    mutex_lock(&virtio_fs_mutex);
    if (list_empty(&fs->list))
            pr_info(... fs->tag);   <-- use-after-free

The virtio_fs object itself is still valid here, only its tag has been
freed behind its back.

Fix the lifetime mismatch at the source: allocate the tag with kmalloc()
and free it from virtio_fs_ktype_release(), so that it lives exactly as
long as the object embedding it.  All probe error paths already drop the
final kobject reference, so they are covered.  Merely dropping the tag
from the error message would paper over this instance while leaving a
devres pointer embedded in an object that routinely outlives its device.

The other readers of fs->tag are unaffected: tag_show() is fenced off by
the kobject_del() in virtio_fs_remove(), the automatic KOBJ_REMOVE uevent
is emitted from __kobject_del() while the device is still bound, and both
virtio_fs_add_instance() and virtio_fs_find_instance() only walk instances
still on virtio_fs_instances.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: <stable@vger.kernel.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-0328b3a1-043b-468e-8425-6a613d91b5ef
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/virtio_fs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba8d79c4bcac..ef58bedc3941 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -193,6 +193,7 @@ static void virtio_fs_ktype_release(struct kobject *kobj)
 {
 	struct virtio_fs *vfs = container_of(kobj, struct virtio_fs, kobj);
 
+	kfree(vfs->tag);
 	kfree(vfs->mq_map);
 	kfree(vfs->vqs);
 	kfree(vfs);
@@ -489,7 +490,11 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 	}
 }
 
-/* Read filesystem name from virtio config into fs->tag (must kfree()). */
+/*
+ * Read filesystem name from virtio config into fs->tag.  Freed by
+ * virtio_fs_ktype_release() so that it stays valid for as long as the
+ * virtio_fs object itself, which may outlive the virtio device.
+ */
 static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 {
 	char tag_buf[sizeof_field(struct virtio_fs_config, tag)];
@@ -505,7 +510,7 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
 		end = &tag_buf[sizeof(tag_buf)];
 
 	len = end - tag_buf;
-	fs->tag = devm_kmalloc(&vdev->dev, len + 1, GFP_KERNEL);
+	fs->tag = kmalloc(len + 1, GFP_KERNEL);
 	if (!fs->tag)
 		return -ENOMEM;
 	memcpy(fs->tag, tag_buf, len);
-- 
2.56.0

