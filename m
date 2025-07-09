Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355A23B608
	for <virtualization@lists.linux.dev>; Wed,  9 Jul 2025 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094536; cv=none; b=JH+KNIypy/sRjSj+yLNLlcnDJCqSN9b+1EoSrj72GdglqKWuUdaNdwVd2v5/98Ibj0Q2T9apvqUVSoaODeH1DYlaHcDS3Mb5FPmst6uFKLN/WPCHTWbEgcVnDhXVdX8ayvCY9Q4pG/qwtNGCgUHGLNQ7KIcwISfKsPHKZvpk5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094536; c=relaxed/simple;
	bh=/lA1LK7ZnNLfv04veBIb9q69E0+yXfc1RvkXI5Te3eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i2HfUWeYm7rh5sSLPjrBHj0hX6DszjHZg5DxVvXR4LkGL7FWfdOlYzQ2qlO2Ook6fA6dAYymAOc8qN19IDaPQ7W2W2cwNRmiODMRCjkURvZYuq335kZNM21YnAmnpMi+XaiiwrInEiNBUBIP/+pgE+61pn+c8AUdAW119BFSfV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyloGRko; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyloGRko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752094533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+8HiDmuIb1V4xNcjsZubuM5A9uuKBpDTrFrPT0qP+4=;
	b=HyloGRkorihpYS3p41Qe2tJ0WjbEtGS7vwInNca7qYBbqtwZ1NturgOYVPTzCYBkFe/5Ww
	+IdPk5kUl8HJsy7gje4Un6Dcll+/6c1m2NHIri3R8hEs5FtrNKgF7Ka5+I2UO5GgFMMFOR
	9X58pKvdoRR6xjSPpX9q4PJuI64BSog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-lOrSW5lQOQOw3rC5RpAplg-1; Wed, 09 Jul 2025 16:55:30 -0400
X-MC-Unique: lOrSW5lQOQOw3rC5RpAplg-1
X-Mimecast-MFC-AGG-ID: lOrSW5lQOQOw3rC5RpAplg_1752094529
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453817323afso1332735e9.1
        for <virtualization@lists.linux.dev>; Wed, 09 Jul 2025 13:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752094529; x=1752699329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+8HiDmuIb1V4xNcjsZubuM5A9uuKBpDTrFrPT0qP+4=;
        b=ai1lUcA5XElPqklP5A6KpwPk8jxV252nJBOR/R9KPAHmtChcz91Z5pVXbYEmKiEcmp
         sk5KzrNyzuLxb4qo4tb4CQgNGP1I0dCuEN+wAR/dcmXzqz8OVUg+7FFRFSs/ZKjK/ZRC
         AS/VEkioskDdESDh3jOSeFEILH48cgJgVyPTClgsikhV+n30sCFYH2KcCC3YerPom+l9
         DwaFGu7etYDo/yfHBh6jVEaojWq/GuDEKZUtv4JK9JCFviTwYMdTC2q5AzwWI1xiRpWj
         2jJWTSsH8z69UZfAv0WprPh6Iz6L2sFCbEHvYaP86UJBxboN245wiLDdyinnj0kKWzfL
         GLqg==
X-Forwarded-Encrypted: i=1; AJvYcCW53EHwcwFu3AkN96Sc/hJyMAy4C2JntFbtDQUWQMuKWtaCgF4mGhFf29Sg3HjA+wI+ntlZFXoKXhIr7QfjnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwX40cJNlYW7bzW4eH7Sm+cuvXLEWizEDrd1tgYcj2WGNHgFVve
	vC2dRD7R+hHMf+EnQLL/Drhyt2+d8luYP5L5TYjH2eBrABWJIWA2WIN0O1ZmM3W2U5q3kjLXQCh
	O+13tcz2IbrOVjODwula526hYlUUCs8tGLjobowfn1ecbjGMXfLmrTV5UsyT0vhTpvz2u
X-Gm-Gg: ASbGnctlNs362kdr4NX6gqOs053zJnKMLfR0SXbvGrRNtT3xrILe2qNuNegbCAm8d/4
	PLzlkSWWeW0DlMTBnN4B50dl74HQnubLO+4B+tRGXpm1Ey++p2wotflDP1zKcT3uFQF6Ubwg6Yd
	+9MKxOSu3PpHRUGejxlCe3G/kdIEVG4pbZFdft/2FNqfzCQsbY2k1Xv6uwNsXNp8dBUhTWgsYuH
	qd9u5ufSlbNd6Mp3tbq5i7kZFXzLL3Kz19g+n5/dCYINFs1wWGRb24PQPnhE+0WGfaiHNA/I51m
	CmD1HNaUhIJfrK0=
