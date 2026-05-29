Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5321A453;
	Fri, 29 May 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064894; cv=none; b=UIGhJblWdS9hDpi2POj72m3awssRVGXqPHHLgf0keGRa5nlTW39xqHRxcAKMZ/qmVBHL9Bh9BdG7b6dyqsAD+hvMcVoT3eQ7TZuXTQUv2qjeqjhoro9+AgrGofBcADnLH6jfaX3kbWE2YwdlSy5x9ODid6UHcJ/2viREhOwnSBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064894; c=relaxed/simple;
	bh=cIgfnw1Odn1bnUkmebwDdRVFvHzn1+LqD5i5OE9f8Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pTUKiUXi4U24Yr7SHd0hFHb0S38CxlW06DsopTJf1nUXn3CHpoLefaCMZxo5bUOqV8yAR7DNl8SDt0OiLMV5RcY2SkNRAquLJWx9tWZepcbKEQEfIozgYw+jHUfTfD4KgAjDHF69XkzoMzXpT49aFKwJBvaa2eGglyQnWy1b3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhXNXhQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhXNXhQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C8E7C2BCB8;
	Fri, 29 May 2026 14:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780064894;
	bh=cIgfnw1Odn1bnUkmebwDdRVFvHzn1+LqD5i5OE9f8Eo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fhXNXhQ7/cTf/jGuEsDd4DuyikxelyNVgl4bHmHHM1zyN8ncsMyI9iTX/v2d7czWt
	 QpjG2rCMFeI0TSlIlEqQsT2NdNwt5Fe2NXbV6Eto9vnoF/5hHedCIO/q84oZGYl9WC
	 vvtanUv+SJ6REUivd7uHSK2AWDFsAJygUxnb/oADtoGwhw9FWNwa30wVF2mSPobp8s
	 m1GbiwYwcGQ1LB7pM+LjrkZji4yvIeMfaZL7xL6blik858HEWZGTR/CjErsKPr4tw1
	 zdRJZlMkxBRGq6TAI4P1NKQkGw84Dk4B6Phqp92TkZVzVO3G697n/Dm/R02oTE1Daw
	 33cN9+Zo++rQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401ACCD6E4A;
	Fri, 29 May 2026 14:28:14 +0000 (UTC)
From: Alexis Bouzigues via B4 Relay <devnull+BouziguesAlexis.JohnDeere.com@kernel.org>
Date: Fri, 29 May 2026 09:28:14 -0500
Subject: [PATCH] i2c: virtio: mark device ready before registering the
 adapter
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-virtio-i2c-driver-ok-v1-1-ecf2504f6a56@JohnDeere.com>
X-B4-Tracking: v=1; b=H4sIAH2iGWoC/x3MQQqDMBBG4avIrB3QaZTGq4iLkoztT8HIRIIg3
 r2hy2/x3kVZDZppai4yLchIW0XfNhQ+r+2tjFhN0snYDeK5wA4khgSOhqLG6ct+dM4F0eHhn1T
 T3XTF+d/Oy33/ABQZNFdmAAAA
To: Viresh Kumar <viresh.kumar@linaro.org>, 
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780064893; l=1298;
 i=BouziguesAlexis@JohnDeere.com; s=20260527; h=from:subject:message-id;
 bh=iPwimaClnP4+pM+SMSAbPbbHxIEK/XLSHtxDtApz4AY=;
 b=eToR/52uFUF29AE4RN1+uvqSOsg3sZ2bMRNc1c29cCgA5nCagFpEEoIkP0QMJovGBAwjUJQeS
 oMRbCXyXn2GA7QEhvCEG3Sea87kyPPzWzbuJFXhdqGPnqma3u/p2TJD
X-Developer-Key: i=BouziguesAlexis@JohnDeere.com; a=ed25519;
 pk=5KJ7ArL00x5flpPhi9zRLC2p88V1rZXDQ5SXhpRvTDk=
X-Endpoint-Received: by B4 Relay for BouziguesAlexis@JohnDeere.com/20260527
 with auth_id=797
X-Original-From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
Reply-To: BouziguesAlexis@JohnDeere.com

From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>

virtio_i2c_probe() synchronously probes child i2c drivers on the bus,
but peripherals may use the bus at probe for tasks like reading a chip
id. The vhost-user-i2c backend stalls at such probes unless DRIVER_OK
is already set before the virtqueue is first kicked.

Set DRIVER_OK explicitly before i2c_add_adapter(), as done for the
same reason in commit f5866db64f34 ("virtio_console: enable VQs
early") and commit 71e4b8bf0482 ("virtio_rpmsg: set DRIVER_OK before
using device").

Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
---
 drivers/i2c/busses/i2c-virtio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 7b0b0bff8000..5da6fef92bec 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -222,6 +222,8 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
 	 */
 	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(vdev->dev.parent));
 
+	virtio_device_ready(vdev);
+
 	ret = i2c_add_adapter(&vi->adap);
 	if (ret)
 		virtio_i2c_del_vqs(vdev);

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260529-virtio-i2c-driver-ok-96444c2e5398

Best regards,
-- 
Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>


