From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 1/1] Staging: hv: Add the necessary dependencies to
	hyperv	Kconfig
Date: Wed, 4 May 2011 13:44:27 -0500
Message-ID: <0D753D10438DA54287A00B027084269764D295CE91__45709.7668703229$1304621702$gmane$org@AUSP01VMBX24.collaborationhost.net>
References: <1304535105-26892-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1304535105-26892-1-git-send-email-kys@microsoft.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "K. Y. Srinivasan" <kys@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday, May 04, 2011 11:52 AM, K. Y. Srinivasan wrote:
>
> The vmbus driver dependes on ACPI and PCI subsystems. Change 
> Kconfig to reflect this.
>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/staging/hv/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/staging/hv/Kconfig b/drivers/staging/hv/Kconfig
> index 76f0756..5e0c9f6 100644
> --- a/drivers/staging/hv/Kconfig
> +++ b/drivers/staging/hv/Kconfig
> @@ -1,6 +1,6 @@
>  config HYPERV
>  	tristate "Microsoft Hyper-V client drivers"
> -	depends on X86 && m
> +	depends on X86 && ACPI && PCI && m
>  	default n
>  	help
> 	  Select this option to run Linux as a Hyper-V client operating

ACPI itself depends on PCI.  It also depends on IA64 || X86.  Will the
vmbus driver work with IA64?  If so the depends on could just be:

	depends on ACPI && m

Also, default n is redudant since n is the default anyway.

Regards,
Hartley
