From: Mikulas Patocka <mpatocka@redhat.com>
Subject: network performance degradation in virtio_net in 4.12-rc
Date: Mon, 22 May 2017 10:25:19 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1705221003450.20076__17331.005811184$1495463132$gmane$org@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi

I see severe network performance degradation with the kernels 4.12-rc1 and 
4.12-rc2 in the network virtio driver. Download rate drops down to about 
100kB/s.

I bisected it and it is caused by patch 
d85b758f72b05a774045545f24d70980e3e9aac4 ("virtio_net: fix support for 
small rings"). When I revert this patch, the problem goes away.

The host is Debian Jessie with kernel 4.4.62, the guest is Debian Sid with 
kernel 4.12-rc.

Mikulas
