From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 18/42] virtio_blk: make serial attribute static
Date: Wed, 26 Nov 2014 10:50:33 +0100
Message-ID: <20141126105033.6167484e.cornelia.huck@de.ibm.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-19-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1416933600-21398-19-git-send-email-mst@redhat.com>
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
Cc: rusty@au1.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Nov 2014 18:42:42 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> It's never declared so no need to make it extern.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index f601f16..055f3df 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -332,7 +332,8 @@ static ssize_t virtblk_serial_show(struct device *dev,
> 
>  	return err;
>  }
> -DEVICE_ATTR(serial, S_IRUGO, virtblk_serial_show, NULL);
> +
> +static DEVICE_ATTR(serial, S_IRUGO, virtblk_serial_show, NULL);
> 
>  static void virtblk_config_changed_work(struct work_struct *work)
>  {

The virtio-blk attributes might benefit from a conversion to attribute
groups (which support masking and so on), but that's a different
cleanup. So, fwiw:

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
