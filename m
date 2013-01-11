From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
	implementation
Date: Fri, 11 Jan 2013 15:22:35 +0000
Message-ID: <50F02E3B.3090506@citrix.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<50DBC856.6030208@zytor.com>
	<791b4922-078f-4adc-b3f3-0651f2266147@email.android.com>
	<50DC58C4.3000307@citrix.com> <874nj7qsor.fsf@xmission.com>
	<50E41973.9050705@citrix.com>
	<20130104142257.GC3346@host-192-168-1-59.local.net-space.pl>
	<50E6E974.5090805@citrix.com>
	<20130104170120.GA3472@host-192-168-1-59.local.net-space.pl>
	<50EECE0B.2080604@citrix.com>
	<20130111132212.GB5150@host-192-168-1-59.local.net-space.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130111132212.GB5150@host-192-168-1-59.local.net-space.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "H.
	Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/01/13 13:22, Daniel Kiper wrote:
> On Thu, Jan 10, 2013 at 02:19:55PM +0000, David Vrabel wrote:
>> On 04/01/13 17:01, Daniel Kiper wrote:
>>> My .5 cents:
>>>   - We should focus on KEXEC_CMD_kexec_load and KEXEC_CMD_kexec_unload;
>>>     probably we should introduce KEXEC_CMD_kexec_load2 and KEXEC_CMD_kexec_unload2;
>>>     load should __LOAD__ kernel image and other things into hypervisor memory;
>>
>> Yes, but I don't see how we can easily support both ABIs easily.  I'd be
>> in favour of replacing the existing hypercalls and requiring updated
>> kexec tools in dom0 (this isn't that different to requiring the correct
>> libxc in dom0).
> 
> Why? Just define new strutures for new functions of kexec hypercall.
> That should suffice.

The current hypervisor ABI depends on an internal kernel ABI (i.e., the
ABI provided by relocate_kernel).  We do not want hypervisor internals
to be constrained by having to be compatible with kernel internals.

>>>   - Hmmm... Now I think that we should still use kexec syscall to load image
>>>     into Xen memory (with new KEXEC_CMD_kexec_load2) because it establishes
>>>     all things which are needed to call kdump if dom0 crashes; however,
>>>     I could be wrong...
>>
>> I don't think we need the kexec syscall.  The kernel can unconditionally
>> do the crash hypercall, which will return if the kdump kernel isn't
>> loaded and the kernel can fall back to the regular non-kexec panic.
> 
> No, please do not do that. When you call HYPERVISOR_kexec_op(KEXEC_CMD_kexec)
> system is completly shutdown. Return form HYPERVISOR_kexec_op(KEXEC_CMD_kexec)
> would require to restore some kernel functionalities. It maybe impossible
> in some cases. Additionally, it means that some changes should be made
> in generic kexec code path. As I know kexec maintainers are very reluctant
> to make such things.

Huh?  There only needs to be a call to a new hypervisor_crash_kexec()
function (which would then call the Xen specific crash hypercall) at the
very beginning of crash_kexec().  If this returns the normal
crash/shutdown path is done (which could even include a guest kexec!).

David
