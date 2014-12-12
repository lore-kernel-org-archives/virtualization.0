From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 04/20] virtio: add feature checking helpers
Date: Fri, 12 Dec 2014 09:37:36 +0100
Message-ID: <20141212093736.3200c2dd.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-5-git-send-email-cornelia.huck@de.ibm.com>
	<20141211154623.4a73fef9@oc7435384737.ibm.com>
	<20141211170526.GA14001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141211170526.GA14001@redhat.com>
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
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 11 Dec 2014 19:05:26 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Dec 11, 2014 at 03:46:23PM +0100, Thomas Huth wrote:
> > On Thu, 11 Dec 2014 14:25:06 +0100
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > 
> > > Add a helper function for checking whether a bit is set in the guest
> > > features for a vdev as well as one that works on a feature bit set.
> > > 
> > > Convert code that open-coded this: It cleans up the code and makes it
> > > easier to extend the guest feature bits.
> > > 
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ...
> > > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > > index ef48550..56c92fb 100644
> > > --- a/hw/scsi/virtio-scsi.c
> > > +++ b/hw/scsi/virtio-scsi.c
> > > @@ -144,7 +144,7 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
> > >       *
> > >       * TODO: always disable this workaround for virtio 1.0 devices.
> > >       */
> > > -    if ((vdev->guest_features & VIRTIO_F_ANY_LAYOUT) == 0) {
> > > +    if (!virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT)) {
> > 
> > Wait ... this does not only look like a clean-up, but also like a
> > bug-fix to me, since it should have been "(1 << VIRTIO_F_ANY_LAYOUT)"
> > instead of "VIRTIO_F_ANY_LAYOUT" in the original code instead?

I've clearly been looking at this stuff for too long, as I didn't even
notice this bug :)

> > 
> > So in case this patch queue takes a little bit longer 'til it gets
> > upstream, do we might want to submit a separate patch for fixing this
> > issue first?
> 
> Yes, please do.

OK, will send.
