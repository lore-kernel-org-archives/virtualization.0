From: "Samuel Masham" <samuel.masham@gmail.com>
Subject: Re: [kvm-devel] [PATCH 1/1] QEMU/KVM: Support for PCI Passthrough
Date: Fri, 18 Apr 2008 17:46:46 +0900
Message-ID: <93564eb70804180146w7bb6a2b9qeea1eb8f9dd59da9@mail.gmail.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<1208090956.17832.89.camel@localhost.localdomain>
	<93564eb70804131731x1e08554due1e0c1bf9665e77f@mail.gmail.com>
	<200804181109.52123.amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804181109.52123.amit.shah@qumranet.com>
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
To: Amit Shah <amit.shah@qumranet.com>
Cc: chrisw@redhat.com, kvm-devel@lists.sourceforge.net, allen.m.kay@intel.com, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 18, 2008 at 2:39 PM, Amit Shah <amit.shah@qumranet.com> wrote:
> * On Monday 14 Apr 2008 06:01:07 Samuel Masham wrote:
>  >
>  > Please keep the userspace support alive.
>  >
>  > I am particularly interested in using the pci-passthough to qemu
>  > running non x86 system emulation
>  > (at the moment mips)
>  >
>  > My hope is that the pci - passthough could help with developing
>  > drivers and testing across architectures...
>
>  OK; keeping support around won't be too much of a hassle, though the current
>  support for pci-passthrough and the irqhook module are developed with x86 in
>  mind (and only tested on x86).
>
>  Since it's not tested on any other architecture, I've marked it TARGET_I386
>  and TARGET_X86_64 for now. Feel free to extend it to other architectures.

Thanks,

I will let you know if I get anything useful out of it.

Samuel
