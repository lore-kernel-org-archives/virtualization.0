From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 13/22] virtio_net: use virtqueue_add_sgs[] for command
	buffers.
Date: Tue, 19 Mar 2013 10:17:02 +1030
Message-ID: <87r4jcqnih.fsf@rustcorp.com.au>
References: <1363599293-23065-1-git-send-email-rusty@rustcorp.com.au>
	<1363599293-23065-14-git-send-email-rusty@rustcorp.com.au>
	<20130318111024.GA7595@redhat.com>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:
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
>
> Also
> 	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs))
> probably a good idea?

Thanks, did both.

Cheers,
Rusty.
