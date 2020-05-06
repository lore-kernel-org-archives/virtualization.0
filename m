From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: fix the XDP truesize calculation
 for mergeable buffers
Date: Wed, 6 May 2020 16:21:15 +0800
Message-ID: <789fc6e6-9667-a609-c777-a9b1fed72f41@redhat.com>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506061633.16327-2-jasowang@redhat.com>
 <20200506033259-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506033259-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/6 =E4=B8=8B=E5=8D=883:37, Michael S. Tsirkin wrote:
> On Wed, May 06, 2020 at 02:16:33PM +0800, Jason Wang wrote:
>> We should not exclude headroom and tailroom when XDP is set. So this
>> patch fixes this by initializing the truesize from PAGE_SIZE when XDP
>> is set.
>>
>> Cc: Jesper Dangaard Brouer<brouer@redhat.com>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Seems too aggressive, we do not use up the whole page for the size.
>
>
>

For XDP yes, we do:

static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 struct ewma_pkt_len *avg_pkt_len,
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 unsigned int room)
{
 =C2=A0=C2=A0=C2=A0 const size_t hdr_len =3D sizeof(struct virtio_net_hdr=
_mrg_rxbuf);
 =C2=A0=C2=A0=C2=A0 unsigned int len;

 =C2=A0=C2=A0=C2=A0 if (room)
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return PAGE_SIZE - room;

...

Thanks
