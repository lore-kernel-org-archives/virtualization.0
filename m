Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2CC1D4603
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784996; cv=none; b=Ta/Leo21eU71ao72GogHMghxVv6HcSJ/Gvl3c4/1WhEKc4Mg2tqUbPwSjnQ2QFePYs7Nru29HtgMbAUsI3Yi2DrYKguNT0Kf/1HrW1QCvKO9zvHQ+FbOwZP3+dHNBClwiGrfUkVqTmNwcg7ZmPRj1+iD5cRwZe70+vq3gpRTlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784996; c=relaxed/simple;
	bh=JMbg4eMibkjbCBRT/iJAl8N9RNBguY/qcuyAy9Bi6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijZs+gCUOhV+C9lcE1RgWTW/1ktFyRw6mgpGmFKU8245d/BWZkqqg9kW0jo6HIz8nL6UXhgNGt3ThVyNmvffXIElA5j5kky64tKl4p717QoqbzIDlMl2NDXanyncg1DtcyrOp+NBjZOvUl8ha7oQlT5EAZWkjh86au3D8JyVNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVWFXLnW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVWFXLnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=326BlglD5Q8k45ugPSVf+4k9+mzBOEJ61jidx8Y66gA=;
	b=EVWFXLnWO3sTJABjG3wuBLKK4ecxLL8gnAfhJiKoInMPxv2q6vcIvh8SpBhCRKplGnR1j2
	diOaT2OOAWut3dvysdXkcKdIqOcJvvxiz7NMtJg1KCh8UsAbvDanzsXSJxrhEYfy+2gNfd
	FAwvIF7wyjRhebRAnzjImmh5L1m5QKU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516--SimH9JQP1-2z-CSMjM0wQ-1; Tue, 27 Aug 2024 14:56:31 -0400
X-MC-Unique: -SimH9JQP1-2z-CSMjM0wQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5bec49ca724so4770050a12.3
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 11:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784990; x=1725389790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=326BlglD5Q8k45ugPSVf+4k9+mzBOEJ61jidx8Y66gA=;
        b=ZT5GO/CvxBds62X3U5nd8jmne+ABkTSVrRkpUc41Y6NWlnL+Vx5Hr0HwEV4X3lh5Zr
         B4SHqrOcrEkmdemWdNlsBrhWq7HlF0kbf/l56OkrsmMG31YNWtxA3Gi5rZCCngn7v0hg
         Wy8XubinbFuOD254RVugQ8rLWp136B/ds2wr7UQZzwA2PycchWyuyHqrYLCQ6u6d3HRi
         mXKnPDOBqfAdYNo5GfvXAE9KNdkdOgBAz7UqSML5PPBA0Cbn+jzWqdYYY6dwy3+GKBxq
         LnWTCL+BlU2vH1B5idFs+QqhMkcbKms6F31Hw2+K12nKDDmjeIH/4A+GTdZPXt9yziY8
         p6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX840P+XUYb6wcOc+uC8FpwC8L5Q3sBotp6hg77P3ohusmB8kHYBL5X0JWsSZpKHuNsfAh4Cn+TUxqQsOYCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxofRmSuAHowX+H79zW83BLpBeybszq2j/ubghtdYchfFJYDD+
	zbzbtg6vO4t5QKZshfZE1BNtUL3cl+xBNCl5UEP/PmTZc5rV3NLqrOcnhGjEnVTkYd/VST4PaTe
	9sQYyLdzOYSMS+BpxDfOJxgGrkx10n4PTRHLNZD1XAognWQTWVPtKb+dZpj7Dmpao
X-Received: by 2002:a17:907:7295:b0:a86:97c0:9bb3 with SMTP id a640c23a62f3a-a86a54b8d24mr1205130266b.51.1724784990404;
        Tue, 27 Aug 2024 11:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3LQz+Ovtpn7UQw3Ih17gexf8/42HNMXwzrnqKpk9+fwQeRpCxA2TD7y7c22AXPuu4p6dfJQ==
X-Received: by 2002:a17:907:7295:b0:a86:97c0:9bb3 with SMTP id a640c23a62f3a-a86a54b8d24mr1205127066b.51.1724784989954;
        Tue, 27 Aug 2024 11:56:29 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v4 6/7] vdpa: solidrun: Fix UB bug with devres
Date: Tue, 27 Aug 2024 20:56:11 +0200
Message-ID: <20240827185616.45094-7-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
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
2.46.0

