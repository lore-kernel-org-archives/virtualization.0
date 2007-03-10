From: Zachary Amsden <zach@vmware.com>
Subject: Re: PATCH: Fix VMI and COMPAT_VDSO for 2.6.21
Date: Fri, 09 Mar 2007 23:01:21 -0800
Message-ID: <45F257C1.4070904@vmware.com>
References: <45F2578E.3060907@vmware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090606070209090205050408"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F2578E.3060907@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090606070209090205050408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Zachary Amsden wrote:
> VMI is broken under COMPAT_VDSO, as Xen and other non hardware 
> assisted hypervisors will be.  I have been working on a fix for this 
> which works for older glibcs that panic when the new relocatable VDSO 
> is used.  However, I believe at this time that the fix is going to be 
> too radical to consider at this stage in the release of 2.6.21.  We 
> don't expect this config option to be turned on by vendors for new 
> distributions, so at this point we are willing to drop support for it 
> when VMI is compiled in, and work on a patch for 2.6.22 which more 
> fully addresses the problem.
>
> Please apply, thanks.

I suppose it would be better if I attached the patch.

Zach

--------------090606070209090205050408
Content-Type: text/plain;
 name="vmi-depends-on-not-compat-vdso.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmi-depends-on-not-compat-vdso.patch"

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.21/arch/i386/Kconfig
===================================================================
--- linux-2.6.21.orig/arch/i386/Kconfig	2007-03-06 18:51:33.000000000 -0800
+++ linux-2.6.21/arch/i386/Kconfig	2007-03-09 22:36:15.000000000 -0800
@@ -220,7 +220,7 @@ config PARAVIRT
 
 config VMI
 	bool "VMI Paravirt-ops support"
-	depends on PARAVIRT
+	depends on PARAVIRT && !COMPAT_VDSO
 	help
 	  VMI provides a paravirtualized interface to the VMware ESX server
 	  (it could be used by other hypervisors in theory too, but is not

--------------090606070209090205050408
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------090606070209090205050408--
