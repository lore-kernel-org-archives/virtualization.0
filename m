From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/2] virtio-balloon: virtio 1 support
Date: Mon, 13 Apr 2015 10:02:58 +0200
Message-ID: <20150413100258.1f2c636f.cornelia.huck@de.ibm.com>
References: <1428849904-28953-1-git-send-email-mst@redhat.com>
	<1428849904-28953-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1428849904-28953-2-git-send-email-mst@redhat.com>
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
Cc: qemu-devel@nongnu.org, Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 12 Apr 2015 17:00:48 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Virtio 1.0 doesn't include a modern balloon device.  At some point we'll
> likely define an incompatible interface with a different ID and
> different semantics.  But for now, it's not a big effort to support a
> transitional balloon device: this has the advantage of supporting
> existing drivers, transparently, as well as transports that don't allow
> mixing virtio 0 and virtio 1 devices. And balloon is an easy device to
> test, so it's also useful for people to test virtio core handling of
> transitional devices.
> 
> The only interface issue is with the stats buffer, which has misaligned
> fields. We could leave it as is, but this sets a bad precedent that
> others might copy by mistake.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio-balloon.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index d2d7c3e..568a008 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -239,7 +239,8 @@ static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
>      VirtQueueElement *elem = &s->stats_vq_elem;
> -    VirtIOBalloonStat stat;
> +    VirtIOBalloonStat legacy_stat;
> +    VirtIOBalloonStatModern modern_stat;
>      size_t offset = 0;
>      qemu_timeval tv;
> 
> @@ -253,14 +254,28 @@ static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *vq)
>       */
>      reset_stats(s);
> 
> -    while (iov_to_buf(elem->out_sg, elem->out_num, offset, &stat, sizeof(stat))
> -           == sizeof(stat)) {
> -        uint16_t tag = virtio_tswap16(vdev, stat.tag);
> -        uint64_t val = virtio_tswap64(vdev, stat.val);
> +    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        while (iov_to_buf(elem->out_sg, elem->out_num, offset,
> +                          &modern_stat, sizeof(modern_stat))
> +               == sizeof(modern_stat)) {
> +            uint16_t tag = le16_to_cpu(modern_stat.tag);
> +            uint64_t val = le64_to_cpu(modern_stat.val);
> 
> -        offset += sizeof(stat);
> -        if (tag < VIRTIO_BALLOON_S_NR)
> -            s->stats[tag] = val;
> +            offset += sizeof(modern_stat);
> +            if (tag < VIRTIO_BALLOON_S_NR)
> +                s->stats[tag] = val;
> +        }
> +    } else {
> +        while (iov_to_buf(elem->out_sg, elem->out_num, offset,
> +                          &legacy_stat, sizeof(legacy_stat))
> +               == sizeof(legacy_stat)) {
> +            uint16_t tag = virtio_tswap16(vdev, legacy_stat.tag);
> +            uint64_t val = virtio_tswap64(vdev, legacy_stat.val);
> +
> +            offset += sizeof(legacy_stat);
> +            if (tag < VIRTIO_BALLOON_S_NR)
> +                s->stats[tag] = val;
> +        }
>      }
>      s->stats_vq_offset = offset;
> 

I'm still not really convinced that changing the stat structure is an
improvement. Without that, you wouldn't need the above change at all,
would you?

Also, doesn't get_features need to be modified as well so that
VERSION_1 is advertised?
