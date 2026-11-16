Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862262;
	b=rdVmWknynPtsrEXs3DatQ/3UBLsB5zYf+ucZv6X87KumqptyGQFO5LdQAWrSy54Yn3hr
	 0x/Xe5YWBXLmkJ7aTqFlhEz1J7u1EzxL4OzISD2kxe/HK/469CBGLLzQhkv3yO9RqZzyC
	 VhnUvoLmVAy5dvX/3W/arzfPBqXiGrAVmBv1PjlJt/UQENFYYf2eJ3sOroK3PY95AFZ4Z
	 a5S1C7AW5iluHneeUkRe3HpQ1g4eBVUHNV5i+KpD8AhMlhkCRECjbaqoT9WiGHQ+aR/bx
	 uI1ijYskHPGVXLWj6Eh1aie/h4qklu+2PG/nzaSt3KwoKT7lwuHU0ygThLCP4rwDqmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862262;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LbYY8S+YO6IOf9cej8HAyGPboaJz0Yq/WVfxOOkRios=;
	b=ECeDR1ZbrfgXz6U4aeucUHqNhqzvlhzcX61V1ukz+AJah9DF8Ss0Teez0WcGpMW4GYWx
	 iqia2ZM4ySQJlDS3KnkDfy01TtVJ4OtT3gKGNpdjUL7Ue05WK4Dw13Alu7kLmzoRd4dTR
	 /eG2VSHJOaZysy9GITwFN1JAnEeCwITrwXS1UBHPqhhA1aiJGe55wskheQ4ktIuKfRm7Z
	 SbAI7Cf2ovgPF8mlzsAChjTnbNWB5Vx1653vf8BHTf65ms3npil4FEgT2CMWQP5g9Qxuz
	 h7dkRU7Ucw97MyslJIDr5FvlzdoXcoOM47iiIYh9dPDYvN2HtqQ5328+s1KZ6YrQoCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kc3N08k+;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B52606A331;
	Mon, 16 Nov 2026 20:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B52606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kc3N08k+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794862262; x=1826398262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+hAdGEu/G2i+6qXpIrE3hZjue1EEFXSISQEDRzQof4=;
  b=Kc3N08k+1Xc9Kzbt58HPLEFIBolee9HsoPL7rVf4ffHuv/xRCwb30pjF
   MF0XFgotEDFsSiq0S49rnT/WlewulcqmjJLYQALqIfMSVOOcWyzxQV+At
   e0Yp/ClUU6Z8S99YyJQTigteIlAKqW3hgYyKKl9n4QVnqYXM3XFqmxybV
   eR5/pSNCfLRSu8yvrYaaUx8Mn81Th0XtTkbwutLDp8BGAfeaUbSB0FjBV
   93tPm+LBfA1oyMwdcWjUhqUah9qFfjgOPxdv1pFz86BFBTagnt6l4S3NF
   sU9O1iyg/hf7BPO8dBIoxZh/dWecVNsRsOAfen5gtBrtiWmICMZXC4L3J
   A==;
X-CSE-ConnectionGUID: C4LHScVaR0SzEyzDUpcpgQ==
X-CSE-MsgGUID: h838g+ShQ0u2e06ds0rUOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3627642"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3627642"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 12:51:02 -0800
X-CSE-ConnectionGUID: XQbmmi1NSs+nwwq2ukQKFg==
X-CSE-MsgGUID: Z839PmLoT2aZ0zvCWNu+dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9660347"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Nov 2026 12:50:56 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xT3fB-000000019PL-1eCy;
	Mon, 16 Nov 2026 20:50:53 +0000
Date: Tue, 17 Nov 2026 04:50:35 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kvm@vger.kernel.org, kernel@pengutronix.de,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH net-next v5 6/9] virtio-net: assert header sizes
Message-ID: <202611170421.klVDQaAD-lkp@intel.com>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f@pengutronix.de>

Hi Steffen,

kernel test robot noticed the following build errors:

