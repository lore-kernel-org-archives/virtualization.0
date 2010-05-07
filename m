From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Qemu-devel] [PATCH RFC] virtio: put last seen used index into
	=?iso-8859-1?q?ring=09itself?=
Date: Fri, 7 May 2010 12:53:52 +0930
Message-ID: <201005071253.53393.rusty__16869.3795022138$1273202793$gmane$org@rustcorp.com.au>
References: <20100505205814.GA7090@redhat.com> <4BE29320.5090506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4BE29320.5090506@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 6 May 2010 07:30:00 pm Avi Kivity wrote:
> On 05/05/2010 11:58 PM, Michael S. Tsirkin wrote:
> > +	/* We publish the last-seen used index at the end of the available ring.
> > +	 * It is at the end for backwards compatibility. */
> > +	vr->last_used_idx =&(vr)->avail->ring[num];
> > +	/* Verify that last used index does not spill over the used ring. */
> > +	BUG_ON((void *)vr->last_used_idx +
> > +	       sizeof *vr->last_used_idx>  (void *)vr->used);
> >   }
> >    
> 
> Shouldn't this be on its own cache line?

It's next to the available ring; because that's where the guest publishes
its data.  That whole page is guest-write, host-read.

Putting it on a cacheline by itself would be a slight pessimization; the host
cpu would have to get the last_used_idx cacheline and the avail descriptor
cacheline every time.  This way, they are sometimes the same cacheline.

Hope that clarifies,
Rusty.
