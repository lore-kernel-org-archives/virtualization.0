From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost: drop hard-coded num_buffers size
Date: Fri, 27 Feb 2015 15:58:39 -0500 (EST)
Message-ID: <20150227.155839.1663676199560076048.davem__22983.294100459$1425070738$gmane$org@davemloft.net>
References: <1424795457-6770-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1424795457-6770-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 24 Feb 2015 17:31:10 +0100

> The 2 that we use for copy_to_iter comes from sizeof(u16),
> it used to be that way before the iov iter update.
> Fix it up, making it obvious the size of stack access
> is right.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied.
