From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Sun, 8 Nov 2009 11:36:33 -0800
Message-ID: <20091108193633.GL8424__19923.6773224131$1257709050$gmane$org@linux.vnet.ibm.com>
References: <cover.1257267892.git.mst@redhat.com>
	<200911061531.20299.rusty@rustcorp.com.au>
	<20091106163007.GC6746@linux.vnet.ibm.com>
	<200911081439.59770.rusty@rustcorp.com.au>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911081439.59770.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Nov 08, 2009 at 02:39:59PM +1030, Rusty Russell wrote:
> On Sat, 7 Nov 2009 03:00:07 am Paul E. McKenney wrote:
> > On Fri, Nov 06, 2009 at 03:31:20PM +1030, Rusty Russell wrote:
> > > But it's still nasty to use half an API.  If it were a few places I would
> > > have open-coded it with a comment, or wrapped it.  As it is, I don't think
> > > that would be a win.
> > 
> > So would it help to have a rcu_read_lock_workqueue() and
> > rcu_read_unlock_workqueue() that checked nesting and whether they were
> > actually running in the context of a workqueue item?  Or did you have
> > something else in mind?  Or am I misjudging the level of sarcasm in
> > your reply?  ;-)
> 
> You read correctly.  If we get a second user, creating an API makes sense.

Makes sense to me as well.  Which does provide some time to come up with
a primitive designed to answer the question "Am I currently executing in
the context of a workqueue item?".  ;-)

							Thanx, Paul
