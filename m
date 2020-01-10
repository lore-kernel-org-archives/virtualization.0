From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: add missing virtio_gpu_array_lock_resv call
Date: Fri, 10 Jan 2020 13:02:17 -0800
Message-ID: <CAPaKu7TQCXOmj1zthBXq4XtNpK8WT4Rv5CwUmLrRBNwm4f0uRw__17038.7222476833$1578690240$gmane$org@mail.gmail.com>
References: <20200110094535.23472-1-kraxel@redhat.com>
 <CAG48ez0wfLkTqdBtDBV4b1uUQMGeeAr09GPPi9WT++Fn8ph4rA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAG48ez0wfLkTqdBtDBV4b1uUQMGeeAr09GPPi9WT++Fn8ph4rA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Jann Horn <jannh@google.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 10, 2020 at 6:27 AM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Jan 10, 2020 at 10:45 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > When submitting a fenced command we must lock the object reservations
> > because virtio_gpu_queue_fenced_ctrl_buffer() unlocks after adding the
> > fence.
>
> Thanks a lot! With this patch applied, my VM doesn't throw lockdep
> warnings anymore. If you want, you can add:
>
> Tested-by: Jann Horn <jannh@google.com>
>
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
> >  1 file changed, 1 insertion(+)
