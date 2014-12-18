From: Benjamin Coddington <bcodding@redhat.com>
Subject: loading upstream v3.18-11290-g44e8967: virtio_pci: unknown symbols
Date: Thu, 18 Dec 2014 14:17:10 -0500 (EST)
Message-ID: <alpine.OSX.2.19.9992.1412181335040.62182@planck.local>
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
To: virtualization@lists.linux-foundation.org
Cc: bcodding@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Hi list, I'm having a problem at boot before root mounts.

virtio_pci fails to load because of unknown symbols:
vring_transport_features
irq_set_affinity_hint

... and more.

Is drivers/virtio/virtio_pci_legacy.c missing MODULE_LICENSE("GPL"); ?

Not sure if that's the right fix or I'm doing something stupid..

Ben
