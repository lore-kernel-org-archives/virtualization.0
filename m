From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Date: Fri, 6 Sep 2019 08:08:17 -0400
Message-ID: <20190906120817.GA22083__42164.0300470003$1567771716$gmane$org@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
	<CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
	<20190906103613.GH5900@stefanha-x1.localdomain>
	<CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, linux-kernel@vger.kernel.org, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 06, 2019 at 01:52:41PM +0200, Miklos Szeredi wrote:
> On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > > On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > > > items and races w.r.t device removal.
> > > >
> > > > In this first round of cleanups, I have taken care of most pressing
> > > > issues.
> > > >
> > > > These patches apply on top of following.
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > > >
> > > > I have tested these patches with mount/umount and device removal using
> > > > qemu monitor. For example.
> > >
> > > Is device removal mandatory?  Can't this be made a non-removable
> > > device?  Is there a good reason why removing the virtio-fs device
> > > makes sense?
> >
> > Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> > much like removal to work from the beginning.
> 
> Can you give an example use case?

David Gilbert mentioned this could be useful if daemon stops responding
or dies. One could remove device. That will fail all future requests
and allow unmounting filesystem.

Havind said that, current implementation will help in above situation
only if there are no pending requests. If there are pending requests
and daemon stops responding, then removal will hang too, as we wait
for draining the queues.

So at some point of time, we also need some sort of timeout functionality
where we end requests with error after a timeout.

I feel we should support removing device at some point of time. But its
not necessarily a must have feature for first round.

Thanks
Vivek
