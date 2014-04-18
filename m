From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 00/19] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Thu, 17 Apr 2014 21:50:54 -0400
Message-ID: <535084FE.2030902__45708.1409557306$1397785872$gmane$org@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<20140417172246.GA9849@localhost.localdomain>
	<5350120C.40607@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5350120C.40607@linux.vnet.ibm.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 04/17/2014 01:40 PM, Raghavendra K T wrote:
> On 04/17/2014 10:53 PM, Konrad Rzeszutek Wilk wrote:
>> On Thu, Apr 17, 2014 at 11:03:52AM -0400, Waiman Long wrote:
>>> v8->v9:
>>>    - Integrate PeterZ's version of the queue spinlock patch with some
>>>      modification:
>>>      http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
>>>    - Break the more complex patches into smaller ones to ease review 
>>> effort.
>>>    - Fix a racing condition in the PV qspinlock code.
>>
>> I am not seeing anything mentioning that the overcommit scenario
>> for KVM and Xen had been fixed. Or was the 'racing condition' said
>> issue?
>
> Saw changes in patch 18 that fixes for kvm (19 for xen). 'll
> test the series and confirm.
>

The main fix is by replacing some barrier() with smp_mb(). The 
additional changes in kvm and xen are not the main one.

-Longman
