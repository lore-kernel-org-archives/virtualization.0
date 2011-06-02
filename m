From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 RFC 0/4] virtio and vhost-net capacity handling
Date: Thu, 2 Jun 2011 18:42:35 +0300
Message-ID: <cover.1307029008.git.mst__5660.32267311147$1307029488$gmane$org@redhat.com>
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

Warning: untested. Posting now to give people chance to
comment on the API.

Changes from v1:
- fix comment in patch 2 to correct confusion noted by Rusty
- rewrite patch 3 along the lines suggested by Rusty
  note: it's not exactly the same but I hope it's close
  enough, the main difference is that mine does limited
  polling even in the unlikely xmit failure case.
- added a patch to not return capacity from add_buf
  it always looked like a weird hack

Michael S. Tsirkin (4):
  virtio_ring: add capacity check API
  virtio_net: fix tx capacity checks using new API
  virtio_net: limit xmit polling
  Revert "virtio: make add_buf return capacity remaining:

 drivers/net/virtio_net.c     |  111 ++++++++++++++++++++++++++----------------
 drivers/virtio/virtio_ring.c |   10 +++-
 include/linux/virtio.h       |    7 ++-
 3 files changed, 84 insertions(+), 44 deletions(-)

-- 
1.7.5.53.gc233e
