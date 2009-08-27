From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv4 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 27 Aug 2009 19:29:22 +0930
Message-ID: <200908271929.23454.rusty__20266.8392834768$1251367258$gmane$org@rustcorp.com.au>
References: <cover.1250693417.git.mst@redhat.com>
	<20090825131634.GA13949@redhat.com>
	<20090826165655.GA23632@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090826165655.GA23632@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 Aug 2009 02:26:55 am Michael S. Tsirkin wrote:
> On Tue, Aug 25, 2009 at 04:16:34PM +0300, Michael S. Tsirkin wrote:
> > > > +	/* If they don't want an interrupt, don't send one, unless empty. */
> > > > +	if ((flags & VRING_AVAIL_F_NO_INTERRUPT) && vq->inflight)
> > > > +		return;
> > > 
> > > And I wouldn't support notify on empty at all, TBH.
> > 
> > If I don't, virtio net in guest uses a timer, which might be expensive.
> > Will need to check what this does.
> > 
> > >  It should
> > > definitely be conditional on the guest accepting the NOTIFY_ON_EMPTY
> > > feature.
> 
> lguest does not do it this way though, do it?

Does when a patch in my current queue is applied though.

Thanks,
Rusty.
