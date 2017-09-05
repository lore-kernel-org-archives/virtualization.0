From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 3/4] paravirt: add virt_spin_lock pvops function
Date: Tue, 5 Sep 2017 16:01:40 +0200
Message-ID: <4134a0d5-a25e-9f8a-9598-c36d2cabd18a@suse.com>
References: <20170905132444.7163-1-jgross@suse.com>
	<20170905132444.7163-4-jgross@suse.com>
	<20170905135506.55drjahteljbatak@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170905135506.55drjahteljbatak@hirez.programming.kicks-ass.net>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: jeremy@goop.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, longman@redhat.com, hpa@zytor.com, xen-devel@lists.xenproject.org, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 05/09/17 15:55, Peter Zijlstra wrote:
> On Tue, Sep 05, 2017 at 03:24:43PM +0200, Juergen Gross wrote:
>> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
>> index 48a706f641f2..fbd98896385c 100644
>> --- a/arch/x86/include/asm/qspinlock.h
>> +++ b/arch/x86/include/asm/qspinlock.h
>> @@ -17,6 +17,25 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
>>  	smp_store_release((u8 *)lock, 0);
>>  }
>>  
> 
> 
> Should this not have:
> 
> #ifdef CONFIG_PARAVIRT
> 
> ?

I can add it if you want.


Juergen
