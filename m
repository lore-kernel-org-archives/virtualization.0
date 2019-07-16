From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 0/2] Remove 32-bit Xen PV guest support
Date: Tue, 16 Jul 2019 05:55:20 +0200
Message-ID: <b466e2eb-2d9c-46cb-c239-a93967ccf74c__6446.02309200621$1563249334$gmane$org@suse.com>
References: <20190715113739.17694-1-jgross@suse.com>
	<87y30zfe9z.fsf@linux.intel.com>
	<CALCETrUn=gho5Oug-yYvF2d1WYCe7gvtx+bXuhJ8LTjb9guvuA@mail.gmail.com>
	<bbf1ea2d-1206-eb54-3611-4c9b9fad4aa4@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <bbf1ea2d-1206-eb54-3611-4c9b9fad4aa4@citrix.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, X86 ML <x86@kernel.org>, Alok Kataria <akataria@vmware.com>, LKML <linux-kernel@vger.kernel.org>, LinuxVirtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel <xen-devel@lists.xenproject.org>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 15.07.19 19:39, Andrew Cooper wrote:
> On 15/07/2019 18:28, Andy Lutomirski wrote:
>> On Mon, Jul 15, 2019 at 9:34 AM Andi Kleen <ak@linux.intel.com> wrote:
>>> Juergen Gross <jgross@suse.com> writes:
>>>
>>>> The long term plan has been to replace Xen PV guests by PVH. The first
>>>> victim of that plan are now 32-bit PV guests, as those are used only
>>>> rather seldom these days. Xen on x86 requires 64-bit support and with
>>>> Grub2 now supporting PVH officially since version 2.04 there is no
>>>> need to keep 32-bit PV guest support alive in the Linux kernel.
>>>> Additionally Meltdown mitigation is not available in the kernel running
>>>> as 32-bit PV guest, so dropping this mode makes sense from security
>>>> point of view, too.
>>> Normally we have a deprecation period for feature removals like this.
>>> You would make the kernel print a warning for some releases, and when
>>> no user complains you can then remove. If a user complains you can't.
>>>
>> As I understand it, the kernel rules do allow changes like this even
>> if there's a complaint: this is a patch that removes what is
>> effectively hardware support.  If the maintenance cost exceeds the
>> value, then removal is fair game.  (Obviously we weight the value to
>> preserving compatibility quite highly, but in this case, Xen dropped
>> 32-bit hardware support a long time ago.  If the Xen hypervisor says
>> that 32-bit PV guest support is deprecated, it's deprecated.)
>>
>> That being said, a warning might not be a bad idea.  What's the
>> current status of this in upstream Xen?
> 
> So personally, I'd prefer to see support stay, but at the end of the day
> it is Juergen's choice as the maintainer of the code.

Especially on the security front we are unsafe with 32-bit PV Linux.
And making it safe will make it so slow that the needed effort is not
spent very well.


Juergen
