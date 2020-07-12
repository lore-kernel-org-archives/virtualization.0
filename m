From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_balloon: clear modern features under legacy
Date: Sun, 12 Jul 2020 11:09:57 -0400
Message-ID: <20200712105926-mutt-send-email-mst@kernel.org>
References: <20200710113046.421366-1-mst@redhat.com>
 <CAKgT0UeZN+mOWNhgiT0btZTyki3TPoj7pbqA+__GkCxoifPqeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKgT0UeZN+mOWNhgiT0btZTyki3TPoj7pbqA+__GkCxoifPqeg@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 10, 2020 at 09:13:41AM -0700, Alexander Duyck wrote:
> On Fri, Jul 10, 2020 at 4:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Page reporting features were never supported by legacy hypervisors.
> > Supporting them poses a problem: should we use native endian-ness (like
> > current code assumes)? Or little endian-ness like the virtio spec says?
> > Rather than try to figure out, and since results of
> > incorrect endian-ness are dire, let's just block this configuration.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> So I am not sure about the patch description. In the case of page
> poison and free page reporting I don't think we are defining anything
> that doesn't already have a definition of how to use in legacy.
> Specifically the virtio_balloon_config is already defined as having
> all fields as little endian in legacy mode, and there is a definition
> for all of the fields in a virtqueue and how they behave in legacy
> mode.
> 
> As far as I can see the only item that may be an issue is the command
> ID being supplied via the virtqueue for free page hinting, which
> appears to be in native endian-ness. Otherwise it would have fallen
> into the same category since it is making use of virtio_balloon_config
> and a virtqueue for supplying the page location and length.



So as you point out correctly balloon spec says all fields are little
endian.  Fair enough.
Problem is when virtio 1 is not negotiated, then this is not what the
driver assumes for any except a handlful of fields.

But yes it mostly works out.

For example:


static void update_balloon_size(struct virtio_balloon *vb)
{
        u32 actual = vb->num_pages;

        /* Legacy balloon config space is LE, unlike all other devices. */
        if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
                actual = (__force u32)cpu_to_le32(actual);

        virtio_cwrite(vb->vdev, struct virtio_balloon_config, actual,
                      &actual);
}


this is LE even without VIRTIO_F_VERSION_1, so matches spec.

                /* Start with poison val of 0 representing general init */
                __u32 poison_val = 0;

                /*
                 * Let the hypervisor know that we are expecting a
                 * specific value to be written back in balloon pages.
                 */
                if (!want_init_on_free())
                        memset(&poison_val, PAGE_POISON, sizeof(poison_val));

                virtio_cwrite(vb->vdev, struct virtio_balloon_config,
                              poison_val, &poison_val);


actually this writes a native endian-ness value. All bytes happen to be
the same though, and host only cares about 0 or non 0 ATM.

As you say correctly the command id is actually assumed native endian:


static u32 virtio_balloon_cmd_id_received(struct virtio_balloon *vb)
{
        if (test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
                               &vb->config_read_bitmap))
                virtio_cread(vb->vdev, struct virtio_balloon_config,
                             free_page_hint_cmd_id,
                             &vb->cmd_id_received_cache);

        return vb->cmd_id_received_cache;
}


So guest assumes native, host assumes LE.




> > ---
> >  drivers/virtio/virtio_balloon.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 5d4b891bf84f..b9bc03345157 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -1107,6 +1107,15 @@ static int virtballoon_restore(struct virtio_device *vdev)
> >
> >  static int virtballoon_validate(struct virtio_device *vdev)
> >  {
> > +       /*
> > +        * Legacy devices never specified how modern features should behave.
> > +        * E.g. which endian-ness to use? Better not to assume anything.
> > +        */
> > +       if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
> > +               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
> > +       }
> >         /*
> >          * Inform the hypervisor that our pages are poisoned or
> >          * initialized. If we cannot do that then we should disable
> 
> The patch content itself I am fine with since odds are nobody would
> expect to use these features with a legacy device.
> 
> Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Hmm so now you pointed out it's just cmd id, maybe I should just fix it
instead? what do you say?

-- 
MST
