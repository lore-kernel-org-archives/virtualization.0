From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/8] Staging: hv: vmbus: Fix a checkpatch warning in
	ring_buffer.c
Date: Tue, 23 Aug 2011 16:14:45 -0700
Message-ID: <20110823231445.GB9955@kroah.com>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
	<1311101065-23417-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1311101065-23417-1-git-send-email-kys@microsoft.com>
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

On Tue, Jul 19, 2011 at 11:44:18AM -0700, K. Y. Srinivasan wrote:
> Fix a checkpatch warning in ring_buffer.c (line over 80 characters).
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/ring_buffer.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
> index 9212699..e41d206 100644
> --- a/drivers/staging/hv/ring_buffer.c
> +++ b/drivers/staging/hv/ring_buffer.c
> @@ -34,7 +34,8 @@
>  
>  
>  /* Amount of space to write to */
> -#define BYTES_AVAIL_TO_WRITE(r, w, z) ((w) >= (r)) ? ((z) - ((w) - (r))) : ((r) - (w))
> +#define BYTES_AVAIL_TO_WRITE(r, w, z) \
> +(((w) >= (r)) ? ((z) - ((w) - (r))) : ((r) - (w)))

Please at least indent the second line a little bit, otherwise it's a
pain to read, right?

greg k-h
