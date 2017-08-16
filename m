From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/4] various sizeof cleanups
Date: Wed, 16 Aug 2017 11:02:12 -0700 (PDT)
Message-ID: <20170816.110212.1356690082964267932.davem__39585.4010167115$1502906538$gmane$org@davemloft.net>
References: <20170815172919.26153-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170815172919.26153-1-sthemmin@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: stephen@networkplumber.org
Cc: sthemmin@microsoft.com, mst@redhat.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mlindner@marvell.com
List-Id: virtualization@lists.linuxfoundation.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 15 Aug 2017 10:29:15 -0700

> Noticed some places that were using sizeof as an operator.
> This is legal C but is not the convention used in the kernel.

Series applied, thanks.
