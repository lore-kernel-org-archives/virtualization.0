From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V5 2/6] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Tue, 17 Apr 2012 12:36:51 +0530
Message-ID: <4F8D168B.7090806__16288.01726406$1334646723$gmane$org@linux.vnet.ibm.com>
References: <20120323080503.14568.43092.sendpatchset@codeblue>
	<20120323080701.14568.97779.sendpatchset@codeblue>
	<20120412000629.GA32051@amt.cnet> <20120412002909.GD32051@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120412002909.GD32051@amt.cnet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, X86 <x86@kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization <virtualization@lists.linux-foundation.org>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/12/2012 05:59 AM, Marcelo Tosatti wrote:
> On Wed, Apr 11, 2012 at 09:06:29PM -0300, Marcelo Tosatti wrote:
>> On Fri, Mar 23, 2012 at 01:37:04PM +0530, Raghavendra K T wrote:
>>> From: Srivatsa Vaddagiri<vatsa@linux.vnet.ibm.com>
>>>
[...]

		barrier();
>>
>> Is it always OK to erase the notification, even in case an unrelated
>> event such as interrupt was the source of wakeup?
>
> Note i am only asking whether it is OK to lose a notification, not
> requesting a change to atomic test-and-clear.

Yes.. got your point.
IMO, this is the only (safe) place where it can clear
kicked(pv_unhalted) flag. Since it is going to be runnable.

and you are also right in having concern on unwanted clear of flag
since that would result in vcpu /vm hangs eventually.

Hope I did not miss anything.

>
> It would be nice to have a comment explaining it.
>

Sure will do that

>>
