From: Amit Shah <amit.shah@redhat.com>
Subject: Re: PATCH: virtio_console: Fix poll blocking even though there is
	data to read
Date: Wed, 15 Sep 2010 18:55:36 +0530
Message-ID: <20100915132536.GA12320__38437.4742083766$1284557187$gmane$org@amit-laptop.redhat.com>
References: <4C90C475.4010809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C90C475.4010809@redhat.com>
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

On (Wed) Sep 15 2010 [15:04:53], Hans de Goede wrote:
> Hi All,
> 
> I found this while working on a Linux agent for spice, the symptom I was
> seeing was select blocking on the spice vdagent virtio serial port even
> though there were messages queued up there.
> 
> I found this while working on a Linux agent for spice, the symptom I was
> seeing was select blocking on the spice vdagent virtio serial port even
> though there were messages queued up there.
> 
> virtio_console's port_fops_poll checks port->inbuf != NULL to determine if
> read won't block. However if an application reads enough bytes from inbuf
> through port_fops_read, to empty the current port->inbuf, port->inbuf
> will be NULL even though there may be buffers left in the virtqueue.
> 
> This causes poll() to block even though there is data to be read, this patch
> fixes this by using the alredy defined will_read_block utility function
> instead of the port->inbuf != NULL check.
> 
> Signed-off-By: Hans de Goede <hdegoede@redhat.com>
> 
> Regards,
> 
> Hans

> diff -up linux-2.6.35.x86_64/drivers/char/virtio_console.c~ linux-2.6.35.x86_64/drivers/char/virtio_console.c
> --- linux-2.6.35.x86_64/drivers/char/virtio_console.c~	2010-08-02 00:11:14.000000000 +0200
> +++ linux-2.6.35.x86_64/drivers/char/virtio_console.c	2010-09-15 13:39:29.043505000 +0200
> @@ -642,7 +642,7 @@ static unsigned int port_fops_poll(struc
>  	poll_wait(filp, &port->waitqueue, wait);
>  
>  	ret = 0;
> -	if (port->inbuf)
> +	if (!will_read_block(port))

Looks correct, but this should be

	if (port_has_data(port))

instead.

will_read_block() also tests if the host is connected, which is not what
we want for POLLIN to be set.

		Amit
