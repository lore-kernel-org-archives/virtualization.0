From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/3] virtio and vhost-net capacity handling
Date: Wed, 1 Jun 2011 12:49:37 +0300
Message-ID: <cover.1306921434.git.mst__32923.5098594383$1306922285$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

OK, here's a new attempt to use the new capacity api.  I also added more
comments to clarify the logic.  Hope this is more readable.  Let me know
pls.

This is on top of the patches applied by Rusty.

Note: there are now actually 2 calls to fee_old_xmit_skbs on
data path so instead of passing flag '2' to the
second one I thought we can just make each call free up
at least 1 skb. This will work and even might be a bit faster (less
branches), but in the end I discarded this idea as too fragile (relies
on two calls on data path to function properly).

Warning: untested. Posting now to give people chance to
comment on the API.

Michael S. Tsirkin (3):
  virtio_ring: add capacity check API
  virtio_net: fix tx capacity checks using new API
  virtio_net: limit xmit polling

 drivers/net/virtio_net.c     |   65 +++++++++++++++++++++++------------------
 drivers/virtio/virtio_ring.c |    8 +++++
 include/linux/virtio.h       |    5 +++
 3 files changed, 49 insertions(+), 29 deletions(-)

-- 
1.7.5.53.gc233e
