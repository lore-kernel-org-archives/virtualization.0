From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost: return EINVAL if iovecs size does not match the
	message size
Date: Sat, 15 Dec 2018 11:46:11 -0800 (PST)
Message-ID: <20181215.114611.1702968159223320911.davem__31987.0601677851$1544903066$gmane$org@davemloft.net>
References: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ptikhomirov@virtuozzo.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, khorenko@virtuozzo.com
List-Id: virtualization@lists.linuxfoundation.org

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Date: Thu, 13 Dec 2018 17:53:50 +0300

> We've failed to copy and process vhost_iotlb_msg so let userspace at
> least know about it. For instance before these patch the code below runs
> without any error:
 ...
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Michael, will you be taking this in via your tree?

Thanks.
