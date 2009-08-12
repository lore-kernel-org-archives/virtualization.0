From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 2/2] vhost_net: a kernel-level virtio server
Date: Wed, 12 Aug 2009 16:47:15 +0300
Message-ID: <20090812134715.GB29340__37419.1295858056$1250085191$gmane$org@redhat.com>
References: <cover.1249992497.git.mst@redhat.com>
	<20090811212802.GC26309@redhat.com> <4A82076A.1060805@gmail.com>
	<20090812090219.GB26847@redhat.com> <4A82BD2F.7080405@gmail.com>
	<20090812132539.GD29200@redhat.com> <4A82C68F.8070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A82C68F.8070306@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, netdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 12, 2009 at 09:41:35AM -0400, Gregory Haskins wrote:
> Michael S. Tsirkin wrote:
> > On Wed, Aug 12, 2009 at 09:01:35AM -0400, Gregory Haskins wrote:
> >> I think I understand what your comment above meant:  You don't need to
> >> do synchronize_rcu() because you can flush the workqueue instead to
> >> ensure that all readers have completed.
> > 
> > Yes.
> > 
> >>  But if thats true, to me, the
> >> rcu_dereference itself is gratuitous,
> > 
> > Here's a thesis on what rcu_dereference does (besides documentation):
> > 
> > reader does this
> > 
> > 	A: sock = n->sock
> > 	B: use *sock
> > 
> > Say writer does this:
> > 
> > 	C: newsock = allocate socket
> > 	D: initialize(newsock)
> > 	E: n->sock = newsock
> > 	F: flush
> > 
> > 
> > On Alpha, reads could be reordered.  So, on smp, command A could get
> > data from point F, and command B - from point D (uninitialized, from
> > cache).  IOW, you get fresh pointer but stale data.
> > So we need to stick a barrier in there.
> 
> Yes, that is understood.  Perhaps you should just use a normal barrier,
> however.  (Or at least a comment that says "I am just using this for its
> barrier").
> 
> > 
> >> and that pointer is *not* actually
> >> RCU protected (nor does it need to be).
> > 
> > Heh, if readers are lockless and writer does init/update/sync,
> > this to me spells rcu.
> 
> More correctly: it "smells like" RCU, but its not. ;)  It's rcu-like,
> but you are not really using the rcu facilities.  I think anyone that
> knows RCU and reads your code will likely be scratching their heads as well.
> 
> Its probably not a big deal, as I understand your code now.  Just a
> suggestion to help clarify it.
> 
> Regards,
> -Greg
> 

OK, I'll add some comments about that.
Thanks for the review!

-- 
MST
