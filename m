From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git pull] lguest: paravirt boot code
Date: Tue, 23 Oct 2007 16:37:08 -0400
Message-ID: <471E5B74.8030900__43044.6679624312$1193238454$gmane$org@garzik.org>
References: <200710221237.14542.rusty@rustcorp.com.au>
	<alpine.LFD.0.999.0710221927131.30120@woody.linux-foundation.org>
	<200710231603.21620.rusty@rustcorp.com.au>
	<alpine.LFD.0.999.0710230903330.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710230903330.30120@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Linus Torvalds wrote:
> 
> On Tue, 23 Oct 2007, Rusty Russell wrote:
>> Well, with that out the way, and some scatterlist fixups, please pull from
>>
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-lguest.git

Also, please add a "lguest: " prefix to all future commits.

Otherwise, in the one-line summary, it is impossible to tell what 
portion of the kernel is being updated:

	Use "struct boot_params" in example launcher
	Loading bzImage directly.
	Rename "cr3" to "gpgdir" to avoid x86-specific naming.
	Pagetables to use normal kernel types
	Move register setup into i386_core.c
	Accept elf files that are valid but have sections that can not
		be mmap'ed for some reason.

git tools are all keyed to use that first line as a summary of the 
changeset, without giving any other context whatsoever.  See Linus's 
2.6.X-rcY announcements, for example.

This is also described in akpm's 
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt or my 
http://linux.yyz.us/patch-format.html

	Jeff
