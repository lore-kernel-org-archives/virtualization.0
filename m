From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3] vsock/virtio: free packets during the socket release
Date: Fri, 17 May 2019 11:47:20 -0700 (PDT)
Message-ID: <20190517.114720.1616258447183708235.davem__15251.0293106147$1558118855$gmane$org@davemloft.net>
References: <20190517144543.362935-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190517144543.362935-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 17 May 2019 16:45:43 +0200

> When the socket is released, we should free all packets
> queued in the per-socket list in order to avoid a memory
> leak.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Applied and queued up for -stable.
