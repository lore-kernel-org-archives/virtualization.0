From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v4 03/16] virtio: support more feature bits
Date: Thu, 27 Nov 2014 16:40:29 +0100
Message-ID: <20141127164029.08953e4a.cornelia.huck@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417101409-29482-4-git-send-email-cornelia.huck@de.ibm.com>
	<20141127153419.GB26747@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141127153419.GB26747@redhat.com>
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

On Thu, 27 Nov 2014 17:34:19 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Nov 27, 2014 at 04:16:36PM +0100, Cornelia Huck wrote:
> > With virtio-1, we support more than 32 feature bits. Let's make
> > vdev->guest_features depend on the number of supported feature bits,
> > allowing us to grow the feature bits automatically.

^ This was one reason why I did it this way...

> > 
> > We also need to enhance the internal functions dealing with getting
> > and setting features with an additional index field, so that all feature
> > bits may be accessed (in chunks of 32 bits).
> > 
> > vhost and migration have been ignored for now.
> > 
> > Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > @@ -117,7 +125,7 @@ struct VirtIODevice
> >      uint8_t status;
> >      uint8_t isr;
> >      uint16_t queue_sel;
> > -    uint32_t guest_features;
> > +    uint32_t guest_features[NR_VIRTIO_FEATURE_WORDS];
> >      size_t config_len;
> >      void *config;
> >      uint16_t config_vector;
> 
> Ugh.
> 
> That's quite tricky to use correctly.
> Why don't we just make it uint64_t?

...and another one was that at least virtio-ccw reads/writes in chunks
of 32 bits anyway.
> 
> The only real issue is that DEFINE_PROP_BIT wants
> a uint32_t.
> 
> But that's easy to fix: add DEFINE_PROP64_BIT
> that is the same but handles a 64 bit array.
> 
Sure, this would not really be a problem to add. But we'll stand before
the same problem again when we want to grow past 64 bits, won't we?
