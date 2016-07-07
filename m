From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Date: Thu, 7 Jul 2016 13:15:54 +0200
Message-ID: <20160707111554.GV30921@twins.programming.kicks-ass.net>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160706065255.GH30909@twins.programming.kicks-ass.net>
	<14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
	<CANRm+CwXLsNrC59g6tZk=U+T0Scn_O=b60NPESJXU6uaP7-AsA@mail.gmail.com>
	<8e8edf1b-b64b-3c44-b580-b9271663844c@redhat.com>
	<CANRm+Cz1Ncxm7g0ophT+ijUmqnmTq9VwCZau3wMS56Vkm2+7fQ@mail.gmail.com>
	<20160707094215.GT30921@twins.programming.kicks-ass.net>
	<CANRm+CyrPbOVpJ6-Wa=g6oXTU0vVfw-ciLgm-duZeVF6MBH=RA@mail.gmail.com>
	<CANRm+CxKVqrFB-cRPEvmUamZ5Y8cOGe3pyc0LMJy0t9_jo+i0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CANRm+CxKVqrFB-cRPEvmUamZ5Y8cOGe3pyc0LMJy0t9_jo+i0Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, benh@kernel.crashing.org, kvm <kvm@vger.kernel.org>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, schwidefsky@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 07, 2016 at 06:27:26PM +0800, Wanpeng Li wrote:
> In addition, I see xen's vcpu_runstate_info::state is updated during
> schedule, so I think I can do this similarly through kvm preemption
> notifier. IIUC, xen hypervisor has VCPUOP_get_runstate_info hypercall
> implemention, so the desired interface can be implemented if they add
> hypercall callsite in domU. I can add hypercall to kvm similarly.

So I suspect Xen has the page its writing to pinned in memory; so that a
write to it is guaranteed to not fault.

Otherwise I cannot see this working.

That is part of the larger surgery required for KVM steal time to get
'fixed'. Currently that steal time stuff uses kvm_write_guest_cached()
which appears to be able to fault in guest pages.

Or I'm not reading this stuff right; which is entirely possible.
