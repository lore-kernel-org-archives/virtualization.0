From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC] qemu: Adapter interrupts for virtio-ccw.
Date: Fri,  7 Jun 2013 12:37:07 +0200
Message-ID: <1370601428-23447-1-git-send-email-cornelia.huck__31966.5363560945$1370601469$gmane$org@de.ibm.com>
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

here's the qemu patch that implements the new adapter indicators ccw
in virtio-ccw and injects adapter interrupts for the devices enabled
for it.

Cornelia Huck (1):
  s390/virtio-ccw: Adapter interrupt support.

 hw/s390x/css.c        |   10 ++++++++
 hw/s390x/css.h        |    2 ++
 hw/s390x/virtio-ccw.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/virtio-ccw.h |    4 +++
 target-s390x/ioinst.h |    2 ++
 target-s390x/kvm.c    |    8 ++++--
 trace-events          |    1 +
 7 files changed, 90 insertions(+), 3 deletions(-)

-- 
1.7.9.5
