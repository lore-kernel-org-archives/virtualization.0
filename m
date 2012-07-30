From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH V3 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 30 Jul 2012 09:31:06 +0200
Message-ID: <5016383A.5090008@redhat.com>
References: <971756309.4742543.1343457753475.JavaMail.root@redhat.com>
	<501610E0.8000504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <501610E0.8000504@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 30/07/2012 06:43, Asias He ha scritto:
>>
> 
> Yes. Something like this:
> 
>   qemu -drive file=foo.img,cache=writeback/unsafe
> 
> is not safe against power losses also?

cache=writeback and cache=none are safe, cache=unsafe isn't.

> I think we can add REQ_FLUSH & REQ_FUA support to bio path and that
> deserves another patch.

You only need to add REQ_FLUSH support.  The virtio-blk protocol does
not support REQ_FUA, because there's no easy way to do it in userspace.

Paolo
