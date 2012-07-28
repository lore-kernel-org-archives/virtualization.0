From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V3 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Sat, 28 Jul 2012 10:38:41 +0800
Message-ID: <501350B1.7080908@redhat.com>
References: <1342168731-11797-1-git-send-email-asias@redhat.com>
	<1342168731-11797-4-git-send-email-asias@redhat.com>
	<87d33initv.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d33initv.fsf@rustcorp.com.au>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On 07/27/2012 08:33 AM, Rusty Russell wrote:
> On Fri, 13 Jul 2012 16:38:51 +0800, Asias He <asias@redhat.com> wrote:
>> Add 'virtio_blk.use_bio=1' to kernel cmdline or 'modprobe virtio_blk
>> use_bio=1' to enable ->make_request_fn() based I/O path.
>
> This patch conflicts with Paolo's Bonzini's 'virtio-blk: allow toggling
> host cache between writeback and writethrough' which is also queued (see
> linux-next).

Rebased against Paolo's patch in V4.

> I'm not sure what the correct behavior for bio & cacheflush is, if any.

REQ_FLUSH is not supported in the bio path.

> But as to the patch itself: it's a hack.
>
> 1) Leaving the guest's admin to turn on the switch is a terrible choice.
> 2) The block layer should stop merging and sorting when a device is
>     fast, not the driver.
> 3) I pointed out that slow disks have low IOPS, so why is this
>     conditional?  Sure, more guest exits, but it's still a small number
>     for a slow device.
> 4) The only case where we want merging is on a slow device when the host
>     isn't doing it.
>
> Now, despite this, I'm prepared to commit it.  But in my mind it's a
> hack: we should aim for use_bio to be based on a feature bit fed from
> the host, and use the module parameter only if we want to override it.

OK. A feature bit from host sound like a choice but a switch is also 
needed on host side. And for other OS, e.g. Windows, the bio thing does 
not apply at all.

Anyway, I have to admit that adding a module parameter here is not the 
best choice. Let's think more.

-- 
Asias
