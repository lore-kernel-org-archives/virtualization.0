From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Fri, 25 May 2007 10:46:29 -0600
Message-ID: <m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>
References: <4656FB8F.4090604@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4656FB8F.4090604@goop.org> (Jeremy Fitzhardinge's message of
	"Fri, 25 May 2007 16:06:55 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Well, it seems to be about time to have this conversation again.
>
> A rough overview of the previous thread and requirements is:
>
>    1. bzImage would not be a bare ELF file, but it would contain an ELF
>       header+file within it
>    2. We need some way to add extra ELF notes into that ELF file

>    3. We use a "paravirtualized" bootloader type, with some other field
>       to determine which hypervisor we're dealing with
>    4. We need to extend the boot info structure to include a pointer to
>       some other hypervisor-specific information
>    5. When started at the 32-bit entrypoint, bzImage expects:
>          1. 32-bit mode
>          2. running in any ring (and ring implies nothing about the
>             environment)
>          3. all segment registers are loaded with flat 4G segments
>          4. there may or may not be a valid GDT (segment registers must
>             not be reloaded until GDT is explicitly set up)
>          5. interrupts disabled
>          6. paging may or may not be enabled; if enabled, it has 1:1
>             mappings where the ELF file's Phdrs say they should be
>    6. When bzImage starts the kernel-proper, it works out how to choose
>       the appropriate boot path based on the boot info structure in %esi

Yes.

> How much of this already exists?  Is there enough to start prototyping with?
>
>
> What was the problem with ELF bzImage?  Is it confirmed to be
> problematic, or just suspected?

There was a problem, Andrews machine would not the kernel with the ELF
header.  It was not root caused.  So we are not certain why.

> Could we end up using a plain ELF file
> (which would be easiest for me, since I think the existing ELF domain
> builder could pretty much deal with that as-is).

I think we should start there and be prepared to munge the ELF
magic number if there are problems.  Placing ELF notes is going
to require a little work but mostly it should be a matter of
copying the from vmlinux.

Most of that though is just packaging.  The meat of the issue
is how do we upgrade the bootloader data.  Do the changes
below sound like everything we need?

 Field name:	loadflags
 Type:		modify (obligatory)
 Offset/size:	0x211/1
 Protocol:	2.00+
 
   This field is a bitmask.
 
   Bit 0 (read):	LOADED_HIGH
 	- If 0, the protected-mode code is loaded at 0x10000.
 	- If 1, the protected-mode code is loaded at 0x100000.

+  Bit 6 (write): KEEP_SEGMENTS
+	Protocol: 2.07+
+	- if 0, reload the segment registers in the 32bit entry point.
+	- if 1, do not reload the segment registers in the 32bit entry point.
+		Assume that %cs %ds %ss %es are all set to flat segments with
+		a base of 0 (or the equivalent for their environment).
 
   Bit 7 (write): CAN_USE_HEAP
 	Set this bit to 1 to indicate that the value entered in the
 	heap_end_ptr is valid.  If this field is clear, some setup code
 	functionality will be disabled.

.....
+Field name:	hardware_subarch
+Type:		write
+Offset/size:	0x23c/4
+Protocol:	2.07+
+
+  In a paravirtualized environment the hardware low level architectural 
+  pieces such as interrupt handling, page table handling, and
+  accessing process control registers needs to be done differently.
+
+  This field allows the bootloader to inform the kernel we are in one
+  one of those environments.
+
+  0x00000000	The default x86/PC environment
+  0x00000001	lguest
+  0x00000002	Xen
+
+Field name:	hardware_subarch_data
+Type:		write
+Offset/size:	0x23c/8
+Protocol:	2.07+
+
+  A pointer to data that is specific to hardware subarch
+

Eric
