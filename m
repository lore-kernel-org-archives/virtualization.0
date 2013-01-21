From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 2/3] net: split eth_mac_addr for better error handling
Date: Sun, 20 Jan 2013 23:14:32 -0500 (EST)
Message-ID: <20130120.231432.1625470984232658368.davem__13599.0144372501$1358741700$gmane$org@davemloft.net>
References: <1358649789-2338-1-git-send-email-akong@redhat.com>
	<1358649789-2338-3-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358649789-2338-3-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: akong@redhat.com
Date: Sun, 20 Jan 2013 10:43:08 +0800

> From: Stefan Hajnoczi <stefanha@gmail.com>
> 
> When we set mac address, software mac address in system and hardware mac
> address all need to be updated. Current eth_mac_addr() doesn't allow
> callers to implement error handling nicely.
> 
> This patch split eth_mac_addr() to prepare part and real commit part,
> then we can prepare first, and try to change hardware address, then do
> the real commit if hardware address is set successfully.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Amos Kong <akong@redhat.com>

This patch doesn't apply to net-next.
