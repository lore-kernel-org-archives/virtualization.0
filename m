From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/4] KVM/vmx: re-write the msr auto switch feature
Date: Mon, 25 Sep 2017 13:54:37 +0200
Message-ID: <7f9d54dd-546a-548f-5425-e4151e09fbdc__12517.0859661468$1506340512$gmane$org@redhat.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-2-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506314696-4632-2-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, ak@linux.intel.com, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 25/09/2017 06:44, Wei Wang wrote:
>  
> +static void update_msr_autoload_count_max(void)
> +{
> +	u64 vmx_msr;
> +	int n;
> +
> +	/*
> +	 * According to the Intel SDM, if Bits 27:25 of MSR_IA32_VMX_MISC is
> +	 * n, then (n + 1) * 512 is the recommended max number of MSRs to be
> +	 * included in the VMExit and VMEntry MSR auto switch list.
> +	 */
> +	rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
> +	n = ((vmx_msr & 0xe000000) >> 25) + 1;
> +	msr_autoload_count_max = n * KVM_VMX_DEFAULT_MSR_AUTO_LOAD_COUNT;
> +}
> +


Any reasons to do this if it's unlikely that we'll ever update more than
512 MSRs?

Paolo
