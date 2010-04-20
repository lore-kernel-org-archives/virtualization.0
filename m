From: Paul Brook <paul@codesourcery.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-spec: document block CMD and FLUSH
Date: Tue, 20 Apr 2010 14:22:58 +0100
Message-ID: <201004201422.58456.paul__3859.61751821942$1271769842$gmane$org@codesourcery.com>
References: <20100218222220.GA14847@redhat.com>
	<20100420014635.GE21899@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100420014635.GE21899@shareable.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jamie Lokier <jamie@shareable.org>, virtualization@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

> Does this mean that virtio-blk supports all three combinations?
> 
>    1. FLUSH that isn't a barrier
>    2. FLUSH that is also a barrier
>    3. Barrier that is not a flush
> 
> 1 is good for fsync-like operations;
> 2 is good for journalling-like ordered operations.
> 3 sounds like it doesn't mean a lot as the host cache provides no
> guarantees and has no ordering facility that can be used.

(3) allows the guest to queue overlapping transfers with well defined results.
I have no idea how useful this is in practice, but it's certainly plausible.

Paul
