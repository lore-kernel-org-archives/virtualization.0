From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
Date: Wed, 15 Nov 2006 23:16:15 -0800
Message-ID: <20061116071615.GX1397@sequoia.sous-sol.org>
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com>
	<20061116032702.GH9579@bingen.suse.de>
	<20061115210630.94bf8824.akpm@osdl.org>
	<200611160802.05131.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200611160802.05131.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

* Andi Kleen (ak@suse.de) wrote:
> Maybe it's my toolchain (gcc 4.0) or my config (defconfig)
> But looking at the asm() I'm not sure it ever worked anywhere.

That's possible, I recall this being broken before and it was not hitting
everyone.  BTW, here's what I have so far...

Up to 'config-core2' both ff and mm are the same with these minor caveats
below[1].  This includes the core paravirt patches.  I'm now digging
into the last few tidy-up type of patches.

[1] The changes below were to try and get clean diffs.  Nothing
substantial, mostly just things that have gone upstream.

in ff, not mm
-------------
i386-pci-dma-iounmap (added to mm for clean diff)

in mm, not ff
-------------
x86_64-mm-io-apic-reuse.patch (commented out from mm)
x86_64-mm-fix-exit-idle-race.patch (pushed to linus)
x86_64-mm-reserve-bootmem-beyond-end-pfn.patch (pushed to linus)
x86_64-mm-setup-saved_max_pfn-correctly-kdump.patch (pushed to linus)
x86_64-mm-ptrace-compat-threadarea.patch (pushed to linus)
x86_64-mm-pci-mcfg-reserve-e820.patch (dropped?)
x86_64-mm-fix-boot-gdt-limit.patch (pushed)
x86_64-mm-e820-small-entries.patch (dropped?)

refreshed in mm
---------------
x86_64-mm-i386-reloc-abssym.patch
x86_64-mm-try-multiple-timer-pins.patch
