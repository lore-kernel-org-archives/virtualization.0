From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V10 18/18] kvm hypervisor: Add directed yield in vcpu
	block path
Date: Mon, 15 Jul 2013 11:34:05 +0530
Message-ID: <51E390D5.3000707@linux.vnet.ibm.com>
References: <20130624124014.27508.8906.sendpatchset@codeblue.in.ibm.com>
	<20130624124415.27508.74230.sendpatchset@codeblue.in.ibm.com>
	<20130714141818.GD11772@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130714141818.GD11772@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gleb Natapov <gleb@redhat.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On 07/14/2013 07:48 PM, Gleb Natapov wrote:
> On Mon, Jun 24, 2013 at 06:14:15PM +0530, Raghavendra K T wrote:
>> kvm hypervisor: Add directed yield in vcpu block path
>>
>> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>>
>> We use the improved PLE handler logic in vcpu block patch for
>> scheduling rather than plain schedule, so that we can make
>> intelligent decisions.
>>
> What kind of improvement this provides? Doesn't it screw up our pause
> exit heuristics?

No. it does not affect negatively from what I saw. ( and even from
results).

So it will make ple handler to avoid yield_to to those vcpus,
still looping in  halt handler.
May be vcpus which are pv_unhalted but not running, may miss this.
but haven't seen anything bad happening with that.
But yes, planning to do some experiments around this. Thanks for
bringing this up.

Between another good point about this is, though non PLE hardwares are
becoming obsolete, they can potentially take the advantage of PLE
handler.

>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/ia64/include/asm/kvm_host.h    |    5 +++++
>>   arch/powerpc/include/asm/kvm_host.h |    5 +++++
>>   arch/s390/include/asm/kvm_host.h    |    5 +++++
>>   arch/x86/include/asm/kvm_host.h     |    2 +-
>>   arch/x86/kvm/x86.c                  |    8 ++++++++
>>   include/linux/kvm_host.h            |    2 +-
>>   virt/kvm/kvm_main.c                 |    6 ++++--
> This miss some arches.

Thanks for pointing that. arm and mips were not around at V8 time, I 
missed them.
