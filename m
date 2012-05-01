From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 1/5] kvm hypervisor : Add a hypercall to KVM
	hypervisor to support pv-ticketlocks
Date: Wed, 02 May 2012 01:50:06 +0530
Message-ID: <4FA04576.6030405__18786.8256740787$1335903665$gmane$org@linux.vnet.ibm.com>
References: <20120423095937.30893.14776.sendpatchset@codeblue.in.ibm.com>
	<20120423095947.30893.84029.sendpatchset@codeblue.in.ibm.com>
	<4F9D415B.7010103@redhat.com> <4F9E42F6.8050108@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F9E42F6.8050108@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, X86 <x86@kernel.org>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/30/2012 01:14 PM, Raghavendra K T wrote:

>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 4044ce0..7fc9be6 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -2147,6 +2147,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>>> case KVM_CAP_ASYNC_PF:
>>> case KVM_CAP_GET_TSC_KHZ:
>>> case KVM_CAP_PCI_2_3:
>>> + case KVM_CAP_PV_UNHALT:
>>> r = 1;
>>> break;
>>> case KVM_CAP_COALESCED_MMIO:
>>
>> Redundant, since we can infer this from KVM_GET_SUPPORTED_CPUID. But
>> please indicate this in the documentation.
>>
>
> Ok. will mention that in documentation added for KVM_CAP_PV_UNHALT.
>

I think it is better to remove  KVM_CAP_PV_UNHALT itself and avoid
spamming CAP.. will do that in coming version.
