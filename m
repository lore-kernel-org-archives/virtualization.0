From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2-RFC 0/2] virtio: put last seen used index into ring
	itself
Date: Mon, 31 May 2010 15:20:56 +0300
Message-ID: <20100531122055.GB1704__21290.9610396766$1275308852$gmane$org@redhat.com>
References: <cover.1274903328.git.mst@redhat.com>
	<201005311716.43573.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005311716.43573.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 31, 2010 at 05:16:42PM +0930, Rusty Russell wrote:
> On Thu, 27 May 2010 05:20:35 am Michael S. Tsirkin wrote:
> > Here's a rewrite of the original patch with a new layout.
> > I haven't tested it yet so no idea how this performs, but
> > I think this addresses the cache bounce issue raised by Avi.
> > Posting for early flames/comments.
> 
> Sorry, not without some evidence that it'll actually reduce cacheline
> bouncing.  I *think* it will, but it's not obvious: the host may keep
> looking at avail_idx as we're updating last_seen.  Or does qemu always
> look at both together anyway?
> Can someone convince me this is a win?
> Rusty.

What really happens is host looks at flags and last_seen together.
And flags happens to be in the same cache line with avail idx.
So to get an obvious win, we should put flags and last_seen
in a separate cache line from avail, which us easy - just add some padding.

And I'll relax the requirement from guest to only require it to update
last_seen when interrupts are enabled. This way flags and
last_seen are written together and read together.

Makes sense?
-- 
MST
