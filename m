From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 15/20] virtio-net: no writeable mac for virtio-1
Date: Thu, 22 Jan 2015 17:31:17 +0100
Message-ID: <20150122173117.46f7ba32.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-16-git-send-email-cornelia.huck@de.ibm.com>
	<20150120111947.GM17631@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150120111947.GM17631@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 20 Jan 2015 11:19:47 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Thu, Dec 11, 2014 at 02:25:17PM +0100, Cornelia Huck wrote:
> > Devices operating as virtio 1.0 may not allow writes to the mac
> > address in config space.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/net/virtio-net.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index d6d1b98..ebbea60 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -87,6 +87,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
> >      memcpy(&netcfg, config, n->config_size);
> >  
> >      if (!virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
> 
> I don't see VIRTIO_NET_F_CTRL_MAC_ADDR (23) in the VIRTIO 1.0 "5.1.3.1
> Legacy Interface: Feature bits" section.  Should it be there just so
> people don't try to reuse bit 23 in the future?

But this isn't a legacy flag. Virtio-1 devices simply may not
manipulate the mac address directly even if this feature has not been
negotiated.

> 
> The patch itself:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
