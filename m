From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/2] vsock/virtio: make the credit mechanism more
	robust
Date: Fri, 18 Oct 2019 13:20:04 -0400 (EDT)
Message-ID: <20191018.132004.44442251462291428.davem__31869.1911803157$1571419218$gmane$org@davemloft.net>
References: <20191017124403.266242-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191017124403.266242-1-sgarzare@redhat.com>
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
Cc: netdev@vger.kernel.org, stefanha@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Oct 2019 14:44:01 +0200

> This series makes the credit mechanism implemented in the
> virtio-vsock devices more robust.
> Patch 1 sends an update to the remote peer when the buf_alloc
> change.
> Patch 2 prevents a malicious peer (especially the guest) can
> consume all the memory of the other peer, discarding packets
> when the credit available is not respected.

Series applied, thanks.
