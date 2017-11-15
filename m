From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC v3 3/6] sched/idle: Add a generic poll before enter
	real idle path
Date: Wed, 15 Nov 2017 13:11:52 +0100
Message-ID: <20171115121152.gqug5wzerlo3eimd@hirez.programming.kicks-ass.net>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
	<1510567565-5118-4-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1510567565-5118-4-git-send-email-quan.xu0@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Quan Xu <quan.xu03@gmail.com>
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Len Brown <len.brown@intel.com>, Quan Xu <quan.xu0@gmail.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Kyle Huey <me@kylehuey.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Tobias Klauser <tklauser@distanz.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 13, 2017 at 06:06:02PM +0800, Quan Xu wrote:
> From: Yang Zhang <yang.zhang.wz@gmail.com>
> 
> Implement a generic idle poll which resembles the functionality
> found in arch/. Provide weak arch_cpu_idle_poll function which
> can be overridden by the architecture code if needed.

No, we want less of those magic hooks, not more.

> Interrupts arrive which may not cause a reschedule in idle loops.
> In KVM guest, this costs several VM-exit/VM-entry cycles, VM-entry
> for interrupts and VM-exit immediately. Also this becomes more
> expensive than bare metal. Add a generic idle poll before enter
> real idle path. When a reschedule event is pending, we can bypass
> the real idle path.

Why not do a HV specific idle driver?
