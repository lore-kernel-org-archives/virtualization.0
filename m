Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E35A93D
	for <virtualization@lists.linux.dev>; Sun,  8 Sep 2024 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725778417; cv=none; b=DsRBrTUc8BtA9ZSdLSRsO4ELDZyDIShhCb2D4w6MEEONgCkvh3jC+fE4aB4yx+4ZRDuW/W5+GRKQmSzQHS8uQdgPurRH106lnaEC9/pWXGv//mdkaErvTw9oHUWMHAnkaF5nX7nQMbWQw/fKo8DEIyr7Ar/S689sYJnFCDiZnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725778417; c=relaxed/simple;
	bh=zPAg7VNhQvNNsfra+KnaQcSnvxjOSaUhSh5rAlZU1ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=blxM2o6k2rOQ1B5vclgXpWJlEbE4PBq7ftGS1cvdpz6KIJjnXIs7clhgcJqWIiOQj7YfwdH2MmISCmTcPwzlyg714k9FD45fCU2+Ak5nS4YdAQfLUWTCVdqh11lY3+ULy9zQjJPkLEDY7YjIk8I6giNru8PRNAZJLyhqmiZT9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Am4E9osx; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Am4E9osx"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nBmTs6D2ClL4CnBmUs81fW; Sun, 08 Sep 2024 08:52:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725778339;
	bh=wv3WFe0KxwUo6zf2E3vPHM9Wor5nA2RClGvCNFKZsVI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Am4E9osxNI8CqTI+8JwTgwxpCW+Gb/Fz0hzjEHGqO5wkkYbUgG29UOKphKF5zIWA9
	 lC0R1EmTIQI327JhyOBUoXFOX7HWcUmvQeZm/1nqJ80hUht5aYWJryno0f8YcuWjPf
	 LPtg5QzluOjJhkddmJXqP+n9lvo+ObQmh0JwrfXSZSB4uSoZJf9MM1RkPt1Eduzzq6
	 BzijJZv/8tuaPDjF1dKyE32EatccHPMn89iMKVuJN5xMIFLR2xJyCRbxPJVpxxTIG+
	 MsWcJOBQA0xnusiZtgHr2w8LmMl2g6gkghHJ1QeBMwHPA+mfjyR7f9xpspijGV3E2A
	 yj23vREDRk/oQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Sep 2024 08:52:19 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH] i2c: virtio: Constify struct i2c_algorithm and struct virtio_device_id
Date: Sun,  8 Sep 2024 08:52:07 +0200
Message-ID: <b98c3fa7072bf519ce8a9bc771e9d18c091b3509.1725778305.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct i2c_algorithm' and 'struct virtio_device_id' are not modified in
this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers, which is the case for struct i2c_algorithm.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   6663	    568	     16	   7247	   1c4f	drivers/i2c/busses/i2c-virtio.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   6735	    472	     16	   7223	   1c37	drivers/i2c/busses/i2c-virtio.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
--
Compile tested only
---
 drivers/i2c/busses/i2c-virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 52ba1e0845ca..2a351f961b89 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -182,7 +182,7 @@ static u32 virtio_i2c_func(struct i2c_adapter *adap)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
-static struct i2c_algorithm virtio_algorithm = {
+static const struct i2c_algorithm virtio_algorithm = {
 	.xfer = virtio_i2c_xfer,
 	.functionality = virtio_i2c_func,
 };
@@ -237,7 +237,7 @@ static void virtio_i2c_remove(struct virtio_device *vdev)
 	virtio_i2c_del_vqs(vdev);
 }
 
-static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_I2C_ADAPTER, VIRTIO_DEV_ANY_ID },
 	{}
 };
-- 
2.46.0

