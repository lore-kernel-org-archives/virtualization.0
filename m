From: Keith Owens <kaos@ocs.com.au>
Subject: Re: [kvm-ia64-devel] [PATCH 0/4] ia64/xen: paravirtualization of hand
	written assembly code
Date: Tue, 26 Feb 2008 00:33:12 +1100
Message-ID: <25065.1203946392__13582.5551268228$1203946575$gmane$org@ocs10w>
References: <1203944088.47c2ba98e5c91@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: Your message of "Mon, 25 Feb 2008 13:54:48 BST."
	<1203944088.47c2ba98e5c91@imp.free.fr>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tgingold@free.fr
Cc: virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

tgingold@free.fr (on Mon, 25 Feb 2008 13:54:48 +0100) wrote:
>Quoting Keith Owens <kaos@ocs.com.au>:
>{...}
>> A combination of options (2) and (3) would work.  Have a single source
>> file for the IVT, using conditional macros.  Use that source file to
>> build (at least) two copies of the IVT, for native and any virtualized
>> modes.  The native copy of the IVT starts at label ia64_ivt in section
>> .text.ivt, as it does now.  Any IVT versions for virtualized mode are
>> defined as __cpuinitdata, so they are discarded after boot, unless
>> CONFIG_HOTPLUG_CPU=y.  arch/ia64/kernel/head.S copies the relevant
>> virtualized version over ia64_ivt when necessary, before initializing
>> cr.iva.
>>
>> Single source for maintenance.  No indirect function overhead at run
>> time.  Binary patching at boot time for the right mode.  No wasted
>> space in the kernel.
>
>Good idea.  The linker script will be slightly more complex however...

Don't see why the linker script needs to change at all.  The existing
native IVT is at label ia64_ivt in section .text.ivt, as it is now.
arch/ia64/kernel/head.S simply overwrites ia64_ivt with 32K of data for
the virtualized IVT, copying from another data area.  AFAICT, nothing
in that process requires linker changes.
