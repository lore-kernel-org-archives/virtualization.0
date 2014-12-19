From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 6/6] virtio: core support for config generation
Date: Fri, 19 Dec 2014 13:31:53 +1030
Message-ID: <87mw6ks5pa.fsf@rustcorp.com.au>
References: <1418678575-31755-1-git-send-email-mst@redhat.com>
	<1418678575-31755-7-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418678575-31755-7-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> virtio 1.0 spec says:
>
> Drivers MUST NOT assume reads from fields greater than 32 bits wide are
> atomic, nor are reads from multiple fields: drivers SHOULD read device
> configuration space fields like so:
> 	u32 before, after;
> 	do {
> 		before = get_config_generation(device);
> 		// read config entry/entries.
> 		after = get_config_generation(device);
> 	} while (after != before);
>
> Do exactly this, for transports that support it.

>  static inline void virtio_cwrite8(struct virtio_device *vdev,
> @@ -352,6 +375,7 @@ static inline u64 virtio_cread64(struct virtio_device *vdev,
>  {
>  	u64 ret;
>  	vdev->config->get(vdev, offset, &ret, sizeof(ret));
> +	__virtio_cread_many(vdev, offset, &ret, 1, sizeof(ret));
>  	return virtio64_to_cpu(vdev, (__force __virtio64)ret);
>  }

The "vdev->config->get(vdev, offset, &ret, sizeof(ret));" should
be deleted.  Harmless if not, though.

Cheers,
Rusty.
