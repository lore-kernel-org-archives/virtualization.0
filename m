From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH] virtio_balloon: clear modern features under legacy
Date: Fri, 10 Jul 2020 09:13:41 -0700
Message-ID: <CAKgT0UeZN+mOWNhgiT0btZTyki3TPoj7pbqA+__GkCxoifPqeg@mail.gmail.com>
References: <20200710113046.421366-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20200710113046.421366-1-mst@redhat.com>
Sender: stable-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 4:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Page reporting features were never supported by legacy hypervisors.
> Supporting them poses a problem: should we use native endian-ness (like
> current code assumes)? Or little endian-ness like the virtio spec says?
> Rather than try to figure out, and since results of
> incorrect endian-ness are dire, let's just block this configuration.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

So I am not sure about the patch description. In the case of page
poison and free page reporting I don't think we are defining anything
that doesn't already have a definition of how to use in legacy.
Specifically the virtio_balloon_config is already defined as having
all fields as little endian in legacy mode, and there is a definition
for all of the fields in a virtqueue and how they behave in legacy
mode.

As far as I can see the only item that may be an issue is the command
ID being supplied via the virtqueue for free page hinting, which
appears to be in native endian-ness. Otherwise it would have fallen
into the same category since it is making use of virtio_balloon_config
and a virtqueue for supplying the page location and length.

> ---
>  drivers/virtio/virtio_balloon.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5d4b891bf84f..b9bc03345157 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1107,6 +1107,15 @@ static int virtballoon_restore(struct virtio_device *vdev)
>
>  static int virtballoon_validate(struct virtio_device *vdev)
>  {
> +       /*
> +        * Legacy devices never specified how modern features should behave.
> +        * E.g. which endian-ness to use? Better not to assume anything.
> +        */
> +       if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> +       }
>         /*
>          * Inform the hypervisor that our pages are poisoned or
>          * initialized. If we cannot do that then we should disable

The patch content itself I am fine with since odds are nobody would
expect to use these features with a legacy device.

Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
