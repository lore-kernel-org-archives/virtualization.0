Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A678F2E
	for <virtualization@lists.linux.dev>; Sat, 28 Jun 2025 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751137137; cv=none; b=nDuYhdvpKUDvD/i/MDCWMmm2se/DRbcdHEOFmfF/pOqIXfzD3XVWlTYzy1UX3gdlpwRKBjJQa36G05ivc7DYQZ/svxvvSB2MxFmy1NbskEcFh9B7jQjUEzIMQ5cOJLXzIYoXR9detw81ULQxxWEPxQtcDHTKSEp8rvdO/IJK0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751137137; c=relaxed/simple;
	bh=ztg5EsMbdjxvKumjrsUF9Vbhn9ZJVkNBuY302Z6WDro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sRoVXMS87FJF0KbtKx/WsPB6KKWMB0+t+9BhnVm8roXeyDAHUJjISVUdGhHqu5lyYYb8ZhfzimSrQLj1EN0wyNMCAw3Z0H6PbbEil++zgGQ3rUqVe2E17qoYhIahn3NBufPJjrbR+oy7e4jkzNG1DBLl8+eyecYmdohW5TD+37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPTAdUp7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPTAdUp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751137134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=D2jr+MLExuQlTYBzZJpvrbRyvQXC+JLX+EMkY/N8xKM=;
	b=JPTAdUp70S6iO5nsqJJDpRVMUCI4NhwYCN0K1f0ZF3CZNkN6hKUkvfuG+GNFAM7bjwQm5L
	ZHpfhfCSJ2r6KaZ85xC6HpRfUkgT2ojn5wcmPZN7CVukhh2lqFBo4LwAb7OiokpPh5mhf2
	kP7nUFSO646k6/BMgUiebCFshhcCk58=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-dPM3H-nqNAKWYNNVTPYzWw-1; Sat, 28 Jun 2025 14:58:53 -0400
X-MC-Unique: dPM3H-nqNAKWYNNVTPYzWw-1
X-Mimecast-MFC-AGG-ID: dPM3H-nqNAKWYNNVTPYzWw_1751137132
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5780e8137so2014208f8f.1
        for <virtualization@lists.linux.dev>; Sat, 28 Jun 2025 11:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751137132; x=1751741932;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2jr+MLExuQlTYBzZJpvrbRyvQXC+JLX+EMkY/N8xKM=;
        b=Ro6oeVgr8Bj15rImE+BE2hcFEN9VvOrsyGrea9hWJ05CcZnzye27CdDVT8cbiSK24f
         kEN/rrt7yaYERO/m0XHovicmTZ9VaUHbvfvwoANL6EyDwGyI3MC4BDDNzr5mCi0C95Dj
         Ri3rfGkX55j1uMT8cyonSOBYLKYeyCnkd1dErZoDDy1nefVp2sfcb3olUYUrRwYFXA+q
         dE3KYmB3p3VN2cLcqxGZRrgZMsD+14x9X3PUHyImXv4S+TGO7lb48Ok3hLHr0KQAweAS
         T3V0OryMdsFf+/dr15EIJS5ucpm5qTBGhX+1DTuohHAEKqM2w/gUaQ4bgWhKY9/9HzA7
         Ie0g==
X-Forwarded-Encrypted: i=1; AJvYcCUegPQoGFcPnm4qptrxOAjjOMO7lM3tR8uILZ3edr97DVzQhUz9GI+7Ssr2+lHVhwIvsh85qcs1fqwDVwy+Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw85EQOcNgXqy0ucU7vf8CzRNVXBaySFd4OqUwipzPtGy6as1j3
	wAOB403oYk+T7kP117Ji5BK+e+7S514YB3Id7v51TQxyPU4s7qLzQLKAppgQ0COpq77pFWQOr54
	nPxzwPuzkGca/RP9yspX222250N/dgfB7Z/7gyymXl2wGZCSuoxYZw3Ye2bjrisMtVDJB
X-Gm-Gg: ASbGncuDw4kcp+6x/AOOUXOub5ej9O3Ta/EO9zT1koieC0M5p0krfNdpFZbuV4vNIF7
	++bThrTm2l/Rxc/cVD/aHN8JscAXp3qYx8IVb0lRdVAdsYczN7YmcB8xivTrg1eeKAGZ2BeTwHh
	5n4IQ4AKJIMbg9LGYYosVGluRx7gCAKMS4KrzLV0q9HlEkUsJcgiYKzDXlg7CEuH2bG1+I3i7sW
	DyPZfSAHkHTonwpQR9ieTnq8YVwAx41OBudiKXa5+6Alf8TFLD9SpTTt3p+qP57QPrH0NCyKjT6
	6Hx73tjnnFs8n8PZ
X-Received: by 2002:a05:6000:2d82:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a6f312dca2mr7141645f8f.16.1751137132108;
        Sat, 28 Jun 2025 11:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBJMUvsuhSV4mrdNlnlvt4UgUb//QS8f+KlaM7+aGDdwZ8OM/DCTqh3V0G1zt1cycebQnDQg==
X-Received: by 2002:a05:6000:2d82:b0:3a4:eb7a:2ccb with SMTP id ffacd0b85a97d-3a6f312dca2mr7141634f8f.16.1751137131628;
        Sat, 28 Jun 2025 11:58:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6e9esm118646395e9.28.2025.06.28.11.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 11:58:51 -0700 (PDT)
Date: Sat, 28 Jun 2025 14:58:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com
Subject: [PATCH RFC] pci: report surprise removal events
Message-ID: <11cfcb55b5302999b0e58b94018f92a379196698.1751136072.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ioiMVuaJhblnJWBCWkzYPs6ZnNZqb7Ad_ddPnB7dqCc_1751137132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

At the moment, in case of a surprise removal, the regular
remove callback is invoked, exclusively.
This works well, because mostly, the cleanup would be the same.

However, there's a race: imagine device removal was initiated by a user
action, such as driver unbind, and it in turn initiated some cleanup and
is now waiting for an interrupt from the device. If the device is now
surprise-removed, that never arrives and the remove callback hangs
forever.

Drivers can artificially add timeouts to handle that, but it can be
flaky.

Instead, let's add a way for the driver to be notified about the
disconnect. It can then do any necessary cleanup, knowing that the
device is inactive.

Given this is by design kind of asynchronous with normal probe/remove
callbacks, I added it in the pci_error_handlers callback.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Warning: build-tested only at this point.

Posting for early flames/feedback.

Cc a bunch of people who discussed this problem specifically in the
virtio blk driver.

 drivers/pci/pci.h   | 9 +++++++++
 include/linux/pci.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62..78b064be10d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -549,6 +549,15 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	/* Notify driver of surprise removal */
+	device_lock(&dev->dev);
+
+	if (dev->driver && dev->driver->err_handler &&
+	    dev->driver->err_handler->disconnect)
+		dev->driver->err_handler->disconnect(dev);
+
+	device_unlock(&dev->dev);
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51e2bd6405cd..30a8c7ee09f6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -878,6 +878,9 @@ struct pci_error_handlers {
 	/* PCI slot has been reset */
 	pci_ers_result_t (*slot_reset)(struct pci_dev *dev);
 
+	/* PCI slot has been disconnected */
+        void (*disconnect)(struct pci_dev *dev);
+
 	/* PCI function reset prepare or completed */
 	void (*reset_prepare)(struct pci_dev *dev);
 	void (*reset_done)(struct pci_dev *dev);
-- 
MST

