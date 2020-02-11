From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: Work around frames incorrectly marked as gso
Date: Tue, 11 Feb 2020 10:51:54 +0800
Message-ID: <f78bfe6e-2ffc-3734-9618-470f1afea0c6@redhat.com>
References: <20191209104824.17059-1-anton.ivanov@cambridgegreys.com>
 <57230228-7030-c65f-a24f-910ca52bbe9e@cambridgegreys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <57230228-7030-c65f-a24f-910ca52bbe9e@cambridgegreys.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, netdev@vger.kernel.org
Cc: linux-um@lists.infradead.org, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/11 =E4=B8=8A=E5=8D=8812:55, Anton Ivanov wrote:
>
>
> On 09/12/2019 10:48, anton.ivanov@cambridgegreys.com wrote:
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> Some of the frames marked as GSO which arrive at
>> virtio_net_hdr_from_skb() have no GSO_TYPE, no
>> fragments (data_len =3D 0) and length significantly shorter
>> than the MTU (752 in my experiments).
>>
>> This is observed on raw sockets reading off vEth interfaces
>> in all 4.x and 5.x kernels I tested.
>>
>> These frames are reported as invalid while they are in fact
>> gso-less frames.
>>
>> This patch marks the vnet header as no-GSO for them instead
>> of reporting it as invalid.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>> =C2=A0 include/linux/virtio_net.h | 8 ++++++--
>> =C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
>> index 0d1fe9297ac6..d90d5cff1b9a 100644
>> --- a/include/linux/virtio_net.h
>> +++ b/include/linux/virtio_net.h
>> @@ -112,8 +112,12 @@ static inline int virtio_net_hdr_from_skb(const=20
>> struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (sinfo-=
>gso_type & SKB_GSO_TCPV6)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (skb->data_len =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 hdr->gso_type =3D VIRTIO_NET_HDR_GSO_NONE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 el=
se
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sinfo->gso_=
type & SKB_GSO_TCP_ECN)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else
>>
>
> ping.
>

Do you mean gso_size is set but gso_type is not? Looks like a bug elsewhe=
re.

Thanks
