From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/spinlock: support vcpu preempted check
Date: Tue, 5 Jul 2016 17:57:56 +0800
Message-ID: <CANRm+CxQMSrg69p2Xey829Mz4Au9YCai+4JD17i9urdbj0VgkQ__29468.4543893256$1467739870$gmane$org@mail.gmail.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1467124991-13164-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Peter Zijlstra <peterz@infradead.org>, mpe@ellerman.id.au, boqun.feng@gmail.com, will.deacon@arm.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Waiman Long <waiman.long@hpe.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org, schwidefsky@de.ibm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Xinhui,
2016-06-28 22:43 GMT+08:00 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>:
> This is to fix some lock holder preemption issues. Some other locks
> implementation do a spin loop before acquiring the lock itself. Currently
> kernel has an interface of bool vcpu_is_preempted(int cpu). It take the cpu
> as parameter and return true if the cpu is preempted. Then kernel can break
> the spin loops upon on the retval of vcpu_is_preempted.
>
> As kernel has used this interface, So lets support it.
>
> Only pSeries need supoort it. And the fact is powerNV are built into same
> kernel image with pSeries. So we need return false if we are runnig as
> powerNV. The another fact is that lppaca->yiled_count keeps zero on
> powerNV. So we can just skip the machine type.

Lock holder vCPU preemption can be detected by hardware pSeries or
paravirt method?

Regards,
Wanpeng Li
