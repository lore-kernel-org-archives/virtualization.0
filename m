From: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: 2.6.25-rc5-mm1 (paravirt/vsmp/no PCI)
Date: Tue, 11 Mar 2008 17:10:40 -0700
Message-ID: <20080312001040.GA6434@localdomain>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <20080311100955.ca113f90.randy.dunlap@oracle.com> <47D6CD04.8060303@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752000AbYCLBcX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47D6CD04.8060303@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <glommer@gmail.com>, shai@scalex86.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 11, 2008 at 11:18:44AM -0700, Jeremy Fitzhardinge wrote:
>Randy Dunlap wrote:
>
>Added Cc:
>
>>On Tue, 11 Mar 2008 01:14:34 -0700 Andrew Morton wrote:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc5/2.6.25-rc5-mm1/
>>>
>>
>>randconfig (x86_64) with
>>PCI=n
>>PARAVIRT=y
>>VSMP=n
>>
>>ends with
>>
>>arch/x86/kernel/built-in.o: In function `is_vsmp_box':
>>(.text+0x1178d): undefined reference to `early_pci_allowed'
>>arch/x86/kernel/built-in.o: In function `is_vsmp_box':
>>(.text+0x117a9): undefined reference to `read_pci_config'
>>arch/x86/kernel/built-in.o: In function `vsmp_init':
>>(.init.text+0x4fcc): undefined reference to `early_pci_allowed'
>>arch/x86/kernel/built-in.o: In function `vsmp_init':
>>(.init.text+0x501a): undefined reference to `read_pci_config'
>>make[1]: *** [.tmp_vmlinux1] Error 1
>>
>>config attached.
>
>   J


Would anyone have objection to have PARAVIRT depend on PCI, since the
vsmp paravirt bits depend on PCI cfg space to determine if the system is
vsmp?   If not, this patch would suffice.

Glauber?

Thanks,
Kiran

---

Make PARAVIRT depend on PCI.

vSMP PARAVIRT ops probe the pci config space to determine if the
system is indeed a ScaleMP vSMP box.  Hence, depend on PCI to enable
PARAVIRT.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.24/arch/x86/Kconfig
===================================================================
--- linux-2.6.24.orig/arch/x86/Kconfig	2008-03-11 16:38:26.000000000 -0700
+++ linux-2.6.24/arch/x86/Kconfig	2008-03-11 16:50:52.000000000 -0700
@@ -384,7 +384,7 @@ source "arch/x86/lguest/Kconfig"
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
-	depends on !(X86_VISWS || X86_VOYAGER)
+	depends on !(X86_VISWS || X86_VOYAGER) && PCI
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
