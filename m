From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Tue, 12 Jun 2018 04:57:51 +0300
Message-ID: <20180612043723-mutt-send-email-mst@kernel.org>
References: <20180611192353-mutt-send-email-mst@kernel.org>
	<CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: nilal@redhat.com, KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 11, 2018 at 11:32:41AM -0700, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 9:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >       virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> 
> Is this really a good idea?

Well knowing which pages are unused does seem to be useful.  Do you
refer to this generally or to the idea of scanning the free list,
or to the specific implementation issues you listed below?


> Plus it seems entirely broken.
> 
> The report_pfn_range() callback is done under the zone lock, but
> virtio_balloon_send_free_pages() (which is the only callback used that
> I can find) does add_one_sg(), which does virtqueue_add_inbuf(vq, &sg,
> 1, vq, GFP_KERNEL);
> 
> So now we apparently do a GFP_KERNEL allocation insider the mm zone
> lock, which is broken on just _so_ many levels.
> 
> Pulled and then unpulled again.
> 
> Either somebody needs to explain why I'm wrong and you can re-submit
> this, or this kind of garbage needs to go away.
> 
> I do *not* want to be in the situation where I pull stuff from the
> virtio people that adds completely broken core VM functionality.
> 
> Because if I'm in that situation, I will stop pulling from you guys.
> Seriously. You have *no* place sending me broken shit that is outside
> the virtio layer.
> 
> Subsystems that break code MM will get shunned. You just aren't
> important enough to allow you breaking code VM.
> 
>                 Linus

So no, it doesn't do any allocations - GFP_KERNEL or otherwise, but I
agree how it might be confusing.

So I'll drop this for now, but it would be nice if there is a bit more
direction on this feature since I know several people are trying to work
on this.


-- 
MST
