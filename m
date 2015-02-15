From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V5] x86 spinlock: Fix memory corruption on completing
	completions
Date: Sun, 15 Feb 2015 21:31:59 +0100
Message-ID: <20150215203159.GA8191@redhat.com>
References: <1423979744-18320-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150215173043.GA7471@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150215173043.GA7471@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/15, Raghavendra K T wrote:
>
> * Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> [2015-02-15 11:25:44]:
>
> Resending the V5 with smp_mb__after_atomic() change without bumping up
> revision

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


Of course, this needs the acks from maintainers. And I agree that SLOWPATH
in .head makes xadd() in unlock() unavoidable. However I do not see how we
can avoid the locked inc if we want to eliminate read-after-unlock.
