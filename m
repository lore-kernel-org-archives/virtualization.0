From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/5] virtio-pmem: Add virtio pmem driver
Date: Wed, 10 Apr 2019 18:52:41 +0200
Message-ID: <20190410185241.1b0b1982.cohuck__27123.1144013413$1554915214$gmane$org@redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-3-pagupta@redhat.com>
	<20190410091216-mutt-send-email-mst@kernel.org>
	<127904196.20807948.1554904981681.JavaMail.zimbra@redhat.com>
	<20190410163139.4a04175e.cohuck@redhat.com>
	<20190410124114-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410124114-mutt-send-email-mst@kernel.org>
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
Cc: Pankaj Gupta <pagupta@redhat.com>, jack@suse.cz, kvm@vger.kernel.org, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vg
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 10 Apr 2019 12:46:12 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Apr 10, 2019 at 04:31:39PM +0200, Cornelia Huck wrote:
> > On Wed, 10 Apr 2019 10:03:01 -0400 (EDT)
> > Pankaj Gupta <pagupta@redhat.com> wrote:
> >   
> > > > 
> > > > On Wed, Apr 10, 2019 at 09:38:22AM +0530, Pankaj Gupta wrote:    
> > > > > This patch adds virtio-pmem driver for KVM guest.
> > > > > 
> > > > > Guest reads the persistent memory range information from
> > > > > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > > > > creates a nd_region object with the persistent memory
> > > > > range information so that existing 'nvdimm/pmem' driver
> > > > > can reserve this into system memory map. This way
> > > > > 'virtio-pmem' driver uses existing functionality of pmem
> > > > > driver to register persistent memory compatible for DAX
> > > > > capable filesystems.
> > > > > 
> > > > > This also provides function to perform guest flush over
> > > > > VIRTIO from 'pmem' driver when userspace performs flush
> > > > > on DAX memory range.
> > > > > 
> > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>  
> >   
> > > > > diff --git a/include/uapi/linux/virtio_ids.h
> > > > > b/include/uapi/linux/virtio_ids.h
> > > > > index 6d5c3b2d4f4d..346389565ac1 100644
> > > > > --- a/include/uapi/linux/virtio_ids.h
> > > > > +++ b/include/uapi/linux/virtio_ids.h
> > > > > @@ -43,5 +43,6 @@
> > > > >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> > > > >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> > > > >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > > > > +#define VIRTIO_ID_PMEM         25 /* virtio pmem */
> > > > >  
> > > > >  #endif /* _LINUX_VIRTIO_IDS_H */    
> > > > 
> > > > Didn't Paolo point out someone is using 25 for audio?    
> > > 
> > > 
> > > Sorry! I did not notice this.
> > >   
> > > > 
> > > > Please, reserve an ID with the Virtio TC before using it.    
> > > 
> > > I thought I requested[1] ID 25.
> > > 
> > > [1] https://github.com/oasis-tcs/virtio-spec/issues/38
> > > [2] https://lists.oasis-open.org/archives/virtio-dev/201805/threads.html
> > > 
> > > In that case I will send request for next available ID i.e 26?  
> > 
> > Have the folks using this for audio sent a reservation request as well?
> > If not, I'd say the first requester should get the id...  
> 
> No but I think they ship their's already. No one ships pmem
> so it's less pain for everyone if we just skip 25.

Ugh. Ok, then we should change pmem...

> 
> > (And yes, we need to be quicker with voting on/applying id
> > reservations :/)  
> 
> We can't vote on what was not proposed for a vote.
> At the moment that responsibility is with the commented
> once discussion on the comment has taken place.
> 
> I think what's missing is a description of the process
> in the README. Want to write it up and post it?

I can add that to my TODO list, can't promise speedy resolution, though.
