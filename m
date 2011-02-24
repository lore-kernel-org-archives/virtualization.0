From: Chuck Ebbert <cebbert@redhat.com>
Subject: Can't build in the virtio console driver on x86_64 when the other
	virtio drivers are modular
Date: Thu, 24 Feb 2011 11:28:19 -0500
Message-ID: <20110224112819.10f59f68__47468.9393690371$1298565168$gmane$org@katamari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The virtio configuration options are inconsistent. According to this,
every options that needs virtio will select it:

 # Virtio always gets selected by whoever wants it.
 config VIRTIO
        tristate

Note that it's not user-selectable, so any config file that tries to
set it will be ignored when kconfig loads those options. And yet we
have a whole set of options that depend on VIRTIO, like VIRTIO_CONSOLE
for example. This makes it impossible to have VIRTIO_PCI modular and
VIRTIO_CONSOLE built-in on x86_64, because:

1. VIRTIO_PCI selects VIRTIO and sets it to M
2. VIRTIO_CONSOLE gets forced to M because one of its dependencies is M

So either VIRTIO (and VIRTIO_RING) need to be user-selectable, or all
of the options that depend on VIRTIO need to be changed to select it
instead.

(For even more fun, LGUEST_GUEST on i386 forces VIRTIO, VIRTIO_RING and
VIRTIO_CONSOLE all to Y.)