[auto build test ERROR on c88fd6989aea9237a60a4859139a265bfb7ddc0b]

url:    https://github.com/intel-lab-lkp/linux/commits/Steffen-Trumtrar/net-ethtool-tsconfig-allow-hardware-timestamping-without-a-PHC/20261112-121933
base:   c88fd6989aea9237a60a4859139a265bfb7ddc0b
patch link:    https://lore.kernel.org/r/20261112-v6-7-topic-virtio-net-ptp-v5-6-7ab67b572f4f%40pengutronix.de
patch subject: [PATCH net-next v5 6/9] virtio-net: assert header sizes
config: arm-neponset_defconfig (https://download.01.org/0day-ci/archive/20261117/202611170421.klVDQaAD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261117/202611170421.klVDQaAD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611170421.klVDQaAD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bits.h:30,
                    from include/linux/bitops.h:6,
                    from include/linux/bitmap.h:8,
                    from include/linux/ethtool.h:16,
                    from net/packet/af_packet.c:51:
>> include/linux/build_bug.h:80:41: error: static assertion failed: "offsetof(struct virtio_net_common_hdr, tstamp) == 32"
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:79:34: note: in expansion of macro '__static_assert'
      79 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/virtio_net.h:36:1: note: in expansion of macro 'static_assert'
      36 | static_assert(offsetof(struct virtio_net_common_hdr, tstamp) == 32);
         | ^~~~~~~~~~~~~
>> include/linux/build_bug.h:80:41: error: static assertion failed: "__alignof__(struct virtio_net_common_hdr) == 2"
      80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:79:34: note: in expansion of macro '__static_assert'
      79 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/virtio_net.h:39:1: note: in expansion of macro 'static_assert'
      39 | static_assert(__alignof__(struct virtio_net_common_hdr) == 2);
         | ^~~~~~~~~~~~~


vim +80 include/linux/build_bug.h

bc6245e5efd70c4 Ian Abbott       2017-07-10  61  
6bab69c65013bed Rasmus Villemoes 2019-03-07  62  /**
6bab69c65013bed Rasmus Villemoes 2019-03-07  63   * static_assert - check integer constant expression at build time
6ffd853b0b10e1e Randy Dunlap     2026-03-01  64   * @expr: expression to be checked
6bab69c65013bed Rasmus Villemoes 2019-03-07  65   *
6bab69c65013bed Rasmus Villemoes 2019-03-07  66   * static_assert() is a wrapper for the C11 _Static_assert, with a
6bab69c65013bed Rasmus Villemoes 2019-03-07  67   * little macro magic to make the message optional (defaulting to the
6bab69c65013bed Rasmus Villemoes 2019-03-07  68   * stringification of the tested expression).
6bab69c65013bed Rasmus Villemoes 2019-03-07  69   *
6bab69c65013bed Rasmus Villemoes 2019-03-07  70   * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
6bab69c65013bed Rasmus Villemoes 2019-03-07  71   * scope, but requires the expression to be an integer constant
6bab69c65013bed Rasmus Villemoes 2019-03-07  72   * expression (i.e., it is not enough that __builtin_constant_p() is
6bab69c65013bed Rasmus Villemoes 2019-03-07  73   * true for expr).
6bab69c65013bed Rasmus Villemoes 2019-03-07  74   *
6bab69c65013bed Rasmus Villemoes 2019-03-07  75   * Also note that BUILD_BUG_ON() fails the build if the condition is
6bab69c65013bed Rasmus Villemoes 2019-03-07  76   * true, while static_assert() fails the build if the expression is
6bab69c65013bed Rasmus Villemoes 2019-03-07  77   * false.
6bab69c65013bed Rasmus Villemoes 2019-03-07  78   */
6bab69c65013bed Rasmus Villemoes 2019-03-07  79  #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
6bab69c65013bed Rasmus Villemoes 2019-03-07 @80  #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
6bab69c65013bed Rasmus Villemoes 2019-03-07  81  
07a368b3f55a79d Maxim Levitsky   2022-10-25  82  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
