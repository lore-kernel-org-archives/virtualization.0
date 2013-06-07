From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 0/2] KVM: s390: virtio-ccw adapter interrupts.
Date: Fri,  7 Jun 2013 12:37:09 +0200
Message-ID: <1370601431-46381-1-git-send-email-cornelia.huck__47330.1972415813$1370601492$gmane$org@de.ibm.com>
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
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

here's the guest driver support for adapter interrupts in virtio-ccw.

We use one summary indicator per page of indicators. For each device,
we try to find a space in an indicator where all of its virtqueues fit.

Locking probably needs some more love, but it seems to work fine so far.

Cornelia Huck (2):
  KVM: s390: virtio-ccw: Handle command rejects.
  KVM: s390: virtio-ccw adapter interrupt support.

 arch/s390/include/asm/irq.h   |   1 +
 arch/s390/kernel/irq.c        |   1 +
 drivers/s390/kvm/virtio_ccw.c | 307 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 298 insertions(+), 11 deletions(-)

-- 
1.8.1.6
