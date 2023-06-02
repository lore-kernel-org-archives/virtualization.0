Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3727FC77B7A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 17:20:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86E0F84397;
	Fri,  2 Jun 2023 17:20:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86E0F84397
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OXPk6jWb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZhJPUqohbId; Fri,  2 Jun 2023 17:20:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51D328438C;
	Fri,  2 Jun 2023 17:20:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 51D328438C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36EE2C0037;
	Fri,  2 Jun 2023 17:20:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EA8CC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DABA1425A5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:19:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DABA1425A5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OXPk6jWb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JQBqO8T0hqF8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F4A2424CB
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F4A2424CB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685726394; x=1717262394;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=huQWIaGLCyDwNEyv4gbOkY32hoPagVTcWkg9cSo0J7c=;
 b=OXPk6jWbqEwrBlXti43NY4X9lWbLYOHGU0pLWDAdfhWsT2AY1a0T6PeS
 2vpJDqSpqemtYPDzK/QVFAaspLrriNsGShaCCb9g4z7FA6tUSUiEOoLls
 aDqgyP/tDt3ergvT86LzqUTaz1h0Wq1K/aAKCr/YJpR7m6bGYZ2++sTpl
 CbKNwPS0cNVry2sQ1+TE2Xkip9uibAVaRGhaynzN0dztcbyJRgDi+2HF/
 N7MyHj4nLZXTXxtsEqCl2bbh/zAJ1s99DAfI5/sZRNiVLBPVeRUsYatQT
 xGvnwQbRbDKWu+5Vf16MyQ4LE7A1Va5lpRkMYB4RfpCk0Y+NMlObOMrOQ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="419455144"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; d="scan'208";a="419455144"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 10:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="737615596"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; d="scan'208";a="737615596"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 02 Jun 2023 10:19:50 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q58RJ-0000lB-17;
 Fri, 02 Jun 2023 17:19:49 +0000
Date: Sat, 3 Jun 2023 01:19:37 +0800
From: kernel test robot <lkp@intel.com>
To: Shunsuke Mie <mie@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4 1/1] vringh: IOMEM support
Message-ID: <202306030119.NG7CQmJ8-lkp@intel.com>
References: <20230602055211.309960-2-mie@igel.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230602055211.309960-2-mie@igel.co.jp>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Shunsuke Mie <mie@igel.co.jp>, oe-kbuild-all@lists.linux.dev
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

