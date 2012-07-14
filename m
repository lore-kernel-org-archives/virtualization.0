From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH 12/15] Tools: hv: Gather DHCP information
Date: Sat, 14 Jul 2012 23:36:30 +0200
Message-ID: <CAFLxGvxkidfN+o8yFsmGm8-YhT4Q5dgzQOAJJXnM=nXoXVpqTA@mail.gmail.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
	<1342298060-12662-1-git-send-email-kys@microsoft.com>
	<1342298060-12662-12-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342298060-12662-12-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 14, 2012 at 10:34 PM, K. Y. Srinivasan <kys@microsoft.com> wrote:
> Collect information on dhcp setting for the specified interface.
> We invoke an exyernal script to get this information.
>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  tools/hv/hv_kvp_daemon.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index a81ce67..c510283 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -524,6 +524,9 @@ static void kvp_get_ipconfig_info(char *if_name,
>                                  struct hv_kvp_ipaddr_value *buffer)
>  {
>         char cmd[512];
> +       char dhcp_info[128];
> +       char *p;
> +       FILE *file;
>
>         /*
>          * Get the address of default gateway (ipv4).
> @@ -580,6 +583,36 @@ static void kvp_get_ipconfig_info(char *if_name,
>          */
>         kvp_process_ipconfig_file(cmd, (char *)buffer->dns_addr,
>                                 (MAX_IP_ADDR_SIZE * 2), INET_ADDRSTRLEN, 0);
> +
> +       /*
> +        * Gather the DHCP state.
> +        * We will gather this state by invoking an external script.
> +        * The parameter to the script is the interface name.
> +        * Here is the expected output:
> +        *
> +        * Enabled: DHCP enabled.
> +        */
> +
> +       memset(cmd, 0, 512);

Why not sizeof(cmd)?

> +       strcat(cmd, "/sbin/hv_get_dhcp_info ");
> +       strcat(cmd, if_name);

What about strncat()?

-- 
Thanks,
//richard
