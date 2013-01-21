From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 0/3] make mac programming for virtio net more robust
Date: Mon, 21 Jan 2013 14:09:20 -0500 (EST)
Message-ID: <20130121.140920.2221386686285571275.davem__13742.5241446637$1358795390$gmane$org@davemloft.net>
References: <1358767043-24548-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358767043-24548-1-git-send-email-akong@redhat.com>
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

From: Amos Kong <akong@redhat.com>
Date: Mon, 21 Jan 2013 19:17:20 +0800

> Currenly mac is programmed byte by byte. This means that we
> have an intermediate step where mac is wrong. 
> 
> Third patch introduced a new vq control command to set mac
> address, it's atomic.
> 
> V2: check return of sending command, delay eth_mac_addr()
> V3: restore software address when fail to set hardware address
> V4: split eth_mac_addr, fix error handle
> V5: rebase patches to net-next tree

I'll apply this series, thanks.
