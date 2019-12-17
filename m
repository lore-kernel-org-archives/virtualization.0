From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/2] vsock/virtio: fix null-pointer dereference and
 related precautions
Date: Mon, 16 Dec 2019 16:07:35 -0800 (PST)
Message-ID: <20191216.160735.2178914413882940281.davem__16927.7917755366$1576541273$gmane$org@davemloft.net>
References: <20191213184801.486675-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191213184801.486675-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org, stefanha@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 13 Dec 2019 19:47:59 +0100

> This series mainly solves a possible null-pointer dereference in
> virtio_transport_recv_listen() introduced with the multi-transport
> support [PATCH 1].
> 
> PATCH 2 adds a WARN_ON check for the same potential issue
> and a returned error in the virtio_transport_send_pkt_info() function
> to avoid crashing the kernel.

Series applied, thanks.
