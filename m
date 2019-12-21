From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v3 00/11] VSOCK: add vsock_test test suite
Date: Fri, 20 Dec 2019 21:10:08 -0800 (PST)
Message-ID: <20191220.211008.1078307833860411304.davem__7474.5621228189$1576905026$gmane$org@davemloft.net>
References: <20191218180708.120337-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191218180708.120337-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, decui@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, jhansen@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 18 Dec 2019 19:06:57 +0100

> The vsock_diag.ko module already has a test suite but the core AF_VSOCK
> functionality has no tests. This patch series adds several test cases that
> exercise AF_VSOCK SOCK_STREAM socket semantics (send/recv, connect/accept,
> half-closed connections, simultaneous connections).
> 
> The v1 of this series was originally sent by Stefan.
> 
> v3:
> - Patch 6:
>   * check the byte received in the recv_byte()
>   * use send(2)/recv(2) instead of write(2)/read(2) to test also flags
>     (e.g. MSG_PEEK)
> - Patch 8:
>   * removed unnecessary control_expectln("CLOSED") [Stefan].
> - removed patches 9,10,11 added in the v2
> - new Patch 9 add parameters to list and skip tests (e.g. useful for vmci
>   that doesn't support half-closed socket in the host)
> - new Patch 10 prints a list of options in the help
> - new Patch 11 tests MSG_PEEK flags of recv(2)
> 
> v2: https://patchwork.ozlabs.org/cover/1140538/
> v1: https://patchwork.ozlabs.org/cover/847998/

Series applied, thanks.
