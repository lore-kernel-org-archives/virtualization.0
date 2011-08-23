From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 086/117] Staging: hv: storvsc: Leverage the spinlock to
	manage ref_cnt
Date: Tue, 23 Aug 2011 16:10:28 -0700
Message-ID: <20110823231028.GO9641@kroah.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-86-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1310752065-27895-86-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: devel@linuxdriverproject.org, Haiyang Zhang <haiyangz@microsoft.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 15, 2011 at 10:47:14AM -0700, K. Y. Srinivasan wrote:
> Now that we have a spin lock protecting access to the stor device pointer,
> use it manage the reference count as well.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/hyperv_storage.h |    8 ++++----
>  drivers/staging/hv/storvsc.c        |   10 +++++-----
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/hv/hyperv_storage.h b/drivers/staging/hv/hyperv_storage.h
> index 53b65be..d946211 100644
> --- a/drivers/staging/hv/hyperv_storage.h
> +++ b/drivers/staging/hv/hyperv_storage.h
> @@ -265,7 +265,7 @@ struct storvsc_device {
>  	struct hv_device *device;
>  
>  	/* 0 indicates the device is being destroyed */
> -	atomic_t ref_count;
> +	int	 ref_count;

Is this really needed?  Can't you rely on the reference count of the
hv_device itself?

greg k-h
