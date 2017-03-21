From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH-v5 0/4] vsock: cancel connect packets when failing to
	connect
Date: Tue, 21 Mar 2017 14:42:00 -0700 (PDT)
Message-ID: <20170321.144200.728688553537467782.davem__4027.63323295421$1490132538$gmane$org@davemloft.net>
References: <1489541537-130429-1-git-send-email-bergwolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1489541537-130429-1-git-send-email-bergwolf@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: bergwolf@gmail.com
Cc: netdev@vger.kernel.org, jhansen@vmware.com, stefanha@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Peng Tao <bergwolf@gmail.com>
Date: Wed, 15 Mar 2017 09:32:13 +0800

> Currently, if a connect call fails on a signal or timeout (e.g., guest is still
> in the process of starting up), we'll just return to caller and leave the connect
> packet queued and they are sent even though the connection is considered a failure,
> which can confuse applications with unwanted false connect attempt.
> 
> The patchset enables vsock (both host and guest) to cancel queued packets when
> a connect attempt is considered to fail.
> 
> v5 changelog:
>   - change virtio_vsock_pkt->cancel_token back to virtio_vsock_pkt->vsk
> v4 changelog:
>   - drop two unnecessary void * cast
>   - update new callback comment
> v3 changelog:
>   - define cancel_pkt callback in struct vsock_transport rather than struct virtio_transport
>   - rename virtio_vsock_pkt->vsk to virtio_vsock_pkt->cancel_token
> v2 changelog:
>   - fix queued_replies counting and resume tx/rx when necessary

Series applied, thanks.
