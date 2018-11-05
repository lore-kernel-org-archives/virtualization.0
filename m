From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/5] drm/virtio: add virtio_gpu_alloc_fence()
Date: Mon, 5 Nov 2018 07:38:18 +0100
Message-ID: <20181105063818.b2yvncgzlnat5qn2__22206.8106443205$1541399780$gmane$org@sirius.home.kraxel.org>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-2-robert.foss@collabora.com>
	<CACvgo516JGdfBZ8zM73bQ-TCeNEbOp9ioBy9jh0AAtpUsu5tOg@mail.gmail.com>
	<1c92b6dc-4152-c81b-5180-2f48799b959f@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1c92b6dc-4152-c81b-5180-2f48799b959f@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robert Foss <robert.foss@collabora.com>
Cc: David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

> > On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
> > > 
> > > From: Gustavo Padovan <gustavo.padovan@collabora.com>
> > > 
> > > Refactor fence creation to remove the potential allocation failure from
> > > the cmd_submit and atomic_commit paths. Now the fence should be allocated
> > > first and just after we should proceed with the rest of the execution.
> > > 
> > 
> > Commit does a bit more that what the above says:
> >   - dummy, factor out fence creation/destruction
> >   - use per virtio_gpu_framebuffer fence
> > 
> > Personally I'd keep the two separate patches and elaborate on the latter.
> > Obviously in that case, one will need to add 3 lines worth of
> > virtio_gpu_fence_alloc() in virtio_gpu_cursor_plane_update which will be nuked
> > with the next patch.
> > 
> > Not a big deal, but it's up-to the maintainer to make the final call if it's
> > worth splitting or not.
> 
> Agreed, I'll hold off with this change until then.

No need to split this, but a bit more verbose commit message would be
good.

cheers,
  Gerd
