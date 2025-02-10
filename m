Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F31C549F
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739181595; cv=none; b=i61XfScf+WJolL2aOsFMr4W9YuCdhMJenAXRJTU0qptp2rxsECmYPmH/PDgnsqq0BTYMlY5PqwmlXk/E8s9x1eS7YXkRd4Ddpfew8YcM7cxVHGnFtk1YJTOr+fSmRicaDCzhLiWAvuhYfT2PG3C9EirWrhC/5W7XsSoZRYgGqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739181595; c=relaxed/simple;
	bh=E+6G9ivPSVsgFELSOBAAWHbWTTLXkPSljJe47y9F14w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZjo+iGDifvmQ2Ix116T/eYgENs4yIrI72czjvb+4o+dJXeA+k2xxkOBKvyEVAKRZuE1d2uFjqK75j/+aYz5Tfu14HSJ2HtanT5heZGzdMFEtv/hlVvDkh6JMQSsE2qqeHJAJA74DynmgF2E3L6BsszLIfltVPlv9nfKo5GSJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQrJP15Q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQrJP15Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739181594; x=1770717594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E+6G9ivPSVsgFELSOBAAWHbWTTLXkPSljJe47y9F14w=;
  b=eQrJP15Q29GeQ4vRyKtux3UJbNMAfSaJ35ldeNQ5p8kE846h3DGSxyVp
   Qf0HO4/P9zJqg0EPe8YCuR3cYYbWs3YK/LHGPU9GBqCv/gw06xVxsqXwr
   2Kv4ZYXkBn91/fP69bPvQEc8BzyBBNZDx32WetQx+2yCtAGHuYTRRGcMa
   4LFILxCdXzvuuUZCfgAShDTnuVPvgF25xniUBY5e24I5rQ1QKo5RnykX4
   lqHfFzqKnq6ljbORcd3U+DTiNxQQAFdXR9dsoMBLPmyahaUL+tP/0gRLh
   A5QLdi7IQLAU069oQDTMdd4T3QItUCxgpkCpPiUydl3T0SOp8UCPZQ75E
   w==;
X-CSE-ConnectionGUID: 7xQ1StprSSSCyKNcjmX9ag==
X-CSE-MsgGUID: nVqG1xwdQli9/WYpkYzrLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39666642"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39666642"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:59:53 -0800
X-CSE-ConnectionGUID: Lz+XmfaiRZuvKqZNFCS1sg==
X-CSE-MsgGUID: T5+4AuQ0R7Sqoz3Biyq8rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112584355"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 10 Feb 2025 01:59:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7F6392F2; Mon, 10 Feb 2025 11:59:49 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] virtio_console: Get rid of unneeded temporary variable
Date: Mon, 10 Feb 2025 11:59:45 +0200
Message-ID: <20250210095946.4122771-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When compiling a kernel with GCC using `make W=1` with CONFIG_WERROR=y
(which is default nowadays), the build fails:

drivers/char/virtio_console.c:1427:9: note: ‘snprintf’ output between 9 and 27 bytes into a destination of size 16

Indeed, GCC can't see the limits of the variables that are in use.
Fix this by using dev_name() of the newly created device that is
luckily the same as the string used for the DebugFS node name.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/char/virtio_console.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 24442485e73e..707464d2227c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1321,7 +1321,6 @@ static void send_sigio_to_port(struct port *port)
 
 static int add_port(struct ports_device *portdev, u32 id)
 {
-	char debugfs_name[16];
 	struct port *port;
 	dev_t devt;
 	int err;
@@ -1424,9 +1423,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	 * Finally, create the debugfs file that we can use to
 	 * inspect a port's state at any time
 	 */
-	snprintf(debugfs_name, sizeof(debugfs_name), "vport%up%u",
-		 port->portdev->vdev->index, id);
-	port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
+	port->debugfs_file = debugfs_create_file(dev_name(port->dev), 0444,
 						 pdrvdata.debugfs_dir,
 						 port, &port_debugfs_fops);
 	return 0;
-- 
2.45.1.3035.g276e886db78b

