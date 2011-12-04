From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Sun, 4 Dec 2011 17:11:49 +0200
Message-ID: <20111204151148.GA21851@redhat.com>
References: <1322669511.3985.8.camel@lappy> <87wrahrp0u.fsf@rustcorp.com.au>
	<20111201075847.GA5479@redhat.com> <1322726977.3259.3.camel@lappy>
	<20111201102640.GB8822@redhat.com> <87zkfbre9x.fsf@rustcorp.com.au>
	<1322913028.3782.4.camel@lappy> <4EDB5EF0.2010909@redhat.com>
	<20111204120132.GB18758@redhat.com> <4EDB624A.3030403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4EDB624A.3030403@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: markmc@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Dec 04, 2011 at 02:06:34PM +0200, Avi Kivity wrote:
> On 12/04/2011 02:01 PM, Michael S. Tsirkin wrote:
> > > 
> > > How much better?
> > > 
> > > I think that if indirects benefit networking, then we're doing something
> > > wrong.  What's going on?  Does the ring get filled too early?  If so we
> > > should expand it.
> >
> > The ring is physically contigious.
> > With 256 entries and 64 bytes each, that's already 16K.
> 
> A descriptor is just 16 bytes.

Right. Not sure where did I get 64.

> There's also the used ring, but that's a
> mistake if you have out of order completion.  We should have used copying.

Seems unrelated... unless you want used to be written into
descriptor ring itself?
But, I don't really know why does virtio ring insist on
making the 3 buffers (avail/used/descriptor)
physically contigious. Rusty?

> 16kB worth of descriptors is 1024 entries.  With 4kB buffers, that's 4MB
> worth of data, or 4 ms at 10GbE line speed.  With 1500 byte buffers it's
> just 1.5 ms.  In any case I think it's sufficient.

Right. So I think that without indirect, we waste about 3 entries
per packet for virtio header and transport etc headers.

> -- 
> error compiling committee.c: too many arguments to function
