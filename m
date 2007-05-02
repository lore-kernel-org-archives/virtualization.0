From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RELEASE] Lguest for 2.6.21
Date: Thu, 03 May 2007 00:43:48 +1000
Message-ID: <1178117028.19815.14.camel__24911.6121944555$1178151535$gmane$org@localhost.localdomain>
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
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	Lguest is a simple hypervisor which runs Linux under Linux, without
needing VT hardware.

	Two people asked if I had a version of lguest which worked on
other-than-bleeding-edge-mm kernels, so I did a backport of the latest
version to 2.6.21.

	http://lguest.ozlabs.org/lguest-2.6.21-254.patch.gz

See Documentation/lguest/lguest.txt for how to run,
drivers/lguest/README for the draft code documentation journey.

Bug or even success reports always welcome!
Rusty.


Quickstart:

$ cd linux-2.6.21
$ zcat /tmp/lguest-2.6.21-254.patch.gz | patch -p1
$ make
	- Say "y" to CONFIG_EXPERIMENTAL, "m" to CONFIG_LGUEST.
$ make modules_install
$ make -C Documentation/lguest
$ sudo Documentation/lguest/lguest --block=<some-convenient-raw-image> \
	128 vmlinux root=/dev/lgba

Three ^C's within one second will kill the guest.
