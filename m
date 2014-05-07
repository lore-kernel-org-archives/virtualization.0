From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 00/19] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Wed, 07 May 2014 11:00:10 -0400
Message-ID: <536A4A7A.3050001__40486.7707206451$1399474847$gmane$org@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<535D47D3.20202@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <535D47D3.20202@linux.vnet.ibm.com>
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

On 04/27/2014 02:09 PM, Raghavendra K T wrote:
>
> For kvm part feel free to add:
> Tested-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>
> V9 testing has shown no hangs.
> I was able to do some performance testing. here are the results:
>
> Overall we are seeing good improvement for pv-unfair version.
>
> System : 32 cpu sandybridge with HT on. (4 node machine with 32 GB each)
> Guest: 8GB with 16 vcpu/VM.
> Average was taken over 8-10 data points.
>
> Base = 3.15-rc2    with PRAVIRT_SPINLOCK = y
> A = 3.15-rc2 + qspinlock v9 patch with QUEUE_SPINLOCK = y 
> PRAVIRT_SPINLOCK = y PARAVIRT_UNFAIR_LOCKS = y (unfair lock)
> B =  3.15-rc2 + qspinlock v9 patch with QUEUE_SPINLOCK = y 
> PRAVIRT_SPINLOCK = n PARAVIRT_UNFAIR_LOCKS = n (queue spinlock without 
> paravirt)
> C = 3.15-rc2 + qspinlock v9 patch with  QUEUE_SPINLOCK = y 
> PRAVIRT_SPINLOCK = y  PARAVIRT_UNFAIR_LOCKS = n (queue spinlock with 
> paravirt)
>
>
> Ebizzy % improvements
> ========================
> overcommit A        B        C
> 0.5x    4.4265        2.0611        1.5824
> 1.0x    0.9015        -7.7828       4.5443
> 1.5x    46.1162       -2.9845       -3.5046
> 2.0x    99.8150       -2.7116       4.7461
>
> Dbench     %improvements
> overcommit A        B        C
> 0.5x    3.2617        3.5436        2.5676
> 1.0x    0.6302        2.2342        5.2201
> 1.5x    5.0027        4.8275        3.8375
> 2.0x    23.8242       4.5782        12.6067
>
> Absolute values of base results: (overcommit, value, stdev)
> Ebizzy ( records / sec with 120 sec run)
> 0.5x 20941.8750 (2%)
> 1.0x 17623.8750 (5%)
> 1.5x  5874.7778 (15%)
> 2.0x  3581.8750 (7%)
>
> Dbench (throughput in MB/sec)
> 0.5x 10009.6610 (5%)
> 1.0x  6583.0538 (1%)
> 1.5x  3991.9622 (4%)
> 2.0x  2527.0613 (2.5%)
>

Thank for the testing. I will include your Test-by tag in the next version.

-Longman
