From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2] Adapter interrupts for virtio-ccw.
Date: Tue,  9 Jul 2013 13:33:50 +0200
Message-ID: <1373369631-3148-1-git-send-email-cornelia.huck__1970.636615488$1373369662$gmane$org@de.ibm.com>
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

here's again my proposal for adapter (thin) interrupt support for virtio-ccw
devices, originally posted at
http://marc.info/?l=linux-virtualization&m=137060143904927&w=2

The document is unchanged, only rebased against current master.

Cornelia Huck (1):
  virtio-ccw: Document adapter interrupts.

 virtio-spec.lyx |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 3 deletions(-)

-- 
1.7.9.5
