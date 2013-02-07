From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/8] virtio: new API for addition of buffers,
	scatterlist changes
Date: Thu, 07 Feb 2013 14:30:54 +0100
Message-ID: <5113AC8E.5030508@redhat.com>
References: <1360239752-2470-1-git-send-email-pbonzini@redhat.com>
	<20130207130912.GA20875@redhat.com> <5113A8B0.5080104@redhat.com>
	<20130207132349.GA21707@redhat.com> <5113AA35.3010209@redhat.com>
	<20130207133133.GC21707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130207133133.GC21707@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 07/02/2013 14:31, Michael S. Tsirkin ha scritto:
> > Single means *this piece* (for example a request header) is single.  It
> > could still end up in an indirect buffer because QEMU does not support
> > mixed direct/indirect buffers.
> 
> Yes but why is the optimization worth it?
> It makes sense if all we want to do is add a single buffer
> in one go, this would give us virtqueue_add_buf_single.
> 
> But if we are building up an s/g list anyway,
> speeding up one of the entries a tiny bit
> seems very unlikely to be measureable.
> No?

There is some optimization potential even in unrolling the loop, but
yes, it looks like I misunderstood.  I'll add virtqueue_add_buf_single
instead.

Paolo
