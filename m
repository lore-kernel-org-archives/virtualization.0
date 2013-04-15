From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/1] virtio: console: replace EMFILE with EBUSY for
	already-open port
Date: Mon, 15 Apr 2013 12:00:27 +0930
Message-ID: <87sj2s8r0c.fsf@rustcorp.com.au>
References: <2d57d36ef32e2d9073b0ca3e4e4b2dc32897932f.1365660074.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <2d57d36ef32e2d9073b0ca3e4e4b2dc32897932f.1365660074.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:
> Returning EMFILE (process has too many open files) is incorrect to
> indicate a port is already open by another process.  Use EBUSY for that.
>
> This does change what we report to userspace, but I believe userspace
> can look at it this way: it gets EBUSY, a new error code, instead of
> EMFILE.  It's still an error, and that's not changing.
>
> Reported-by: Mateusz Guzik <mguzik@redhat.com>
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
> Rusty, is this OK?  It's a change for the userspace, so is it considered
> breakage?  OTOH the current return value is obviously wrong, 

Yes, I agree.  I don't know of anyone testing for EMFILE particularly,
so this is OK.

Applied,
Rusty.

>
> 'Broken' userspace code could be relying on the exact error type
> (current EMFILE) to detect if other processes are using the same file,
> that's the only thing I can think  of where this change can break
> existing userspace.  But is that a strong enough reason to not fix this?
>
>
>  drivers/char/virtio_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index ce5f3fc..b94be04 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1040,7 +1040,7 @@ static int port_fops_open(struct inode *inode, struct file *filp)
>  	spin_lock_irq(&port->inbuf_lock);
>  	if (port->guest_connected) {
>  		spin_unlock_irq(&port->inbuf_lock);
> -		ret = -EMFILE;
> +		ret = -EBUSY;
>  		goto out;
>  	}
>  
> -- 
> 1.8.1.4
