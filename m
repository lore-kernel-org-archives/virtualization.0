From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 16/20] virtio-net: support longer header
Date: Wed, 21 Jan 2015 17:06:17 +0100
Message-ID: <20150121170617.021f2285.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-17-git-send-email-cornelia.huck@de.ibm.com>
	<20150120131814.GN17631@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150120131814.GN17631@stefanha-thinkpad.redhat.com>
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

On Tue, 20 Jan 2015 13:18:14 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Thu, Dec 11, 2014 at 02:25:18PM +0100, Cornelia Huck wrote:
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index ebbea60..7ee2bd6 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -373,15 +373,21 @@ static int peer_has_ufo(VirtIONet *n)
> >      return n->has_ufo;
> >  }
> >  
> > -static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs)
> > +static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
> > +                                       int version_1)
> 
> Please use bool, it makes it 100% clear what the meaning of "version_1"
> is.
> 
> s/int/bool/

OK, will change.
