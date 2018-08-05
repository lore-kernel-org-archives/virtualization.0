From: Tariq Toukan <tariqt@mellanox.com>
Subject: Re: [PATCH net-next 0/6] virtio_net: Add ethtool stat items
Date: Sun, 5 Aug 2018 17:22:57 +0300
Message-ID: <1873b07d-95e7-8b67-0371-f2f4b4bdd55f@mellanox.com>
References: <20180723143609.2242-1-toshiaki.makita1@gmail.com>
	<20180725123908-mutt-send-email-mst@kernel.org>
	<20180725.125909.840615930497803596.davem@davemloft.net>
	<eacdf80a-87cd-ce8d-b56a-c49432948773@mellanox.com>
	<8a21b956-af42-3598-b752-d1e3fa9e63d3@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8a21b956-af42-3598-b752-d1e3fa9e63d3@mellanox.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>, mst@redhat.com, toshiaki.makita1@gmail.com, makita.toshiaki@lab.ntt.co.jp
Cc: ranro@mellanox.com, netdev@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>, virtualization@lists.linux-foundation.org, Maor Gottlieb <maorg@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org



On 05/08/2018 4:45 PM, Tariq Toukan wrote:
> 
> 
> On 05/08/2018 4:15 PM, Tariq Toukan wrote:
>>
>>
>> On 25/07/2018 10:59 PM, David Miller wrote:
>>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>> Date: Wed, 25 Jul 2018 12:40:12 +0300
>>>
>>>> On Mon, Jul 23, 2018 at 11:36:03PM +0900, Toshiaki Makita wrote:
>>>>> From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>>>>
>>>>> Add some ethtool stat items useful for performance analysis.
>>>>>
>>>>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>>>>
>>>> Series:
>>>>
>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> Series applied.
>>>
>>>> Patch 1 seems appropriate for stable, even though it's minor.
>>>
>>> Ok, I'll put patch #1 also into 'net' and queue it up for -stable.
>>>
>>> Thanks.
>>>
>>
>> Hi,
>> Our verification team encountered the following degradation, 
>> introduced by this series. Please check KASAN bug report below.
>>
>> We tested before and after the series, but didn't bisect within it. We 
>> can do if necessary.
>>
>> Thanks,
>> Tariq
>>
> 
> I see this might already be fixed, here:
> https://marc.info/?l=linux-netdev&m=153335713407532&w=2
> 
> Verifying...
> 

No repro when applying this fix.

Thanks,
Tariq
