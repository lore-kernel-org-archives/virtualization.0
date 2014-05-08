From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 00/19] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Thu, 08 May 2014 13:54:55 -0400
Message-ID: <536BC4EF.9040208__46540.6388314024$1399571731$gmane$org@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<20140507190723.GB16333@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140507190723.GB16333@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/07/2014 03:07 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, May 07, 2014 at 11:01:28AM -0400, Waiman Long wrote:
>> v9->v10:
>>    - Make some minor changes to qspinlock.c to accommodate review feedback.
>>    - Change author to PeterZ for 2 of the patches.
>>    - Include Raghavendra KT's test results in patch 18.
> Any chance you can post these on a git tree? Thanks.

I have pushed the bit to https://github.com/longman88/kernel-qspinlock-v10 .

-Longman
