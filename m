Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17641227E8A;
	Thu, 17 Apr 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882830; cv=none; b=XOBd15enG/0GwzFoujdT7qCxr09woZpItG44NUhBYco0xCZr6frI37ZyToQxJ4G2nP94Uc0JG2KNiOvKPeqKxGBvcrw7Byvn3P008pq2MkM7EeArcCL0uSh0KmVZUMfNz1tgN3lCuGxphWSp4fQoOw+QoH/4jvsz63l/ZCPfQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882830; c=relaxed/simple;
	bh=xVWJwK7dduWtiwYoiIb/scMBtR0de7McYRps8TtEQ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=luf4ttRbfIfi4+GjWAXI6kFZlJUgSdp4EV8tvO0+VpGn60ybmZvEOSxGUq/BHL+QUTJOZy4GCF/89TBofWG2zCDXmuMmna1qcz5UKFRYYLj1ctyH0r/IEEto1PlCxKnZKPyb7FupWQjxpU71izJ9MRLPGaYetNtQC8eCyAfg7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umGet/Ui; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umGet/Ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE450C4CEE4;
	Thu, 17 Apr 2025 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744882829;
	bh=xVWJwK7dduWtiwYoiIb/scMBtR0de7McYRps8TtEQ2U=;
	h=From:To:Cc:Subject:Date:From;
	b=umGet/Ui/9PCBXwRwBEw3wqvFN7JZ2eo/gJ2V5LztwFpWtvOgNB4TggLi9KntCeBJ
	 zY9q2n9mBB2T3zkyyYIiAlQRxEelNXG6FzyvinLU0d1He9TxH/mqGJejF18KkiWaCw
	 8tWUlsNswGJ55H10KDYBoZCBaatBvXZjR/IFkcpxRLkZSPrKy9zL/KjSVNfHzx2JSZ
	 DHgJ08nhH5rz2nGLCSAQqAF/e8iY9x8bKPM7lXs1hiAShKaAuV7vU95AWYWXuWkJKI
	 b82wmIP6EBKZ0KDWH9/V5qlNe07HXdXgKmEMsXMUoMsCgf78B/XyLYl2lKa7DLavBk
	 DmPVeXcM1g2Zw==
From: Philipp Stanner <phasta@kernel.org>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Philipp Stanner <phasta@kernel.org>
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/cirrus: Use non-hybrid PCI devres API
Date: Thu, 17 Apr 2025 11:40:10 +0200
Message-ID: <20250417094009.29297-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cirrus enables its PCI device with pcim_enable_device(). This,
implicitly, switches the function pci_request_regions() into managed
mode, where it becomes a devres function.

The PCI subsystem wants to remove this hybrid nature from its
interfaces. To do so, users of the aforementioned combination of
functions must be ported to non-hybrid functions.

Replace the call to sometimes-managed pci_request_regions() with one to
the always-managed pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 52ec1e4ea9e5..1ff678e26aa1 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -681,7 +681,7 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	ret = pci_request_regions(pdev, DRIVER_NAME);
+	ret = pcim_request_all_regions(pdev, DRIVER_NAME);
 	if (ret)
 		return ret;
 
-- 
2.48.1

