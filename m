Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EEFC433F5
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 08:30:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 707CE8333F;
	Fri, 21 Jan 2022 08:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auDh_nIwU1ZN; Fri, 21 Jan 2022 08:30:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1E49D832FF;
	Fri, 21 Jan 2022 08:30:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB9E2C0031;
	Fri, 21 Jan 2022 08:30:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE94C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D56E404FB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0FutYjRCZbjh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:30:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 67C13403BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642753842; x=1674289842;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mx3znovqbTqSHRCLPhWAXVsdrHy1wURwplgEYl4lCrs=;
 b=dqf8bvX/mu8LAU+agxPKiHdEI+LJPDgXYJsd9yUQRmleydCLs6T8Xwbx
 R7b4ORW/gGwBomYUqgPeF03USoYKD3lZrCAGj7CnymePj4Wxlaslbctp0
 JSzT16XDtMHlyIx2tR+V+fYFBRqPf9Qx7NYA0ZjNwYMcQHuYgurETLGpk
 9H01hPnJbrrDXjkiyxcfggRe3YN5M9Us9FLKSkHsGDxzWIZbj/bBNkzaP
 +aq5Zard118Vtk0SDASf803UF0WO68obuSxxy+ZvBMIw3GuVOSBqLMLnB
 iZ6LjFc/DVxLXH1VePpo91tmpjzEDMnss+KjnUEoToNz0glAfLmKmadHD g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="308930304"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="308930304"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2022 00:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="518982996"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 21 Jan 2022 00:30:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nApJe-000F73-N2; Fri, 21 Jan 2022 08:30:38 +0000
Date: Fri, 21 Jan 2022 16:29:52 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
 arei.gonglei@huawei.com
Subject: [RFC PATCH] virtio-crypto: virtio_crypto_rsa_do_req() can be static
Message-ID: <20220121082951.GA46247@b53fa9759326>
References: <20220121022438.1042547-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220121022438.1042547-4-pizhenwei@bytedance.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, helei.sig11@bytedance.com,
 linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org, linux-crypto@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:5: warning: symbol 'virtio_crypto_rsa_do_req' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 virtio_crypto_akcipher_algo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
index eebccf71b2fab..2b3f8780b7551 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
@@ -273,7 +273,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	return -ENOMEM;
 }
 
-int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
+static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
 {
 	struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
 	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
