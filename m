From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/4] virtio_blk: Rename a jump label in virtblk_get_id()
Date: Mon, 10 Oct 2016 02:30:24 +0300
Message-ID: <20161010022831-mutt-send-email-mst@kernel.org>
References: <566ABCD9.1060404@users.sourceforge.net>
	<02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
	<a303f7a6-c675-5228-99bd-a03c9e9252e9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a303f7a6-c675-5228-99bd-a03c9e9252e9@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 13, 2016 at 02:15:20PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Sep 2016 13:50:56 +0200
> 
> Adjust a jump label according to the current Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Please don't send me such patches, I'm not really
interested in renaming labels unless it clearly adds
to a significant improvement in readability.

> ---
>  drivers/block/virtio_blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 696f452..fef2bd0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -247,10 +247,10 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  
>  	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
>  	if (err)
> -		goto out;
> +		goto put_request;
>  
>  	err = blk_execute_rq(vblk->disk->queue, vblk->disk, req, false);
> -out:
> + put_request:
>  	blk_put_request(req);
>  	return err;
>  }
> -- 
> 2.10.0
