From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Fwd: Re: [RFC] kvm tools: Implement multiple VQ for virtio-net
Date: Fri, 25 Nov 2011 02:47:44 -0500
Message-ID: <20111125074744.GA5705__4385.99173580787$1322345478$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Krishna Kumar <krkumar2@in.ibm.com>, gorcunov@gmail.com, Lai Jiangshan <laijs@cn.fujitsu.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias.hejun@gmail.com>, virtualization@lists.linux-foundation.org, Pekka Enberg <penberg@kernel.org>, Benjamin Poirier <benjamin.poirier@gmail.com>, Sasha Levin <levinsasha928@gmail.com>, netdev@vger.kernel.org, mingo@elte.hu, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Stephen,

Benjamin forwarded me your email stating:

> I have been playing with userspace-rcu which has a number of neat
> lockless routines for queuing and hashing. But there aren't kernel versions
> and several of them may require cmpxchg to work.

Just FYI, I made sure a few years ago that cmpxchg is implemented on all
architectures within the Linux kernel (using a interrupt disable
fallback on the cases where it is not supported architecturally, on
UP-only architectures), so we should be good to use the lock-free
structures as-is in the kernel on this front. As for the RCU use by
these structures, userspace RCU has very much the same semantic as in
the kernel, so we can implement and test these structures in userspace
and eventually port them to the kernel as needed.

Lai Jiangshan is actively working at making sure the user-level
implementation of the RCU lock-free hash table (currently in a
development branch of the userspace RCU git tree : urcu/ht-shrink, not
yet in master) is suitable for use in the Linux kernel too.

Best regards,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
