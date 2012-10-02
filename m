From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] virtio-blk: Disable callback in virtblk_done()
Date: Tue, 2 Oct 2012 16:42:58 +0200
Message-ID: <CAJSP0QW4_1LJ5y=MCHt3pZYE+Tvw_xEb1-WpYtRGueAphmUhYw@mail.gmail.com>
References: <1348540577-7474-1-git-send-email-asias@redhat.com>
	<5061BAED.9020205@redhat.com> <87ehlo497o.fsf@rustcorp.com.au>
	<50642400.5030906@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50642400.5030906@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 27, 2012 at 12:01 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 27/09/2012 02:10, Rusty Russell ha scritto:
>>>> >> +        do {
>>>> >> +                virtqueue_disable_cb(vq);
>>>> >> +                while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
>>>> >> +                        if (vbr->bio) {
>>>> >> +                                virtblk_bio_done(vbr);
>>>> >> +                                bio_done = true;
>>>> >> +                        } else {
>>>> >> +                                virtblk_request_done(vbr);
>>>> >> +                                req_done = true;
>>>> >> +                        }
>>>> >>                  }
>>>> >> -        }
>>>> >> +        } while (!virtqueue_enable_cb(vq));
>>>> >>          /* In case queue is stopped waiting for more buffers. */
>>>> >>          if (req_done)
>>>> >>                  blk_start_queue(vblk->disk->queue);
>> Fascinating.  Please just confirm that VIRTIO_RING_F_EVENT_IDX is
>> enabled?
>
> Yeah, it's a nice and cheap trick.  Stefan, I see that you had this in
> virtio-scsi since even before I picked it up.  Do you remember how you
> came up with it?

I've played with disable_cb/enable_cb previously in virtio-blk and
virtio-scsi when aliguori had suggested reducing notifies.  I
definitely didn't invent it :).

Stefan
