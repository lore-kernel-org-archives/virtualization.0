From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
Date: Tue, 30 Oct 2018 11:31:04 +0000
Message-ID: <CACvgo50MK1jU0jKMCfZJQSaSmpQ8mmYj1=4GP2NQvM_DHOaW-Q__20246.0672626787$1540899049$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-3-robert.foss@collabora.com>
	<20181030061127.hp4n2scw5f3j2rqq@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181030061127.hp4n2scw5f3j2rqq@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>, Robert Foss <robert.foss@collabora.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

HI Gerd,

On Tue, 30 Oct 2018 at 06:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > The execbuffer IOCTL is now read-write to allow the userspace to read the
> > out-fence.
>
> >  #define DRM_IOCTL_VIRTGPU_EXECBUFFER \
> > -     DRM_IOW(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
> > +     DRM_IOWR(DRM_COMMAND_BASE + DRM_VIRTGPU_EXECBUFFER,\
> >               struct drm_virtgpu_execbuffer)
>
> That changes the ioctl number and breaks the userspace api.
>
Have you looked at the drm_ioctl() implementation? AFAICT it
explicitly caters for this kind of changes.

-Emil
