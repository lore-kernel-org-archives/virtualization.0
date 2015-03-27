From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Fri, 27 Mar 2015 12:10:48 +0530
Message-ID: <5514FB70.4010600__10082.3520137512$1427438962$gmane$org@linux.vnet.ibm.com>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150316131613.720617163@infradead.org>
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
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, x86@kernel.org, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: virtualization@lists.linuxfoundation.org

On 03/16/2015 06:46 PM, Peter Zijlstra wrote:
> Hi Waiman,
>
> As promised; here is the paravirt stuff I did during the trip to BOS last week.
>
> All the !paravirt patches are more or less the same as before (the only real
> change is the copyright lines in the first patch).
>
> The paravirt stuff is 'simple' and KVM only -- the Xen code was a little more
> convoluted and I've no real way to test that but it should be stright fwd to
> make work.
>
> I ran this using the virtme tool (thanks Andy) on my laptop with a 4x
> overcommit on vcpus (16 vcpus as compared to the 4 my laptop actually has) and
> it both booted and survived a hackbench run (perf bench sched messaging -g 20
> -l 5000).
>
> So while the paravirt code isn't the most optimal code ever conceived it does work.
>
> Also, the paravirt patching includes replacing the call with "movb $0, %arg1"
> for the native case, which should greatly reduce the cost of having
> CONFIG_PARAVIRT_SPINLOCKS enabled on actual hardware.
>
> I feel that if someone were to do a Xen patch we can go ahead and merge this
> stuff (finally!).
>
> These patches do not implement the paravirt spinlock debug stats currently
> implemented (separately) by KVM and Xen, but that should not be too hard to do
> on top and in the 'generic' code -- no reason to duplicate all that.
>
> Of course; once this lands people can look at improving the paravirt nonsense.
>

last time I had reported some hangs in kvm case, and I can confirm that
the current set of patches works fine.

Feel free to add
Tested-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> #kvm pv

As far as performance is concerned (with my 16core +ht machine having
16vcpu guests [ even w/ , w/o the lfsr hash patchset ]), I do not see
any significant observations to report, though I understand that we
could see much more benefit with large number of vcpus because of
possible reduction in cache bouncing.
