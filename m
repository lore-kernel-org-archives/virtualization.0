From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 5/7] virtio: use u32, not bitmap for struct
	virtio_device's features
Date: Fri, 5 Apr 2013 09:36:04 +0300
Message-ID: <CAK=WgbbK-sPaEobcPwfeNB-bh-Gxq2Uj6Z+fcU1xrQbFgZEHRA@mail.gmail.com>
References: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
	<1365133025-5397-6-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365133025-5397-6-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 5, 2013 at 6:37 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index afed9b7..fb8faee 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -219,7 +219,7 @@ static void rproc_virtio_finalize_features(struct virtio_device *vdev)
>          * fixed as part of a small resource table overhaul and then an
>          * extension of the virtio resource entries.
>          */
> -       rvdev->gfeatures = vdev->features[0];
> +       rvdev->gfeatures = vdev->features;
>  }

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks!
