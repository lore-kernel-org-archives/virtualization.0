From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] Revert "Merge branch 'vsock-virtio'"
Date: Tue, 08 Dec 2015 21:58:03 -0500 (EST)
Message-ID: <20151208.215803.235838081070973876.davem__31828.098165761$1449629903$gmane$org@davemloft.net>
References: <1449629472-26286-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449629472-26286-1-git-send-email-stefanha@redhat.com>
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
Cc: arnd@arndb.de, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mbenjamin@redhat.com, christoffer.dall@linaro.org, matt.ma@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  9 Dec 2015 10:51:12 +0800

> This reverts commit 0d76d6e8b2507983a2cae4c09880798079007421 and merge
> commit c402293bd76fbc93e52ef8c0947ab81eea3ae019, reversing changes made
> to c89359a42e2a49656451569c382eed63e781153c.
> 
> The virtio-vsock device specification is not finalized yet.  Michael
> Tsirkin voiced concerned about merging this code when the hardware
> interface (and possibly the userspace interface) could still change.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Revert merge commit and coccinelle fixup in a single patch

Applied, th anks.
