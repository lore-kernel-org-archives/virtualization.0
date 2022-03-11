Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E16C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Mar 2022 02:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E254741987;
	Fri, 11 Mar 2022 02:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X63tAaY3ALY1; Fri, 11 Mar 2022 02:55:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6CA3341999;
	Fri, 11 Mar 2022 02:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA2AC0012;
	Fri, 11 Mar 2022 02:55:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CDA4C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 02:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35B0E826E7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 02:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xHZKdKH9W1AN
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 02:55:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06A1A81BA8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646967321; x=1678503321;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uemGpo3r1Ljzh7J5aQez3PPGjZxZAPOCkt2/GKim9c8=;
 b=fIm+pMi0s4/eQJkMxF1DAvYI6KiVUfL+2jWuqxNUqanhxV5mknvao5M+
 pMJEtV6MoM4aomXLHz20DxQlVqYK10ROyAm6YQlVpItNRGfKeTcffyV1G
 hJsNQk5oMQl2ZmvDFIakv2zsuTVpweKMUFVPOUApAkKTH7NrZnuraND2l
 d24UJr5OQE5fPEsD2XQBWKujID2V/rueN+GCgnEGkNRDFryZWrEhqncKc
 wC8gg7ZW3Hqm0jybvhlcSgSeEglZyYFKBNBblrjTfz/XfIHwSyZKalJpW
 R12faRK4wjRmaRz+H9dIPzFlp8sWCQYzwaN9NunPzXOPVcKW/uhKEEAlK g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237658216"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; d="scan'208";a="237658216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2022 18:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; d="scan'208";a="688937088"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2022 18:55:16 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nSVQy-0005k9-1G; Fri, 11 Mar 2022 02:55:16 +0000
Date: Fri, 11 Mar 2022 10:55:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jiyong Park <jiyong@google.com>, sgarzare@redhat.com,
 stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com,
 davem@davemloft.net, kuba@kernel.org
Subject: Re: [PATCH 1/2] vsock: each transport cycles only on its own sockets
Message-ID: <202203111023.SPYFGn7W-lkp@intel.com>
References: <20220310125425.4193879-2-jiyong@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310125425.4193879-2-jiyong@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: adelva@google.com, Jiyong Park <jiyong@google.com>, kbuild-all@lists.01.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Hi Jiyong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b]

url:    https://github.com/0day-ci/linux/commits/Jiyong-Park/vsock-cycle-only-on-its-own-socket/20220310-205638
base:   3bf7edc84a9eb4007dd9a0cb8878a7e1d5ec6a3b
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220311/202203111023.SPYFGn7W-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/6219060e1d706d7055fb0829b3bf23c5ae84790e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiyong-Park/vsock-cycle-only-on-its-own-socket/20220310-205638
        git checkout 6219060e1d706d7055fb0829b3bf23c5ae84790e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/vmw_vsock/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/vmw_vsock/vmci_transport.c: In function 'vmci_transport_handle_detach':
>> net/vmw_vsock/vmci_transport.c:808:25: error: 'vmci_transport' undeclared (first use in this function)
     808 |  if (vsk->transport != &vmci_transport)
         |                         ^~~~~~~~~~~~~~
   net/vmw_vsock/vmci_transport.c:808:25: note: each undeclared identifier is reported only once for each function it appears in


vim +/vmci_transport +808 net/vmw_vsock/vmci_transport.c

   800	
   801	static void vmci_transport_handle_detach(struct sock *sk)
   802	{
   803		struct vsock_sock *vsk;
   804	
   805		vsk = vsock_sk(sk);
   806	
   807		/* Only handle our own sockets */
 > 808		if (vsk->transport != &vmci_transport)
   809			return;
   810	
   811		if (!vmci_handle_is_invalid(vmci_trans(vsk)->qp_handle)) {
   812			sock_set_flag(sk, SOCK_DONE);
   813	
   814			/* On a detach the peer will not be sending or receiving
   815			 * anymore.
   816			 */
   817			vsk->peer_shutdown = SHUTDOWN_MASK;
   818	
   819			/* We should not be sending anymore since the peer won't be
   820			 * there to receive, but we can still receive if there is data
   821			 * left in our consume queue. If the local endpoint is a host,
   822			 * we can't call vsock_stream_has_data, since that may block,
   823			 * but a host endpoint can't read data once the VM has
   824			 * detached, so there is no available data in that case.
   825			 */
   826			if (vsk->local_addr.svm_cid == VMADDR_CID_HOST ||
   827			    vsock_stream_has_data(vsk) <= 0) {
   828				if (sk->sk_state == TCP_SYN_SENT) {
   829					/* The peer may detach from a queue pair while
   830					 * we are still in the connecting state, i.e.,
   831					 * if the peer VM is killed after attaching to
   832					 * a queue pair, but before we complete the
   833					 * handshake. In that case, we treat the detach
   834					 * event like a reset.
   835					 */
   836	
   837					sk->sk_state = TCP_CLOSE;
   838					sk->sk_err = ECONNRESET;
   839					sk_error_report(sk);
   840					return;
   841				}
   842				sk->sk_state = TCP_CLOSE;
   843			}
   844			sk->sk_state_change(sk);
   845		}
   846	}
   847	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
