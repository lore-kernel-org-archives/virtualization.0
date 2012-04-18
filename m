From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_console: link vq to port with a private
	pointer in struct virtqueue
Date: Wed, 18 Apr 2012 21:48:38 +0300
Message-ID: <20120418184836.GB14635@redhat.com>
References: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
	<20120418142146.GB11801@redhat.com> <4F8ED0E4.6000702@redhat.com>
	<20120418161028.GB12815@redhat.com> <4F8F0A08.8010900@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4F8F0A08.8010900@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 18, 2012 at 08:38:00PM +0200, Paolo Bonzini wrote:
> >>>>   * @priv: a pointer for the virtqueue implementation to use.
> >>>>   */
> >>>>  struct virtqueue {
> >>>> @@ -21,6 +22,7 @@ struct virtqueue {
> >>>>  	void (*callback)(struct virtqueue *vq);
> >>>>  	const char *name;
> >>>>  	struct virtio_device *vdev;
> >>>> +	void *vdev_priv;
> >>>>  	void *priv;
> >>>
> >>> The name is confusing: it seems to imply it's a device pointer.
> >>
> >> ... it's private to the driver that owns vdev, hence the name.
> > 
> > I own a car but I'm not called Michael Car :)
> > driver_priv might be ok too. unfortunately virtio-pci
> > is also a driver so it can be misunderstood.
> 
> Yes.  Is fixing the comment and keeping the vdev_priv name ok with you?

This puts it lower on the scale of bad interfaces but
I think we still need a better name.

> > devices should dominate. ring is an implementation detail.
> 
> Ring came first, ring gets the nice name. :)
> 
> Paolo
