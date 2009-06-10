From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 12/13] qemu: virtio save/load bindings
Date: Wed, 10 Jun 2009 13:11:02 +0300
Message-ID: <20090610101102.GI6844__4053.40991351313$1244628888$gmane$org@redhat.com>
References: <cover.1244192535.git.mst@redhat.com>
	<20090605102426.GM26770@redhat.com>
	<20090609174554.GD19375@poweredge.glommer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090609174554.GD19375@poweredge.glommer>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <glommer@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 09, 2009 at 02:45:54PM -0300, Glauber Costa wrote:
> duplicated save config.
> 
> > diff --git a/hw/virtio.h b/hw/virtio.h
> > index 04a3c3d..ce05517 100644
> > --- a/hw/virtio.h
> > +++ b/hw/virtio.h
> > @@ -72,6 +72,10 @@ typedef struct VirtQueueElement
> >  
> >  typedef struct {
> >      void (*notify)(void * opaque, uint16_t vector);
> > +    void (*save_config)(void * opaque, QEMUFile *f);
> > +    void (*save_queue)(void * opaque, int n, QEMUFile *f);
> > +    int (*load_config)(void * opaque, QEMUFile *f);
> > +    int (*load_queue)(void * opaque, int n, QEMUFile *f);
> >  } VirtIOBindings;
> >  
> So, what's the overall effect on a virtual machine that gets migrated,
> of a certain device not implementing one of those functions?

Those are implemented by a transport (e.g. virtio_pci) not the device.

> Will it work? Will it break?

It will work - assuming there's nothing transport-specific you need to
save and load. If there is - this patch is not breaking anything
that isn't already broken ...

-- 
MST
