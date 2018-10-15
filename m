From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [RFC] VSOCK: The performance problem of vhost_vsock.
Date: Mon, 15 Oct 2018 09:43:48 +0800
Message-ID: <5BC3F0D4.60409__41928.982086438$1539567714$gmane$org@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stefanha@redhat.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Stefan & All:

Now I find vhost-vsock has two performance problems even if it
is not designed for performance.

First, I think vhost-vsock should faster than vhost-net because it
is no TCP/IP stack, but the real test result vhost-net is 5~10
times than vhost-vsock, currently I am looking for the reason.

Second, vhost-vsock only supports two vqs(tx and rx), that means
if multiple sockets in the guest will use the same vq to transmit
the message and get the response. So if there are multiple applications
in the guest, we should support "Multiqueue" feature for Virtio-vsock.

Stefan, have you encountered these problems?

Thanks,
Yiwen.
