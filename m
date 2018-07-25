From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/6] virtio_net: Add ethtool stat items
Date: Wed, 25 Jul 2018 12:59:09 -0700 (PDT)
Message-ID: <20180725.125909.840615930497803596.davem__20823.8874249675$1532548643$gmane$org@davemloft.net>
References: <20180723143609.2242-1-toshiaki.makita1@gmail.com>
	<20180725123908-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180725123908-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, toshiaki.makita1@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 25 Jul 2018 12:40:12 +0300

> On Mon, Jul 23, 2018 at 11:36:03PM +0900, Toshiaki Makita wrote:
>> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> 
>> Add some ethtool stat items useful for performance analysis.
>> 
>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> 
> Series:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Series applied.

> Patch 1 seems appropriate for stable, even though it's minor.

Ok, I'll put patch #1 also into 'net' and queue it up for -stable.

Thanks.
