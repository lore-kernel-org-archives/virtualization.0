From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 4/4] KVM/vmx: enable lbr for the guest
Date: Mon, 25 Sep 2017 07:57:20 -0700
Message-ID: <20170925145720.GM4311__5718.68309421024$1506351457$gmane$org@tassilo.jf.intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> +static void auto_switch_lbr_msrs(struct vcpu_vmx *vmx)
> +{
> +	int i;
> +	struct perf_lbr_stack lbr_stack;
> +
> +	perf_get_lbr_stack(&lbr_stack);
> +
> +	add_atomic_switch_msr(vmx, MSR_LBR_SELECT, 0, 0);
> +	add_atomic_switch_msr(vmx, lbr_stack.lbr_tos, 0, 0);
> +
> +	for (i = 0; i < lbr_stack.lbr_nr; i++) {
> +		add_atomic_switch_msr(vmx, lbr_stack.lbr_from + i, 0, 0);
> +		add_atomic_switch_msr(vmx, lbr_stack.lbr_to + i, 0, 0);
> +		if (lbr_stack.lbr_info)
> +			add_atomic_switch_msr(vmx, lbr_stack.lbr_info + i, 0,
> +					      0);
> +	}

That will be really expensive and add a lot of overhead to every entry/exit.
perf can already context switch the LBRs on task context switch. With that
you can just switch LBR_SELECT, which is *much* cheaper because there
are far less context switches than exit/entries.

It implies that when KVM is running it needs to prevent perf from enabling
LBRs in the context of KVM, but that should be straight forward.

-Andi
