From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [patch] virtio_console: use snprintf() for safety
Date: Fri, 8 May 2015 12:01:18 +0530
Message-ID: <20150508063118.GA6361@grmbl.mre>
References: <20150508061902.GA14769@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150508061902.GA14769@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 08 May 2015 [09:19:02], Dan Carpenter wrote:
> My static checker complains that this sprintf() can overflow.
> 
> vdev->index is selected by ida_simple_get() in register_virtio_device()
> so my reading of the code is that this overflow is theoretically
> possible.  The max value of "id" is configurable and I'm not sure what
> typical values are.

vdev->index is per-device, and starts with 0 for the first attached
virtio-serial-pci device.  So to overflow, a lot of devices have to be
attached, which isn't possible with current qemu.  16 bytes was
already overkill..

> Anyway, it's simple enough to make the buffer larger and I changed it to
> snprintf() as well.

Any reason to choose 28?  I think 16 is enough.

The snprintf change is fine, though.


		Amit
