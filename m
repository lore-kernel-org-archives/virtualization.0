From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_balloon: don't push uninitialized buffers to
	stats virtqueue
Date: Wed, 22 Mar 2017 19:15:40 +0200
Message-ID: <20170322190803-mutt-send-email-mst@kernel.org>
References: <1490195427-25085-1-git-send-email-lprosek@redhat.com>
	<20170322181424-mutt-send-email-mst@kernel.org>
	<CABdb737CkqiJXDVU5J2S+Kbg2zht2XB-1ETsxZ_e95ViRfyDpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CABdb737CkqiJXDVU5J2S+Kbg2zht2XB-1ETsxZ_e95ViRfyDpA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ladi Prosek <lprosek@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 22, 2017 at 06:05:39PM +0100, Ladi Prosek wrote:
> On Wed, Mar 22, 2017 at 5:14 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, Mar 22, 2017 at 04:10:27PM +0100, Ladi Prosek wrote:
> >> When init_vqs runs, virtio_balloon.stats is either uninitialized or
> >> contains stale values. The host updates its state with garbage data
> >> because it has no way of knowing that this is just a marker buffer
> >> used for signaling.
> >>
> >> This patch initializes all tags with U16_MAX which is guaranteed to
> >> be ignored by the host.
> >>
> >> The alternative fix would be to push an empty buffer in init_vqs but
> >> that's not easily done with the current virtio implementation and
> >> would still not eliminate the invariant that update_balloon_stats
> >> has to update all VIRTIO_BALLOON_S_NR fields.
> >>
> >> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> >> ---
> >>  drivers/virtio/virtio_balloon.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> >> index 4e11915..d34f56f 100644
> >> --- a/drivers/virtio/virtio_balloon.c
> >> +++ b/drivers/virtio/virtio_balloon.c
> >> @@ -423,12 +423,16 @@ static int init_vqs(struct virtio_balloon *vb)
> >>       vb->deflate_vq = vqs[1];
> >>       if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> >>               struct scatterlist sg;
> >> +             int idx;
> >>               vb->stats_vq = vqs[2];
> >>
> >>               /*
> >>                * Prime this virtqueue with one buffer so the hypervisor can
> >>                * use it to signal us later (it can't be broken yet!).
> >>                */
> >> +             for (idx = 0; idx < VIRTIO_BALLOON_S_NR; idx++)
> >> +                     update_stat(vb, idx, U16_MAX, 0);
> >> +
> >
> > Can't we fill in actual values?
> 
> We can if we're fine with the unsolicited update.
> 
> In QEMU, this would mean that you'll see valid stats in
> /machine/peripheral/balloon0/guest-stats without setting the
> guest-stats-polling-interval. And they would be updated on driver
> (re-)load, so kind of arbitrarily from host pov.

IUC the only issue would be that someone might come to
depend on this. Doesn't look like a big deal to me.

> On the other hand, this patch does not really comply with (5.5.6.3.1
> Driver Requirements: Memory Statistics):
> 
> "Driver MUST supply the same subset of statistics in all buffers
> submitted to the statsq."
> 
> So going by the letter of the law, we should fill in actual values.
> Going by the (the purpose of the initial buffer is to wait for the
> host to request stats), we should push an empty buffer or invalid
> values.
> >>               sg_init_one(&sg, vb->stats, sizeof vb->stats);
> >>               if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
> >>                   < 0)
> >> --
> >> 2.7.4
