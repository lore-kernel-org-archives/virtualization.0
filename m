From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH v2 0/5] VSOCK: support mergeable rx buffer in vhost-vsock
Date: Fri, 14 Dec 2018 17:39:29 +0800
Message-ID: <5C137A51.20505__37907.8087317341$1544780254$gmane$org@huawei.com>
References: <5C10D41E.9050002@huawei.com>
	<20181213163409.GP23318@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181213163409.GP23318@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2018/12/14 0:34, Stefan Hajnoczi wrote:
> On Wed, Dec 12, 2018 at 05:25:50PM +0800, jiangyiwen wrote:
>> Now vsock only support send/receive small packet, it can't achieve
>> high performance. As previous discussed with Jason Wang, I revisit the
>> idea of vhost-net about mergeable rx buffer and implement the mergeable
>> rx buffer in vhost-vsock, it can allow big packet to be scattered in
>> into different buffers and improve performance obviously.
> 
> Sorry, I've been a bad maintainer.  I was focussed on other projects and
> my email backlog is huge.
> 
> I like the idea of trying out optimizations on virtio-vsock, seeing if
> code can be shared with virtio-net, and maybe later switching to a
> virtio-net transport for vsock (if it turns out enough code can be
> shared).
> 
> Another optimization that could be interesting:
> 
> Userspace processes reading from a socket sleep in
> vsock_stream_recvmsg().  I wonder if we can bypass struct
> virtio_vsock_pkt and copying the payload into pkt->buf in this case.
> (This doesn't improve poll(2)/select(2) though!)
> 
> Imagine a userspace process waiting for data on a socket.  When the
> virtqueue becomes ready, we can read in struct virtio_vsock_hdr and find
> the socket for that connection.  Then we could copy the payload directly
> to userspace instead of creating a virtio_vsock_pkt and copying to
> pkt->buf first.
> 

Great, I also consider the optimization point later.
Then, I will send the next version based on your suggestions.

Thanks,
Yiwen.
