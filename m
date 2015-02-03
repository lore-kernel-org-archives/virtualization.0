From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] virtio_console: fix sparse warnings
Date: Tue, 3 Feb 2015 15:48:25 -0800
Message-ID: <20150203234825.GA24626@kroah.com>
References: <1417433749-17408-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417433749-17408-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 01, 2014 at 01:35:57PM +0200, Michael S. Tsirkin wrote:
> CHECK drivers/char/virtio_console.c
> drivers/char/virtio_console.c:687:36: warning: incorrect type in
> 	argument 1 (different address spaces)
> drivers/char/virtio_console.c:687:36:    expected void [noderef]
> 	<asn:1>*to
> drivers/char/virtio_console.c:687:36:    got char *out_buf
> drivers/char/virtio_console.c:790:35: warning: incorrect type in
> 	argument 2 (different address spaces)
> drivers/char/virtio_console.c:790:35:    expected char *out_buf
> drivers/char/virtio_console.c:790:35:    got char [noderef]
> 	<asn:1>*ubuf
> 
> fill_readbuf is reused with both kernel and userspace pointers,
> depending on value of to_user flag.

That's horrid, don't do that.  Have two different functions for this
type of thing, otherwise you defeat the whole purpose of trying to track
__user pointers.

thanks,

greg k-h
