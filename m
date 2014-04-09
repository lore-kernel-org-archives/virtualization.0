From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 00/10] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Wed, 09 Apr 2014 17:38:11 +0530
Message-ID: <5345382B.3050400__9437.58804719455$1397045611$gmane$org@linux.vnet.ibm.com>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
	<5342425A.7040005@linux.vnet.ibm.com> <5342D475.7060503@hp.com>
	<5342E5B2.1070306@linux.vnet.ibm.com> <53444AEE.9050705@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53444AEE.9050705@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/09/2014 12:45 AM, Waiman Long wrote:
> Yes, I am able to reproduce the hang problem with ebizzy. BTW, could you
> try to apply the attached patch file on top of the v8 patch series to
> see if it can fix the hang problem?

Ran the benchmarks with the fix and I am not seeing hang so far.
ebizzy improvements.

0.5x  2.7345
1x   -10.6593
1.5x  35.6962
2x    88.0461

dbench improvements
0.5x   3.2428
1x     1.1514
1.5x   5.5071
2x    23.8700
( I will have to restest on ebizzy 1x reression but overall performance
numbers look good).

>> Baseline was 3.14-rc8 without any of the qspin patch series.
>>
>
> Does the baseline have PV ticketlock or without any PV support?

baseline had PV ticketlock enabled.
