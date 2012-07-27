From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V3 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Fri, 27 Jul 2012 10:03:48 +0930
Message-ID: <87d33initv.fsf@rustcorp.com.au>
References: <1342168731-11797-1-git-send-email-asias@redhat.com>
	<1342168731-11797-4-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342168731-11797-4-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 13 Jul 2012 16:38:51 +0800, Asias He <asias@redhat.com> wrote:
> Add 'virtio_blk.use_bio=1' to kernel cmdline or 'modprobe virtio_blk
> use_bio=1' to enable ->make_request_fn() based I/O path.

This patch conflicts with Paolo's Bonzini's 'virtio-blk: allow toggling
host cache between writeback and writethrough' which is also queued (see
linux-next).

I'm not sure what the correct behavior for bio & cacheflush is, if any.

But as to the patch itself: it's a hack.

1) Leaving the guest's admin to turn on the switch is a terrible choice.
2) The block layer should stop merging and sorting when a device is
   fast, not the driver.
3) I pointed out that slow disks have low IOPS, so why is this
   conditional?  Sure, more guest exits, but it's still a small number
   for a slow device.
4) The only case where we want merging is on a slow device when the host
   isn't doing it.

Now, despite this, I'm prepared to commit it.  But in my mind it's a
hack: we should aim for use_bio to be based on a feature bit fed from
the host, and use the module parameter only if we want to override it.

Cheers,
Rusty.
