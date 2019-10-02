From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2] vsock/virtio: add support for MSG_PEEK
Date: Tue, 01 Oct 2019 21:27:28 -0400 (EDT)
Message-ID: <20191001.212728.1087995517897062240.davem__46623.4420122177$1569979662$gmane$org@davemloft.net>
References: <1569867923-28200-1-git-send-email-matiasevara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1569867923-28200-1-git-send-email-matiasevara@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: matiasevara@gmail.com
Cc: eric.dumazet@gmail.com, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, sgarzare@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
Date: Mon, 30 Sep 2019 18:25:23 +0000

> This patch adds support for MSG_PEEK. In such a case, packets are not
> removed from the rx_queue and credit updates are not sent.
> 
> Signed-off-by: Matias Ezequiel Vara Larsen <matiasevara@gmail.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Applied.
