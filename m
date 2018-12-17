From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] VSOCK: Send reset control packet when socket is
	partially bound
Date: Mon, 17 Dec 2018 11:15:20 -0800 (PST)
Message-ID: <20181217.111520.2080670078373730186.davem@davemloft.net>
References: <1544607539-52634-1-git-send-email-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1544607539-52634-1-git-send-email-jhansen@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jhansen@vmware.com
Cc: pv-drivers@vmware.com, netdev@vger.kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jorgen Hansen <jhansen@vmware.com>
Date: Wed, 12 Dec 2018 01:38:59 -0800

>  static int vmci_transport_send_reset_bh(struct sockaddr_vm *dst,
> @@ -312,12 +328,29 @@ static int vmci_transport_send_reset_bh(struct sockaddr_vm *dst,
>  static int vmci_transport_send_reset(struct sock *sk,
>  				     struct vmci_transport_packet *pkt)
>  {
> +	struct sockaddr_vm dst;
> +	struct sockaddr_vm *dst_ptr;
> +	struct vsock_sock *vsk;
> +

Please order local variables from longest to shortest line.

Thank you.
