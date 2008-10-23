From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [PATCH 7/16 v6] PCI: cleanup pcibios_allocate_resources()
Date: Thu, 23 Oct 2008 00:10:26 -0700
Message-ID: <86802c440810230010redfbbe7oaf94bf2077ccdcdf__41464.2030177221$1224772169$gmane$org@mail.gmail.com>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084241.GG3773@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081022084241.GG3773@yzhao12-linux.sh.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 22, 2008 at 1:42 AM, Yu Zhao <yu.zhao@intel.com> wrote:
> This cleanup makes pcibios_allocate_resources() easier to read.
>
> Cc: Alex Chiang <achiang@hp.com>
> Cc: Grant Grundler <grundler@parisc-linux.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Jesse Barnes <jbarnes@virtuousgeek.org>
> Cc: Matthew Wilcox <matthew@wil.cx>
> Cc: Randy Dunlap <randy.dunlap@oracle.com>
> Cc: Roland Dreier <rdreier@cisco.com>
> Signed-off-by: Yu Zhao <yu.zhao@intel.com>
>
> ---
>  arch/x86/pci/i386.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index 844df0c..8729bde 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -147,7 +147,7 @@ static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
>  static void __init pcibios_allocate_resources(int pass)
>  {
>        struct pci_dev *dev = NULL;
> -       int idx, disabled;
> +       int idx, enabled;
>        u16 command;
>        struct resource *r, *pr;
>
> @@ -160,22 +160,22 @@ static void __init pcibios_allocate_resources(int pass)
>                        if (!r->start)          /* Address not assigned at all */
>                                continue;
>                        if (r->flags & IORESOURCE_IO)
> -                               disabled = !(command & PCI_COMMAND_IO);
> +                               enabled = command & PCI_COMMAND_IO;
>                        else
> -                               disabled = !(command & PCI_COMMAND_MEMORY);
> -                       if (pass == disabled) {
> -                               dev_dbg(&dev->dev, "resource %#08llx-%#08llx (f=%lx, d=%d, p=%d)\n",
> +                               enabled = command & PCI_COMMAND_MEMORY;
> +                       if (pass == enabled)
> +                               continue;

it seems you change the flow here for MMIO
because PCI_COMMAND_MEMORY is 2.

YH
