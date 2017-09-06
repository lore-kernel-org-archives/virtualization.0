From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] paravirt: add virt_spin_lock pvops function
Date: Wed, 6 Sep 2017 09:08:16 +0200
Message-ID: <20170906070816.s6rtgtqpljnbudux__33297.6627433256$1504681745$gmane$org@hirez.programming.kicks-ass.net>
References: <20170905132444.7163-1-jgross@suse.com>
	<20170905132444.7163-4-jgross@suse.com>
	<c62a47cd-c46d-bfbf-77f2-ec27c86c0f7c@redhat.com>
	<42918500-4487-f0d8-e6fd-99e4d0d7f1bf@suse.com>
	<3a2eefe7-5c0b-9768-2bb8-03c947133b06@redhat.com>
	<a921465a-3c4f-9223-b4af-cd250df62f90@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a921465a-3c4f-9223-b4af-cd250df62f90@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org


Guys, please trim email.

On Tue, Sep 05, 2017 at 10:31:46AM -0400, Waiman Long wrote:
> For clarification, I was actually asking if you consider just adding one
> more jump label to skip it for Xen/KVM instead of making
> virt_spin_lock() a pv-op.

I don't understand. What performance are you worried about. Native will
now do: "xor rax,rax; jnz some_cold_label" that's fairly trival code.
