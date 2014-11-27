From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v4 03/16] virtio: support more feature bits
Date: Thu, 27 Nov 2014 17:34:19 +0200
Message-ID: <20141127153419.GB26747@redhat.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417101409-29482-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417101409-29482-4-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 27, 2014 at 04:16:36PM +0100, Cornelia Huck wrote:
> With virtio-1, we support more than 32 feature bits. Let's make
> vdev->guest_features depend on the number of supported feature bits,
> allowing us to grow the feature bits automatically.
> 
> We also need to enhance the internal functions dealing with getting
> and setting features with an additional index field, so that all feature
> bits may be accessed (in chunks of 32 bits).
> 
> vhost and migration have been ignored for now.
> 
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> @@ -117,7 +125,7 @@ struct VirtIODevice
>      uint8_t status;
>      uint8_t isr;
>      uint16_t queue_sel;
> -    uint32_t guest_features;
> +    uint32_t guest_features[NR_VIRTIO_FEATURE_WORDS];
>      size_t config_len;
>      void *config;
>      uint16_t config_vector;

Ugh.

That's quite tricky to use correctly.
Why don't we just make it uint64_t?

The only real issue is that DEFINE_PROP_BIT wants
a uint32_t.

But that's easy to fix: add DEFINE_PROP64_BIT
that is the same but handles a 64 bit array.

-- 
MST
