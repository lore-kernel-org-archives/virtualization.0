From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net 0/4] Fix several issues of virtio-net mergeable XDP
Date: Mon, 21 May 2018 16:35:02 +0800
Message-ID: <1526891706-18516-1-git-send-email-jasowang__28760.2876117036$1526891591$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi:

Please review the patches that tries to fix sevreal issues of
virtio-net mergeable XDP.

Thanks

Jason Wang (4):
  virtio-net: correctly redirect linearized packet
  virtio-net: correctly transmit XDP buff after linearizing
  virtio-net: reset num_buf to 1 after linearizing packet
  virito-net: fix leaking page for gso packet during mergeable XDP

 drivers/net/virtio_net.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.7.4
