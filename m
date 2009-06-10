From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: TODO list for qemu+KVM networking performance v2
Date: Wed, 10 Jun 2009 17:53:58 +0300
Message-ID: <20090610145358.GB28601__44580.3922870711$1244645748$gmane$org@redhat.com>
References: <20090604164320.GB14592@redhat.com>
	<200906101309.14532.rusty@rustcorp.com.au>
	<4A2F5217.9090401@redhat.com>
	<200906110009.34671.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906110009.34671.rusty@rustcorp.com.au>
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
Cc: Chris Wright <chrisw@redhat.com>, Mark McLoughlin <markmc@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, Brian Stein <bstein@redhat.com>, Herbert Xu <herbert.xu@redhat.com>, virtualization@lists.linux-foundation.org, Dor Laor <dor@redhat.com>, Avi Kivity <avi@redhat.com>, Yaron Haviv <yaronh@voltaire.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2009 at 12:09:33AM +0930, Rusty Russell wrote:
> On Wed, 10 Jun 2009 03:56:31 pm Dor Laor wrote:
> > Rusty Russell wrote:
> > > The current theoretical hole is that the host suppresses notifications
> > > using the VIRTIO_AVAIL_F_NO_NOTIFY flag, but we can get a number of
> > > notifications in before it gets to that suppression.  You can use a
> > > counter to improve this: you only notify when they're equal, and inc when
> > > you notify.  That way you suppress further notifications even if the
> > > other side takes ages to wake up. In practice, this shouldn't be played
> > > with until we have full aio (or equiv in kernel) for other side: host
> > > xmit tends to be too fast at the moment and we get a notification per
> > > packet anyway.
> >
> > Xen ring has the exact optimization for ages. imho we should have it
> > too, regardless of aio.
> > It reduces #vmexits/spurious wakeups and it is very simple to implement.
> 
> But look at number of wakeups received vs notifications sent: I just don't see 
> any benefit there at the moment.  As I said, improving the host code might 
> change that significantly.
> 
> And implementing it the other way is v. v. hard given the nature of interrupts 
> (shared and coalesced).

I agree it's not such a simple thing to implement race-free,
so I do buy the argument that we shouldn't unless it gives
a performance benefit.

But I don't understand how aio will make implementing it easier -
or are you merely saying that it will make it worthwhile?

-- 
MST
