From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 5/7] Xen: fix whitespaces, tabs coding style issue in
	drivers/xen/xenbus/xenbus_client.c
Date: Tue, 26 Jul 2011 09:17:48 -0700
Message-ID: <4E2EE8AC.1090703__760.127817238931$1311697198$gmane$org@goop.org>
References: <1311679009-16659-1-git-send-email-ruslan@rpisarev.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1311679009-16659-1-git-send-email-ruslan@rpisarev.org.ua>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ruslanpisarev@gmail.com
Cc: Ruslan Pisarev <ruslan@rpisarev.org.ua>, jeremy.fitzhardinge@citrix.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 07/26/2011 04:16 AM, ruslanpisarev@gmail.com wrote:
> From: Ruslan Pisarev <ruslan@rpisarev.org.ua>
>
> This is a patch to the xenbus_client.c file that fixed up whitespaces, tabs errors found by the checkpatch.pl tools.
>
> Signed-off-by: Ruslan Pisarev <ruslan@rpisarev.org.ua>
> ---
>  drivers/xen/xenbus/xenbus_client.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
> index cdacf92..ff4f03c 100644
> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -43,15 +43,15 @@
>  const char *xenbus_strstate(enum xenbus_state state)
>  {
>  	static const char *const name[] = {
> -		[ XenbusStateUnknown      ] = "Unknown",
> -		[ XenbusStateInitialising ] = "Initialising",
> -		[ XenbusStateInitWait     ] = "InitWait",
> -		[ XenbusStateInitialised  ] = "Initialised",
> -		[ XenbusStateConnected    ] = "Connected",
> -		[ XenbusStateClosing      ] = "Closing",
> -		[ XenbusStateClosed	  ] = "Closed",
> -		[XenbusStateReconfiguring] = "Reconfiguring",
> -		[XenbusStateReconfigured] = "Reconfigured",
> +		[XenbusStateUnknown] =		"Unknown",
> +		[XenbusStateInitialising] =	"Initialising",
> +		[XenbusStateInitWait] =		"InitWait",
> +		[XenbusStateInitialised] =	"Initialised",
> +		[XenbusStateConnected] =	"Connected",
> +		[XenbusStateClosing] =		"Closing",
> +		[XenbusStateClosed] =		"Closed",
> +		[XenbusStateReconfiguring] =	"Reconfiguring",
> +		[XenbusStateReconfigured] =	"Reconfigured",
>  	};

Eh, I think this looks worse now.

    J
