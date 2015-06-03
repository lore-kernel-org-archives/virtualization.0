From: Linhaifeng <haifeng.lin@huawei.com>
Subject: virtio-net: why not always to set avail->flags to
	VRING_AVAIL_F_NO_INTERRUPT
Date: Wed, 3 Jun 2015 14:32:39 +0800
Message-ID: <556E9F87.7030202__29868.7292299748$1433346042$gmane$org@huawei.com>
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
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I'm a newbie and have a question about vring_new_virtqueue function.

Why we set avail->flags to VRING_AVAIL_F_NO_INTERRUPT when no callbacks?
I think we should set avail->flags to VRING_AVAIL_F_NO_INTERRUPT even if no callbacks.
