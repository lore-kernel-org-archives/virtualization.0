From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] powerpc use pv-qpsinlock as the default spinlock
	implemention
Date: Thu, 26 May 2016 18:50:47 +0200
Message-ID: <20160526165047.GM3206@twins.programming.kicks-ass.net>
References: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1464164289-6124-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
Cc: jeremy@goop.org, mpe@ellerman.id.au, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, paulus@samba.org, benh@kernel.crashing.org, akataria@vmware.com, paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 25, 2016 at 04:18:03PM +0800, Pan Xinhui wrote:

> _____test________________spinlcok______________pv-qspinlcok_____
> |futex hash	|	556370 ops	|	629634 ops	|
> |futex lock-pi	|	362 ops		|	367 ops		|
> 
> scheduler test:
> Test how many loops of schedule() can finish within 10 seconds on all cpus.
> 
> _____test________________spinlcok______________pv-qspinlcok_____
> |schedule() loops|	322811921 	|	311449290	|
> 
> kernel compiling test:
> build a linux kernel image to see how long it took
> 
> _____test________________spinlcok______________pv-qspinlcok_____
> | compiling takes|	22m 		|	22m		|


s/spinlcok/spinlock/

Is 'spinlcok' the current test-and-set lock?

And what about regular qspinlock, in case of !SHARED_PROCESSOR?
