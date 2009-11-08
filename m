From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Sun, 8 Nov 2009 14:39:59 +1030
Message-ID: <200911081439.59770.rusty__37794.4039916203$1257653524$gmane$org@rustcorp.com.au>
References: <cover.1257267892.git.mst@redhat.com>
	<200911061531.20299.rusty@rustcorp.com.au>
	<20091106163007.GC6746@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091106163007.GC6746@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 7 Nov 2009 03:00:07 am Paul E. McKenney wrote:
> On Fri, Nov 06, 2009 at 03:31:20PM +1030, Rusty Russell wrote:
> > But it's still nasty to use half an API.  If it were a few places I would
> > have open-coded it with a comment, or wrapped it.  As it is, I don't think
> > that would be a win.
> 
> So would it help to have a rcu_read_lock_workqueue() and
> rcu_read_unlock_workqueue() that checked nesting and whether they were
> actually running in the context of a workqueue item?  Or did you have
> something else in mind?  Or am I misjudging the level of sarcasm in
> your reply?  ;-)

You read correctly.  If we get a second user, creating an API makes sense.

Thanks,
Rusty.
