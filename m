From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] vsock: correct removal of socket from the list
Date: Fri, 14 Jun 2019 19:20:38 -0700 (PDT)
Message-ID: <20190614.192038.685198515789181601.davem__44750.4333032825$1560565253$gmane$org@davemloft.net>
References: <MW2PR2101MB11162BBAEC52B232A7B1EFAFC0EF0@MW2PR2101MB1116.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <MW2PR2101MB11162BBAEC52B232A7B1EFAFC0EF0@MW2PR2101MB1116.namprd21.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sunilmut@microsoft.com
Cc: netdev@vger.kernel.org, decui@microsoft.com, kvm@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Sunil Muthuswamy <sunilmut@microsoft.com>
Date: Thu, 13 Jun 2019 03:52:27 +0000

> The current vsock code for removal of socket from the list is both
> subject to race and inefficient. It takes the lock, checks whether
> the socket is in the list, drops the lock and if the socket was on the
> list, deletes it from the list. This is subject to race because as soon
> as the lock is dropped once it is checked for presence, that condition
> cannot be relied upon for any decision. It is also inefficient because
> if the socket is present in the list, it takes the lock twice.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>

Applied.
