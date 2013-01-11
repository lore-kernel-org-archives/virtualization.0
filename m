From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Xen-devel] [PATCH v3 00/11] xen: Initial kexec/kdump
	implementation
Date: Fri, 11 Jan 2013 12:05:16 -0800
Message-ID: <87pq1bxz7n.fsf@xmission.com>
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
	<50F02E3B.3090506@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50F02E3B.3090506@citrix.com> (David Vrabel's message of "Fri, 11
	Jan 2013 15:22:35 +0000")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "maxim.uvarov@oracle.com" <maxim.uvarov@oracle.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

David Vrabel <david.vrabel@citrix.com> writes:

> On 11/01/13 13:22, Daniel Kiper wrote:
>> On Thu, Jan 10, 2013 at 02:19:55PM +0000, David Vrabel wrote:
>>> On 04/01/13 17:01, Daniel Kiper wrote:
>>>> My .5 cents:
>>>>   - We should focus on KEXEC_CMD_kexec_load and KEXEC_CMD_kexec_unload;
>>>>     probably we should introduce KEXEC_CMD_kexec_load2 and KEXEC_CMD_kexec_unload2;
>>>>     load should __LOAD__ kernel image and other things into hypervisor memory;
>>>
>>> Yes, but I don't see how we can easily support both ABIs easily.  I'd be
>>> in favour of replacing the existing hypercalls and requiring updated
>>> kexec tools in dom0 (this isn't that different to requiring the correct
>>> libxc in dom0).
>> 
>> Why? Just define new strutures for new functions of kexec hypercall.
>> That should suffice.
>
> The current hypervisor ABI depends on an internal kernel ABI (i.e., the
> ABI provided by relocate_kernel).  We do not want hypervisor internals
> to be constrained by having to be compatible with kernel internals.

I think this is violent agreement.  A new call with new arguments seems
agreed upon.  The only question seems to be what happens to the old
hypercall.  Keeping the current deprecated hypercall with the current
ABI and not updating it, or modifying the current hypercall to return
the xen equivalant of -ENOSYS seems to be the only question.

Certainly /sbin/kexec will only support the new hypercall once the
support has merged.

>> No, please do not do that. When you call HYPERVISOR_kexec_op(KEXEC_CMD_kexec)
>> system is completly shutdown. Return form HYPERVISOR_kexec_op(KEXEC_CMD_kexec)
>> would require to restore some kernel functionalities. It maybe impossible
>> in some cases. Additionally, it means that some changes should be made
>> in generic kexec code path. As I know kexec maintainers are very reluctant
>> to make such things.
>
> Huh?  There only needs to be a call to a new hypervisor_crash_kexec()
> function (which would then call the Xen specific crash hypercall) at the
> very beginning of crash_kexec().  If this returns the normal
> crash/shutdown path is done (which could even include a guest kexec!).

Can you imagine what crash_kexec would look like if every architecture
would hard code their own little piece in there?

The practical issue with changing crash_kexec is that you are hard
coding Xen policy just before a jump to a piece of code whose purpose
is to implement policy.

From a maintenance and code comprehension stand-ponit it is much cleaner
to put the hypervisor_crash_kexec() hypercall into the code that is
loaded with sys_kexec_load and is branched to by crash_kexec.  I would
have no problem with hard coding that behavior into /sbin/kexec in
the case of Xen dom0.

Having any code have different semantics when running under Xen is a
maintenance nightmare, and why we are having the conversation years and
years after the initial deployment of Xen.  A tiny hard coded stub that
calls a hypercall should work indefinitely with no one having to do
anything.

Eric
