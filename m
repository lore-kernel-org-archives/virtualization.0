From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv2-RFC 0/2] virtio: put last seen used index into ring
	itself
Date: Mon, 31 May 2010 17:16:42 +0930
Message-ID: <201005311716.43573.rusty__35161.6102889695$1275292050$gmane$org@rustcorp.com.au>
References: <cover.1274903328.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1274903328.git.mst@redhat.com>
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 27 May 2010 05:20:35 am Michael S. Tsirkin wrote:
> Here's a rewrite of the original patch with a new layout.
> I haven't tested it yet so no idea how this performs, but
> I think this addresses the cache bounce issue raised by Avi.
> Posting for early flames/comments.

Sorry, not without some evidence that it'll actually reduce cacheline
bouncing.  I *think* it will, but it's not obvious: the host may keep
looking at avail_idx as we're updating last_seen.  Or does qemu always
look at both together anyway?

Can someone convince me this is a win?
Rusty.
