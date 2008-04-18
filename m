From: Amit Shah <amit.shah@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 1/1] QEMU/KVM: Support for PCI Passthrough
Date: Fri, 18 Apr 2008 11:09:51 +0530
Message-ID: <200804181109.52123.amit.shah__15766.5950748653$1208497398$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<1208090956.17832.89.camel@localhost.localdomain>
	<93564eb70804131731x1e08554due1e0c1bf9665e77f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <93564eb70804131731x1e08554due1e0c1bf9665e77f@mail.gmail.com>
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
To: Samuel Masham <samuel.masham@gmail.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

* On Monday 14 Apr 2008 06:01:07 Samuel Masham wrote:
> On Sun, Apr 13, 2008 at 9:49 PM, Dor Laor <dor.laor@qumranet.com> wrote:
> >  On Thu, 2008-04-10 at 11:48 +0300, Amit Shah wrote:
> >  > If kvm uses the in-kernel irqchip, interrupts are routed to
> >  > the guest via the kvm module (accompanied kernel changes are
> >  > necessar). If -no-kvm-irqchip is used, the 'irqhook' module, also
> >  > included here, is to be used.
> >
> >  IMO we can drop the pci pass through support in userspace and only keep
> >  the in-kenel chip path. Normally we do want the option of running w/o
> >  kernel devices but it's only to test for regressions against userspace.
> >  In this case it's all new code so there is no point to compare, it's
> >  just lots of complicated code (userspace apic, irqhook module) that only
> >  helpful for qemu. Since it's not likely qemu will merge it, let's stick
> >  with the main path.
> >  Comments?
>
> Please keep the userspace support alive.
>
> I am particularly interested in using the pci-passthough to qemu
> running non x86 system emulation
> (at the moment mips)
>
> My hope is that the pci - passthough could help with developing
> drivers and testing across architectures...

OK; keeping support around won't be too much of a hassle, though the current 
support for pci-passthrough and the irqhook module are developed with x86 in 
mind (and only tested on x86).

Since it's not tested on any other architecture, I've marked it TARGET_I386 
and TARGET_X86_64 for now. Feel free to extend it to other architectures.

Amit.
