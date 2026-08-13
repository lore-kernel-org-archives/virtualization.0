Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC837F727
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610798; cv=none; b=eUtJyEc0Xs1fRJV3fSigGHLAyFrNcZirhkSPihJmiG9WJdtD/QIb3D56ff9hWUwEXZI/MM+gibdUJR28cBO3ApK9FPdycegHedRdLYiKsr6072788hFHhvacqWN3YrMMoCvaja0XHxfF7Ek6aSdf+nMz96hghbupmVrowSsQtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610798; c=relaxed/simple;
	bh=vR1iT0cN+qkYxdDauHjJ13eOGbWiC8B4X8NJUtRZrlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogDTV3zDDhnOmT/e3DxAHCSwaixeXBOcbsbn4UN2mgZUiWbpLmAFnqDAWEAe/qrALKqAxj+g9QsIlTpqiTnTJE+4QXpQTIugODXftC2oFlkTJUXnYY2VmNgUoqCG3/49cylCkrQt6J+VQe2yZh2RrFTQecuQu0nyVnxIwHqO1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=gvFZN+jm; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="gvFZN+jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1786610797; x=1818146797;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jgwzIPadzRuXgTwI5wjbbgiEuwhXVVMg9yCs74dnSCk=;
  b=gvFZN+jmkrjVG+YaX9Bv/YIPjGRUrKKU/k1jNgO05v64f6YTPp+P9X5m
   ArGIMtpHQ4xdNikePW8eJ5VyO8VYWKRoRdOdsezSqXhrJVzeBnItsSo6N
   QEBLW2r8c3AJBpvePiS2gb70YivSbG+m7G+8uOIW6Zc/fPYXsW5rGkPtg
   FQZVNw67Rm48+uuMD0VSnscCGmzKpwRcOMBhzda37qV846LDdjl8Qb6/8
   CP+2OJcwpTvv5IBLLemnyQ1huMENqFVNn5RA0raZn/Xb9d99OHiayb+Rw
   NJoe+GH+l4JIzYZ/PiiRWfaa2D4LxJS+vOk5/knzLSP08/IBZY0U+zSB4
   A==;
X-CSE-ConnectionGUID: dWhQdZivRIWN2xuk3gmlBA==
X-CSE-MsgGUID: tWiCkXFnT8GFJMsQn8+AMg==
X-IronPort-AV: E=Sophos;i="6.25,221,1779148800"; 
   d="scan'208";a="25883897"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 08:46:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:12214]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.140:2525] with esmtp (Farcaster)
 id 319fcf5e-cb2e-4262-9506-6f9b8706e05c; Thu, 13 Aug 2026 08:46:34 +0000 (UTC)
X-Farcaster-Flow-ID: 319fcf5e-cb2e-4262-9506-6f9b8706e05c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 13 Aug 2026 08:46:33 +0000
Received: from dev-dsk-jaspwise-1b-5558f826.eu-west-1.amazon.com
 (10.13.227.24) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Thu, 13 Aug 2026
 08:46:32 +0000
From: Jasper Wise <jaspwise@amazon.co.uk>
To: <quic_haixcui@quicinc.com>, <broonie@kernel.org>
CC: <virtualization@lists.linux.dev>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [PATCH] spi: virtio: mark device ready before registering the controller
Date: Thu, 13 Aug 2026 08:46:18 +0000
Message-ID: <20260813084618.613172-1-jaspwise@amazon.co.uk>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

virtio_spi_probe() registers the SPI controller with
devm_spi_register_controller(). spi_register_controller() binds a child
inline unless its driver has asked for asynchronous probing, so a
peripheral that performs a transfer during its own probe reaches
virtio_spi_transfer_one(), which kicks the virtqueue before probe has
returned.

The driver never calls virtio_device_ready(), so DRIVER_OK is set on its
behalf by virtio_dev_probe(), only once probe has returned. The virtio
spec is explicit about that ordering in 3.1 Device Initialization:
  |  The driver MUST NOT send any buffer available notifications to the
  |  device before setting DRIVER_OK.

A device that waits for DRIVER_OK before servicing the queue therefore
leaves the transfer unanswered, and virtio_spi_transfer_one() waits for its
completion with no timeout, so probe never returns.

Mark the device ready before registering the controller, as done for the
same reason in commit f5866db64f34 ("virtio_console: enable VQs early") and
commit 1d774589f924 ("i2c: virtio: mark device ready before registering the
adapter").

Fixes: f98cabe3f6cf ("SPI: Add virtio SPI driver")
Signed-off-by: Jasper Wise <jaspwise@amazon.co.uk>
---
 drivers/spi/spi-virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
index fa4c68049eca..2256dfec5407 100644
--- a/drivers/spi/spi-virtio.c
+++ b/drivers/spi/spi-virtio.c
@@ -358,6 +358,8 @@ static int virtio_spi_probe(struct virtio_device *vdev)
 	if (ret)
 		return dev_err_probe(&vdev->dev, ret, "Cannot register virtqueue cleanup\n");
 
+	virtio_device_ready(vdev);
+
 	/* Use devm version to register controller */
 	ret = devm_spi_register_controller(&vdev->dev, ctrl);
 	if (ret)

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.50.1

