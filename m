From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2-RFC 0/2] virtio: put last seen used index into ring
	itself
Date: Mon, 31 May 2010 16:29:50 +0300
Message-ID: <20100531132950.GC1704__37788.3338057019$1275312994$gmane$org@redhat.com>
References: <cover.1274903328.git.mst@redhat.com> <4BFF9366.5090103@redhat.com>
	<20100530112220.GA27611@redhat.com> <4C0366E0.6040203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C0366E0.6040203@redhat.com>
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

On Mon, May 31, 2010 at 09:36:00AM +0200, Jes Sorensen wrote:
> On 05/30/10 13:22, Michael S. Tsirkin wrote:
> > On Fri, May 28, 2010 at 11:56:54AM +0200, Jes Sorensen wrote:
> >> It looks pretty good to me, however one thing I have been thinking of
> >> while reading through it:
> >>
> >> Rather than storing a pointer within the ring struct, pointing into a
> >> position within the same struct. How about storing a byte offset instead
> >> and using a cast to get to the pointer position? That would avoid the
> >> pointer dereference, which is less effective cache wise and harder for
> >> the CPU to predict.
> >>
> >> Not sure whether it really matters performance wise, just a thought.
> > 
> > I think this won't work: when PUBLUSH_USED_IDX is negotiated,
> > the pointer is to within the ring.
> 
> Hmmm shame, it would be a nice optimization.
> 
> Maybe it's time to introduce the v2 ring format, rather than having
> adding more kludges to the existing one?
> 
> Cheers,
> Jes

There has been discussion about a ring format that does not
use indexes at all. My guess is that would be a good point
for v2 ring format. But making that a product
and tuning might take a while. So definitely something to
keep in mind but I would not want that to block this optimization.

-- 
MST
