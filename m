From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] Consolidate host virtualization support under
	Virtualization menu
Date: Sat, 15 Sep 2007 13:05:04 +1000
Message-ID: <1189825504.7262.75.camel__1108.88322019509$1189825692$gmane$org@localhost.localdomain>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<1189747124.7262.36.camel@localhost.localdomain>
	<20070914091921.73007c5a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070914091921.73007c5a.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, jengelh@gmx.de
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-09-14 at 09:19 -0700, Randy Dunlap wrote:
> On Fri, 14 Sep 2007 15:18:44 +1000 Rusty Russell wrote:
> 
> > We turn "Virtualization" into a menu, not a config option, since it's
> > actually only used as a menu.  Then we move lguest under that menu.
> 
> so you want to revert the 2007-july-16 merge that changes
> menu -> menuconfig and makes most of the menus consistent in
> presentation.  I'd rather not, but I don't own it.

Ok, I missed that one.  To me it seems gratuitous to create a config
option simply to control a menu.  However if that is considered the
Right Way, here is the "Just move lguest" variant.

> And Yes, lguest does need to be moved into a better location.

Indeed,
Rusty.
===
Move lguest under the virtualization menu.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r c2893801de2a drivers/Kconfig
--- a/drivers/Kconfig	Fri Sep 14 13:24:46 2007 +1000
+++ b/drivers/Kconfig	Fri Sep 14 13:24:49 2007 +1000
@@ -87,6 +87,4 @@ source "drivers/kvm/Kconfig"
 source "drivers/kvm/Kconfig"
 
 source "drivers/uio/Kconfig"
-
-source "drivers/lguest/Kconfig"
 endmenu
diff -r c2893801de2a drivers/kvm/Kconfig
--- a/drivers/kvm/Kconfig	Fri Sep 14 13:24:46 2007 +1000
+++ b/drivers/kvm/Kconfig	Fri Sep 14 13:32:22 2007 +1000
@@ -45,4 +36,8 @@ config KVM_AMD
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
 
-endif # VIRTUALIZATION
+# OK, it's a little counter-intuitive to do this, but it puts it neatly under
+# the virtualization menu.
+source drivers/lguest/Kconfig
+
+endif # VIRTUALIZATION
