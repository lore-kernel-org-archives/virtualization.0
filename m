From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/8] Staging: hv: vmbus: Fix checkpatch warnings
Date: Tue, 23 Aug 2011 16:16:57 -0700
Message-ID: <20110823231657.GC9955@kroah.com>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
	<1311101065-23417-1-git-send-email-kys@microsoft.com>
	<1311101065-23417-4-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1311101065-23417-4-git-send-email-kys@microsoft.com>
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

On Tue, Jul 19, 2011 at 11:44:21AM -0700, K. Y. Srinivasan wrote:
> Fix  checkpatch warnings in hv.c
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/hv.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
> index e733173..14e6315 100644
> --- a/drivers/staging/hv/hv.c
> +++ b/drivers/staging/hv/hv.c
> @@ -111,7 +111,7 @@ static u64 do_hypercall(u64 control, void *input, void *output)
>  	u64 hv_status = 0;
>  	u64 input_address = (input) ? virt_to_phys(input) : 0;
>  	u64 output_address = (output) ? virt_to_phys(output) : 0;
> -	volatile void *hypercall_page = hv_context.hypercall_page;
> +	void *hypercall_page = hv_context.hypercall_page;

Are you sure?  This was just someone being foolish?  No other reason
someone tried to use volatile here?

greg k-h
