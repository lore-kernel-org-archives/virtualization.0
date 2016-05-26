From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] powerpc use pv-qpsinlock as the default spinlock
	implemention
Date: Thu, 26 May 2016 18:54:23 +0200
Message-ID: <20160526165423.GN3206@twins.programming.kicks-ass.net>
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
> I do several tests on pseries IBM,8408-E8E with 32cpus, 64GB memory.
> benchmark test results are below.

> _____test________________spinlcok______________pv-qspinlcok_____
> | compiling takes|	22m 		|	22m		|

How can a kernel build take 22 minutes with 32 CPUs? That's far too
long. My 40 CPU IVB-EP takes all of 50 seconds to build an
x86_64-defconfig from scratch.
