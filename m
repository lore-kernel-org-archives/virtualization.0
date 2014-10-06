From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 03/15] virtio-pci: move freeze/restore to virtio core
Date: Mon, 6 Oct 2014 18:26:55 +0300
Message-ID: <20141006152655.GA32277@redhat.com>
References: <1412608214-31944-1-git-send-email-mst@redhat.com>
	<1412608214-31944-4-git-send-email-mst@redhat.com>
	<20141006172055.6fd0fa20.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141006172055.6fd0fa20.cornelia.huck@de.ibm.com>
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 06, 2014 at 05:20:55PM +0200, Cornelia Huck wrote:
> On Mon, 6 Oct 2014 18:10:51 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > This is in preparation to extending config changed event handling
> > in core.
> > Wrapping these in an API also seems to make for a cleaner code.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio.h      |  6 +++++
> >  drivers/virtio/virtio.c     | 53 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/virtio/virtio_pci.c | 55 ++-------------------------------------------
> >  3 files changed, 61 insertions(+), 53 deletions(-)
> > 
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 3c19bd3..8df7ba8 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -78,6 +78,7 @@ bool virtqueue_is_broken(struct virtqueue *vq);
> >  /**
> >   * virtio_device - representation of a device using virtio
> >   * @index: unique position on the virtio bus
> > + * @failed: saved value for CONFIG_S_FAILED bit (for restore)
> 
> Have you considered s/failed/saved_failed/ ?

I kind of prefer the shorter name, your reviewed tag made me think
you don't cosider this too important?

> >   * @dev: underlying device.
> >   * @id: the device type identification (used to match it with a driver).
> >   * @config: the configuration ops for this device.
> 
> Otherwise, my
> 
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> still stands.
