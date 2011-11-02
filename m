From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 0/2] virtio-pci: polling mode support
Date: Wed, 2 Nov 2011 21:02:42 +0200
Message-ID: <cover.1320259840.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Stefan Weil <weil@mail.berlios.de>, Avi Kivity <avi@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

MSIX spec requires that device can be operated with
all vectors masked, by polling.

So the following patchset (lightly tested) adds this
ability: when driver reads ISR, the device
recalls a pending notification, and returns
pending status in the ISR register.

The polling driver can operate as follows:
- map all VQs and config to the same vector
- poll ISR to get status - this also flushes VQ updates to memory
- handle config change or VQ event depending on ISR

Comments?

-- 
1.7.5.53.gc233e
