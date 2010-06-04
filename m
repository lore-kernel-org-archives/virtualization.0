From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv3 1/2] virtio: support layout with avail ring before idx
Date: Fri, 4 Jun 2010 20:46:49 +0930
Message-ID: <201006042046.49872.rusty__47075.7850715474$1275650314$gmane$org@rustcorp.com.au>
References: <cover.1275403477.git.mst@redhat.com>
	<201006041204.57973.rusty@rustcorp.com.au>
	<20100604103543.GA22270@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100604103543.GA22270@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 4 Jun 2010 08:05:43 pm Michael S. Tsirkin wrote:
> On Fri, Jun 04, 2010 at 12:04:57PM +0930, Rusty Russell wrote:
> > On Wed, 2 Jun 2010 12:17:12 am Michael S. Tsirkin wrote:
> > > This adds an (unused) option to put available ring before control (avail
> > > index, flags), and adds padding between index and flags. This avoids
> > > cache line sharing between control and ring, and also makes it possible
> > > to extend avail control without incurring extra cache misses.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > No no no no.  254?  You're trying to Morton me![1]
> 
> Hmm, I wonder what will we do if we want a 3rd field on
> a separate chacheline. But ok.
> 
> > How's this (untested):
> 
> I think we also want to put flags there as well,
> they are used on interrupt path, together with last used index.

I'm uncomfortable with moving a field.

We haven't done that before and I wonder what will break with old code.

Should we instead just abandon the flags field and use last_used only?
Or, more radically, put flags == last_used when the feature is on?

Thoughts?
Rusty.
