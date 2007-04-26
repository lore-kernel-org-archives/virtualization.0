From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Xen/paravirt_ops kernel available for testing
Date: Thu, 26 Apr 2007 13:23:52 -0700
Message-ID: <46310A58.4090207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Xen-devel <xen-devel@lists.xensource.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

I'm pleased to announce a Xen paravirt_ops kernel available for testing
at http://xenbits.xensource.com/ext/paravirt_ops/.

These kernels are based on this morning's 2.6.21, along with all the
paravirt_ops + Xen patches.  The pre-built i386 kernel RPM is based on
the FC6 configuration, and it has both Xen and VMI paravirt_ops support
enabled.  Unfortunately the RPM is a bit rough, and you'll need to
generate an initrd and update your boot-loader to make it bootable.  To
boot under Xen, use /boot/vmlinux-.gz as the kernel image.

This is definitely a testing snapshot release, but it has had a bit of
testing.  I've been using it running native on my main work machine, and
it behaves exactly like a non-paravirt kernel.  It has also been tested
under Xen on XenRT, XenSource's automated testing infrastructure, where
it passes almost everything.

There are a couple of expected BUG messages which appear on boot: one in
init_sched_clock, and one in xen_apic_read.  Both are harmless warning
messages, and will be removed shortly.  (However, if you see more than
one xen_apic_read warning, please send me the details along with your
kernel config.)

Please see the RELEASE*.txt for release notes.

    J
