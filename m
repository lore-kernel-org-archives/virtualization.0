From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 0/4] Enable LBR for the guest
Date: Tue, 26 Sep 2017 16:47:19 +0800
Message-ID: <59CA1417.7070602__44587.8737526529$1506415473$gmane$org@intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<20170925145908.GN4311@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170925145908.GN4311@tassilo.jf.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@linux.intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 09/25/2017 10:59 PM, Andi Kleen wrote:
> On Mon, Sep 25, 2017 at 12:44:52PM +0800, Wei Wang wrote:
>> This patch series enables the Last Branch Recording feature for the
>> guest. Instead of trapping each LBR stack MSR access, the MSRs are
>> passthroughed to the guest. Those MSRs are switched (i.e. load and
>> saved) on VMExit and VMEntry.
>>
>> Test:
>> Try "perf record -b ./test_program" on guest.
> I don't see where you expose the PERF capabilities MSR?
>
> That's normally needed for LBR too to report the version
> number.
>

It was missed, thanks for pointing it out. I also found KVM/QEMU doesn't
expose CPUID.PDCM, will add that too.

Since for now we are enabling LBR, I plan to expose only "PERF_CAP & 0x3f"
to the guest, which reports the LBR format only.

On the other side, it seems that the (guest) kernel driver also works 
without
the above being supported, should we change it to report error and stop
using the PMU features when the check of the above two fails (at 
intel_pmu_init())?


Best,
Wei
