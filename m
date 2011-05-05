From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] virtio_ring: need_event api comment fix
Date: Thu, 5 May 2011 18:08:17 +0300
Message-ID: <c8b6d8a8df4927826d0024fceeb68726c50d0b1a.1304605817.git.mst__42980.4157851779$1304608285$gmane$org@redhat.com>
References: <cover.1304605816.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1304605816.git.mst@redhat.com>
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

fix typo in a comment: size -> side

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 089cbf2..0a45c6e 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -131,7 +131,7 @@ static inline unsigned vring_size(unsigned int num, unsigned long align)
 }
 
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
-/* Assuming a given event_idx value from the other size, if
+/* Assuming a given event_idx value from the other side, if
  * we have just incremented index from old to new_idx,
  * should we trigger an event? */
 static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
-- 
1.7.5.53.gc233e
