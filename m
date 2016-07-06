From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Date: Wed, 6 Jul 2016 09:58:14 +0200
Message-ID: <20160706075814.GF30921@twins.programming.kicks-ass.net>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ@mail.gmail.com>
	<577C8FE3.3010208@linux.vnet.ibm.com>
	<CANRm+CySutzEYQuCaeqyLKKVPPcFDFT94UsNaYWo8fU43VsSig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CANRm+CySutzEYQuCaeqyLKKVPPcFDFT94UsNaYWo8fU43VsSig@mail.gmail.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, benh@kernel.crashing.org, kvm <kvm@vger.kernel.org>, xinhui <xinhui.pan@linux.vnet.ibm.com>, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, mpe@ellerman.id.au, schwidefsky@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 06, 2016 at 02:46:34PM +0800, Wanpeng Li wrote:
> > SO it's easy for ppc to implement such interface. Note that yield_count is
> > set by powerVM/KVM.
> > and only pSeries can run a guest for now. :)
> >
> > I also review x86 related code, looks like we need add one hyer-call to get
> > such vcpu preemption info?
> 
> There is no such stuff to record lock holder in x86 kvm, maybe we
> don't need to depend on PLE handler algorithm to guess it if we can
> know lock holder vCPU directly.

x86/kvm has vcpu->preempted to indicate if a vcpu is currently preempted
or not. I'm just not sure if that is visible to the guest or how to make
it so.
