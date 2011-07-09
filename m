From: Raghavendra D Prabhu <rprabhu@wnohang.net>
Subject: Re: [TOME] Re: [Xen-devel] Re: [PATCH] Modpost section mismatch fix
	(for platform-pci-unplug.c)
Date: Sat, 9 Jul 2011 21:59:07 +0530
Message-ID: <20110709162907.GA4437__3830.45934509045$1310229113$gmane$org@Xye>
References: <20110705141323.GG2972@dumpdata.com> <20110705142731.GA4463@Xye>
	<20110705144846.GA13548@dumpdata.com>
	<20110705213243.GA3647@dumpdata.com> <20110707154648.GA4394@Xye>
	<20110707162454.GA8164@dumpdata.com> <20110707194851.GB4394@Xye>
	<20110707200949.GA25216@dumpdata.com> <20110707210429.GD4394@Xye>
	<20110708202628.GA25998@dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110708202628.GA25998@dumpdata.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jeremy.fitzhardinge@citrix.com, Ian Campbell <ijc@hellion.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

* On Fri, Jul 08, 2011 at 04:26:28PM -0400, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
>> >>Also,
>> >>I had sent another change (oneline) for the file
>> >>arch/x86/xen/platform-pci-unplug.c for check_platform_magic, looks like that has not gone into
>> >>the pull request for Linus.

>> >Oh, I didn't see it. Did you CC me on it? Can you bounce it to me please?

>> =========================
>>  diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
>>  index 25c52f9..ffcf261 100644
>>  --- a/arch/x86/xen/platform-pci-unplug.c
>>  +++ b/arch/x86/xen/platform-pci-unplug.c
>>  @@ -35,7 +35,7 @@ EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
>>   #ifdef CONFIG_XEN_PVHVM
>>   static int xen_emul_unplug;

>>  -static int __init check_platform_magic(void)
>>  +static int check_platform_magic(void)
>>   {
>>          short magic;
>>          char protocol;
>>  --

>
>Yeah, that would cause an issue during suspend/resume by PVonHVM. How
>we didn't trip over this I've no idea..
>
>Anyhow, can you provide me with your Signed-off-by please and I will queue
>it right up.
Sorry for missing the Signed-off thing (was there in original one I had sent).
===========================================================

   Removing __init from check_platform_magic since it is called by
xen_unplug_emulated_devices in non-init contexts (It probably gets inlined
because of -finline-functions-called-once, removing __init is more to avoid
mismatch being reported).

  Signed-off-by: Raghavendra D Prabhu <rprabhu@wnohang.net>
  ---
   arch/x86/xen/platform-pci-unplug.c |    2 +-

  diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
  index fe00830..fb5eeb0 100644
  --- a/arch/x86/pci/xen.c
  +++ b/arch/x86/pci/xen.c
  @@ -327,7 +327,7 @@ int __init pci_xen_hvm_init(void)
   }

   #ifdef CONFIG_XEN_DOM0
  -static int xen_register_pirq(u32 gsi, int triggering)
  +static  __refdata  int xen_register_pirq(u32 gsi, int triggering)
   {
          int rc, pirq, irq = -1;
          struct physdev_map_pirq map_irq;
  diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
  index 25c52f9..ffcf261 100644
  --- a/arch/x86/xen/platform-pci-unplug.c
  +++ b/arch/x86/xen/platform-pci-unplug.c
  @@ -35,7 +35,7 @@ EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
   #ifdef CONFIG_XEN_PVHVM
   static int xen_emul_unplug;

  -static int __init check_platform_magic(void)
  +static int check_platform_magic(void)
   {
          short magic;
          char protocol;
  --

>
>Stefano, you OK with this patch?
>
--------------------------
Raghavendra Prabhu
GPG Id : 0xD72BE977
Fingerprint: B93F EBCB 8E05 7039 CD3C A4B8 A616 DCA1 D72B E977
www: wnohang.net
