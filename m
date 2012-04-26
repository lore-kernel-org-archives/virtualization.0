From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 5/5] Documentation/kvm : Add documentation on
	Hypercalls and features used for PV spinlock
Date: Thu, 26 Apr 2012 21:34:38 +0530
Message-ID: <4F997216.6080804@linux.vnet.ibm.com>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
	<20120423100034.30893.81866.sendpatchset@codeblue.in.ibm.com>
	<4F997058.6070509@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F997058.6070509@landley.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rob Landley <rob@landley.net>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, X86 <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/26/2012 09:27 PM, Rob Landley wrote:
> On 04/23/2012 05:00 AM, Raghavendra K T wrote:
>> From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
> ...
>> --- /dev/null
>> +++ b/Documentation/virtual/kvm/hypercalls.txt
>> @@ -0,0 +1,59 @@
>> +KVM Hypercalls Documentation
>> +===========================
>> +Template for documentation is
>> +The documenenation for hypercalls should inlcude
>
> What does the line about templates mean/
>
> documenenation? inlcude?

I think I should correct some redundant statements here. The template is 
meant for current "structure / layout of hypercall documentation".

>
>> +1. Hypercall name, value.
>> +2. Architecture(s)
>> +3. status (deprecated, obsolete, active)
>> +4. Purpose
>> +
>> +
>> +1. KVM_HC_VAPIC_POLL_IRQ
>> +------------------------
>> +value: 1
>> +Architecture: x86
>> +Purpose:
>
> Purpose: none.
>

Will add this when I respin the patch soon

> Rob

Thanks for review.
