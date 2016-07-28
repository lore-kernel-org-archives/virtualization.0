From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4] virtio: new feature to detect IOMMU device quirk
Date: Fri, 29 Jul 2016 00:28:23 +0300
Message-ID: <20160729001244-mutt-send-email-mst@kernel.org>
References: <1469659378-15957-1-git-send-email-mst@redhat.com>
	<20160728065918.GA22392@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160728065918.GA22392@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 27, 2016 at 11:59:18PM -0700, Christoph Hellwig wrote:
> Again, this is still the wrong way around.  A "noiommu" feature is a
> quirk and should not be the default.

Christoph, I'm not sure what you mean by the default here.

We read a register from the device (bit 33 in the feature qword)
and act on it.

The specific register value is 0 on noiommu quirky devices
(it happened to be that way in the past),
and 1 on clean iommu devices.

 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+       if (virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
+               return true;
+
+       /* Otherwise, we are left to guess. */

As a hypothesis, do you object to use of virtio_has_feature?

Yes this might be confusing but in fact that
is just testing a cached register bit: at init time we read it:

        device_features = dev->config->get_features(dev);

        ....
        vdev->features = device_features

and later

            return vdev->features & BIT_ULL(fbit);

I'll add a comment clarifying that in the next version.

-- 
MST
