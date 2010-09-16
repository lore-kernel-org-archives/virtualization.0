From: Amit Shah <amit.shah@redhat.com>
Subject: Re: PATCH: virtio_console: Fix poll blocking even though there is
	data to read (version 2)
Date: Thu, 16 Sep 2010 10:46:26 +0530
Message-ID: <20100916051626.GA2429__9349.0952662707$1284614329$gmane$org@amit-laptop.redhat.com>
References: <4C90E3BF.4000408@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C90E3BF.4000408@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: spice-devel@lists.freedesktop.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Sep 15 2010 [17:18:23], Hans de Goede wrote:
> diff -up linux-2.6.35.x86_64/drivers/char/virtio_console.c~ linux-2.6.35.x86_64/drivers/char/virtio_console.c
> --- linux-2.6.35.x86_64/drivers/char/virtio_console.c~	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.35.x86_64/drivers/char/virtio_console.c	2010-09-15 13:39:29.043505000 +0200
> @@ -642,7 +642,7 @@ static unsigned int port_fops_poll(struc
>  	poll_wait(filp, &port->waitqueue, wait);
>  
>  	ret = 0;
> -	if (port->inbuf)
> +	if (port_has_data(port))
>  		ret |= POLLIN | POLLRDNORM;
>  	if (!will_write_block(port))
>  		ret |= POLLOUT;

Thanks, this works.

I'll send a git-formatted patch to Rusty.

		Amit
