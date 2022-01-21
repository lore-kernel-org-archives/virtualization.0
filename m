Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C92CC433F5
	for <virtualization@archiver.kernel.org>; Fri, 21 Jan 2022 06:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A433833AE;
	Fri, 21 Jan 2022 06:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6lpkXyqgRyP; Fri, 21 Jan 2022 06:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8D2688336F;
	Fri, 21 Jan 2022 06:37:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 606FDC0031;
	Fri, 21 Jan 2022 06:37:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB3EC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 06:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 033E183386
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 06:37:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ikyKdSChs7a
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 06:37:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F07A8336F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Jan 2022 06:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642747059; x=1674283059;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PrB7+txqACOqvxAdRJEN6Ri06z0Sf+hn/heR9Ndq8fo=;
 b=DGxj68lhbbGP/vzeX37LuVzssSKtYqQcc8KQ7qSjxgvoVvw1/R4aeNT6
 QZxBhPX2DurSMMMpq5YO5p6G+lZMzGe/VgYHp3evGxOMBFBSaKMOG+EAb
 +V6aow+PlSdwwJ4wym7M404MuczyuRt7ink3d3tjK6Lt5yNPYUbDo01Da
 j6+ZEMLJ6x3quz6USxNJsGJaopaRAkB41HULqPVYZoKQE86N+3d82A8Lc
 8P0mabZ9C8OgUTts2evODg8d9eZ/ko4x2q7OtijTHsRYy9ZpbCNG99VO+
 /UxYT4ywe6PrVZtcyH0GHNGfq2EP+5ez+VtghvBfGHe9lG25oJxi76FQi w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="245530562"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="245530562"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2022 22:37:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; d="scan'208";a="616400090"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by FMSMGA003.fm.intel.com with ESMTP; 20 Jan 2022 22:37:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nAnYE-000F0y-Qp; Fri, 21 Jan 2022 06:37:34 +0000
Date: Fri, 21 Jan 2022 14:36:51 +0800
From: kernel test robot <lkp@intel.com>
To: zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
 arei.gonglei@huawei.com
Subject: Re: [PATCH 3/3] virtio-crypto: implement RSA algorithm
Message-ID: <202201211427.TgczsUOo-lkp@intel.com>
References: <20220121022438.1042547-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220121022438.1042547-4-pizhenwei@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, helei.sig11@bytedance.com, llvm@lists.linux.dev,
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

Hi zhenwei,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linux/master linus/master v5.16 next-20220121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
config: hexagon-randconfig-r026-20220120 (https://download.01.org/0day-ci/archive/20220121/202201211427.TgczsUOo-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d4baf3b1322b84816aa623d8e8cb45a49cb68b84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fa1045d13dd16399ab0287c599719a977892cf05
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review zhenwei-pi/Introduce-akcipher-service-for-virtio-crypto/20220121-102730
        git checkout fa1045d13dd16399ab0287c599719a977892cf05
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/crypto/virtio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:5: warning: no previous prototype for function 'virtio_crypto_rsa_do_req' [-Wmissing-prototypes]
   int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
       ^
   drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
   ^
   static 
   1 warning generated.


vim +/virtio_crypto_rsa_do_req +276 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c

   275	
 > 276	int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
   277	{
   278		struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
   279		struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
   280		struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
   281		struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
   282		struct virtio_crypto *vcrypto = ctx->vcrypto;
   283		struct data_queue *data_vq = vc_req->dataq;
   284		struct virtio_crypto_op_header *header;
   285		struct virtio_crypto_akcipher_data_req *akcipher_req;
   286		int ret;
   287	
   288		vc_req->sgs = NULL;
   289		vc_req->req_data = kzalloc_node(sizeof(*vc_req->req_data),
   290			GFP_KERNEL, dev_to_node(&vcrypto->vdev->dev));
   291		if (!vc_req->req_data)
   292			return -ENOMEM;
   293	
   294		/* build request header */
   295		header = &vc_req->req_data->header;
   296		header->opcode = cpu_to_le32(vc_akcipher_req->opcode);
   297		header->algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
   298		header->session_id = cpu_to_le64(ctx->session_id);
   299	
   300		/* build request akcipher data */
   301		akcipher_req = &vc_req->req_data->u.akcipher_req;
   302		akcipher_req->para.src_data_len = cpu_to_le32(req->src_len);
   303		akcipher_req->para.dst_data_len = cpu_to_le32(req->dst_len);
   304	
   305		ret = __virtio_crypto_akcipher_do_req(vc_akcipher_req, req, data_vq);
   306		if (ret < 0) {
   307			kfree_sensitive(vc_req->req_data);
   308			vc_req->req_data = NULL;
   309			return ret;
   310		}
   311	
   312		return 0;
   313	}
   314	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
