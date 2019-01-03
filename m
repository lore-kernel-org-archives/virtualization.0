From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio: document virtio_config_ops restrictions
Date: Thu, 3 Jan 2019 11:28:28 -0500
Message-ID: <20190103112627-mutt-send-email-mst__34541.1863680512$1546532829$gmane$org@kernel.org>
References: <20190103160804.21438-1-cohuck@redhat.com>
	<20190103160804.21438-3-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190103160804.21438-3-cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 03, 2019 at 05:08:04PM +0100, Cornelia Huck wrote:
> Some transports (e.g. virtio-ccw) implement virtio operations that
> seem to be a simple read/write as something more involved that
> cannot be done from an atomic context.
> 
> Give at least a hint about that.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/linux/virtio_config.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 7087ef946ba7..987b6491b946 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -12,6 +12,11 @@ struct irq_affinity;
>  
>  /**
>   * virtio_config_ops - operations for configuring a virtio device
> + * Note: Do not assume that a transport implements all of the operations
> + *       getting/setting a value as a simple read/write! Generally speaking,
> + *       any of @get/@set, @get_status/@set_status, or @get_features/
> + *       @finalize_features are NOT safe to be called from an atomic
> + *       context.
>   * @get: read the value of a configuration field
>   *	vdev: the virtio_device
>   *	offset: the offset of the configuration field

Then might_sleep in virtio_cread/virtio_cwrite and
friends would be appropriate? I guess we'll need to fix
balloon first.

> -- 
> 2.17.2
