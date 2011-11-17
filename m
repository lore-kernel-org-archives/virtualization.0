From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 09/11] virtio: net: Add freeze, restore handlers to
	support S4
Date: Thu, 17 Nov 2011 17:57:06 +0530
Message-ID: <20111117122706.GA2873@amit-x200.redhat.com>
References: <cover.1321530505.git.amit.shah@redhat.com>
	<85eca44fe83d2deabfdf402bfed72531ebad6026.1321530505.git.amit.shah@redhat.com>
	<20111117121907.GA19682@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20111117121907.GA19682@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, levinsasha928@gmail.com, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 17 Nov 2011 [14:19:09], Michael S. Tsirkin wrote:
> On Thu, Nov 17, 2011 at 05:27:40PM +0530, Amit Shah wrote:

> > +#ifdef CONFIG_PM
> > +static int virtnet_freeze(struct virtio_device *vdev)
> > +{
> > +	struct virtnet_info *vi = vdev->priv;
> > +
> > +	netif_device_detach(vi->dev);
> > +	remove_vq_common(vi);
> 
> This stops TX in progress, if any, but not RX
> which might use the RX VQ. Then remove_vq_common
> might delete this VQ while it's still in use.
> 
> So I think we need to call something like napi_disable.
> However, the subtle twist is that we need to call that
> *after interrupts have been disabled*.
> Otherwise we might schedule another napi callback.

resetting the vqs will mean the host won't pass us any data in the
vqs.  Plus we're removing the vqs altogether.  Also, we're disabling
the pci device in virtio_pci.c, so all of these actions will take
care of that, isn't it?

In addition, once the vqs are taken off, there's no chance for any
other rx to happen, so napi_disable() after plugging off vqs doesn't
make sense.

		Amit
