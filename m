From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 30 Jul 2012 15:42:47 +0200
Message-ID: <20120730134247.GA6041@lst.de>
References: <1343442065-15646-1-git-send-email-asias@redhat.com>
	<1343442065-15646-4-git-send-email-asias@redhat.com>
	<20120729111115.GD8977@redhat.com> <87a9yim2qg.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87a9yim2qg.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 30, 2012 at 11:25:51AM +0930, Rusty Russell wrote:
> I consider this approach a half-way step.  Quick attempts on my laptop
> and I couldn't find a case where the bio path was a loss, but in theory
> if the host wasn't doing any reordering and it was a slow device, you'd
> want the guest to do so.
> 
> I'm not sure if current qemu can be configured to do such a thing?


The host kernel will do the I/O scheduling for you unless you explicitly
disable it.  And we should be able to assume an administrator will only
disable it when they have a reason for it - if not they'll get worse
performance for non-virtualized workloads as well.
