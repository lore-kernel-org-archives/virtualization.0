From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH 13/22] virtio_net: use virtqueue_add_sgs[] for command
	buffers.
Date: Tue, 19 Mar 2013 08:00:46 +0800
Message-ID: <5147AAAE.7030309@cn.fujitsu.com>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
	<1363599293-23065-14-git-send-email-rusty@rustcorp.com.au>
	<20130318111024.GA7595@redhat.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130318111024.GA7595@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 03/18/2013 07:10 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 18, 2013 at 08:04:44PM +1030, Rusty Russell wrote:
>> It's a bit cleaner to hand multiple sgs, rather than one big one.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>> ---
>>  drivers/net/virtio_net.c |   50 +++++++++++++++++++++++-----------------------
>>  1 file changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 57ac4b0..f19865a 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -39,7 +39,6 @@ module_param(gso, bool, 0444);
>>  #define MAX_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
>>  #define GOOD_COPY_LEN	128
>>  
>> -#define VIRTNET_SEND_COMMAND_SG_MAX    2
>>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>>  
>>  struct virtnet_stats {
>> @@ -767,32 +766,34 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>   * never fail unless improperly formated.
>>   */
>>  static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>> -				 struct scatterlist *data, int out, int in)
>> +				 struct scatterlist *out,
>> +				 struct scatterlist *in)
>>  {
>> -	struct scatterlist *s, sg[VIRTNET_SEND_COMMAND_SG_MAX + 2];
>> +	struct scatterlist *sgs[4], hdr, stat;
>>  	struct virtio_net_ctrl_hdr ctrl;
>>  	virtio_net_ctrl_ack status = ~0;
>> -	unsigned int tmp;
>> -	int i;
>> +	unsigned out_num = 0, in_num = 0, tmp;
>>  
>>  	/* Caller should know better */
>> -	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ) ||
>> -		(out + in > VIRTNET_SEND_COMMAND_SG_MAX));
>> -
>> -	out++; /* Add header */
>> -	in++; /* Add return status */
>> +	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
>>  
>>  	ctrl.class = class;
>>  	ctrl.cmd = cmd;
>> +	/* Add header */
>> +	sg_init_one(&hdr, &ctrl, sizeof(ctrl));
>> +	sgs[out_num++] = &hdr;
>>  
>> -	sg_init_table(sg, out + in);
>> +	if (out)
>> +		sgs[out_num++] = out;
>> +	if (in)
>> +		sgs[out_num + in_num++] = in;
>>  
>> -	sg_set_buf(&sg[0], &ctrl, sizeof(ctrl));
>> -	for_each_sg(data, s, out + in - 2, i)
>> -		sg_set_buf(&sg[i + 1], sg_virt(s), s->length);
>> -	sg_set_buf(&sg[out + in - 1], &status, sizeof(status));
>> +	/* Add return status. */
>> +	sg_init_one(&stat, &status, sizeof(status));
>> +	sgs[out_num + in_num++] = &hdr;
> 
> Should be &stat?

Good catch!!!
This is why I met the error message here:

[    9.914123] net eth0: Failed to disable promisc mode.
[    9.914958] net eth0: Failed to disable allmulti mode.
[    9.915778] net eth0: Failed to set MAC fitler table.
[    9.916564] net eth0: Failed to disable promisc mode.
[    9.917322] net eth0: Failed to disable allmulti mode.
[    9.918095] net eth0: Failed to set MAC fitler table.
[    9.918876] net eth0: Failed to disable promisc mode.
[    9.919636] net eth0: Failed to disable allmulti mode.
[    9.920403] net eth0: Failed to set MAC fitler table.
[    9.921183] net eth0: Failed to disable promisc mode.
[    9.921921] net eth0: Failed to disable allmulti mode.
[    9.922680] net eth0: Failed to set MAC fitler table.
[   11.943884] net eth0: Failed to disable promisc mode.
[   11.945460] net eth0: Failed to disable allmulti mode.
[   11.946987] net eth0: Failed to set MAC fitler table.
network[503]: Bringing up interface eth0:  [  OK  ]
[   12.242277] net eth0: Failed to disable promisc mode.
[   12.243081] net eth0: Failed to disable allmulti mode.
[   12.243824] net eth0: Failed to set MAC fitler table.


With &stat now, it has gone.

Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


Regards,
Wanlong Gao

> 
> Also
> 	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs))
> probably a good idea?
> 
>>  
>> -	BUG_ON(virtqueue_add_buf(vi->cvq, sg, out, in, vi, GFP_ATOMIC) < 0);
>> +	BUG_ON(virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC)
>> +	       < 0);
>>  
>>  	virtqueue_kick(vi->cvq);
>>  
>> @@ -821,7 +822,7 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
>>  		sg_init_one(&sg, addr->sa_data, dev->addr_len);
>>  		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
>>  					  VIRTIO_NET_CTRL_MAC_ADDR_SET,
>> -					  &sg, 1, 0)) {
>> +					  &sg, NULL)) {
>>  			dev_warn(&vdev->dev,
>>  				 "Failed to set mac address by vq command.\n");
>>  			return -EINVAL;
>> @@ -889,8 +890,7 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
>>  {
>>  	rtnl_lock();
>>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
>> -				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL,
>> -				  0, 0))
>> +				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL, NULL))
>>  		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
>>  	rtnl_unlock();
>>  }
>> @@ -908,7 +908,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>  	sg_init_one(&sg, &s, sizeof(s));
>>  
>>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>> -				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg, 1, 0)){
>> +				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg, NULL)) {
>>  		dev_warn(&dev->dev, "Fail to set num of queue pairs to %d\n",
>>  			 queue_pairs);
>>  		return -EINVAL;
>> @@ -955,7 +955,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>  
>>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>>  				  VIRTIO_NET_CTRL_RX_PROMISC,
>> -				  sg, 1, 0))
>> +				  sg, NULL))
>>  		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
>>  			 promisc ? "en" : "dis");
>>  
>> @@ -963,7 +963,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>  
>>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
>>  				  VIRTIO_NET_CTRL_RX_ALLMULTI,
>> -				  sg, 1, 0))
>> +				  sg, NULL))
>>  		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
>>  			 allmulti ? "en" : "dis");
>>  
>> @@ -1000,7 +1000,7 @@ static void virtnet_set_rx_mode(struct net_device *dev)
>>  
>>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
>>  				  VIRTIO_NET_CTRL_MAC_TABLE_SET,
>> -				  sg, 2, 0))
>> +				  sg, NULL))
>>  		dev_warn(&dev->dev, "Failed to set MAC fitler table.\n");
>>  
>>  	kfree(buf);
>> @@ -1014,7 +1014,7 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev, u16 vid)
>>  	sg_init_one(&sg, &vid, sizeof(vid));
>>  
>>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
>> -				  VIRTIO_NET_CTRL_VLAN_ADD, &sg, 1, 0))
>> +				  VIRTIO_NET_CTRL_VLAN_ADD, &sg, NULL))
>>  		dev_warn(&dev->dev, "Failed to add VLAN ID %d.\n", vid);
>>  	return 0;
>>  }
>> @@ -1027,7 +1027,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev, u16 vid)
>>  	sg_init_one(&sg, &vid, sizeof(vid));
>>  
>>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
>> -				  VIRTIO_NET_CTRL_VLAN_DEL, &sg, 1, 0))
>> +				  VIRTIO_NET_CTRL_VLAN_DEL, &sg, NULL))
>>  		dev_warn(&dev->dev, "Failed to kill VLAN ID %d.\n", vid);
>>  	return 0;
>>  }
>> -- 
>> 1.7.10.4
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
