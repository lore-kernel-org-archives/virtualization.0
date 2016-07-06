From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Date: Wed, 6 Jul 2016 13:59:54 +0200
Message-ID: <20160706115954.GK30921__8947.93173433772$1467806447$gmane$org@twins.programming.kicks-ass.net>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<20160706065255.GH30909@twins.programming.kicks-ass.net>
	<14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <14a24854-9787-e4a1-c9a8-76eba4e97301@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-s390@vger.kernel.org, dave@stgolabs.net, benh@kernel.crashing.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, boqun.feng@gmail.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 06, 2016 at 12:44:58PM +0200, Paolo Bonzini wrote:
> > Paolo, could you help out with an (x86) KVM interface for this?
> 
> If it's just for spin loops, you can check if the version field in the
> steal time structure has changed.

That would require remembering the old value, no?

That would work with a previous interface proposal, see:

  http://lkml.kernel.org/r/1466937715-6683-2-git-send-email-xinhui.pan@linux.vnet.ibm.com

the vcpu_get_yield_count() thing would match that I think.

However the current proposal:

  http://lkml.kernel.org/r/1467124991-13164-2-git-send-email-xinhui.pan@linux.vnet.ibm.com

dropped that in favour of only vcpu_is_preempted(), which requires being
able to tell if a (remote) vcpu is currently running or not, which iirc,
isn't possible with the steal time sequence count.
