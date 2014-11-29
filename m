From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 01/46] virtio: add low-level APIs for feature bits
Date: Sat, 29 Nov 2014 19:30:31 +0200
Message-ID: <20141129173031.GE22746@redhat.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
	<1417118789-18231-2-git-send-email-mst@redhat.com>
	<20141128110220.741c11af.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141128110220.741c11af.cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 28, 2014 at 11:02:20AM +0100, Cornelia Huck wrote:
> On Thu, 27 Nov 2014 22:07:36 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Add low level APIs to test/set/clear feature bits.
> > For use by transports, to make it easier to
> > write code independent of feature bit array format.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/virtio_config.h | 53 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 50 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 7f4ef66..249fcd6 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -77,11 +77,47 @@ void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
> >  					 unsigned int fbit);
> > 
> >  /**
> > - * virtio_has_feature - helper to determine if this device has this feature.
> > + * __virtio_test_bit - helper to test feature bits. For use by transports.
> > + *                     Devices should normally use virtio_has_feature,
> > + *                     which includes more checks.
> >   * @vdev: the device
> >   * @fbit: the feature bit
> >   */
> > -static inline bool virtio_has_feature(const struct virtio_device *vdev,
> > +static inline bool __virtio_test_bit(const struct virtio_device *vdev,
> > +				     unsigned int fbit)
> > +{
> > +	/* Did you forget to fix assumptions on max features? */
> > +	if (__builtin_constant_p(fbit))
> > +		BUILD_BUG_ON(fbit >= 32);
> > +	else
> > +		BUG_ON(fbit >= 32);
> 
> Does this want to be a helper? Might be overkill, but I'm always wary
> of changes that need to be applied manually in many different places :)

I'm not sure.  It's just an assert, if it's not obvious
what it checks then it doesn't serve a useful purpose.

> > +
> > +	return test_bit(fbit, vdev->features);
> > +}
> > +
> > +/**
> > + * __virtio_set_bit - helper to set feature bits. For use by transports.
> > + * @vdev: the device
> > + * @fbit: the feature bit
> > + */
> > +static inline void __virtio_set_bit(struct virtio_device *vdev,
> > +				    unsigned int fbit)
> > +{
> > +	/* Did you forget to fix assumptions on max features? */
> > +	if (__builtin_constant_p(fbit))
> > +		BUILD_BUG_ON(fbit >= 32);
> > +	else
> > +		BUG_ON(fbit >= 32);
> > +
> > +	set_bit(fbit, vdev->features);
> > +}
> > +
> > +/**
> > + * __virtio_clear_bit - helper to set feature bits. For use by transports.
> 
> s/set/clear/

Good catch, thanks.

> > + * @vdev: the device
> > + * @fbit: the feature bit
> > + */
> > +static inline void __virtio_clear_bit(struct virtio_device *vdev,
> >  				      unsigned int fbit)
> >  {
> >  	/* Did you forget to fix assumptions on max features? */
> > @@ -90,10 +126,21 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
> >  	else
> >  		BUG_ON(fbit >= 32);
> > 
> > +	clear_bit(fbit, vdev->features);
> > +}
> > +
> > +/**
> > + * virtio_has_feature - helper to determine if this device has this feature.
> > + * @vdev: the device
> > + * @fbit: the feature bit
> > + */
> > +static inline bool virtio_has_feature(const struct virtio_device *vdev,
> > +				      unsigned int fbit)
> > +{
> >  	if (fbit < VIRTIO_TRANSPORT_F_START)
> >  		virtio_check_driver_offered_feature(vdev, fbit);
> > 
> > -	return test_bit(fbit, vdev->features);
> > +	return __virtio_test_bit(vdev, fbit);
> >  }
> > 
> >  static inline
