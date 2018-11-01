From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Thu, 1 Nov 2018 19:38:12 -0400
Message-ID: <20181101193516-mutt-send-email-mst@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
	<CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: lenaic@lhuard.fr, Michal Hocko <mhocko@suse.com>, bijan.mottahedeh@oracle.com, KVM <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, liang.z.li@intel.com, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 01, 2018 at 04:00:23PM -0700, Kees Cook wrote:
> On Thu, Nov 1, 2018 at 2:19 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fde=
db7d:
> >
> >   Linux 4.19 (2018-10-22 07:37:37 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_=
linus
> >
> > for you to fetch changes up to 79f800b2e76923cd8ce0aa659cb5c019d9643bc9:
> >
> >   MAINTAINERS: remove reference to bogus vsock file (2018-10-24 21:16:1=
4 -0400)
> >
> > ----------------------------------------------------------------
> > virtio, vhost: fixes, tweaks
> >
> > virtio balloon page hinting support
> > vhost scsi control queue
> >
> > misc fixes.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Bijan Mottahedeh (3):
> >       vhost/scsi: Respond to control queue operations
> =

> +static void
> +vhost_scsi_send_tmf_resp(struct vhost_scsi *vs,
> +                          struct vhost_virtqueue *vq,
> +                          int head, unsigned int out)
> +{
> +       struct virtio_scsi_ctrl_tmf_resp __user *resp;
> +       struct virtio_scsi_ctrl_tmf_resp rsp;
> +       int ret;
> +
> +       pr_debug("%s\n", __func__);
> +       memset(&rsp, 0, sizeof(rsp));
> +       rsp.response =3D VIRTIO_SCSI_S_FUNCTION_REJECTED;
> +       resp =3D vq->iov[out].iov_base;
> +       ret =3D __copy_to_user(resp, &rsp, sizeof(rsp));
> =

> Is it actually safe to trust that iov_base has passed an earlier
> access_ok() check here? Why not just use copy_to_user() instead?
> =

> -Kees

I am not sure copy_to_user will do the right thing here, because all
this runs in context of a kernel thread.  We do need access_ok which
takes place way earlier in context of the task.

Another reason it is safe is because the address is not
coming from userspace at all.




> >       vhost/scsi: Extract common handling code from control queue handl=
er
> >       vhost/scsi: Use common handling code in request queue handler
> >
> > Greg Edwards (1):
> >       vhost/scsi: truncate T10 PI iov_iter to prot_bytes
> >
> > L=E9na=EFc Huard (1):
> >       kvm_config: add CONFIG_VIRTIO_MENU
> >
> > Stefan Hajnoczi (1):
> >       MAINTAINERS: remove reference to bogus vsock file
> >
> > Wei Wang (3):
> >       virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> >       mm/page_poison: expose page_poisoning_enabled to kernel modules
> >       virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
> >
> >  MAINTAINERS                         |   1 -
> >  drivers/vhost/scsi.c                | 426 ++++++++++++++++++++++++++++=
--------
> >  drivers/virtio/virtio_balloon.c     | 380 ++++++++++++++++++++++++++++=
+---
> >  include/uapi/linux/virtio_balloon.h |   8 +
> >  kernel/configs/kvm_guest.config     |   1 +
> >  mm/page_poison.c                    |   6 +
> >  6 files changed, 688 insertions(+), 134 deletions(-)
> =

> =

> =

> -- =

> Kees Cook
