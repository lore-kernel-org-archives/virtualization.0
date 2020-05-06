From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Date: Wed, 6 May 2020 16:19:40 +0800
Message-ID: <7a169b06-b6b9-eac1-f03a-39dd1cfcce57@redhat.com>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506033834-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506033834-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/6 =E4=B8=8B=E5=8D=883:53, Michael S. Tsirkin wrote:
> On Wed, May 06, 2020 at 02:16:32PM +0800, Jason Wang wrote:
>> We tried to reserve space for vnet header before
>> xdp.data_hard_start. But this is useless since the packet could be
>> modified by XDP which may invalidate the information stored in the
>> header and there's no way for XDP to know the existence of the vnet
>> header currently.
> What do you mean? Doesn't XDP_PASS use the header in the buffer?


We don't, see 436c9453a1ac0 ("virtio-net: keep vnet header zeroed after=20
processing XDP")

If there's other place, it should be a bug.


>
>> So let's just not reserve space for vnet header in this case.
> In any case, we can find out XDP does head adjustments
> if we need to.


But XDP program can modify the packets without adjusting headers.

Thanks


>
>
>> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 11f722460513..98dd75b665a5 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -684,8 +684,8 @@ static struct sk_buff *receive_small(struct net_de=
vice *dev,
>>   			page =3D xdp_page;
>>   		}
>>  =20
>> -		xdp.data_hard_start =3D buf + VIRTNET_RX_PAD + vi->hdr_len;
>> -		xdp.data =3D xdp.data_hard_start + xdp_headroom;
>> +		xdp.data_hard_start =3D buf + VIRTNET_RX_PAD;
>> +		xdp.data =3D xdp.data_hard_start + xdp_headroom + vi->hdr_len;
>>   		xdp.data_end =3D xdp.data + len;
>>   		xdp.data_meta =3D xdp.data;
>>   		xdp.rxq =3D &rq->xdp_rxq;
>> @@ -845,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>>   		 * the descriptor on if we get an XDP_TX return code.
>>   		 */
>>   		data =3D page_address(xdp_page) + offset;
>> -		xdp.data_hard_start =3D data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
>> +		xdp.data_hard_start =3D data - VIRTIO_XDP_HEADROOM;
>>   		xdp.data =3D data + vi->hdr_len;
>>   		xdp.data_end =3D xdp.data + (len - vi->hdr_len);
>>   		xdp.data_meta =3D xdp.data;
>> --=20
>> 2.20.1
