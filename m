From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/6] virtio with config abstraction and ring implementation
Date: Thu, 20 Sep 2007 22:03:28 +1000
Message-ID: <1190289808.7262.223.camel__18183.2688548186$1190290028$gmane$org@localhost.localdomain>
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
Cc: Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	This patch series attempts to come closer to unifying kvm and lguest's
usage of virtio.  As these two are the first implementations we've seen,
I hope making them closer will make future ones closer too.

	Drivers now unpack their own configuration: their probe() methods are
uniform.  The configuration mechanism is extensible and can be backed by
PCI, a string of bytes, or something else.

	I've abstracted out the lguest ring buffer code into a common library.
The format has changed slightly (mainly because I had an epiphany about
inter-guest I/O).

	I also implemented a console (lguest needs one).

	Finally, there is a working lguest implementation.  Unfortunately,
lguest is being refactored for non-i386 ports, so the virtio patches sit
at the end of the (quite long) for-2.6.24 patchqueue.  Nonetheless, they
can be found at http://lguest.ozlabs.org/patches (click on bz2 to get
the series).

Cheers!
Rusty.
