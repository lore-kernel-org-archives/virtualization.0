From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
	implementation
Date: Fri, 11 Jan 2013 12:26:56 -0800
Message-ID: <87k3rjtqi7.fsf@xmission.com>
References: <50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
	<50E41973.9050705@citrix.com>
	<20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
	<50E6F81D02000078000B3245@nat28.tlf.novell.com>
	<20130104170751.GB3472@host-192-168-1-59.local.net-space.pl>
	<20130104191146.GC6721@phenom.dumpdata.com>
	<20130107123404.GA2927@host-192-168-1-59.local.net-space.pl>
	<20130107162018.GJ3219@phenom.dumpdata.com>
	<87ehhsqrpr.fsf@xmission.com>
	<20130111165506.GD25620@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130111165506.GD25620@phenom.dumpdata.com> (Konrad Rzeszutek
	Wilk's message of "Fri, 11 Jan 2013 11:55:06 -0500")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:

> On Thu, Jan 10, 2013 at 08:16:48PM -0800, Eric W. Biederman wrote:

>> The basic kexec interface is.
>> 
>> load ranges of virtual addresses physical addresses.
>> jump to the physical address  with identity mapped page tables.
>> 
>> There are a few flags to allow for different usage scenarios like
>> kexec on panic vs normal kexec.
>
> And there is nothing fancy to be done for EFI and SecureBoot?

There is a mess with EFI.  Reports are that EFI is a bug ridden pile,
and people keep advocating that we make more and more EFI calls in the
main kernel.  There is an argument over set_virtual_mapping, which is a
call that can be made only once which relocates the EFI code to a
different address, which makes life inconvient for kexec.  There is
another argument that EFI doesn't actually work if you don't make the
set_virtual_mapping call so we can't remove it and always use physical
addresses.

Frankly the only sane way to run a linux kernel under EFI is to scrape
up the information needed to talk to the hardware directly and ignore
EFI.  That is what we have historically done in the face of BIOS madness
and if anything the situation is worse with EFI, but it looks like we
are going to have to learn that the hard way.

Recently there is a desire to figure out how to /sbin/kexec support
signed kernel images.  What will probably happen is to have a specially
trusted userspace application perform the verification.  Sort of like
dom0 for the linux userspace.  A few other ideas have been batted around
but none that have stuck.

None of that is really about SecureBoot.  It is all trusting the kernel
binary but not trusting userspace.  With SecureBoot being an excuse for
coming up with a policy like that.

It looks like the answer to SecureBoot at this point may simply be just
reconfigure your BIOS or root Windows and EFI to get the hardware to do
what you want.

So the answer for looking forward for Xen dom0 is: A trusted /sbin/kexec
won't require changes.  The other suggest solution is a flag that says a
specific chunk of the loaded image is a signature that the magic trust
faires can verify.  As long as you have a flag bit free you should be
able to implement that policy if we ever implement it.

Eric
