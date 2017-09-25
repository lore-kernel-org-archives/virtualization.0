From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 1/4] KVM/vmx: re-write the msr auto switch feature
Date: Mon, 25 Sep 2017 21:02:38 +0800
Message-ID: <59C8FE6E.7070503@intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-2-git-send-email-wei.w.wang@intel.com>
	<7f9d54dd-546a-548f-5425-e4151e09fbdc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7f9d54dd-546a-548f-5425-e4151e09fbdc@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, ak@linux.intel.com, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/25/2017 07:54 PM, Paolo Bonzini wrote:
> On 25/09/2017 06:44, Wei Wang wrote:
>>   
>> +static void update_msr_autoload_count_max(void)
>> +{
>> +	u64 vmx_msr;
>> +	int n;
>> +
>> +	/*
>> +	 * According to the Intel SDM, if Bits 27:25 of MSR_IA32_VMX_MISC is
>> +	 * n, then (n + 1) * 512 is the recommended max number of MSRs to be
>> +	 * included in the VMExit and VMEntry MSR auto switch list.
>> +	 */
>> +	rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
>> +	n = ((vmx_msr & 0xe000000) >> 25) + 1;
>> +	msr_autoload_count_max = n * KVM_VMX_DEFAULT_MSR_AUTO_LOAD_COUNT;
>> +}
>> +
>
> Any reasons to do this if it's unlikely that we'll ever update more than
> 512 MSRs?
>
> Paolo

It isn't a must to allocate memory for 512 MSRs, but I think it would be 
good to
allocate memory at least for 128 MSRs, because on skylake we have 32 
triplets
of MSRs (FROM/TO/INFO), which are 96 in total already.

The disadvantage is that developers would need to manually calculate and 
change
the number carefully when they need to add new MSRs for auto switching 
in the
future. So, if consuming a little bit more memory isn't a concern, I 
think we can
directly allocate memory based on what's recommended by the hardware.


Best,
Wei
