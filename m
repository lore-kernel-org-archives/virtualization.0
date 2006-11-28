From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Date: Tue, 28 Nov 2006 15:36:35 -0800
Message-ID: <20061128153635.abaeb1fc.randy.dunlap@oracle.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061115231626.GC31879@stusta.de>
	<20061115153614.a71f944d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20061115153614.a71f944d.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: zippel@linux-m68k.org, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 15 Nov 2006 15:36:14 -0800 Andrew Morton wrote:

> On Thu, 16 Nov 2006 00:16:26 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> =

> > Paravirt breaks CONFIG_X86_PAE=3Dy compilation:
> > =

> > <--  snip  -->
> > =

> > ...
> >   CC      init/main.o
> > In file included from include2/asm/pgtable.h:245,
> >                  from =

> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/mm.h:40,
> >                  from =

> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/poll.h:1=
1,
> >                  from =

> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/rtc.h:11=
3,
> >                  from =

> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/efi.h:19,
> >                  from =

> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/init/main.c:43:
> > include2/asm/pgtable-3level.h:108: error: redefinition of 'pte_clear'
> > include2/asm/paravirt.h:365: error: previous definition of 'pte_clear' =
was here
> > include2/asm/pgtable-3level.h:115: error: redefinition of 'pmd_clear'
> > include2/asm/paravirt.h:370: error: previous definition of 'pmd_clear' =
was here
> > make[2]: *** [init/main.o] Error 1
> > =

> =

> So it does.  Zach will save us.
> =

> How come allmodconfig doesn't select highmem?

Must be because of "choice" and its default:

choice
	prompt "High Memory Support"
	default NOHIGHMEM

Changing the default fixes it.  I suppose conf.c could be
hacked to do something different on choices, but it's not
clear how/what to do there as a general rule.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Make ix86 default to HIGHMEM4G instead of NOHIGHMEM.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19-rc6-git10.orig/arch/i386/Kconfig
+++ linux-2.6.19-rc6-git10/arch/i386/Kconfig
@@ -443,7 +443,8 @@ source "drivers/firmware/Kconfig"
 =

 choice
 	prompt "High Memory Support"
-	default NOHIGHMEM
+	default HIGHMEM4G if !X86_NUMAQ
+	default HIGHMEM64G if X86_NUMAQ
 =

 config NOHIGHMEM
 	bool "off"
