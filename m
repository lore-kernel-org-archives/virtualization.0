From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 0/2] KVM: s390: virtio-ccw adapter interrupts.
Date: Tue,  9 Jul 2013 13:34:15 +0200
Message-ID: <1373369657-51675-1-git-send-email-cornelia.huck__42938.3535324179$1373369682$gmane$org@de.ibm.com>
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

next version of the guest exploitation of virtio-ccw adapter interrupts.

Changes from the last version:

- adapt to latest kvm-next
- changed housekeeping for indicator locations: we now use cacheline-sized
  and aligned areas
- minor tweaks

Cornelia Huck (2):
  KVM: s390: virtio-ccw: Handle command rejects.
  KVM: s390: virtio-ccw adapter interrupt support.

 arch/s390/include/asm/irq.h   |   1 +
 arch/s390/kernel/irq.c        |   1 +
 drivers/s390/kvm/virtio_ccw.c | 314 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 305 insertions(+), 11 deletions(-)

-- 
1.8.2.2
