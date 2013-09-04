From: Alok Kataria <akataria@vmware.com>
Subject: [PATCH] Add an entry in MAINTAINERS for VMware's hypervisor interface
Date: Wed, 04 Sep 2013 14:23:41 +0530
Message-ID: <1378284821.9739.7404.camel@akataria-dtop.eng.vmware.com>
Reply-To: Alok Kataria <akataria@vmware.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, the arch/x86 maintainers <x86@kernel.org>
Cc: Doug Covelli <dcovelli@vmware.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hey,

This change adds an entry to the maintainers file to explicitly state
that any changes to vmware.c should be sent to the authors of the file
as well.

If you are thinking why do this now, off late we have seen quite a few
changes that touched the "arch/x86/kernel/cpu/vmware.c" file but were
not directed to me, someone else made me aware of those changes. It
could be that my use of different SOB lines "Alok N Kataria" vs "Alok
Kataria" confuses get_maintainer.pl, but adding this entry in
MAINTAINERS should solve the problem at hand. For one of the changes
[1], I did verify that get_maintainer.pl, now expectedly includes me in
the cc list.

Thanks,
Alok 

[1] http://marc.info/?l=linux-kernel&m=137571112610984&w=2

From : Alok Kataria <akataria@vmware.com>

Add an entry in MAINTAINERS file to reflect the authors of a file.

Signed-off-by: Alok Kataria <akataria@vmware.com>

Index: linux-2.6/MAINTAINERS
===================================================================
--- linux-2.6.orig/MAINTAINERS	2013-09-04 14:07:34.404027068 +0530
+++ linux-2.6/MAINTAINERS	2013-09-04 14:20:39.714026943 +0530
@@ -9038,6 +9038,12 @@
 F:	drivers/vme/
 F:	include/linux/vme*
 
+VMWARE HYPERVISOR INTERFACE
+M: Alok Kataria <akataria@vmware.com>
+L: virtualization@lists.linux-foundation.org
+S: Supported
+F: arch/x86/kernel/cpu/vmware.c
+
 VMWARE VMXNET3 ETHERNET DRIVER
 M:	Shreyas Bhatewara <sbhatewara@vmware.com>
 M:	"VMware, Inc." <pv-drivers@vmware.com>
