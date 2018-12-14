From: jiangyiwen <jiangyiwen@huawei.com>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer in
	host
Date: Fri, 14 Dec 2018 15:47:55 +0800
Message-ID: <5C13602B.1080505__31567.9002822892$1544773582$gmane$org@huawei.com>
References: <5C10D4FB.6070009@huawei.com>
	<20181212.110944.1077302806391053539.davem@davemloft.net>
	<5C11CDF4.4040405@huawei.com>
	<20181213094935-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181213094935-mutt-send-email-mst@kernel.org>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On 2018/12/13 22:50, Michael S. Tsirkin wrote:
> On Thu, Dec 13, 2018 at 11:11:48AM +0800, jiangyiwen wrote:
>> On 2018/12/13 3:09, David Miller wrote:
>>> From: jiangyiwen <jiangyiwen@huawei.com>
>>> Date: Wed, 12 Dec 2018 17:29:31 +0800
>>>
>>>> diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>>>> index 1d57ed3..2292f30 100644
>>>> --- a/include/uapi/linux/virtio_vsock.h
>>>> +++ b/include/uapi/linux/virtio_vsock.h
>>>> @@ -63,6 +63,11 @@ struct virtio_vsock_hdr {
>>>>  	__le32	fwd_cnt;
>>>>  } __attribute__((packed));
>>>>
>>>> +/* It add mergeable rx buffers feature */
>>>> +struct virtio_vsock_mrg_rxbuf_hdr {
>>>> +	__le16  num_buffers;    /* number of mergeable rx buffers */
>>>> +} __attribute__((packed));
>>>> +
>>>
>>> I know the rest of this file uses 'packed' but this attribute should
>>> only be used if absolutely necessary as it incurs a
>>> non-trivial performance penalty for some architectures.
>>>
>>> .
>>>
>>
>> Hi David,
>>
>> I hope Host can fill fewer bytes into rx virtqueue, so
>> I keep structure virtio_vsock_mrg_rxbuf_hdr one byte
>> alignment.
>>
>> Thanks,
>> Yiwen.
> 
> It doesn't work like this now though, does it?
> Buffers are preallocated and they are always aligned.
> So I do not see the point.
> 

Hi Michael,

Now my patch has a serious problem, I use virtio_vsock_pkt as
the transport header from host to guest, it will cause
guest parse the wrong packet length. Because this structure
size may be different under different compilers
(guest and host are different). I will solve the problem
in later version.

Thanks,
Yiwen.
