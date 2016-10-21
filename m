From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/9] implement vcpu preempted check
Date: Fri, 21 Oct 2016 07:40:50 +0200
Message-ID: <20161021054050.GX3102__9417.73703457347$1477030785$gmane$org@twins.programming.kicks-ass.net>
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, jgross@suse.com, kvm@vger.kernel.org, rkrcmar@redhat.com, xen-devel-request@lists.xenproject.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, boqun.feng@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 20, 2016 at 05:27:45PM -0400, Pan Xinhui wrote:

> 
> This patch set aims to fix lock holder preemption issues.

Thanks, this looks very good. I'll wait for ACKs from at least the KVM
people, since that was I think the most contentious patch.
