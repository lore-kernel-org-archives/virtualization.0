From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH 0/2] virtio-mmio updates for 3.7
Date: Mon, 24 Sep 2012 14:33:40 +0100
Message-ID: <1348493622-26091-1-git-send-email-pawel.moll@arm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Brian Foley <brian.foley@arm.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Rusty,

Would you be so kind and consider getting those two small fixes into
3.7 merge? All credits go to Brian, all shame on me :-)

Cheers!

Pawel

Brian Foley (2):
  virtio_mmio: fix off by one error allocating queue
  virtio_mmio: Don't attempt to create empty virtqueues

 drivers/virtio/virtio_mmio.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
1.7.9.5
