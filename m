From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: Re: [PATCH vhost] vhost_net: Fix too many vring kick on busypoll
Date: Mon, 2 Jul 2018 11:59:42 +0900
Message-ID: <09967fa3-1efe-23c2-67a7-3ce9ee9705e5@lab.ntt.co.jp>
References: <1530259790-2414-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<20180629193448-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180629193448-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2018/06/30 1:38, Michael S. Tsirkin wrote:
...
>> Performance numbers:
>>
>> - Bulk transfer from guest to external physical server.
>>     [Guest]->vhost_net->tap--(XDP_REDIRECT)-->i40e --(wire)--> [Server]
>> - Set 10us busypoll.
>> - Guest disables checksum and TSO because of host XDP.
>> - Measured single flow Mbps by netperf, and kicks by perf kvm stat
>>   (EPT_MISCONFIG event).
>>
>>                             Before              After
>>                           Mbps  kicks/s      Mbps  kicks/s
>> UDP_STREAM 1472byte              247758                 27
>>                 Send   3645.37            6958.10
>>                 Recv   3588.56            6958.10
>>               1byte                9865                 37
>>                 Send      4.34               5.43
>>                 Recv      4.17               5.26
>> TCP_STREAM             8801.03    45794   9592.77     2884
>>
>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> 
> Is this with busy poll enabled?

Yes, as I wrote "Set 10us busypoll" above.

> Are there CPU utilization #s?

I used one cpu for one vcpu and one cpu for one vhost.
Each host cpu for vcpu/vhost was like this:

- Before
 vcpu cpu : %guest 70 %sys 30
 vhost cpu: %sys 100

- After
 vcpu cpu : %guest 100
 vhost cpu: %sys 100

I think %sys before patch was caused by vring kick.

-- 
Toshiaki Makita
