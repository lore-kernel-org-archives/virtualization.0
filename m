From: "Samuel Masham" <samuel.masham@gmail.com>
Subject: Re: [kvm-devel] [PATCH 1/1] QEMU/KVM: Support for PCI Passthrough
Date: Mon, 14 Apr 2008 09:31:07 +0900
Message-ID: <93564eb70804131731x1e08554due1e0c1bf9665e77f__25380.1414547072$1208185863$gmane$org@mail.gmail.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-2-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-3-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-4-git-send-email-amit.shah@qumranet.com>
	<1208090956.17832.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1208090956.17832.89.camel@localhost.localdomain>
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
To: dor.laor@qumranet.com
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Apr 13, 2008 at 9:49 PM, Dor Laor <dor.laor@qumranet.com> wrote:
>  On Thu, 2008-04-10 at 11:48 +0300, Amit Shah wrote:
>  > If kvm uses the in-kernel irqchip, interrupts are routed to
>  > the guest via the kvm module (accompanied kernel changes are necessar).
>  > If -no-kvm-irqchip is used, the 'irqhook' module, also included here,
>  > is to be used.
>  >
>
>  IMO we can drop the pci pass through support in userspace and only keep
>  the in-kenel chip path. Normally we do want the option of running w/o
>  kernel devices but it's only to test for regressions against userspace.
>  In this case it's all new code so there is no point to compare, it's
>  just lots of complicated code (userspace apic, irqhook module) that only
>  helpful for qemu. Since it's not likely qemu will merge it, let's stick
>  with the main path.
>  Comments?

Please keep the userspace support alive.

I am particularly interested in using the pci-passthough to qemu
running non x86 system emulation
(at the moment mips)

My hope is that the pci - passthough could help with developing
drivers and testing across architectures...

Samuel




>  Dor
>
>
>  > Signed-off-by: Amit Shah <amit.shah@qumranet.com>
>  > ---
>  >  Makefile                  |   10 +-
>  >  irqhook/Kbuild            |    3 +
>  >  irqhook/Makefile          |   25 ++
>  >  irqhook/irqhook_main.c    |  215 ++++++++++++++
>  >  kernel/Makefile           |    4 +
>  >  libkvm/libkvm-x86.c       |   14 +-
>  >  libkvm/libkvm.h           |   24 ++
>  >  qemu/Makefile.target      |    1 +
>  >  qemu/hw/apic.c            |    2 +
>  >  qemu/hw/isa.h             |    2 +
>  >  qemu/hw/pc.c              |    4 +
>  >  qemu/hw/pci-passthrough.c |  677 +++++++++++++++++++++++++++++++++++++++++++++
>  >  qemu/hw/pci-passthrough.h |  102 +++++++
>  >  qemu/hw/pci.c             |   11 +
>  >  qemu/hw/pci.h             |    1 +
>  >  qemu/hw/piix_pci.c        |   19 ++
>  >  qemu/vl.c                 |   16 +
>  >  tools/pci_barsize.c       |   53 ++++
>  >  tools/pci_mmio.c          |   82 ++++++
>  >  19 files changed, 1260 insertions(+), 5 deletions(-)
>  >
>
>
>
>
>
> -------------------------------------------------------------------------
>  This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
>  Don't miss this year's exciting event. There's still time to save $100.
>  Use priority code J8TL2D2.
>  http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
>  _______________________________________________
>  kvm-devel mailing list
>  kvm-devel@lists.sourceforge.net
>  https://lists.sourceforge.net/lists/listinfo/kvm-devel
>
