From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v6 02/11] locking/osq: Drop the overload of osq_lock()
Date: Sat, 29 Oct 2016 09:52:16 -0700
Message-ID: <20161029165216.GA17451__46212.1740718887$1477760648$gmane$org@linux-80c1.suse>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1477642287-24104-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, rkrcmar@redhat.com, peterz@infradead.org, benh@kernel.crashing.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, kernellwp@gmail.com, linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, jgross@suse.com, linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM, mpe@ellerman.id.au, pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 28 Oct 2016, Pan Xinhui wrote:
> 		/*
> 		 * If we need to reschedule bail... so we can block.
>+		 * Use vcpu_is_preempted to detech lock holder preemption issue
                                            ^^ detect
>+		 * and break. 

Could you please remove the rest of this comment? Its just noise to point out
that vcpu_is_preempted is a macro defined by arch/false. This is standard protocol
in the kernel.

Same goes for all locks you change with this.

Thanks,
Davidlohr

>                * vcpu_is_preempted is a macro defined by false if
>+		 * arch does not support vcpu preempted check,
> 		 */
>-		if (need_resched())
>+		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
> 			goto unqueue;
>
> 		cpu_relax_lowlatency();
>-- 
>2.4.11
>
