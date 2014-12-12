From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v6 12/20] virtio: disallow late feature changes for
	virtio-1
Date: Fri, 12 Dec 2014 12:25:47 +0100
Message-ID: <20141212122547.511baafd@oc7435384737.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-13-git-send-email-cornelia.huck@de.ibm.com>
	<20141212115538.2aa96fd2@oc7435384737.ibm.com>
	<20141212121825.6c09af4d.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141212121825.6c09af4d.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 12 Dec 2014 12:18:25 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Fri, 12 Dec 2014 11:55:38 +0100
> Thomas Huth <thuth@linux.vnet.ibm.com> wrote:
> 
> > On Thu, 11 Dec 2014 14:25:14 +0100
> > Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > 
> > > For virtio-1 devices, the driver must not attempt to set feature bits
> > > after it set FEATURES_OK in the device status. Simply reject it in
> > > that case.
> > > 
> > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > ---
> > >  hw/virtio/virtio.c         |   16 ++++++++++++++--
> > >  include/hw/virtio/virtio.h |    2 ++
> > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > index 57190ba..a3dd67b 100644
> > > --- a/hw/virtio/virtio.c
> > > +++ b/hw/virtio/virtio.c
> > > @@ -978,7 +978,7 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
> > >      vmstate_save_state(f, &vmstate_virtio, vdev);
> > >  }
> > > 
> > > -int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > > +static int __virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > 
> > Maybe avoid the double underscores here? But unfortunately, I also fail
> > to come up with a better suggestion for a name here ...
> 
> virtio_set_features_nocheck()?

Sounds ok to me.

> This function is only called within virtio.c anyway...

Right, so the double underscores should be ok here, too. (I still do
not like them very much, but that's just my personal taste in this case)

> > >  {
> > >      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> > >      VirtioBusClass *vbusk = VIRTIO_BUS_GET_CLASS(qbus);
> > > @@ -994,6 +994,18 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > >      return bad ? -1 : 0;
> > >  }
> > > 
> > > +int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> > > +{
> > > +   /*
> > > +     * The driver must not attempt to set features after feature negotiation
> > > +     * has finished.
> > > +     */
> > > +    if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
> > > +        return -EINVAL;
> > > +    }
> > 
> > Hmm, according to your patch description, the FEATURES_OK check only
> > applies to virtio-1.0 devices ... so shouldn't there be a check for
> > virtio-1 here? Or did I miss something?
> 
> A device in legacy mode will never have FEATURES_OK set. But it is a
> bit non-obvious - maybe adding a check for VERSION_1 does not hurt.

Ah, ok, right, and if it is a legacy device and has FEATURES_OK set, it
is certainly a misbehavior wrt the legacy protocol. So it really should
be ok or even good to _not_ check for virtio-1.0 here. So sorry for the
confusion, I think now the patch is good as it is:

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
