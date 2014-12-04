From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v5 10/19] s390x/virtio-ccw: add virtio set-revision
	call
Date: Thu, 4 Dec 2014 17:43:52 +0100
Message-ID: <20141204174352.4c8bfc65.cornelia.huck@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417525227-14051-11-git-send-email-cornelia.huck@de.ibm.com>
	<20141204162005.GA23214@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141204162005.GA23214@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 4 Dec 2014 18:20:05 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Dec 02, 2014 at 02:00:18PM +0100, Cornelia Huck wrote:
> > From: Thomas Huth <thuth@linux.vnet.ibm.com>
> > 
> > Handle the virtio-ccw revision according to what the guest sets.
> > When revision 1 is selected, we have a virtio-1 standard device
> > with byteswapping for the virtio rings.
> > 
> > When a channel gets disabled, we have to revert to the legacy behavior
> > in case the next user of the device does not negotiate the revision 1
> > anymore (e.g. the boot firmware uses revision 1, but the operating
> > system only uses the legacy mode).
> > 
> > Note that revisions > 0 are still disabled.
> > 
> > Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/s390x/virtio-ccw.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/s390x/virtio-ccw.h |    5 +++++
> >  2 files changed, 57 insertions(+)

> > @@ -747,6 +797,8 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
> >      sch->id.cu_type = VIRTIO_CCW_CU_TYPE;
> >      sch->id.cu_model = vdev->device_id;
> >  
> > +    dev->revision = -1;
> > +
> >      /* Set default feature bits that are offered by the host. */
> >      dev->host_features = 0;
> >      virtio_add_feature(&dev->host_features, VIRTIO_F_NOTIFY_ON_EMPTY);
> 
> You should also clear it on device reset.

Nope, revision survives reset and can only be cleared by disabling and
reenabling the device.
