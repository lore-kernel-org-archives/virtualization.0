From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 03/10] staging: hv: Convert camel cased struct fields
	in hv.h to lower cases
Date: Mon, 1 Nov 2010 10:43:10 -0700
Message-ID: <20101101174310.GA12632@suse.de>
References: <1288630429-12330-1-git-send-email-haiyangz@linuxonhyperv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1288630429-12330-1-git-send-email-haiyangz@linuxonhyperv.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Cc: devel@linuxdriverproject.org, haiyangz@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 01, 2010 at 09:53:45AM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Convert camel cased struct fields in hv.h to lower cases
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

Why did I get two different copies of some of these patches?  Are they
different?

>  /* The one and only */
> -struct hv_context gHvContext = {
> -	.SynICInitialized	= false,
> -	.HypercallPage		= NULL,
> -	.SignalEventParam	= NULL,
> -	.SignalEventBuffer	= NULL,
> +struct hv_context g_hv_context = {

What is the "g_" for?  Why are you keeping the unneeded, and unwanted
hungarian notation around?  Please don't do that.

thanks,

greg k-h
