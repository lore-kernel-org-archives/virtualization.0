From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 4/4] KVM/vmx: enable lbr for the guest
Date: Mon, 25 Sep 2017 20:57:04 +0800
Message-ID: <59C8FD20.5070109__34766.7421367534$1506344062$gmane$org@intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
	<d4a81b5d-87ec-d118-112f-b017e58aa6e7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d4a81b5d-87ec-d118-112f-b017e58aa6e7@redhat.com>
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

On 09/25/2017 05:16 PM, Paolo Bonzini wrote:
> On 25/09/2017 06:44, Wei Wang wrote:
>> Passthrough the LBR stack to the guest, and auto switch the stack MSRs
>> upon VMEntry and VMExit.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> This has to be enabled separately for each guest, because it may prevent
> live migration to hosts with a different family/model.

Did you mean trapping MSR_IA32_DEBUGCTLMSR, instead of passing through it?
In that case, we would also need to modify the kernel driver (i.e. the 
PMI handler)
to check MSR_IA32_DEBUGCTLMSR before reading the LBR MSRs. Then the guest
driver can notice that the feature that is in use has been disabled 
after live
migration.

This kind of live migration disables features that are being used. Would 
it be
common in real usage to migrate between different CPU models?

I think this issue isn't specific to the LBR feature. May I know how 
would other
features be handled in this case? Thanks.

On the other hand, an alternative approach coming up to my mind is that we
can do some kind of feature negotiation at the very beginning of 
migration, and
fails live migration if the feature negotiation fails.


Best,
Wei
