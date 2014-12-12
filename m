From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 04/20] virtio: add feature checking helpers
Date: Fri, 12 Dec 2014 11:07:01 +0100
Message-ID: <20141212110701.0c6d879b.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-5-git-send-email-cornelia.huck@de.ibm.com>
	<20141211154623.4a73fef9@oc7435384737.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141211154623.4a73fef9@oc7435384737.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@linux.vnet.ibm.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 11 Dec 2014 15:46:23 +0100
Thomas Huth <thuth@linux.vnet.ibm.com> wrote:


> > +static inline bool __virtio_has_feature(uint32_t features, unsigned int fbit)
> > +{
> > +    assert(fbit < 32);
> > +    return !!(features & (1 << fbit));
> > +}
> > +
> > +static inline bool virtio_has_feature(VirtIODevice *vdev, unsigned int fbit)
> > +{
> > +    return __virtio_has_feature(vdev->guest_features, fbit);
> > +}
> > +
> 
> I've got to say that I'm a little bit unhappy with the naming of the
> functions - and in contrast to the Linux kernel code, I think it is
> also quite uncommon in the QEMU sources to use function names with
> double underscores at the beginning.
> 
> Could you maybe rename the second function to "virtio_vdev_has_feature"
> instead? And then remove the double underscores from the first function?

Renamed the functions just like this.
