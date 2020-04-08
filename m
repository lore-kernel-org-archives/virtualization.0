From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 15/26] x86/alternatives: Non-emulated text poking
Date: Wed, 8 Apr 2020 13:13:22 +0200
Message-ID: <20200408111322.GU20713@hirez.programming.kicks-ass.net>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408050323.4237-16-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200408050323.4237-16-ankur.a.arora@oracle.com>
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

On Tue, Apr 07, 2020 at 10:03:12PM -0700, Ankur Arora wrote:
> +static void __maybe_unused sync_one(void)
> +{
> +	/*
> +	 * We might be executing in NMI context, and so cannot use
> +	 * IRET as a synchronizing instruction.
> +	 *
> +	 * We could use native_write_cr2() but that is not guaranteed
> +	 * to work on Xen-PV -- it is emulated by Xen and might not
> +	 * execute an iret (or similar synchronizing instruction)
> +	 * internally.
> +	 *
> +	 * cpuid() would trap as well. Unclear if that's a solution
> +	 * either.
> +	 */
> +	if (in_nmi())
> +		cpuid_eax(1);
> +	else
> +		sync_core();
> +}

That's not thinking staight; what do you think the INT3 does when it
happens inside an NMI ?
