From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH net-next] vhost_net: do not stall on zerocopy depletion
Date: Sun, 1 Oct 2017 08:09:30 +0800
Message-ID: <201710010753.KeY9a5xF%fengguang.wu__17229.4904631146$1506816597$gmane$org@intel.com>
References: <20170928002556.41240-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170928002556.41240-1-willemdebruijn.kernel@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, mst@redhat.com, netdev@vger.kernel.org, den@klaipeden.com, virtualization@lists.linux-foundation.org, kbuild-all@01.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Hi Willem,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Willem-de-Bruijn/vhost_net-do-not-stall-on-zerocopy-depletion/20171001-054709
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +440 drivers/vhost/net.c

   433	
   434	static bool vhost_exceeds_maxpend(struct vhost_net *net)
   435	{
   436		struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
   437		struct vhost_virtqueue *vq = &nvq->vq;
   438	
   439		return (nvq->upend_idx + UIO_MAXIOV - nvq->done_idx) % UIO_MAXIOV >
 > 440		       min(VHOST_MAX_PEND, vq->num >> 2);
   441	}
   442	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
