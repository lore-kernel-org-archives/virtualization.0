From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 02/42] virtio: add support for 64 bit features.
Date: Wed, 26 Nov 2014 18:56:53 +0200
Message-ID: <20141126165653.GB11202@redhat.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-3-git-send-email-mst@redhat.com>
	<20141126174809.24f6be4d@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141126174809.24f6be4d@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, linux-s390@vger.kernel.org, lguest@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, rusty@au1.ibm.com, Brian Swetland <swetland@google.com>, linux390@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Siva Yerramreddy <yshivakrishna@gmail.com>, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, pbonzini@redhat.com, Amit Shah <amit.shah@redhat.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 26, 2014 at 05:48:09PM +0100, Greg Kurz wrote:
> On Tue, 25 Nov 2014 18:41:22 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > From: Rusty Russell <rusty@rustcorp.com.au>
> > 
> > Change the u32 to a u64, and make sure to use 1ULL everywhere!
> > 
> > Cc: Brian Swetland <swetland@google.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > [Thomas Huth: fix up virtio-ccw get_features]
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Acked-by: Pawel Moll <pawel.moll@arm.com>
> > Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

...

> > @@ -86,14 +86,14 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
> >  {
> >  	/* Did you forget to fix assumptions on max features? */
> >  	if (__builtin_constant_p(fbit))
> > -		BUILD_BUG_ON(fbit >= 32);
> > +		BUILD_BUG_ON(fbit >= 64);
> 
> 
> While you're here, maybe you could derive the max value from the .features field ?
> 
> -               BUILD_BUG_ON(fbit >= 64);
> +               BUILD_BUG_ON(fbit >= (sizeof(vdev->features) << 3));

I don't see how that will help.
All that 1ULL math only works up to 64 bit.
So this only makes it look like we support any size,
but doesn't really.

No?
