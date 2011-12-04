From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Sun, 4 Dec 2011 18:00:54 +0200
Message-ID: <20111204160053.GA22501@redhat.com>
References: <20111201075847.GA5479@redhat.com> <1322726977.3259.3.camel@lappy>
	<20111201102640.GB8822@redhat.com> <87zkfbre9x.fsf@rustcorp.com.au>
	<1322913028.3782.4.camel@lappy> <4EDB5EF0.2010909@redhat.com>
	<20111204120132.GB18758@redhat.com> <4EDB624A.3030403@redhat.com>
	<20111204151148.GA21851@redhat.com> <4EDB8EEB.4070309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4EDB8EEB.4070309@redhat.com>
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

On Sun, Dec 04, 2011 at 05:16:59PM +0200, Avi Kivity wrote:
> On 12/04/2011 05:11 PM, Michael S. Tsirkin wrote:
> > > There's also the used ring, but that's a
> > > mistake if you have out of order completion.  We should have used copying.
> >
> > Seems unrelated... unless you want used to be written into
> > descriptor ring itself?
> 
> The avail/used rings are in addition to the regular ring, no?

Yes. A couple of extra pages, if we reduce alignment we could pack this
in a single extra page.

>  If you
> copy descriptors, then it goes away.

The avail ring could go away. used could if we make descriptors
writeable. IIUC it was made RO in the hope that will make it
easier for xen to adopt. Still relevant?

> > But, I don't really know why does virtio ring insist on
> > making the 3 buffers (avail/used/descriptor)
> > physically contigious. Rusty?
> 
> Let's drop them instead.
> 
> >
> > > 16kB worth of descriptors is 1024 entries.  With 4kB buffers, that's 4MB
> > > worth of data, or 4 ms at 10GbE line speed.  With 1500 byte buffers it's
> > > just 1.5 ms.  In any case I think it's sufficient.
> >
> > Right. So I think that without indirect, we waste about 3 entries
> > per packet for virtio header and transport etc headers.
> 
> That does suck.  Are there issues in increasing the ring size?  Or
> making it discontiguous?

discontiguous ring is what indirect is, basically.

> Can you take a peek at how Xen manages its rings?  They have the same
> problems we do.
> 
> -- 
> error compiling committee.c: too many arguments to function
