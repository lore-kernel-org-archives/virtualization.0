From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 00/12] s390: virtio: support protected virtualization
Date: Wed, 10 Apr 2019 18:24:11 +0200
Message-ID: <20190410182411.1dc39bb2.cohuck@redhat.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
	<20190410112048.154c96fc.cohuck@redhat.com>
	<20190410175750.0ed0a454@oc2783563651>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410175750.0ed0a454@oc2783563651>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, Sebastian Ott <sebott@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, virtualization@lists.linux-foundation.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 10 Apr 2019 17:57:50 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 10 Apr 2019 11:20:48 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Fri,  5 Apr 2019 01:16:10 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:
> >   
> > > Enhanced virtualization protection technology may require the use of
> > > bounce buffers for I/O. While support for this was built into the
> > > virtio core,  virtio-ccw wasn't changed accordingly.
> > > 
> > > Thus what needs to be done to bring virtio-ccw up to speed with
> > > respect to this is:
> > > * use some 'new' common virtio stuff
> > > * make sure that virtio-ccw specific stuff uses shared memory when
> > >   talking to the hypervisor (except communication blocks like ORB,
> > > these are handled by the hypervisor)
> > > * make sure the DMA API does what is necessary to talk through shared
> > >   memory if we are a protected virtualization guest.
> > > * make sure the common IO layer plays along as well (airqs, sense).  
> > 
> > It would be good to have a summary somewhere in the code (or
> > Documentation/) as to what needs the dma treatment and what doesn't,
> > for later reference. We don't want people to accidentally break things
> > (especially if they cannot refer to architecture documentation - or
> > will at least some of that be published?)
> >   
> 
> I can put documentation on my TODO list. This cover letter was also
> supposed to provide a bird's-eye view on what needs to be done.

Some comments in the code to prevent further headscratching are also a
good idea.

> 
> > > 
> > > The series is structured in incremental fashion: some of the changes
> > > are overridden by following patches. The main reason why is that
> > > this is how I developed. But I think it ain't bad for the didactic
> > > and we are a bit more flexible with regards to throwing out some of
> > > the stuff in the end.  
> > 
> > FWIW, I think reshuffling the patches in the next iteration would ease
> > review.
> >   
> 
> Can you please tell me more about what is desired here? I mean, I made
> some tentative proposals on squashing some patches together. I don't
> remember any requests to reorder patches or split.

Just try to avoid to rewrite things multiple times -- if we agree on
the end result, we should be able to go there directly :)
