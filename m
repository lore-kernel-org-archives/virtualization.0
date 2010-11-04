From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 3/3] VIDEO: xen-fb,
	switch to for_each_console
Date: Thu, 04 Nov 2010 11:20:42 -0400
Message-ID: <4CD2CF4A.9080503@goop.org>
References: <1288798114-23206-1-git-send-email-jslaby@suse.cz>
	<1288798114-23206-3-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1288798114-23206-3-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-fbdev@vger.kernel.org, xen-devel@lists.xensource.com, jirislaby@gmail.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/03/2010 11:28 AM, Jiri Slaby wrote:
> Use newly added for_each_console for iterating consoles.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jeremy Fitzhardinge <jeremy@xensource.com>

Sure, if that's what all the kids are doing these days.

Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

    J

> Cc: Chris Wright <chrisw@sous-sol.org>
> Cc: virtualization@lists.osdl.org
> Cc: xen-devel@lists.xensource.com
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/xen-fbfront.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/xen-fbfront.c b/drivers/video/xen-fbfront.c
> index 428d273..4abb0b9 100644
> --- a/drivers/video/xen-fbfront.c
> +++ b/drivers/video/xen-fbfront.c
> @@ -492,7 +492,7 @@ xenfb_make_preferred_console(void)
>  		return;
>  
>  	acquire_console_sem();
> -	for (c = console_drivers; c; c = c->next) {
> +	for_each_console(c) {
>  		if (!strcmp(c->name, "tty") && c->index == 0)
>  			break;
>  	}
