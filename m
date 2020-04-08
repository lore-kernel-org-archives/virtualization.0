From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 09/26] x86/paravirt: Add runtime_patch()
Date: Wed, 8 Apr 2020 13:05:01 +0200
Message-ID: <20200408110501.GS20713@hirez.programming.kicks-ass.net>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408050323.4237-10-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200408050323.4237-10-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: jgross@suse.com, hpa@zytor.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 07, 2020 at 10:03:06PM -0700, Ankur Arora wrote:
> +/*
> + * preempt_enable_no_resched() so we don't add any preemption points until
> + * after the caller has returned.
> + */
> +#define preempt_enable_runtime_patch()	preempt_enable_no_resched()
> +#define preempt_disable_runtime_patch()	preempt_disable()

NAK, this is probably a stright preemption bug, also, afaict, there
aren't actually any users of this in the patch-set.
