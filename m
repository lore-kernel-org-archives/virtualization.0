From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2-RFC 0/2] virtio: put last seen used index into ring
	itself
Date: Sun, 30 May 2010 14:22:20 +0300
Message-ID: <20100530112220.GA27611__7515.69746430523$1275218853$gmane$org@redhat.com>
References: <cover.1274903328.git.mst@redhat.com> <4BFF9366.5090103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BFF9366.5090103@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jes Sorensen <Jes.Sorensen@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 28, 2010 at 11:56:54AM +0200, Jes Sorensen wrote:
> On 05/26/10 21:50, Michael S. Tsirkin wrote:
> > Here's a rewrite of the original patch with a new layout.
> > I haven't tested it yet so no idea how this performs, but
> > I think this addresses the cache bounce issue raised by Avi.
> > Posting for early flames/comments.
> > 
> > Generally, the Host end of the virtio ring doesn't need to see where
> > Guest is up to in consuming the ring.  However, to completely understand
> > what's going on from the outside, this information must be exposed.
> > For example, host can reduce the number of interrupts by detecting
> > that the guest is currently handling previous buffers.
> > 
> > We add a feature bit so the guest can tell the host that it's writing
> > out the current value there, if it wants to use that.
> > 
> > This differs from original approach in that the used index
> > is put after avail index (they are typically written out together).
> > To avoid cache bounces on descriptor access,
> > and make future extensions easier, we put the ring itself at start of
> > page, and move the control after it.
> 
> Hi Michael,
> 
> It looks pretty good to me, however one thing I have been thinking of
> while reading through it:
> 
> Rather than storing a pointer within the ring struct, pointing into a
> position within the same struct. How about storing a byte offset instead
> and using a cast to get to the pointer position? That would avoid the
> pointer dereference, which is less effective cache wise and harder for
> the CPU to predict.
> 
> Not sure whether it really matters performance wise, just a thought.
> 
> Cheers,
> Jes

I think this won't work: when PUBLUSH_USED_IDX is negotiated,
the pointer is to within the ring.

-- 
MST
