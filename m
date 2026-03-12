Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28D390999
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773312709; cv=none; b=JTaACKCpajRL+4pSLXp8b03aDCVrwps9KNh8iKmXhNabgdFmlzEdT8nmEvuncDUKpl0qBAwFMHlVhfUWuszu6QlCU//3d/1kTcBOOXorokkqNx2UT6v7tnCAKHJxbYoBgvPP36OFUzrecwUE+VVdGVbsolcXteBxAnTBJJiWMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773312709; c=relaxed/simple;
	bh=r29hAxrbF+67wOT89L6BwuVdSkbuIkd93KeqR4v0D80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ednb5FNHeAvXsePbrZmjaxvU6GBh74GWDnJQV4yTykAY6sGaMn4olT/5obctVM5NmB+2nj6a9NJssMWUp77D359H6oR+PIqjxWxoixzOh0OedtL+WEpFrF2zSk4x7tK4gvKd5t7wNupLffBzvuHYhmMpOVptF4jS/l3D514DkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtCTcf6W; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtCTcf6W"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12776bebe9fso25110c88.1
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 03:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773312707; x=1773917507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vudMoe5tbm3Vk8y6iv0PO/6UeQcWquJrU0HrAJAdUN0=;
        b=UtCTcf6WHKFyyQoT2AbevpYjMH3U08+jAXxuQCuXtws/xQvYEy97CZ+NUbADwrBEAf
         tKBP6r+9ZZa+rkQBK75gNpoNVoeqHq4dOlPS169gUloa5kRk0u20CB9e6oYBw6bhQqby
         gj5diRysLhhPbu88W6tycoeIwVzDV58gdp3j08DmBT6ot+ggYjUIjwjDo+b7suCtOfgl
         yhKmOfrETBnqldDRn5fN9M8rOjqL7dVpRj54vgntXGMivSfy2XRw8a8IsBrggtd6c1DR
         A++G22F4wyH+sLBOYS1skkvh6pJJxJc2xZKQY6q+GjdBVChX7vsvIDdfXrBYZ1uEKV00
         9iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773312707; x=1773917507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vudMoe5tbm3Vk8y6iv0PO/6UeQcWquJrU0HrAJAdUN0=;
        b=wqTFdCyoFX1WQLXdZUQnWqm0JqtdfMpi8JuHpNgDzrujxPukaoWJXCVpuhNSLxHsmK
         eRNZMx4Y/iYwGqbG+Ik18UNYeTbu59Nm/dyilRlP+tdXS60FrT1pQTSgQ6hf+8wSAL2V
         dzr8Gsym55uxev8aRcwu1kGvJhCkQlyqVubtdunvtV8FofP8XGS6phWbIOtNtaaT8TQk
         2JrMvvkKUh/zi6Vpl/qgH1LezDjqOV9Wudevsx0eB0aNiAuFqruPtoCUpdATny1RLxPW
         i6V2roQtciI0hzsnq193k+9cTllKJmsAZKPRhwQ3p3H/BVLcUtfHD7dnJjmgbxQf6515
         7dPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVu07AGIbbWI4Nt8tq2FvfKRjrHSHklXzmSeIrKNGeX9gCI6Ur/ieKIe2RRdIHRF6/2wRPp7YHvVKxV7vKDA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoK0MyekhkEI+EVJfhuOmsxlM7H95KFH7iff98/BeomvBzW2K4
	uGJbSg+Ia2uFXX1JPjyCp2O+xeBi83P7hPc0BYYAv0x57+Zx6iavU7lP
X-Gm-Gg: ATEYQzyH/KjBstan4c1S1HZdalp1m/c87QB6BQtysseH+sVd3ZpXfSn9VAxfwsAaIZF
	A8d+360mbnAQnPLbG4c8uF0sG/3jAyvJqryIRzYY/PrQMzSXMeCEn2WoGhi9eIcXerXhCdMqQK7
	k+GK5TNDIo2vSavYgCuxzBkW5izMBFDczNBkJ21DgKESgiNnyYOGzWo7ZPK3FIE28o7UO/U9jSW
	IixP7KZQO8mG1A550XZOkCqfEf110J+m5cMQZwDOXI4bAgtc3dOUl8TKoiVzc1w4nSWWKVcTJb0
	edrcLcclfQFThHhB/5XzPHQO1XSgsDip9yEKobaYdMbUqW7Xv7dLRePFLE41dTyslbmztRqBoOZ
	fdzDUp4fSRjCjnrpRjhqLXy+madHk3cmZchmmARjatvcExal6+e8syHUk+X0/QR6fhCygvatxck
	ZoGPlnvIQvbwsfXDIR
X-Received: by 2002:a05:7022:30d:b0:128:cc34:3616 with SMTP id a92af1059eb24-128e77a5612mr3112793c88.14.1773312707180;
        Thu, 12 Mar 2026 03:51:47 -0700 (PDT)
Received: from localhost ([2804:d56:12ae:b200:67de:4395:bbdb:5257])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128e7ce52aasm7936152c88.15.2026.03.12.03.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:51:46 -0700 (PDT)
From: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kenner.linuxdev@gmail.com
Subject: [PATCH] virtio: fix kernel-doc warnings for virtio_device
Date: Thu, 12 Mar 2026 06:51:39 -0400
Message-ID: <20260312105139.60811-1-kenner.linuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following warnings were reported when running 'make htmldocs':

  WARNING: ./include/linux/virtio.h:188 struct member 'map'
  not described in 'virtio_device'

  WARNING: ./include/linux/virtio.h:188 struct member
  'VIRTIO_DECLARE_FEATURES(features' not described in
  'virtio_device'

  WARNING: ./include/linux/virtio.h:188 struct member 'vmap'
  not described in 'virtio_device'

Document the map and vmap fields in struct virtio_device.

Also avoid kernel-doc confusion caused by the VIRTIO_DECLARE_FEATURES()
macro by documenting the logical @features field.

After these changes, running 'make htmldocs' no longer reports warnings
for map, vmap, or VIRTIO_DECLARE_FEATURES().

Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@gmail.com>
---
 include/linux/virtio.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3bbc4cb6a672..074d36453177 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,11 +157,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: virtio specific mapping operations used by the device or transport.
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
- *		    device.
+ *                device.
  * @priv: private pointer for the driver's use.
+ * @vmap: mapping token passed to virtio mapping helpers and transport ops.
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
@@ -179,6 +181,7 @@ struct virtio_device {
 	const struct vringh_config_ops *vringh_config;
 	const struct virtio_map_ops *map;
 	struct list_head vqs;
+       /* See @features */
 	VIRTIO_DECLARE_FEATURES(features);
 	void *priv;
 	union virtio_map vmap;
-- 
2.43.0

