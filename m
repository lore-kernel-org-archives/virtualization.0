Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98839C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 03:09:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F9164DA3
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 03:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F9164DA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF0756F69F;
	Wed, 10 Mar 2021 03:09:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WScCepXDZgoj; Wed, 10 Mar 2021 03:09:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0356B6F69A;
	Wed, 10 Mar 2021 03:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC04CC000A;
	Wed, 10 Mar 2021 03:09:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C26C1C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 905004EBE2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkMoCT2mYIgY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA2DB4D7A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:09:05 +0000 (UTC)
IronPort-SDR: hLoWvfdOFVc0tZ2b1Pdu+eeo8X/ZSKZxV9P1TY/o5P3DVORcTbrd5EfOsW7aPxcaEt5w123Tlu
 nv2P9zVGoIXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167645716"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
 d="gz'50?scan'50,208,50";a="167645716"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2021 19:09:03 -0800
IronPort-SDR: 75NEsFggBrNk7eBNHd4iDJ1yKHLjfBv19sfN6bBbM94xERV/2lqXN54Dv79Q5MYfiJxZHNlLRN
 7bFmb3AzEWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
 d="gz'50?scan'50,208,50";a="370012446"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 09 Mar 2021 19:09:01 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1lJpDY-0001yk-Fu; Wed, 10 Mar 2021 03:09:00 +0000
Date: Wed, 10 Mar 2021 11:08:21 +0800
From: kernel test robot <lkp@intel.com>
To: Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-mmio: read[wl]()/write[wl] are already
 little-endian
Message-ID: <202103101125.s4HrMQyc-lkp@intel.com>
References: <20210309224313.956065-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20210309224313.956065-1-laurent@vivier.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kbuild-all@lists.01.org,
 Laurent Vivier <laurent@vivier.eu>, virtualization@lists.linux-foundation.org
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Laurent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.12-rc2 next-20210309]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Laurent-Vivier/virtio-mmio-read-wl-write-wl-are-already-little-endian/20210310-064527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
config: x86_64-randconfig-s022-20210310 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-262-g5e674421-dirty
        # https://github.com/0day-ci/linux/commit/1fd3d4da486545f554eb33663c6afe068bbcbcf8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Laurent-Vivier/virtio-mmio-read-wl-write-wl-are-already-little-endian/20210310-064527
        git checkout 1fd3d4da486545f554eb33663c6afe068bbcbcf8
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/virtio/virtio_mmio.c:171:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] w @@     got unsigned short @@
   drivers/virtio/virtio_mmio.c:171:19: sparse:     expected restricted __le16 [usertype] w
   drivers/virtio/virtio_mmio.c:171:19: sparse:     got unsigned short
   drivers/virtio/virtio_mmio.c:175:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] l @@     got unsigned int @@
   drivers/virtio/virtio_mmio.c:175:19: sparse:     expected restricted __le32 [usertype] l
   drivers/virtio/virtio_mmio.c:175:19: sparse:     got unsigned int
   drivers/virtio/virtio_mmio.c:179:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] l @@     got unsigned int @@
   drivers/virtio/virtio_mmio.c:179:19: sparse:     expected restricted __le32 [addressable] [usertype] l
   drivers/virtio/virtio_mmio.c:179:19: sparse:     got unsigned int
   drivers/virtio/virtio_mmio.c:181:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [usertype] l @@     got unsigned int @@
   drivers/virtio/virtio_mmio.c:181:19: sparse:     expected restricted __le32 [addressable] [usertype] l
   drivers/virtio/virtio_mmio.c:181:19: sparse:     got unsigned int
>> drivers/virtio/virtio_mmio.c:215:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short val @@     got restricted __le16 [addressable] [usertype] w @@
   drivers/virtio/virtio_mmio.c:215:24: sparse:     expected unsigned short val
   drivers/virtio/virtio_mmio.c:215:24: sparse:     got restricted __le16 [addressable] [usertype] w
>> drivers/virtio/virtio_mmio.c:219:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [addressable] [usertype] l @@
   drivers/virtio/virtio_mmio.c:219:24: sparse:     expected unsigned int val
   drivers/virtio/virtio_mmio.c:219:24: sparse:     got restricted __le32 [addressable] [usertype] l
   drivers/virtio/virtio_mmio.c:223:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [addressable] [usertype] l @@
   drivers/virtio/virtio_mmio.c:223:24: sparse:     expected unsigned int val
   drivers/virtio/virtio_mmio.c:223:24: sparse:     got restricted __le32 [addressable] [usertype] l
   drivers/virtio/virtio_mmio.c:225:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [addressable] [usertype] l @@
   drivers/virtio/virtio_mmio.c:225:24: sparse:     expected unsigned int val
   drivers/virtio/virtio_mmio.c:225:24: sparse:     got restricted __le32 [addressable] [usertype] l

vim +215 drivers/virtio/virtio_mmio.c

   188	
   189	static void vm_set(struct virtio_device *vdev, unsigned offset,
   190			   const void *buf, unsigned len)
   191	{
   192		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
   193		void __iomem *base = vm_dev->base + VIRTIO_MMIO_CONFIG;
   194		u8 b;
   195		__le16 w;
   196		__le32 l;
   197	
   198		if (vm_dev->version == 1) {
   199			const u8 *ptr = buf;
   200			int i;
   201	
   202			for (i = 0; i < len; i++)
   203				writeb(ptr[i], base + offset + i);
   204	
   205			return;
   206		}
   207	
   208		switch (len) {
   209		case 1:
   210			memcpy(&b, buf, sizeof b);
   211			writeb(b, base + offset);
   212			break;
   213		case 2:
   214			memcpy(&w, buf, sizeof w);
 > 215			writew(w, base + offset);
   216			break;
   217		case 4:
   218			memcpy(&l, buf, sizeof l);
 > 219			writel(l, base + offset);
   220			break;
   221		case 8:
   222			memcpy(&l, buf, sizeof l);
   223			writel(l, base + offset);
   224			memcpy(&l, buf + sizeof l, sizeof l);
   225			writel(l, base + offset + sizeof l);
   226			break;
   227		default:
   228			BUG();
   229		}
   230	}
   231	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9Loh+vJ2CeL4jcPD/wDgUCR3dBACAA==

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--YiEDa0DAkWCtVeE4--
