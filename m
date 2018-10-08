From: jiangyiwen <jiangyiwen@huawei.com>
Subject: [RFC] VSOCK: About Virtio-vsock support "Multiqueue" feature ?
Date: Mon, 8 Oct 2018 15:06:43 +0800
Message-ID: <5BBB0203.1010400@huawei.com>
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

Now virtio-vsock only supports two vqs(tx and rx), that means
if multiple sockets in the guest will use the same vq to transmit
the message and get the response. In this way, the bandwidth will
be limited to ~700MB/s. So if there are multiple applications in
the guest, we should support "Multiqueue" feature for Virtio-vsock.

I want to know whether we already have plans to support multiqueue
or already have simple demo that can be used. If not, I will try
to implement this feature.

Thanks,
Yiwen.
