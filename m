From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] virtio and vhost-net performance enhancements
Date: Thu, 5 May 2011 18:07:56 +0300
Message-ID: <cover.1304605816.git.mst__32426.5214534991$1304608236$gmane$org@redhat.com>
References: <cover.1304541918.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1304541918.git.mst@redhat.com>
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

Here are a couple of minor fixes suggested on list.
Applies on top of the previous patchset.

As before result pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost-net-next-event-idx-v1

Michael S. Tsirkin (3):
  virtio: fix avail event support
  virtio_ring: check used_event offset
  virtio_ring: need_event api comment fix

 drivers/virtio/virtio_ring.c |    2 +-
 include/linux/virtio_ring.h  |   10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
1.7.5.53.gc233e
