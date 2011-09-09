From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 09/25] Staging: hv: util: Perform some service specific
	de-initialization in util_remove()
Date: Fri, 9 Sep 2011 13:42:40 -0700
Message-ID: <20110909204240.GF19127@kroah.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-9-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1315491876-9554-9-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 08, 2011 at 07:24:20AM -0700, K. Y. Srinivasan wrote:
> In preparation for modifying the util driver to fully conform to the
> Linux Driver Model, perform some service specific de-initialization in
> util_remove() as opposed to in exit_hyperv_utils() as is currently done.
> 
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/hv_util.c |   29 ++++++++++++++++++++++++-----
>  1 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
> index b86128a..2475ab2 100644
> --- a/drivers/staging/hv/hv_util.c
> +++ b/drivers/staging/hv/hv_util.c
> @@ -291,6 +291,30 @@ error:
>  static int util_remove(struct hv_device *dev,
>  			const struct hv_vmbus_device_id *dev_id)
>  {
> +	int service = dev_id->driver_data;
> +
> +	switch (service) {
> +	case HV_SHUTDOWN:
> +		kfree(shut_txf_buf);
> +		break;

This switch and "static" pointers you need to free aren't needed at all
if you do this code logic correctly (i.e. a per-device buffer.)

{sigh}

I'm stopping reviewing now, this is making me grumpy, someone owes me a
bunch of beer...

greg k-h
