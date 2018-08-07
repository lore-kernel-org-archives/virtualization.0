From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: allow to call netif_reset_xps_queues()
	under cpu_read_lock
Date: Tue, 07 Aug 2018 13:15:06 -0700 (PDT)
Message-ID: <20180807.131506.1417943889767040945.davem__15465.7245068394$1533672785$gmane$org@davemloft.net>
References: <20180807041454.18315-1-avagin@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180807041454.18315-1-avagin@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: avagin@openvz.org
Cc: amritha.nambiar@intel.com, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, avagin@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Andrei Vagin <avagin@openvz.org>
Date: Mon,  6 Aug 2018 21:14:54 -0700

> This patch adds an ability to call __netif_set_xps_queue under
> cpu_read_lock().

Please don't add conditional locking using a boolean argument.

Simply wrap calls to __netif_set_xps_queue() with cpu read
lock held by the caller or similar.
