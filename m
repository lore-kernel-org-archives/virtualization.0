From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/2] virtio: recover from vector assignment failure
Date: Thu, 23 Jul 2009 18:45:22 +0300
Message-ID: <20090723154522.GA13965__11286.7391006604$1248364131$gmane$org@redhat.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redha
List-Id: virtualization@lists.linuxfoundation.org

This patch series fixes a regression reported by Amit Shah
(see Subject: Re: qemu-kvm missing some msix capability check,
 Message-Id: 20090723142550.GA4470@amit-x200.redhat.com)

Since Amit's testing, I have refactored the change slightly to make the
patch smaller.

Rusty, can this go in for 2.6.31, or do you think it's too big a change?
As an alternative work-around, we possibly could do something in qemu in
host to make it less likely that mapping vq to vector fails - but it
seems that we still want the guest to handle the error as gracefully as
possible, right?

-- 
MST


Michael S. Tsirkin (2):
  virtio: delete vq from list
  virtio: retry on vector assignment failure

 drivers/virtio/virtio_pci.c |  136 ++++++++++++++++++++++++-------------------
 1 files changed, 76 insertions(+), 60 deletions(-)
