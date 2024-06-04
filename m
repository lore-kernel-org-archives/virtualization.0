Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0631DA2F;
	Tue,  4 Jun 2024 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717479073; cv=none; b=i6lpibqLtcxSbY97L1ob5ed4A9CxF8EjMkzRKWedbpEoJKtm+EnQhid96PrW/WqLc5ApBXvXf6bqXk6ZYBU8k6AihYCt3gM4npxZaW0jbyXltRBNyajH1sGGhTFgf5PRY/6C0fsioe8e3Em1M7uJHlkQ6WNMJTDy1fKLlMjOyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717479073; c=relaxed/simple;
	bh=0zbgKfvHTJ/R5q9ClkCPrLlxGR7Xha84YTV21PicIHU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ZWHe68pMGRDYozgTrOapz1GSDqXxVxZ0Swr9QLGW+tt+8fVqVEJlnBP/ISNbkvyCyGNyXnHQvigmhRbAceKGO0cSI1c7LPOuKlStZEhDUAhmprtHCmpfLupSCEHpWh+fVw8KaxnmHjOMS7Ug56VS2NktRixakhLvtiqYbYDdvrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xwBj6eUm; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xwBj6eUm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717479063; h=Message-ID:Subject:Date:From:To;
	bh=on7QTAt93h/XfHQ169rkXSG1LnUtTKMC4HJvTpbfWk8=;
	b=xwBj6eUmISzY/cCWvrcWSesA9aH1/VQIx+5WzhIPuHuPA7nvKnlYAE5XIUn3KPoQVmcKH6cNfSm2hCq8ezWFXFAljhgNc5+k8rwWFA5nZ7Sv0+BnfaFgfmIi0RYQGwMtQbHpIYK1Ix706pKpidt0HMudvpD5L9YK7D8xpINJn1s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=37;SR=0;TI=SMTPD_---0W7poCxp_1717479060;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7poCxp_1717479060)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 13:31:01 +0800
Message-ID: <1717478006.038663-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v14 3/5] ethtool: provide customized dim profile management
Date: Tue, 4 Jun 2024 13:13:26 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Huacai Chen <chenhuacai@loongson.cn>,
 Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Guo Ren <guoren@kernel.org>,
 loongarch@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 donald.hunter@gmail.com,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240603154727.31998-1-hengqi@linux.alibaba.com>
 <20240603154727.31998-4-hengqi@linux.alibaba.com>
 <202406040645.6z95FW1f-lkp@intel.com>
In-Reply-To: <202406040645.6z95FW1f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 4 Jun 2024 07:00:35 +0800, kernel test robot <lkp@intel.com> wrote:
> Hi Heng,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240603-235834
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20240603154727.31998-4-hengqi%40linux.alibaba.com
> patch subject: [PATCH net-next v14 3/5] ethtool: provide customized dim profile management
> config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240604/202406040645.6z95FW1f-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406040645.6z95FW1f-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202406040645.6z95FW1f-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> net/ethtool/coalesce.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable


I'm not sure if this seems to be related to the update of loongarch[1]?
didn't find this warning on other architectures such as arm/openrisc/x86.

+Cc:
loongarch@lists.linux.dev, Guo Ren <guoren@kernel.org>,
Xuerui Wang <kernel@xen0n.name>,
Jiaxun Yang <jiaxun.yang@flygoat.com>,
Huacai Chen <chenhuacai@loongson.cn>

[1] https://lore.kernel.org/all/20240322135619.1423490-1-chenhuacai@loongson.cn/

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
