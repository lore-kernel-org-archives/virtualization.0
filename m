From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: BUG: 'list_empty(&vgdev->free_vbufs)' is true!
Date: Tue, 15 Nov 2016 09:46:28 +0100
Message-ID: <1479199588.32639.16.camel__6461.07964353195$1479199692$gmane$org@redhat.com>
References: <bfe29853-694b-6cb5-02e7-6986a9927438@suse.cz>
	<20161108223153-mutt-send-email-mst@kernel.org>
	<1478678517.2078.12.camel@redhat.com>
	<f006e3a6-51d2-4092-57b6-eea7ff64f58f@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f006e3a6-51d2-4092-57b6-eea7ff64f58f@suse.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fr, 2016-11-11 at 17:28 +0100, Jiri Slaby wrote:
> On 11/09/2016, 09:01 AM, Gerd Hoffmann wrote:
> > On Di, 2016-11-08 at 22:37 +0200, Michael S. Tsirkin wrote:
> >> On Mon, Nov 07, 2016 at 09:43:24AM +0100, Jiri Slaby wrote:
> >>> Hi,
> >>>
> >>> I can relatively easily reproduce this bug:
> > 
> > How?
> 
> Run dmesg -w in the qemu window (virtio_gpu) to see a lot of output.

fbcon?  Or xorg/wayland with terminal app?

> Run pps [1] without exit(0); on e.g. serial console.
> Wait a bit. The lot of output causes the BUG.
> 
> [1] https://github.com/jirislaby/collected_sources/blob/master/pps.c
> 
> >>> BUG: 'list_empty(&vgdev->free_vbufs)' is true!
> > 
> >> The following might be helpful for debugging - if kernel still will
> >> not stop panicing, we are looking at some kind
> >> of memory corruption.
> > 
> > Looking carefully through the code I think it isn't impossible to
> > trigger this, but you need for that:
> > 
> >   (1) command queue full (quite possible),
> >   (2) cursor queue full too (unlikely), and
> >   (3) multiple threads trying to submit commands and waiting for free
> >       space in the command queue (possible with virgl enabled).
> 
> I use -vga virtio with no -display option, so no virtgl, I suppose:
> [drm] virgl 3d acceleration not available
> 
> > Do things improve if you allocate some extra bufs?
> > 
> >  int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
> >  {
> >         struct virtio_gpu_vbuffer *vbuf;
> > -       int i, size, count = 0;
> > +       int i, size, count = 16;
> 
> This seems to help.
> 
> thanks,
