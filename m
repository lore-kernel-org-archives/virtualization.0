From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 04/16] virtio/console: verify device has config space
Date: Tue, 20 Jan 2015 16:10:40 +0530
Message-ID: <20150120104040.GJ31174@grmbl.mre>
References: <1421256142-11512-1-git-send-email-mst@redhat.com>
	<1421256142-11512-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421256142-11512-5-git-send-email-mst@redhat.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 14 Jan 2015 [19:27:35], Michael S. Tsirkin wrote:
> Some devices might not implement config space access
> (e.g. remoteproc used not to - before 3.9).
> virtio/console needs config space access so make it
> fail gracefully if not there.

Do we know any such devices?  Wondering what prompted this patch.  If
it's just theoretical, I'd rather let it be like this, and pull this
in when there's a device that doesn't have config space.

Also, just the console functionality (i.e. F_MULTIPORT is unset) is
available w/o config space access.  In fact, getting this patch in
would mean remoteproc wouldn't even run in its pre-config days...

> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index de03df9..26afb56 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1986,6 +1986,12 @@ static int virtcons_probe(struct virtio_device *vdev)
>  	bool multiport;
>  	bool early = early_put_chars != NULL;
>  
> +	if (!vdev->config->get) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +


		Amit
