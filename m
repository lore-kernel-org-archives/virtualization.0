From: Vlad Yasevich <vyasevic@redhat.com>
Subject: Re: [PATCH V2 net-next 4/6] tun: Add support for SCTP checksum offload
Date: Wed, 2 May 2018 13:17:50 -0400
Message-ID: <5e968e6d-4dbf-cfef-a270-99b0d1dd4ea8__30821.4168450379$1525281355$gmane$org@redhat.com>
References: <20180502020739.19239-1-vyasevic@redhat.com>
	<20180502020739.19239-5-vyasevic@redhat.com>
	<20180502145347.GG5105@localhost.localdomain>
	<20180502145607.GH5105@localhost.localdomain>
Reply-To: vyasevic@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180502145607.GH5105@localhost.localdomain>
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
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Vladislav Yasevich <vyasevich@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, nhorman@tuxdriver.com, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sctp@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/02/2018 10:56 AM, Marcelo Ricardo Leitner wrote:
> On Wed, May 02, 2018 at 11:53:47AM -0300, Marcelo Ricardo Leitner wrote:
>> On Tue, May 01, 2018 at 10:07:37PM -0400, Vladislav Yasevich wrote:
>>> Adds a new tun offload flag to allow for SCTP checksum offload.
>>> The flag has to be set by the user and defaults to "no offload".
>>
>> I'm confused here:
>>
>>> +++ b/drivers/net/tun.c
>>> @@ -216,7 +216,7 @@ struct tun_struct {
>>>  	struct net_device	*dev;
>>>  	netdev_features_t	set_features;
>>>  #define TUN_USER_FEATURES (NETIF_F_HW_CSUM|NETIF_F_TSO_ECN|NETIF_F_TSO| \
>>> -			  NETIF_F_TSO6)
>>> +			  NETIF_F_TSO6|NETIF_F_SCTP_CRC)
>>
>> Doesn't adding it here mean it defaults to "offload", instead?
>>
>> later on, it does:
>>                 dev->hw_features = NETIF_F_SG | NETIF_F_FRAGLIST |
>>                                    TUN_USER_FEATURES | NETIF_F_HW_VLAN_CTAG_TX |
>>                                    NETIF_F_HW_VLAN_STAG_TX;
> 
> Missed to paste the next line too:
>                 dev->features = dev->hw_features | NETIF_F_LLTX;
> 

Yes, as a software device, we can default it to on.  However, qemu will 0-out
the features and then set them up based on the guest (just like regular checksum).

-vlad
