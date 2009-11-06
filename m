From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Fri, 6 Nov 2009 08:30:07 -0800
Message-ID: <20091106163007.GC6746__43840.99254753$1257525182$gmane$org@linux.vnet.ibm.com>
References: <cover.1257267892.git.mst@redhat.com>
	<20091104115729.GD8398@redhat.com>
	<20091104172542.GC6736@linux.vnet.ibm.com>
	<200911061531.20299.rusty@rustcorp.com.au>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911061531.20299.rusty@rustcorp.com.au>
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

On Fri, Nov 06, 2009 at 03:31:20PM +1030, Rusty Russell wrote:
> On Thu, 5 Nov 2009 03:55:42 am Paul E. McKenney wrote:
> > On Wed, Nov 04, 2009 at 01:57:29PM +0200, Michael S. Tsirkin wrote:
> > > Can you ack this usage please?
> > 
> > I thought I had done so in my paragraph above, but if you would like
> > something a bit more formal...
> 
> <snip verbose super-ack with qualifications>
> 
> That's great guys.  And yes, this is a kind of read-copy-update.  And no,
> there's nothing wrong with it.
> 
> But it's still nasty to use half an API.  If it were a few places I would
> have open-coded it with a comment, or wrapped it.  As it is, I don't think
> that would be a win.

So would it help to have a rcu_read_lock_workqueue() and
rcu_read_unlock_workqueue() that checked nesting and whether they were
actually running in the context of a workqueue item?  Or did you have
something else in mind?  Or am I misjudging the level of sarcasm in
your reply?  ;-)

							Thanx, Paul
