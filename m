Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51D22F00
	for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713088101; cv=none; b=ObEKFiDZil4lp5a8lVVDA2jcsLhISqJE135JdgnG3oLGPlRuVvMKn9aruizxieFys0dwtu7ArycqasTpaByXj7PMerLYvH3c5LMOBJGqP0c+lJdyLhcEaBvIua3yH7UdMiNF6tDJDvaNGAJ5U3xR2ICX5Wt+1Zz5g8GrFsQLAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713088101; c=relaxed/simple;
	bh=NDlsgoc6A4IxXBOEATwELgEDexzc69w9dYPIh0f56gg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qj1HljwfZlYB3R2RYpz3pDZkJXyB5yCJmQEDoAzn8cyUR/LTyqBuuiglyLF9M7WWTiK7cyD/+gusA/tla94or0lSvq4jMN6uQG82TS0UPYJpUlWnueGO+l/2KmPaOht2oLbsBrZdvqvPmbaD1HE82rhtbEib2WF7b9R5P/fptDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXNPj6uM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXNPj6uM"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso1834432e87.3
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713088098; x=1713692898; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVqD2Rvirwu12W5FfnBuYS741rQo1YJJcl1syKPBUN0=;
        b=MXNPj6uMdJv0O42zOCCN3ScSXX/xfStAlwKnKWPlbv9oHXe1RvVGW7wapa7nzuDTEI
         amiefzHkiYUfoFM4+V85qY62J+1tLbrFYOt+R3gDNHhtyIZvFUB9DrVnsHMnTrfDeiPs
         J9uqokxgFy+nGhB/EFnp4q5r8UFPBqaowdvDjDc6UysPDGr5Qnx8Ed+k4YjWQtSUWISP
         paPWIBrmF9bP7PsqFJcSiXVIJpLtx3S0+qZMo88hjbyVUlExOWmIuMwAz/B2Jn6cvtP0
         u5QZfjrDKWq5oHwRFOTOKAwgoQUMQJmM2YTPgp2aApoHKh8TxHjSwR2//+/g2NmoQwwS
         dqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713088098; x=1713692898;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVqD2Rvirwu12W5FfnBuYS741rQo1YJJcl1syKPBUN0=;
        b=kY5XkXucBYi5vWHcTbte6OU4QIrscs7n17uLXryIhN/t9xSQm8iS0FaS7WdthfdelK
         nXG7fi3rvbzSsBRF8nlYkQvbTWsc4c6TFo6LoPZfYK64moFuwjDMaLrA3tvKQTbOh24z
         6w5NrtljHexpMIPkJkSUSDuoC73BCfQW+G9+GoHNFlTecf5Kd0rG6uzp44jw1VGfWjEL
         uYPQK4me0ESnSsRd+bMjnzwwu/+AYySLjAqv1nQlhqxKdjxSb42D2XwSoL+GgIE+Iru+
         guKtu97SuoT9uHtDRLaasDHFpCl+0B1WECsNOgdw4zSZDxkNL7+AZjnJKNoRghqnu1u+
         FiEg==
X-Forwarded-Encrypted: i=1; AJvYcCW7lmNsyQzrqineGK68135SUBb+McLmw+zSJGcqhl4IXAUPRJx/DVnyX4uAqt3E4WasNEyMdVSVL6YrSBgpktpVZkT2MsYJ4cTPemILi3c=
X-Gm-Message-State: AOJu0YzyqIV3UkIbTbOY1m9jp5IPUvjbiGdhb9hpXOChwU/t4kMQwarB
	5CobtXGXbdhN4AYTwOi4MluXLd9Og4D+2C/qTGNFH0TdFAAMr4aa3OLXOBF+Lz8=
X-Google-Smtp-Source: AGHT+IF+o4gNFJDGJrFzzBfCpTnxmIUEqX4iFJfz0itRIzQrDGl4yEWKWtL79ugoRK/UVLGNpDL1tQ==
X-Received: by 2002:ac2:51b6:0:b0:518:bd37:606e with SMTP id f22-20020ac251b6000000b00518bd37606emr1630389lfk.13.1713088097535;
        Sun, 14 Apr 2024 02:48:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e23-20020a170906249700b00a52454f4533sm2009486ejb.208.2024.04.14.02.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 02:48:17 -0700 (PDT)
Date: Sun, 14 Apr 2024 12:48:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH vhost 4/6] virtio_net: big mode support premapped
Message-ID: <8f518b9a-36cb-4988-8e69-3ea8ea567364@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411025127.51945-5-xuanzhuo@linux.alibaba.com>

Hi Xuan,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_ring-introduce-dma-map-api-for-page/20240411-105318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240411025127.51945-5-xuanzhuo%40linux.alibaba.com
patch subject: [PATCH vhost 4/6] virtio_net: big mode support premapped
config: i386-randconfig-141-20240414 (https://download.01.org/0day-ci/archive/20240414/202404141343.iPhKo7zd-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404141343.iPhKo7zd-lkp@intel.com/

New smatch warnings:
drivers/net/virtio_net.c:485 give_pages() warn: impossible condition '((page->dma_addr) == (~0)) => (0-u32max == u64max)'

vim +485 drivers/net/virtio_net.c

e9d7417b97f420 Jason Wang      2012-12-07  481  static void give_pages(struct receive_queue *rq, struct page *page)
0a888fd1f6320d Mark McLoughlin 2008-11-16  482  {
9ab86bbcf8be75 Shirley Ma      2010-01-29  483  	struct page *end;
0a888fd1f6320d Mark McLoughlin 2008-11-16  484  
59e4bcf761eeba Xuan Zhuo       2024-04-11 @485  	if (page_dma_addr(page) == DMA_MAPPING_ERROR) {

(struct page)->dma_addr is unsigned long but DMA_MAPPING_ERROR is
dma_addr_t.

59e4bcf761eeba Xuan Zhuo       2024-04-11  486  		if (page_chain_map(rq, page)) {
59e4bcf761eeba Xuan Zhuo       2024-04-11  487  			__free_pages(page, 0);
59e4bcf761eeba Xuan Zhuo       2024-04-11  488  			return;
59e4bcf761eeba Xuan Zhuo       2024-04-11  489  		}
59e4bcf761eeba Xuan Zhuo       2024-04-11  490  	}
59e4bcf761eeba Xuan Zhuo       2024-04-11  491  
e9d7417b97f420 Jason Wang      2012-12-07  492  	/* Find end of list, sew whole thing into vi->rq.pages. */
590f79cf558cb4 Xuan Zhuo       2024-04-11  493  	for (end = page; page_chain_next(end); end = page_chain_next(end));
590f79cf558cb4 Xuan Zhuo       2024-04-11  494  
590f79cf558cb4 Xuan Zhuo       2024-04-11  495  	page_chain_add(end, rq->pages);
e9d7417b97f420 Jason Wang      2012-12-07  496  	rq->pages = page;
0a888fd1f6320d Mark McLoughlin 2008-11-16  497  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

