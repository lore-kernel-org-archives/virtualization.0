From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2] vhost: correctly check the return value of
	translate_desc() in log_used()
Date: Tue, 19 Feb 2019 13:16:09 -0800 (PST)
Message-ID: <20190219.131609.2179516387888671292.davem__38081.4356425375$1550611092$gmane$org@davemloft.net>
References: <20190219065344.24923-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190219065344.24923-1-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Feb 2019 14:53:44 +0800

> When fail, translate_desc() returns negative value, otherwise the
> number of iovs. So we should fail when the return value is negative
> instead of a blindly check against zero.
> 
> Detected by CoverityScan, CID# 1442593:  Control flow issues  (DEADCODE)
> 
> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks.
