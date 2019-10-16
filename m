From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vsock/virtio: remove unused 'work' field from 'struct
	virtio_vsock_pkt'
Date: Tue, 15 Oct 2019 20:55:18 -0700 (PDT)
Message-ID: <20191015.205518.153556911541594688.davem__10153.2122165494$1571198134$gmane$org@davemloft.net>
References: <20191015150051.104631-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191015150051.104631-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sgarzare@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 15 Oct 2019 17:00:51 +0200

> The 'work' field was introduced with commit 06a8fc78367d0
> ("VSOCK: Introduce virtio_vsock_common.ko")
> but it is never used in the code, so we can remove it to save
> memory allocated in the per-packet 'struct virtio_vsock_pkt'
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Michael, will you take this?  I assume so...

Thanks.
