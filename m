From: Alok Kataria <akataria@vmware.com>
Subject: Re: [PATCH] Add an entry in MAINTAINERS for VMware's hypervisor
	interface
Date: Thu, 05 Sep 2013 10:16:53 +0530
Message-ID: <1378356413.9739.7446.camel@akataria-dtop.eng.vmware.com>
References: <1378284821.9739.7404.camel@akataria-dtop.eng.vmware.com>
	<1378314979.1787.24.camel@joe-AO722>
Reply-To: Alok Kataria <akataria@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1378314979.1787.24.camel@joe-AO722>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Doug Covelli <dcovelli@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-09-04 at 10:16 -0700, Joe Perches wrote:
> On Wed, 2013-09-04 at 14:23 +0530, Alok Kataria wrote:
> > Hey,
> > 
> > This change adds an entry to the maintainers file to explicitly state
> > that any changes to vmware.c should be sent to the authors of the file
> > as well.
> 
> It never hurts to add MAINTAINER entries.
> 
> > If you are thinking why do this now, off late we have seen quite a few
> > changes that touched the "arch/x86/kernel/cpu/vmware.c" file but were
> > not directed to me, someone else made me aware of those changes.
> 
> Many people don't use get_maintainer
> 
> > It
> > could be that my use of different SOB lines "Alok N Kataria" vs "Alok
> > Kataria" confuses get_maintainer.pl,
> 
> That shouldn't be a problem unless the email addresses are
> also different.
> 
> > +++ linux-2.6/MAINTAINERS	2013-09-04 14:20:39.714026943 +0530
> []
> > +VMWARE HYPERVISOR INTERFACE
> > +M: Alok Kataria <akataria@vmware.com>
> > +L: virtualization@lists.linux-foundation.org
> > +S: Supported
> > +F: arch/x86/kernel/cpu/vmware.c
> > +
> 
> It'd be nicer to use tabs after the colon

Oops, my current workspace had a different tab setting, thanks for
noticing. Regenerated the diffs on latest tip, tree. Peter can you
please apply this one as well. 
---

Fix whitespace issues. 

Signed-off-by: Alok Kataria <akataria@vmware.com>

Index: linux.trees.git/MAINTAINERS
===================================================================
--- linux.trees.git.orig/MAINTAINERS	2013-09-05 10:11:31.784339571 +0530
+++ linux.trees.git/MAINTAINERS	2013-09-05 10:11:47.364339672 +0530
@@ -9041,10 +9041,10 @@
 F:	include/linux/vme*
 
 VMWARE HYPERVISOR INTERFACE
-M: Alok Kataria <akataria@vmware.com>
-L: virtualization@lists.linux-foundation.org
-S: Supported
-F: arch/x86/kernel/cpu/vmware.c
+M:	Alok Kataria <akataria@vmware.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Supported
+F:	arch/x86/kernel/cpu/vmware.c
 
 VMWARE VMXNET3 ETHERNET DRIVER
 M:	Shreyas Bhatewara <sbhatewara@vmware.com>
