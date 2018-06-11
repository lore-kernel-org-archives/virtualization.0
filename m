From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Mon, 11 Jun 2018 11:32:41 -0700
Message-ID: <CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
References: <20180611192353-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180611192353-mutt-send-email-mst@kernel.org>
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
Cc: KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 11, 2018 at 9:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
>       virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT

Is this really a good idea?

Plus it seems entirely broken.

The report_pfn_range() callback is done under the zone lock, but
virtio_balloon_send_free_pages() (which is the only callback used that
I can find) does add_one_sg(), which does virtqueue_add_inbuf(vq, &sg,
1, vq, GFP_KERNEL);

So now we apparently do a GFP_KERNEL allocation insider the mm zone
lock, which is broken on just _so_ many levels.

Pulled and then unpulled again.

Either somebody needs to explain why I'm wrong and you can re-submit
this, or this kind of garbage needs to go away.

I do *not* want to be in the situation where I pull stuff from the
virtio people that adds completely broken core VM functionality.

Because if I'm in that situation, I will stop pulling from you guys.
Seriously. You have *no* place sending me broken shit that is outside
the virtio layer.

Subsystems that break code MM will get shunned. You just aren't
important enough to allow you breaking code VM.

                Linus
