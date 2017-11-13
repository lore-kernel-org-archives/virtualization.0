From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH RFC v3 1/6] x86/paravirt: Add pv_idle_ops to paravirt ops
Date: Mon, 13 Nov 2017 11:53:52 +0100
Message-ID: <07fac696-e3d4-8f35-8f3d-764d7ab41204__9961.69582144848$1510570447$gmane$org@suse.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-2-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1510567565-5118-2-git-send-email-quan.xu0@gmail.com>
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
To: Quan Xu <quan.xu03@gmail.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Quan Xu <quan.xu0@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On 13/11/17 11:06, Quan Xu wrote:
> From: Quan Xu <quan.xu0@gmail.com>
> 
> So far, pv_idle_ops.poll is the only ops for pv_idle. .poll is called
> in idle path which will poll for a while before we enter the real idle
> state.
> 
> In virtualization, idle path includes several heavy operations
> includes timer access(LAPIC timer or TSC deadline timer) which will
> hurt performance especially for latency intensive workload like message
> passing task. The cost is mainly from the vmexit which is a hardware
> context switch between virtual machine and hypervisor. Our solution is
> to poll for a while and do not enter real idle path if we can get the
> schedule event during polling.
> 
> Poll may cause the CPU waste so we adopt a smart polling mechanism to
> reduce the useless poll.
> 
> Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Alok Kataria <akataria@vmware.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org

Hmm, is the idle entry path really so critical to performance that a new
pvops function is necessary? Wouldn't a function pointer, maybe guarded
by a static key, be enough? A further advantage would be that this would
work on other architectures, too.


Juergen
