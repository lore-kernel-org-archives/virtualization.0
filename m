From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] virtio-net: correctly enable multiqueue
Date: Tue, 13 Dec 2016 10:39:57 -0500 (EST)
Message-ID: <20161213.103957.237216716208627704.davem__18070.9142391153$1481643613$gmane$org@davemloft.net>
References: <1481610185-12183-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481610185-12183-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, mst@redhat.com, tytso@mit.edu, nhorman@tuxdriver.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Dec 2016 14:23:05 +0800

> Commit 4490001029012539937ff02778fe6180613fa949 ("virtio-net: enable
> multiqueue by default") blindly set the affinity instead of queues
> during probe which can cause a mismatch of #queues between guest and
> host. This patch fixes it by setting queues.
> 
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Tested-by: Theodore Ts'o <tytso@mit.edu>
> Cc: Neil Horman <nhorman@tuxdriver.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 49000102901 ("virtio-net: enable multiqueue by default")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied, thanks Jason.
