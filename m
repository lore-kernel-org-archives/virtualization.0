From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 1/6] qspinlock: powerpc support qspinlock
Date: Mon, 6 Jun 2016 17:59:07 +0200
Message-ID: <20160606155907.GH30909@twins.programming.kicks-ass.net>
References: <1464859370-5162-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1464859370-5162-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
	<1464917520.26773.11.camel@kernel.crashing.org>
	<1464917548.26773.12.camel@au1.ibm.com>
	<57510353.1020209@linux.vnet.ibm.com>
	<1464928427.26773.26.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1464928427.26773.26.camel@kernel.crashing.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, xinhui <xinhui.pan@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 03, 2016 at 02:33:47PM +1000, Benjamin Herrenschmidt wrote:
> =A0- For the above, can you show (or describe) where the qspinlock
> =A0 =A0improves things compared to our current locks.

So currently PPC has a fairly straight forward test-and-set spinlock
IIRC. You have this because LPAR/virt muck and lock holder preemption
issues etc..

qspinlock is 1) a fair lock (like ticket locks) and 2) provides
out-of-word spinning, reducing cacheline pressure.

Esp. on multi-socket x86 we saw the out-of-word spinning being a big win
over our ticket locks.

And fairness, brought to us by the ticket locks a long time ago,
eliminated starvation issues we had, where a spinner local to the holder
would 'always' win from a spinner further away. So under heavy enough
local contention, the spinners on 'remote' CPUs would 'never' get to own
the lock.

pv-qspinlock tries to preserve the fairness while allowing limited lock
stealing and explicitly managing which vcpus to wake.

>	While there's
> =A0 =A0theory and to some extent practice on x86, it would be nice to
> =A0 =A0validate the effects on POWER.

Right; so that will have to be from benchmarks which I cannot help you
with ;-)
