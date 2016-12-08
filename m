From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] x86,paravirt: Fix native_patch()
Date: Thu, 08 Dec 2016 16:42:14 +0100
Message-ID: <20161208154349.270616999@infradead.org>
References: <20161208154213.952687487@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=peter_zijlstra-fd6f48529f-_aim7_jobs-per-min_-26_1__regression.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Alok Kataria <akataria@vmware.com>, kernel test robot <xiaolong.ye@intel.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Borislav Petkov <bp@alien8.de>, Peter Anvin <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

While chasing a regression I noticed we potentially patch the wrong
code in native_patch().

If we do not select the native code sequence, we must use the default
patcher, not fall-through the switch case.

Fixes: 3cded4179481 ("x86/paravirt: Optimize native pv_lock_ops.vcpu_is_preempted()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/paravirt_patch_32.c |    4 ++++
 arch/x86/kernel/paravirt_patch_64.c |    4 ++++
 2 files changed, 8 insertions(+)

--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -56,15 +56,19 @@ unsigned native_patch(u8 type, u16 clobb
 				end   = end_pv_lock_ops_queued_spin_unlock;
 				goto patch_site;
 			}
+			goto patch_default;
+
 		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
 			if (pv_is_native_vcpu_is_preempted()) {
 				start = start_pv_lock_ops_vcpu_is_preempted;
 				end   = end_pv_lock_ops_vcpu_is_preempted;
 				goto patch_site;
 			}
+			goto patch_default;
 #endif
 
 	default:
+patch_default:
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
 
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -68,15 +68,19 @@ unsigned native_patch(u8 type, u16 clobb
 				end   = end_pv_lock_ops_queued_spin_unlock;
 				goto patch_site;
 			}
+			goto patch_default;
+
 		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
 			if (pv_is_native_vcpu_is_preempted()) {
 				start = start_pv_lock_ops_vcpu_is_preempted;
 				end   = end_pv_lock_ops_vcpu_is_preempted;
 				goto patch_site;
 			}
+			goto patch_default;
 #endif
 
 	default:
+patch_default:
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
