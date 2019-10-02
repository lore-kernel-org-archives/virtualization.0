From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net v3] vsock: Fix a lockdep warning in __vsock_release()
Date: Tue, 01 Oct 2019 21:23:55 -0400 (EDT)
Message-ID: <20191001.212355.540884408544073853.davem__8560.04127287946$1569979448$gmane$org@davemloft.net>
References: <1569868998-56603-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1569868998-56603-1-git-send-email-decui@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: decui@microsoft.com
Cc: sashal@kernel.org, linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, kvm@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, haiyangz@microsoft.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, sgarzare@redhat.com, deepa.kernel@gmail.com, stefanha@redhat.com, netdev@vger.kernel.org, tglx@linutronix.de, ytht.net@gmail.com, jhansen@vmware.com, mikelley@microsoft.com
List-Id: virtualization@lists.linuxfoundation.org

From: Dexuan Cui <decui@microsoft.com>
Date: Mon, 30 Sep 2019 18:43:50 +0000

> Lockdep is unhappy if two locks from the same class are held.
> 
> Fix the below warning for hyperv and virtio sockets (vmci socket code
> doesn't have the issue) by using lock_sock_nested() when __vsock_release()
> is called recursively:
 ...
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied, thanks.