X-Received: by 2002:a05:600c:4f55:b0:453:9317:8aa0 with SMTP id 5b1f17b1804b1-454dbd82ee3mr6024815e9.32.1752094528973;
        Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErXLt//6ePHOG7+onYgqo8lbrjY4/WxLy3ge58RAx7s9NzBFIJkuYjIjs37Zgj4r08N1hruA==
X-Received: by 2002:a05:600c:4f55:b0:453:9317:8aa0 with SMTP id 5b1f17b1804b1-454dbd82ee3mr6024675e9.32.1752094528475;
        Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5062119sm39984855e9.18.2025.07.09.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 13:55:28 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:55:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
References: <cover.1752094439.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1752094439.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: p-2IBLGQuOOZ2E3S1RmeQj7dsdwgm0ZV_ZPciD8e0Ag_1752094529
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

At the moment, in case of a surprise removal, the regular remove
callback is invoked, exclusively.  This works well, because mostly, the
cleanup would be the same.

However, there's a race: imagine device removal was initiated by a user
action, such as driver unbind, and it in turn initiated some cleanup and
is now waiting for an interrupt from the device. If the device is now
surprise-removed, that never arrives and the remove callback hangs
forever.

For example, this was reported for virtio-blk:

	1. the graceful removal is ongoing in the remove() callback, where disk
	   deletion del_gendisk() is ongoing, which waits for the requests +to
	   complete,

	2. Now few requests are yet to complete, and surprise removal started.

	At this point, virtio block driver will not get notified by the driver
	core layer, because it is likely serializing remove() happening by
	+user/driver unload and PCI hotplug driver-initiated device removal.  So
	vblk driver doesn't know that device is removed, block layer is waiting
	for requests completions to arrive which it never gets.  So
	del_gendisk() gets stuck.

Drivers can artificially add timeouts to handle that, but it can be
flaky.

Instead, let's add a way for the driver to be notified about the
disconnect. It can then do any necessary cleanup, knowing that the
device is inactive.

Since cleanups can take a long time, this takes an approach
of a work struct that the driver initiates and enables
on probe, and tears down on remove.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci.h   |  6 ++++++
 include/linux/pci.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb..3ca4ebfd46be 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -553,6 +553,12 @@ static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
 	pci_doe_disconnected(dev);
 
+	if (READ_ONCE(dev->disconnect_work_enable)) {
+		/* Make sure work is up to date. */
+		smp_rmb();
+		schedule_work(&dev->disconnect_work);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f392..723b17145b62 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -548,6 +548,10 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	/* Report disconnect events. 0x0 - disable, 0x1 - enable */
+	u8 disconnect_work_enable;
+	struct work_struct disconnect_work;
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */
@@ -1993,6 +1997,47 @@ pci_release_mem_regions(struct pci_dev *pdev)
 			    pci_select_bars(pdev, IORESOURCE_MEM));
 }
 
+/*
+ * Run this first thing after getting a disconnect work, to prevent it from
+ * running multiple times.
+ * Returns: true if disconnect was enabled, proceed. false if disabled, abort.
+ */
+static inline bool pci_test_and_clear_disconnect_enable(struct pci_dev *pdev)
+{
+	u8 enable = 0x1;
+	u8 disable = 0x0;
+	return try_cmpxchg(&pdev->disconnect_work_enable, &enable, disable);
+}
+
+/*
+ * Caller must initialize @pdev->disconnect_work before invoking this.
+ * The work function must run and check pci_test_and_clear_disconnect_enable.
+ * Note that device can go away right after this call.
+ */
+static inline void pci_set_disconnect_work(struct pci_dev *pdev)
+{
+	/* Make sure WQ has been initialized already */
+	smp_wmb();
+
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x1);
+
+	/* check the device did not go away meanwhile. */
+	mb();
+
+	if (!pci_device_is_present(pdev))
+		schedule_work(&pdev->disconnect_work);
+}
+
+static inline void pci_clear_disconnect_work(struct pci_dev *pdev)
+{
+	WRITE_ONCE(pdev->disconnect_work_enable, 0x0);
+
+	/* Make sure to stop using work from now on. */
+	smp_wmb();
+
+	cancel_work_sync(&pdev->disconnect_work);
+}
+
 #else /* CONFIG_PCI is not enabled */
 
 static inline void pci_set_flags(int flags) { }
-- 
MST

