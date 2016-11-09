From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: BUG: 'list_empty(&vgdev->free_vbufs)' is true!
Date: Wed, 09 Nov 2016 09:01:57 +0100
Message-ID: <1478678517.2078.12.camel@redhat.com>
References: <bfe29853-694b-6cb5-02e7-6986a9927438@suse.cz>
	<20161108223153-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161108223153-mutt-send-email-mst@kernel.org>
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
Cc: David Airlie <airlied@linux.ie>, Jiri Slaby <jslaby@suse.cz>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Di, 2016-11-08 at 22:37 +0200, Michael S. Tsirkin wrote:
> On Mon, Nov 07, 2016 at 09:43:24AM +0100, Jiri Slaby wrote:
> > Hi,
> > 
> > I can relatively easily reproduce this bug:

How?

> > BUG: 'list_empty(&vgdev->free_vbufs)' is true!

> The following might be helpful for debugging - if kernel still will
> not stop panicing, we are looking at some kind
> of memory corruption.

Looking carefully through the code I think it isn't impossible to
trigger this, but you need for that:

  (1) command queue full (quite possible),
  (2) cursor queue full too (unlikely), and
  (3) multiple threads trying to submit commands and waiting for free
      space in the command queue (possible with virgl enabled).

Do things improve if you allocate some extra bufs?

 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
 {
        struct virtio_gpu_vbuffer *vbuf;
-       int i, size, count = 0;
+       int i, size, count = 16;
        void *ptr;
 
        INIT_LIST_HEAD(&vgdev->free_vbufs);

Memory corruption sounds plausible too.

Redirect console to ttyS0 for trouble-shooting, trying to dump the oops
to the display device which triggered the oops in the first place isn't
going to work very well ...

cheers,
  Gerd
