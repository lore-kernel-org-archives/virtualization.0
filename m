From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 0/4] Enable LBR for the guest
Date: Mon, 25 Sep 2017 12:44:52 +0800
Message-ID: <1506314696-4632-1-git-send-email-wei.w.wang__32971.7458379038$1506315520$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com, ak@linux.intel.com, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch series enables the Last Branch Recording feature for the
guest. Instead of trapping each LBR stack MSR access, the MSRs are
passthroughed to the guest. Those MSRs are switched (i.e. load and
saved) on VMExit and VMEntry.

Test:
Try "perf record -b ./test_program" on guest.

Wei Wang (4):
  KVM/vmx: re-write the msr auto switch feature
  KVM/vmx: auto switch MSR_IA32_DEBUGCTLMSR
  perf/x86: add a function to get the lbr stack
  KVM/vmx: enable lbr for the guest

 arch/x86/events/intel/lbr.c       |  23 +++++++
 arch/x86/include/asm/perf_event.h |  14 ++++
 arch/x86/kvm/vmx.c                | 135 +++++++++++++++++++++++++++++++++-----
 3 files changed, 154 insertions(+), 18 deletions(-)

-- 
2.7.4
