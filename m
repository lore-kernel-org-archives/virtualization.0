From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 3/4] drm/virtio: add in/out fence support for explicit
	synchronization
Date: Mon, 12 Nov 2018 10:10:27 +0100
Message-ID: <20181112091027.3bh4gi5mvu73tcqh__39995.2657906853$1542013707$gmane$org@sirius.home.kraxel.org>
References: <20181105114152.2088-1-robert.foss@collabora.com>
	<20181105114152.2088-4-robert.foss@collabora.com>
	<CACvgo53vCBbgmu4OV4e0WeOYQSXNk=3qwyRBtPx+XAcCSZO8aQ@mail.gmail.com>
	<20181109101354.dc7cv4i4etu3bkhh@sirius.home.kraxel.org>
	<f5143d56-3e11-51f7-a07a-9106aa8bda49@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <f5143d56-3e11-51f7-a07a-9106aa8bda49@collabora.com>
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

On Fri, Nov 09, 2018 at 06:13:52PM +0100, Robert Foss wrote:
> Hey Gerd,
> 
> On 2018-11-09 11:13, Gerd Hoffmann wrote:
> > On Mon, Nov 05, 2018 at 05:25:05PM +0000, Emil Velikov wrote:
> > > On Mon, 5 Nov 2018 at 11:42, Robert Foss <robert.foss@collabora.com> wrote:
> > > > 
> > > > When the execbuf call receives an in-fence it will get the dma_fence
> > > > related to that fence fd and wait on it before submitting the draw call.
> > > > 
> > > > On the out-fence side we get fence returned by the submitted draw call
> > > > and attach it to a sync_file and send the sync_file fd to userspace. On
> > > > error -1 is returned to userspace.
> > > > 
> > > > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> > > > Signed-off-by: Robert Foss <robert.foss@collabora.com>
> > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> > > > ---
> > > > 
> > > > Changes since v3:
> > > >   - Move all in_fence handling to the same VIRTGPU_EXECBUF_FENCE_FD_IN block
> > > Fwiw my suggestion was to explicitly document whether the IOCTL can
> > > support, simultaneously, IN and OUT fence.
> > 
> > Yes, that would be good.  Code looks like it is supposed to work, but
> > explicitly saying so in the commit message would be nice.
> 
> On it! Will send out a v5.
> 
> > 
> > Also: should we use separate fields for in/out fds?
> 
> I'm not sure I understand which fields you're referring to.

fence_in_fd & fence_out_fd in the ioctl struct (patch #2).

cheers,
  Gerd
