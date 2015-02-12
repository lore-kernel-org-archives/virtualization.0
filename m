From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] x86 spinlock: Fix memory corruption on completing
	completions
Date: Thu, 12 Feb 2015 19:51:55 +0530
Message-ID: <54DCB703.9020109__30131.2065720142$1423751435$gmane$org@linux.vnet.ibm.com>
References: <1423741647-2156-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20150212133707.GA10232@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150212133707.GA10232@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: jeremy@goop.org, kvm@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, a.ryabinin@samsung.com, x86@kernel.org, borntraeger@de.ibm.com, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, dave@stgolabs.net, sasha.levin@oracle.com, davej@redhat.com, tglx@linutronix.de, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/12/2015 07:07 PM, Oleg Nesterov wrote:
> On 02/12, Raghavendra K T wrote:
>>
>> @@ -772,7 +773,8 @@ __visible void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
>>   	 * check again make sure it didn't become free while
>>   	 * we weren't looking.
>>   	 */
>> -	if (ACCESS_ONCE(lock->tickets.head) == want) {
>> +	head = ACCESS_ONCE(lock->tickets.head);
>> +	if (__tickets_equal(head, want)) {
>>   		add_stats(TAKEN_SLOW_PICKUP, 1);
>
> While at it, perhaps it makes sense to s/ACCESS_ONCE/READ_ONCE/ but this
> is cosmetic.

yes.. will do.

>
> We also need to change another user of enter_slow_path, xen_lock_spinning()
> in arch/x86/xen/spinlock.c.
>

Had in mind but forgot before sending. will update resend.

> Other than that looks correct at first glance... but this is up to
> maintainers.
>

Thanks
