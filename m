From: Jes Sorensen <Jes.Sorensen@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCHv2-RFC 0/2] virtio: put last seen used
	index	into ring itself
Date: Wed, 02 Jun 2010 22:39:02 +0200
Message-ID: <4C06C166.3050201__35872.2793091603$1275511312$gmane$org@redhat.com>
References: <cover.1274903328.git.mst@redhat.com>
	<201005311716.43573.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/31/10 09:46, Rusty Russell wrote:
> On Thu, 27 May 2010 05:20:35 am Michael S. Tsirkin wrote:
>> Here's a rewrite of the original patch with a new layout.
>> I haven't tested it yet so no idea how this performs, but
>> I think this addresses the cache bounce issue raised by Avi.
>> Posting for early flames/comments.
> 
> Sorry, not without some evidence that it'll actually reduce cacheline
> bouncing.  I *think* it will, but it's not obvious: the host may keep
> looking at avail_idx as we're updating last_seen.  Or does qemu always
> look at both together anyway?
> 
> Can someone convince me this is a win?
> Rusty.

Hi Rusty,

I ran some tests using the vring index publish patch with virtio_blk.
The numbers are based on running IOZone on a ramdisk passed to the guest
via virtio. While I didn't see any throughput improvements, I saw a
20-30% reduction in the VMExit count for the full run. This was measured
grabbing the VMExit count prior and after the run and calculating the
difference.

I have the numbers in a PDF, so I will email it to you in private as I
don't like sending PDFs to the mailing list. However if anybody else
wants the numbers feel free to ping me off list and I'll forward them.

Cheers,
Jes
