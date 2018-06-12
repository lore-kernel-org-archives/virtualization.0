From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PULL] vhost: cleanups and fixes
Date: Tue, 12 Jun 2018 04:36:54 +0300
Message-ID: <20180612042600-mutt-send-email-mst@kernel.org>
References: <20180611192353-mutt-send-email-mst@kernel.org>
	<CA+55aFzrPgnd7hRPrkeV+jX-MSwOZf7T4wKxz66Lk4oub3PZsw@mail.gmail.com>
	<CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFz4uBHaWnBarVUEG90s2ucyVtoLmwYpYVwDV+XQESNRqw@mail.gmail.com>
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
Cc: KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 11, 2018 at 11:44:05AM -0700, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 11:32 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So now we apparently do a GFP_KERNEL allocation insider the mm zone
> > lock, which is broken on just _so_ many levels.
> 
> Oh, I see the comment about how it doesn't actually do an allocation
> at all because it's a single-entry.
> 
> Still too damn ugly to live, and much too fragile. No way in hell do
> we even _hint_ at a GFP_KERNEL when we're inside a context that can't
> do any memory allocation at all.
> 
> Plus I'm not convinced it's a "no allocation" path even despite that
> comment, because it also does a "dma_map_page()" etc, which can cause
> allocations to do the dma mapping thing afaik. No?

Well no because DMA is triggered by the IOMMU flag and
that is always off for the balloon. But I hear what you
are saying about it being fragile.

> Maybe there's some reason why that doesn't happen either, but
> basically this whole callchain looks *way* to complicated to be used
> under a core VM spinlock.
> 
>                 Linus

Maybe it will help to have GFP_NONE which will make any allocation
fail if attempted. Linus, would this address your comment?
-- 
MST
