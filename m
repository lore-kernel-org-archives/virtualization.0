From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Revert "vhost: make msg padding explicit"
Date: Wed, 02 May 2018 10:27:43 -0400 (EDT)
Message-ID: <20180502.102743.390991677723394659.davem__5112.82780576057$1525271152$gmane$org@davemloft.net>
References: <1525270740-460646-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1525270740-460646-1-git-send-email-mst@redhat.com>
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
Date: Wed, 2 May 2018 17:19:05 +0300

> This reverts commit 93c0d549c4c5a7382ad70de6b86610b7aae57406.
> 
> Unfortunately the padding will break 32 bit userspace.
> Ouch. Need to add some compat code, revert for now.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks Michael.
