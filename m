From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 0/6] vsock: add local transport support
Date: Wed, 11 Dec 2019 15:01:39 -0800 (PST)
Message-ID: <20191211.150139.57434044982727807.davem__36676.510381379$1576105319$gmane$org@davemloft.net>
References: <20191210104307.89346-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191210104307.89346-1-sgarzare@redhat.com>
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
Date: Tue, 10 Dec 2019 11:43:01 +0100

> v2:
>  - style fixes [Dave]
>  - removed RCU sync and changed 'the_vsock_loopback' in a global
>    static variable [Stefan]
>  - use G2H transport when local transport is not loaded and remote cid
>    is VMADDR_CID_LOCAL [Stefan]
>  - rebased on net-next
> 
> v1: https://patchwork.kernel.org/cover/11251735/
> 
> This series introduces a new transport (vsock_loopback) to handle
> local communication.
...

Series applied, thanks.
