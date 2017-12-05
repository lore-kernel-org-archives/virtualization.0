From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH tip/core/rcu 21/21] drivers/vhost: Remove now-redundant
	read_barrier_depends()
Date: Tue, 5 Dec 2017 23:09:02 +0100
Message-ID: <20171205220902.GY3165__22536.6378938363$1512562228$gmane$org@worktop.lehotels.local>
References: <20171205202928-mutt-send-email-mst@kernel.org>
	<20171205183946.GP3165@worktop.lehotels.local>
	<20171205204928-mutt-send-email-mst@kernel.org>
	<20171205191733.GQ3165@worktop.lehotels.local>
	<20171205212053-mutt-send-email-mst@kernel.org>
	<20171205193339.GP7829@linux.vnet.ibm.com>
	<20171205215020-mutt-send-email-mst@kernel.org>
	<20171205200801.GR7829@linux.vnet.ibm.com>
	<20171205222857-mutt-send-email-mst@kernel.org>
	<20171205213644.GU7829@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20171205213644.GU7829@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, fweisbec@gmail.com, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org, josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com, netdev@vger.kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, dipankar@in.ibm.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 05, 2017 at 01:36:44PM -0800, Paul E. McKenney wrote:
> What we do in some code is to comment the pairings, allowing the other
> side of the pairing to be easily located.  Would that work for you?

I would say that that is mandatory for any memory ordering code ;-)
