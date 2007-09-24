From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/3] virtio implementation (draft VI)
Date: Mon, 24 Sep 2007 19:13:14 +1000
Message-ID: <1190625194.27805.199.camel__39970.3418057927$1190625434$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

I'm not reposting the drivers this time since they haven't changed
significantly.  See http://lguest.ozlabs.org/patches for the whole
thing, from new-io.patch onwards).

Changes since last version:
	- Switch to our own bus implementation, rather than relying on
	  an implementation-specific bus to back this up.

	- Make virtio_config_ops much higher-level, don't assume layout
	  of config space.

	- Expose "struct virtqueue" again and move ops inside that.

	- virtio_ring uses 64 bit address, 32 bit length, not addr64 +
	  offset16 + len16.

	- flags in virtio_ring to allow suppression of interrupts (by
	  guest) or notifications (by host).

I'm not too unhappy with this as it stands.  Feedback welcome!

Cheers,
Rusty.
