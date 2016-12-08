From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] Fix paravirt fail
Date: Thu, 08 Dec 2016 16:42:13 +0100
Message-ID: <20161208154213.952687487@infradead.org>
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
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, Alok Kataria <akataria@vmware.com>, kernel test robot <xiaolong.ye@intel.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Borislav Petkov <bp@alien8.de>, Peter Anvin <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Two patches that cure fallout from commit:

  3cded4179481 ("x86/paravirt: Optimize native pv_lock_ops.vcpu_is_preempted()")
