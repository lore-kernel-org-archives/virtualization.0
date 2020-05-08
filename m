From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Date: Fri, 8 May 2020 09:56:37 +0800
Message-ID: <c1df2cdf-eaff-f146-1804-f0a6cad6bb2d@redhat.com>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506033834-mutt-send-email-mst@kernel.org>
 <7a169b06-b6b9-eac1-f03a-39dd1cfcce57@redhat.com>
 <20200506055436-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200506055436-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/5/6 下午5:54, Michael S. Tsirkin wrote:
> On Wed, May 06, 2020 at 04:19:40PM +0800, Jason Wang wrote:
>> On 2020/5/6 下午3:53, Michael S. Tsirkin wrote:
>>> On Wed, May 06, 2020 at 02:16:32PM +0800, Jason Wang wrote:
>>>> We tried to reserve space for vnet header before
>>>> xdp.data_hard_start. But this is useless since the packet could be
>>>> modified by XDP which may invalidate the information stored in the
>>>> header and there's no way for XDP to know the existence of the vnet
>>>> header currently.
>>> What do you mean? Doesn't XDP_PASS use the header in the buffer?
>> We don't, see 436c9453a1ac0 ("virtio-net: keep vnet header zeroed after
>> processing XDP")
>>
>> If there's other place, it should be a bug.
>>
>>
>>>> So let's just not reserve space for vnet header in this case.
>>> In any case, we can find out XDP does head adjustments
>>> if we need to.
>> But XDP program can modify the packets without adjusting headers.
>>
>> Thanks
> Then what's the problem?


Then we can't do anything more than just invalidating vnet header since 
we don't know whether or not the packet has been modified or not.

Technically, XDP can give the driver some hint about whether or not the 
packet has been modified, but AFAIK we haven't implemented this yet.

Thanks


>
