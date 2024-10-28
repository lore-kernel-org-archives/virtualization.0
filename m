Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F41BDAA2
	for <virtualization@lists.linux.dev>; Mon, 28 Oct 2024 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101503; cv=none; b=d+Nszm3tHzWDs2hwqjsZcpB7HNqpGOcl869U2SUG91kT65txHXCZ1VsaNMSgIf8tn4XfUnWUC9J5KrhayuwlYwLmpxmHesh80J47nvi5hUO0rtF6bmnGnWOPAmlrC6LEF0jghtkdVwCmS02kQzLLKy0hTHyYH3nKEfi4CoGgOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101503; c=relaxed/simple;
	bh=PEZr0dlQokSOg0EnOX8DNbTQF91ffCeHj6qA1SGw03M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PfDUxVHyUCI8RbqVLXcI/nt6ZViy+cq6NpOVbvm5v454Z6th9o3tQXiW8DsQThYMlcltylc/p8WMXEGd9ZJI3rsF7kO37GogmQcnS03zKFjhXo9G+8MtncyblRLDByf9h9hsWSVdg3nmOnyCcUigTXzl31cs+RLBgx0a8Cmpi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNcGqcHF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNcGqcHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730101499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbIQ/VhVhZ0OvUIRysIuQ3OzP1NdlYynlJ50dCrgjTU=;
	b=FNcGqcHF7Y5DjrML054wbzxnWi1ukZO3Okv8JN7oDf3X9NHDxWXsUSAGpz/Ds+yXlgykVL
	i382p8jA4n661TjqQtWXngoujxLl0uhB+/j8uFURJeNPi7/5v3moQAcrz8uBrbpVklWQ0K
	P38jykbx6o2X5tD4hZYLCBpQ/L3NocU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-GDsRQ0zDN22PF-jDv45yuQ-1; Mon, 28 Oct 2024 03:44:57 -0400
X-MC-Unique: GDsRQ0zDN22PF-jDv45yuQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe933e877so73143026d6.1
        for <virtualization@lists.linux.dev>; Mon, 28 Oct 2024 00:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101496; x=1730706296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbIQ/VhVhZ0OvUIRysIuQ3OzP1NdlYynlJ50dCrgjTU=;
        b=ojbKObjeVLA47ki+rphlMVV4e6/SOsjdif/D+rpFmBS22ROYczYF6xErDDIqVSCLCq
         H8n7GHYN6eJX0mA1NVKDLYrOYCSJIc6HD89ISxVHsWSlVugq8VExCjOTvws+FWUZSwUz
         gUb6VxMkacQseynzfQNtmptHmO6kqPCBAAyKDEAo29B2UvGesqQWAZwfaDGkvli4t3oH
         8gBzoIsuO6lUE+Gy172Q/dE0UkxSpefnp0GMCyrU/QtBJDml9zBG6DlTeDUGEoBZFfh7
         tha0dsp6x3IqSqisZyYBhp99rbEidbyaPaiONVwkhTdDWymnp3MwBBNnPZkkVEXrP4QL
         fZSQ==
X-Gm-Message-State: AOJu0YxBn+les9Ui95r/VeUZHzz2sbSem3hq92rJHqWqdZJDOcaJl+Yz
	76o6KtrNbUIAE8lkfm0swhsjsy3b1MYEKSgIZG+STHyLRe1xtUbWTHhLyRg3md1GpelAtbKctfo
	d189eCxizWfwHkE5SPSgtQy0PcDTFbjH2ztdvY01iaiZSkUBukeoMgQETXf1+mpHS
X-Received: by 2002:a05:6214:2dc6:b0:6cb:cee6:d834 with SMTP id 6a1803df08f44-6d18585e762mr121038886d6.45.1730101496508;
        Mon, 28 Oct 2024 00:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYrXXTQPuJOobZASjIKDFRnHrChhHyjJipSBygd3ZhctAHecyDi+Abnul9u/vpmNdW1daW7Q==
X-Received: by 2002:a05:6214:2dc6:b0:6cb:cee6:d834 with SMTP id 6a1803df08f44-6d18585e762mr121038756d6.45.1730101496220;
        Mon, 28 Oct 2024 00:44:56 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f566sm30237716d6.13.2024.10.28.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:44:55 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2] vdpa: solidrun: Fix UB bug with devres
Date: Mon, 28 Oct 2024 08:43:59 +0100
Message-ID: <20241028074357.9104-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
pcim_iomap_regions() is placed on the stack. Neither
pcim_iomap_regions() nor the functions it calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the strings on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
Changes in v2:
  - Add Stefano's RB
---
 drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..c8b74980dbd1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[50];
+	char *name;
 	int ret;
 
-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.47.0

