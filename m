From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] Implement Batched (group) ticket lock
Date: Tue, 01 Jul 2014 16:41:06 +0530
Message-ID: <53B2974A.6010809@linux.vnet.ibm.com>
References: <1403947024-3193-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20140701080537.GH6758@twins.programming.kicks-ass.net>
	<53B282E9.6060806@linux.vnet.ibm.com>
	<20140701095521.GO6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140701095521.GO6758@twins.programming.kicks-ass.net>
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
Cc: jeremy@goop.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, paul.gortmaker@windriver.com, hpa@zytor.com, ak@linux.intel.com, gleb@redhat.com, x86@kernel.org, mingo@redhat.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, oleg@redhat.com, davej@redhat.com, tglx@linutronix.de, fernando_b1@lab.ntt.co.jp, chegu_vinod@hp.com, waiman.long@hp.com, linux-kernel@vger.kernel.org, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

>>
>> For baremetal we continue to have 'fully fair ticketlock' with this patch
>> series.
>>
>
> But but but, we're looking at removing ticket locks. So why do we want
> to invest in them now?
>

I have nothing against qspinlock. I am happy to test it/add any bit to 
it if I could.

With this patch we get excellent performance for guest with the
unmodified kernel without affecting host.

My test on guest with batch_size =16,32 showed even better performance
               bs=16      bs=32
  ebizzy_0.5x   0.14       0.90
  ebizzy_1.0x   3.57       7.52
  ebizzy_1.5x  58.97      67.65
  ebizzy_2.0x 121.55     136.45
