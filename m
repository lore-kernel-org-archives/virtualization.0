From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 2/4] KVM/vmx: auto switch MSR_IA32_DEBUGCTLMSR
Date: Mon, 25 Sep 2017 13:57:17 +0200
Message-ID: <255ea5c8-09be-9597-93b5-f0524eaa2b4b__22880.4567167119$1506340669$gmane$org@redhat.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-3-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506314696-4632-3-git-send-email-wei.w.wang@intel.com>
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
> Passthrough the MSR_IA32_DEBUGCTLMSR to the guest, and take advantage of
> the hardware VT-x feature to auto switch the msr upon VMExit and VMEntry.

I think most bits in the MSR should not be passed through (for example
FREEZE_WHILE_SMM_EN, FREEZE_LBRS_ON_PMI etc.).  Using auto-switch of
course is fine instead.

Paolo
