From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [PATCH] XEN: xenbus: integer overflow in process_msg()
Date: Wed, 4 Jan 2012 09:24:54 +0000
Message-ID: <1325669095.25206.176.camel@zakaz.uk.xensource.com>
References: <1325619731-13936-1-git-send-email-haogangchen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1325619731-13936-1-git-send-email-haogangchen@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Haogang Chen <haogangchen@gmail.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2012-01-03 at 19:42 +0000, Haogang Chen wrote:
> There is a potential integer overflow in process_msg() that could result
> in cross-domain attack.
> 
> 	body = kmalloc(msg->hdr.len + 1, GFP_NOIO | __GFP_HIGH);
> 
> When a malicious guest passes 0xffffffff in msg->hdr.len, the subsequent
> call to xb_read() would write to a zero-length buffer.

The other end of this connection is always the xenstore backend daemon
so there is no guest (malicious or otherwise) which can do this. The
xenstore daemon is a trusted component in the system.

However this seem like a reasonable robustness improvement so we should
have it.

> This causes
> kernel oops in the receiving guest and hangs its xenbus kernel thread.
> The patch returns -EINVAL in that case.
> 
> Signed-off-by: Haogang Chen <haogangchen@gmail.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> ---
>  drivers/xen/xenbus/xenbus_xs.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index ede860f..e32aefb 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -801,6 +801,12 @@ static int process_msg(void)
>  		goto out;
>  	}
>  
> +	if (msg->hdr.len == UINT_MAX) {
> +		kfree(msg);
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	body = kmalloc(msg->hdr.len + 1, GFP_NOIO | __GFP_HIGH);
>  	if (body == NULL) {
>  		kfree(msg);
