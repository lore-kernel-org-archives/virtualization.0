Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAC35E1AD;
	Wed, 10 Jun 2026 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781118651; cv=none; b=hUQNEEQOD7pE99NsEnRiuGnI5PUXGgkYfeqXsuTX9PwNHr77TQ2SqWQNNynY/NNoAuRHwAryjCnKI7f9ZP+xpS5SBJaUuwt2xNrM+lmbnnzPB4jHFFyofVY2FCksHzESSCMIOVi6Mnn5dV4uuqSdfmUQIPJOiJ6XUWS7SD9e790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781118651; c=relaxed/simple;
	bh=UusuSpxnBqEewppTICNmTk3Nc55pTHnvDixw96lrajU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOelhgLjNCArutFBbbCBGh4Nnm4yM9SmyNdlGxfbnadz7e3TW253PgRnR3mIVKPDIA0hktWSEP6V4vwzH7xkLWw9nsFMb2uxjzU4Nqm6xw0f1OsgggleXgu7V2a4bl+vYPinkjB9kChgDLt8JeWbypAPWp85IYj5bEnQek9M3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDgAAbjX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDgAAbjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781118649; x=1812654649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UusuSpxnBqEewppTICNmTk3Nc55pTHnvDixw96lrajU=;
  b=nDgAAbjXewLFlOaAVS1Jpk2F0ruSUND5MYPv4Kgi7AHobjdvrvR8d402
   I84AtNPL257y7C+Kn/RmMZ2ldgGJ9wFxLRtSISiYT7Wx/SLan1Yu+79Zi
   Uy/b5MgZCyJWr0XT/Pdtv8MKZoTj+igX5NkcJIzkD2N2+62CNvgUkqbnV
   xuNLY0pw0cjNojuMBy6khPCNGT4IEco+qIUchRbmXZdECoLW+eOPkktpc
   L/hvtbtn722hLNjdVz1yJxKLq0VOk1en0qoOY1Or+4W31xb6g2IRdVSD2
   hzlt+3AmcGejvkJnMWoy1cm1P2u455y3+fyWV/LL/xfyyQAconIBlmaIH
   w==;
X-CSE-ConnectionGUID: IUJr0Y7ZSFW7Tx1PvlKGPg==
X-CSE-MsgGUID: pZz4StTkR8iARlOeNLIiuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92596820"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="92596820"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 12:10:48 -0700
X-CSE-ConnectionGUID: D1SAQGkQQXakFoapfkXoPw==
X-CSE-MsgGUID: Q0gHE8A8TwKc7krrJyYVWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="276450343"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Jun 2026 12:10:45 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXOK2-00000000LnG-2Hjk;
	Wed, 10 Jun 2026 19:10:42 +0000
Date: Thu, 11 Jun 2026 03:10:11 +0800
From: kernel test robot <lkp@intel.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Cindy Lu <lulu@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: Re: [PATCH v3] vduse: Add suspend
Message-ID: <202606110222.CJtRWzQl-lkp@intel.com>
References: <20260610083452.477759-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610083452.477759-1-eperezma@redhat.com>

Hi Eugenio,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260609]
[cannot apply to linus/master v7.1-rc7 v7.1-rc6 v7.1-rc5 v7.1-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eugenio-P-rez/vduse-Add-suspend/20260610-164534
base:   next-20260609
patch link:    https://lore.kernel.org/r/20260610083452.477759-1-eperezma%40redhat.com
patch subject: [PATCH v3] vduse: Add suspend
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260611/202606110222.CJtRWzQl-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 7917772d7d61384696c61102c08c2ea158e610fa)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260611/202606110222.CJtRWzQl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606110222.CJtRWzQl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vdpa/vdpa_user/vduse_dev.c:566:3: error: cannot jump from this goto statement to its label
     566 |                 goto unlock;
         |                 ^
   drivers/vdpa/vdpa_user/vduse_dev.c:568:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
     568 |         guard(rwsem_read)(&vq->dev->rwsem);
         |         ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:132:1: note: expanded from here
     132 | class_rwsem_read_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:138:1: note: expanded from here
     138 | __UNIQUE_ID_unlock_770
         | ^
   drivers/vdpa/vdpa_user/vduse_dev.c:568:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:423:15: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:165:2: note: expanded from macro '__UNIQUE_ID'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:126:1: note: expanded from here
     126 | __UNIQUE_ID_guard_769
         | ^
   1 error generated.


vim +566 drivers/vdpa/vdpa_user/vduse_dev.c

c8a6153b6c59d9 Xie Yongji        2021-08-31  561  
c8a6153b6c59d9 Xie Yongji        2021-08-31  562  static void vduse_vq_kick(struct vduse_virtqueue *vq)
c8a6153b6c59d9 Xie Yongji        2021-08-31  563  {
c8a6153b6c59d9 Xie Yongji        2021-08-31  564  	spin_lock(&vq->kick_lock);
c8a6153b6c59d9 Xie Yongji        2021-08-31  565  	if (!vq->ready)
c8a6153b6c59d9 Xie Yongji        2021-08-31 @566  		goto unlock;
c8a6153b6c59d9 Xie Yongji        2021-08-31  567  
9c4307e82fa1dc Eugenio Pérez     2026-06-10  568  	guard(rwsem_read)(&vq->dev->rwsem);
9c4307e82fa1dc Eugenio Pérez     2026-06-10  569  	if (vq->dev->suspended)
9c4307e82fa1dc Eugenio Pérez     2026-06-10  570  		return;
9c4307e82fa1dc Eugenio Pérez     2026-06-10  571  
c8a6153b6c59d9 Xie Yongji        2021-08-31  572  	if (vq->kickfd)
3652117f854819 Christian Brauner 2023-11-22  573  		eventfd_signal(vq->kickfd);
c8a6153b6c59d9 Xie Yongji        2021-08-31  574  	else
c8a6153b6c59d9 Xie Yongji        2021-08-31  575  		vq->kicked = true;
c8a6153b6c59d9 Xie Yongji        2021-08-31  576  unlock:
c8a6153b6c59d9 Xie Yongji        2021-08-31  577  	spin_unlock(&vq->kick_lock);
c8a6153b6c59d9 Xie Yongji        2021-08-31  578  }
c8a6153b6c59d9 Xie Yongji        2021-08-31  579  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