Hi Shunsuke,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master horms-ipvs/master v6.4-rc4 next-20230602]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shunsuke-Mie/vringh-IOMEM-support/20230602-135351
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20230602055211.309960-2-mie%40igel.co.jp
patch subject: [PATCH v4 1/1] vringh: IOMEM support
config: hexagon-randconfig-r034-20230531 (https://download.01.org/0day-ci/archive/20230603/202306030119.NG7CQmJ8-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 4faf3aaf28226a4e950c103a14f6fc1d1fdabb1b)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/de2a1f5220c32e953400f225aba6bd294a8d41b8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shunsuke-Mie/vringh-IOMEM-support/20230602-135351
        git checkout de2a1f5220c32e953400f225aba6bd294a8d41b8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/vhost/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306030119.NG7CQmJ8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/vhost/vringh.c:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/vhost/vringh.c:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/vhost/vringh.c:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/vhost/vringh.c:1661:5: warning: no previous prototype for function 'vringh_init_iomem' [-Wmissing-prototypes]
   int vringh_init_iomem(struct vringh *vrh, u64 features, unsigned int num,
       ^
   drivers/vhost/vringh.c:1661:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vringh_init_iomem(struct vringh *vrh, u64 features, unsigned int num,
   ^
   static 
>> drivers/vhost/vringh.c:1683:5: warning: no previous prototype for function 'vringh_getdesc_iomem' [-Wmissing-prototypes]
   int vringh_getdesc_iomem(struct vringh *vrh, struct vringh_kiov *riov,
       ^
   drivers/vhost/vringh.c:1683:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vringh_getdesc_iomem(struct vringh *vrh, struct vringh_kiov *riov,
   ^
   static 
>> drivers/vhost/vringh.c:1714:9: warning: no previous prototype for function 'vringh_iov_pull_iomem' [-Wmissing-prototypes]
   ssize_t vringh_iov_pull_iomem(struct vringh *vrh, struct vringh_kiov *riov,
           ^
   drivers/vhost/vringh.c:1714:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ssize_t vringh_iov_pull_iomem(struct vringh *vrh, struct vringh_kiov *riov,
   ^
   static 
>> drivers/vhost/vringh.c:1729:9: warning: no previous prototype for function 'vringh_iov_push_iomem' [-Wmissing-prototypes]
   ssize_t vringh_iov_push_iomem(struct vringh *vrh, struct vringh_kiov *wiov,
           ^
   drivers/vhost/vringh.c:1729:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   ssize_t vringh_iov_push_iomem(struct vringh *vrh, struct vringh_kiov *wiov,
   ^
   static 
>> drivers/vhost/vringh.c:1744:6: warning: no previous prototype for function 'vringh_abandon_iomem' [-Wmissing-prototypes]
   void vringh_abandon_iomem(struct vringh *vrh, unsigned int num)
        ^
   drivers/vhost/vringh.c:1744:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void vringh_abandon_iomem(struct vringh *vrh, unsigned int num)
   ^
   static 
>> drivers/vhost/vringh.c:1759:5: warning: no previous prototype for function 'vringh_complete_iomem' [-Wmissing-prototypes]
   int vringh_complete_iomem(struct vringh *vrh, u16 head, u32 len)
       ^
   drivers/vhost/vringh.c:1759:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vringh_complete_iomem(struct vringh *vrh, u16 head, u32 len)
   ^
   static 
>> drivers/vhost/vringh.c:1777:6: warning: no previous prototype for function 'vringh_notify_enable_iomem' [-Wmissing-prototypes]
   bool vringh_notify_enable_iomem(struct vringh *vrh)
        ^
   drivers/vhost/vringh.c:1777:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool vringh_notify_enable_iomem(struct vringh *vrh)
   ^
   static 
>> drivers/vhost/vringh.c:1790:6: warning: no previous prototype for function 'vringh_notify_disable_iomem' [-Wmissing-prototypes]
   void vringh_notify_disable_iomem(struct vringh *vrh)
        ^
   drivers/vhost/vringh.c:1790:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void vringh_notify_disable_iomem(struct vringh *vrh)
   ^
   static 
>> drivers/vhost/vringh.c:1802:5: warning: no previous prototype for function 'vringh_need_notify_iomem' [-Wmissing-prototypes]
   int vringh_need_notify_iomem(struct vringh *vrh)
       ^
   drivers/vhost/vringh.c:1802:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int vringh_need_notify_iomem(struct vringh *vrh)
   ^
   static 
   15 warnings generated.


vim +/vringh_init_iomem +1661 drivers/vhost/vringh.c

  1647	
  1648	/**
  1649	 * vringh_init_iomem - initialize a vringh for a vring on io-memory.
  1650	 * @vrh: the vringh to initialize.
  1651	 * @features: the feature bits for this ring.
  1652	 * @num: the number of elements.
  1653	 * @weak_barriers: true if we only need memory barriers, not I/O.
  1654	 * @desc: the userspace descriptor pointer.
  1655	 * @avail: the userspace avail pointer.
  1656	 * @used: the userspace used pointer.
  1657	 *
  1658	 * Returns an error if num is invalid: you should check pointers
  1659	 * yourself!
  1660	 */
> 1661	int vringh_init_iomem(struct vringh *vrh, u64 features, unsigned int num,
  1662			      bool weak_barriers, struct vring_desc *desc,
  1663			      struct vring_avail *avail, struct vring_used *used)
  1664	{
  1665		return vringh_init_kern(vrh, features, num, weak_barriers, desc, avail,
  1666					used);
  1667	}
  1668	EXPORT_SYMBOL(vringh_init_iomem);
  1669	
  1670	/**
  1671	 * vringh_getdesc_iomem - get next available descriptor from vring on io-memory.
  1672	 * @vrh: the vring on io-memory.
  1673	 * @riov: where to put the readable descriptors (or NULL)
  1674	 * @wiov: where to put the writable descriptors (or NULL)
  1675	 * @head: head index we received, for passing to vringh_complete_iomem().
  1676	 * @gfp: flags for allocating larger riov/wiov.
  1677	 *
  1678	 * Returns 0 if there was no descriptor, 1 if there was, or -errno.
  1679	 *
  1680	 * There some notes, and those are same with vringh_getdesc_kern(). Please see
  1681	 * it.
  1682	 */
> 1683	int vringh_getdesc_iomem(struct vringh *vrh, struct vringh_kiov *riov,
  1684				 struct vringh_kiov *wiov, u16 *head, gfp_t gfp)
  1685	{
  1686		int err;
  1687	
  1688		err = __vringh_get_head(vrh, getu16_iomem, &vrh->last_avail_idx);
  1689		if (err < 0)
  1690			return err;
  1691	
  1692		/* Empty... */
  1693		if (err == vrh->vring.num)
  1694			return 0;
  1695	
  1696		*head = err;
  1697		err = __vringh_iov(vrh, *head, riov, wiov, no_range_check, NULL, gfp,
  1698				   copydesc_iomem);
  1699		if (err)
  1700			return err;
  1701	
  1702		return 1;
  1703	}
  1704	EXPORT_SYMBOL(vringh_getdesc_iomem);
  1705	
  1706	/**
  1707	 * vringh_iov_pull_iomem - copy bytes from vring_iov.
  1708	 * @riov: the riov as passed to vringh_getdesc_iomem() (updated as we consume)
  1709	 * @dst: the place to copy.
  1710	 * @len: the maximum length to copy.
  1711	 *
  1712	 * Returns the bytes copied <= len or a negative errno.
  1713	 */
> 1714	ssize_t vringh_iov_pull_iomem(struct vringh *vrh, struct vringh_kiov *riov,
  1715				      void *dst, size_t len)
  1716	{
  1717		return vringh_iov_xfer(vrh, riov, dst, len, xfer_from_iomem);
  1718	}
  1719	EXPORT_SYMBOL(vringh_iov_pull_iomem);
  1720	
  1721	/**
  1722	 * vringh_iov_push_iomem - copy bytes into vring_iov.
  1723	 * @wiov: the wiov as passed to vringh_getdesc_iomem() (updated as we consume)
  1724	 * @src: the place to copy from.
  1725	 * @len: the maximum length to copy.
  1726	 *
  1727	 * Returns the bytes copied <= len or a negative errno.
  1728	 */
> 1729	ssize_t vringh_iov_push_iomem(struct vringh *vrh, struct vringh_kiov *wiov,
  1730				      const void *src, size_t len)
  1731	{
  1732		return vringh_iov_xfer(vrh, wiov, (void *)src, len, xfer_to_iomem);
  1733	}
  1734	EXPORT_SYMBOL(vringh_iov_push_iomem);
  1735	
  1736	/**
  1737	 * vringh_abandon_iomem - we've decided not to handle the descriptor(s).
  1738	 * @vrh: the vring.
  1739	 * @num: the number of descriptors to put back (ie. num
  1740	 *	 vringh_getdesc_iomem() to undo).
  1741	 *
  1742	 * The next vringh_get_kern() will return the old descriptor(s) again.
  1743	 */
> 1744	void vringh_abandon_iomem(struct vringh *vrh, unsigned int num)
  1745	{
  1746		vringh_abandon_kern(vrh, num);
  1747	}
  1748	EXPORT_SYMBOL(vringh_abandon_iomem);
  1749	
  1750	/**
  1751	 * vringh_complete_iomem - we've finished with descriptor, publish it.
  1752	 * @vrh: the vring.
  1753	 * @head: the head as filled in by vringh_getdesc_iomem().
  1754	 * @len: the length of data we have written.
  1755	 *
  1756	 * You should check vringh_need_notify_iomem() after one or more calls
  1757	 * to this function.
  1758	 */
> 1759	int vringh_complete_iomem(struct vringh *vrh, u16 head, u32 len)
  1760	{
  1761		struct vring_used_elem used;
  1762	
  1763		used.id = cpu_to_vringh32(vrh, head);
  1764		used.len = cpu_to_vringh32(vrh, len);
  1765	
  1766		return __vringh_complete(vrh, &used, 1, putu16_iomem, putused_iomem);
  1767	}
  1768	EXPORT_SYMBOL(vringh_complete_iomem);
  1769	
  1770	/**
  1771	 * vringh_notify_enable_iomem - we want to know if something changes.
  1772	 * @vrh: the vring.
  1773	 *
  1774	 * This always enables notifications, but returns false if there are
  1775	 * now more buffers available in the vring.
  1776	 */
> 1777	bool vringh_notify_enable_iomem(struct vringh *vrh)
  1778	{
  1779		return __vringh_notify_enable(vrh, getu16_iomem, putu16_iomem);
  1780	}
  1781	EXPORT_SYMBOL(vringh_notify_enable_iomem);
  1782	
  1783	/**
  1784	 * vringh_notify_disable_iomem - don't tell us if something changes.
  1785	 * @vrh: the vring.
  1786	 *
  1787	 * This is our normal running state: we disable and then only enable when
  1788	 * we're going to sleep.
  1789	 */
> 1790	void vringh_notify_disable_iomem(struct vringh *vrh)
  1791	{
  1792		__vringh_notify_disable(vrh, putu16_iomem);
  1793	}
  1794	EXPORT_SYMBOL(vringh_notify_disable_iomem);
  1795	
  1796	/**
  1797	 * vringh_need_notify_iomem - must we tell the other side about used buffers?
  1798	 * @vrh: the vring we've called vringh_complete_iomem() on.
  1799	 *
  1800	 * Returns -errno or 0 if we don't need to tell the other side, 1 if we do.
  1801	 */
> 1802	int vringh_need_notify_iomem(struct vringh *vrh)
  1803	{
  1804		return __vringh_need_notify(vrh, getu16_iomem);
  1805	}
  1806	EXPORT_SYMBOL(vringh_need_notify_iomem);
  1807	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
