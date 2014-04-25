From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH 0/1] virtio_ccw: exploit virtio_break_device()
Date: Fri, 25 Apr 2014 14:35:26 +0200
Message-ID: <1398429327-31391-1-git-send-email-graalfs@linux.vnet.ibm.com>
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
To: rusty@rustcorp.com.au
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

this patch exploits the new function virtio_break_device() as of your patch
set dated January 15th on linux-kernel@vger.kernel.org.

The patch avoids hang situations during device unregister, when a (block)
device with active IO is hot-unplugged.

Heinz Graalfs (1):
  virtio_ccw: introduce device_lost in virtio_ccw_device

 drivers/s390/kvm/virtio_ccw.c | 49 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 12 deletions(-)

-- 
1.8.3.1
