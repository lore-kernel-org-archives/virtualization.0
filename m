From: Amit Shah <amit.shah@redhat.com>
Subject: virtio-serial: An interface for host-guest communication
Date: Mon, 27 Jul 2009 23:34:32 +0530
Message-ID: <1248717876-17630-1-git-send-email-amit.shah__17567.4950042323$1248718174$gmane$org@redhat.com>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


Hello all,

This are the latest version of the patches.

Lots of things have changed since the last submission. A few of
which I remember:
- VNC copy / paste works* (* conditions apply)
  - client vnc copies get propagated to guest port 3 (/dev/vmch3)
  - guest writes to port 3 (/dev/vmch3) go straight to client's clipboard
- sysfs hooks to autodiscover ports
- support for 64 ports in this version (MAX_VIRTIO_SERIAL_PORTS). More
  ports can be added by introducing a new feature flag to maintain
  backward compat. However, till this code gets accepted upstream, the
  value of that #define can change. I think 64 ports are enough for
  everyone.
- remove support for control queue (though this queue could make a
  comeback for just one use-case that I can currently think of:
  to prevent rogue (host) userspace putting lots of data into a guest
  that goes unconsumed for a while, increasing the memory pressure. To
  prevent this a threshold level can be decided upon and a control
  message can be sent to host userspace to prevent any more writes
  to the port.
- numerous fixes

There still exist a few kmalloc/kfree-related debug logs that spew up
in the guest but I haven't been able to track them down.

As for the merge with virtio-console, Christian has voiced some oppostion
to that idea. For the merge to happen, the kernel folks have to agree
in merging the driver as well and I can proceed once we have a resolution
on this.

Other than that, a few more rebases have to be done to the qemu code to
make it apply to qemu-upstream.

Please give this a good review. 

Thanks,
	Amit.
