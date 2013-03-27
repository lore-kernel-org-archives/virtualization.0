From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH V3 WIP 3/3] disable vhost_verify_ring_mappings check
Date: Wed, 27 Mar 2013 15:33:49 -0700
Message-ID: <1364423629.17698.25.camel__39257.3187280961$1364423676$gmane$org@haakon2.linux-iscsi.org>
References: <1363653285-23776-1-git-send-email-asias@redhat.com>
	<1363653285-23776-4-git-send-email-asias@redhat.com>
	<20130319084057.GB24393@stefanha-thinkpad.redhat.com>
	<1363744628.13070.28.camel@haakon2.linux-iscsi.org>
	<20130320095140.GA16615@redhat.com>
	<1364419887.17698.19.camel@haakon2.linux-iscsi.org>
	<20130327215625.GC10678@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130327215625.GC10678@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-03-27 at 23:56 +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2013 at 02:31:27PM -0700, Nicholas A. Bellinger wrote:
> > On Wed, 2013-03-20 at 11:51 +0200, Michael S. Tsirkin wrote:
> > > On Tue, Mar 19, 2013 at 06:57:08PM -0700, Nicholas A. Bellinger wrote:
> > > > On Tue, 2013-03-19 at 09:40 +0100, Stefan Hajnoczi wrote:
> > > > > On Tue, Mar 19, 2013 at 08:34:45AM +0800, Asias He wrote:
> > > > > > ---
> > > > > >  hw/vhost.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > > 
> > > > > > diff --git a/hw/vhost.c b/hw/vhost.c
> > > > > > index 4d6aee3..0c52ec4 100644
> > > > > > --- a/hw/vhost.c
> > > > > > +++ b/hw/vhost.c
> > > > > > @@ -421,10 +421,12 @@ static void vhost_set_memory(MemoryListener *listener,
> > > > > >          return;
> > > > > >      }
> > > > > >  
> > > > > > +#if 0
> > > > > >      if (dev->started) {
> > > > > >          r = vhost_verify_ring_mappings(dev, start_addr, size);
> > > > > >          assert(r >= 0);
> > > > > >      }
> > > > > > +#endif
> > > > > 
> > > > > Please add a comment to explain why.
> > > > > 
> > > > 
> > > > Btw, the output that Asias added in the failure case at the behest of
> > > > MST is here:
> > > > 
> > > > http://www.spinics.net/lists/target-devel/msg04077.html
> > > 
> > > Yes I suspected we could get l > ring_size, but this is
> > > not the case here.
> > > 
> > 
> > Hi MST & Co,
> > 
> > A quick update here..
> > 
> > So this issue appears to be related to performing the
> > vhost_verify_ring_mappings() call after vhost_dev_unassign_memory() has
> > been invoked with vhost_set_memory(..., add=false).
> > 
> > AFAICT from the logs below, things appear to work as expected when
> > vhost_verify_ring_mappings() is called only for the
> > vhost_set_memory(..., add=true) case.
> > 
> > Calling vhost_verify_ring_mappings() when dev->started == true +
> > vhost_set_memory(..., add=false) appears to be a bug caused by fallout
> > from:
> > 
> > commit 24f4fe345c1b80bab1ee18573914123d8028a9e6
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Tue Dec 25 17:41:07 2012 +0200
> > 
> >     vhost: set started flag while start is in progress
> > 
> > I'm including the following patch in the forth-coming vhost-scsi series.
> > Please let me know if you have any concerns.
> > 
> > diff --git a/hw/vhost.c b/hw/vhost.c
> > index 4d6aee3..687a689 100644
> > --- a/hw/vhost.c
> > +++ b/hw/vhost.c
> > @@ -421,7 +421,7 @@ static void vhost_set_memory(MemoryListener *listener,
> >          return;
> >      }
> >  
> > -    if (dev->started) {
> > +    if (dev->started && add) {
> >          r = vhost_verify_ring_mappings(dev, start_addr, size);
> >          assert(r >= 0);
> >      }
> > 
> > Thanks!
> > 
> > --nab
> 
> Sorry NAK,
> I think this will shut down too much stuff:
> the main reason to check is when we delete a region.
> 

<nod>

> > vhost_set_memory: section: 0x7f2249986b60 section->size: 2146697216 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 2146697216
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c0000 for vq 2
> > Unable to map ring buffer for ring 2
> > l: 4096 ring_size: 5124
> > vhost_set_memory: section: 0x7f2249986aa0 section->size: 32768 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 32768
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ee000 ring_size: 5124
> > vhost_set_memory: section: 0x7f2249986aa0 section->size: 2146664448 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c8000 size: 2146664448
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c8000 for vq 2
> > vhost_set_memory: section: 0x7f2249986b60 section->size: 32768 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 32768
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ee000 ring_size: 5124
> > vhost_set_memory: section: 0x7f2249986b60 section->size: 2146664448 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c8000 size: 2146664448
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c8000 for vq 2
> > Unable to map ring buffer for ring 2
> > l: 0 ring_size: 5124
> > vhost_set_memory: section: 0x7f2249986aa0 section->size: 36864 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c0000 size: 36864
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ee000 ring_size: 5124
> > vhost_set_memory: section: 0x7f2249986aa0 section->size: 2146660352 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c9000 size: 2146660352
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c9000 for vq 2
> > vhost_set_memory: section: 0x7f2249986b60 section->size: 2146660352 add: 0
> > Before vhost_verify_ring_mappings: start_addr: c9000 size: 2146660352
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c9000 for vq 2
> > Unable to map ring buffer for ring 2
> > l: 0 ring_size: 5124
> > vhost_set_memory: section: 0x7f2249986aa0 section->size: 159744 add: 1
> > Before vhost_verify_ring_mappings: start_addr: c9000 size: 159744
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Calling l: 5124 for start_addr: c9000 for vq 2
> > vhost_set_memory: section: 0x7f2249986aa0 section->size: 65536 add: 1
> > Before vhost_verify_ring_mappings: start_addr: f0000 size: 65536
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ee000 ring_size: 5124
> > vhost_set_memory: section: 0x7f2249986aa0 section->size: 2146435072 add: 1
> > Before vhost_verify_ring_mappings: start_addr: 100000 size: 2146435072
> > Checking vq: 0 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 0 ring_phys: 0 ring_size: 1028
> > Checking vq: 1 ring_phys: 0 ring_size: 1028 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 1 ring_phys: 0 ring_size: 1028
> > Checking vq: 2 ring_phys: ee000 ring_size: 5124 >>>>>>>>>>>>>>>>>>.
> > Got ranges_overlap for vq: 2 ring_phys: ee000 ring_size: 5124
> 
> I still do not understand how this happened.  Somehow a memory region
> was deleted after vhost_dev_start but before vhost_virtqueue_start was
> called?

Not sure..

To clarify, this is only happening during seabios setup+scan of
virtio-scsi, and not during normal virtio_scsi LLD operation.

> Can you set a breakpoint there and see please?
> 
> 

Sure, will have a look here.

Thanks,

--nab
