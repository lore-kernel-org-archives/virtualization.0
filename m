From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost_net: validate sock before trying to put its fd
Date: Sat, 23 Jun 2018 10:24:35 +0900 (KST)
Message-ID: <20180623.102435.440104910657366197.davem@davemloft.net>
References: <1529557891-4828-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1529557891-4828-1-git-send-email-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dan.carpenter@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Jun 2018 13:11:31 +0800

> Sock will be NULL if we pass -1 to vhost_net_set_backend(), but when
> we meet errors during ubuf allocation, the code does not check for
> NULL before calling sockfd_put(), this will lead NULL
> dereferencing. Fixing by checking sock pointer before.
> 
> Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
