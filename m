From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v3] virtio: Work around frames incorrectly marked as gso
Date: Mon, 24 Feb 2020 20:59:15 +0000
Message-ID: <93cb2b3f-6cae-8cf1-5fab-93fa34c14628@cambridgegreys.com>
References: <20200224132550.2083-1-anton.ivanov@cambridgegreys.com>
 <CA+FuTSd8P6uQnwisZEh7+nfowW9qKLBEvA4GPg+xUkjBa-6TDA@mail.gmail.com>
 <4e7757cf-148e-4585-b358-3b38f391275d@cambridgegreys.com>
 <CA+FuTSdOCJZCVS4xohx+BQmkmq8JALnK=gGc0=qy1TbjY707ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CA+FuTSdOCJZCVS4xohx+BQmkmq8JALnK=gGc0=qy1TbjY707ag@mail.gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-um@lists.infradead.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 24/02/2020 20:20, Willem de Bruijn wrote:
> On Mon, Feb 24, 2020 at 2:55 PM Anton Ivanov
> <anton.ivanov@cambridgegreys.com> wrote:
>> On 24/02/2020 19:27, Willem de Bruijn wrote:
>>> On Mon, Feb 24, 2020 at 8:26 AM <anton.ivanov@cambridgegreys.com> wrote:
>>>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>>>
>>>> Some of the locally generated frames marked as GSO which
>>>> arrive at virtio_net_hdr_from_skb() have no GSO_TYPE, no
>>>> fragments (data_len = 0) and length significantly shorter
>>>> than the MTU (752 in my experiments).
>>> Do we understand how these packets are generated?
>> No, we have not been able to trace them.
>>
>> The only thing we know is that this is specific to locally generated
>> packets. Something arriving from the network does not show this.
>>
>>> Else it seems this
>>> might be papering over a deeper problem.
>>>
>>> The stack should not create GSO packets less than or equal to
>>> skb_shinfo(skb)->gso_size. See for instance the check in
>>> tcp_gso_segment after pulling the tcp header:
>>>
>>>           mss = skb_shinfo(skb)->gso_size;
>>>           if (unlikely(skb->len <= mss))
>>>                   goto out;
>>>
>>> What is the gso_type, and does it include SKB_GSO_DODGY?
>>>
>>
>> 0 - not set.
> Thanks for the follow-up details. Is this something that you can trigger easily?

Yes, if you have a UML instance handy.

Running iperf between the host and a UML guest using raw socket 
transport triggers it immediately.

This is my UML command line:

vmlinux mem=2048M umid=OPX \
     ubd0=OPX-3.0-Work.img \
vec0:transport=raw,ifname=p-veth0,depth=128,gro=1,mac=92:9b:36:5e:38:69 \
     root=/dev/ubda ro con=null con0=null,fd:2 con1=fd:0,fd:1

p-right is a part of a vEth pair:

ip link add l-veth0 type veth peer name p-veth0 && ifconfig p-veth0 up

iperf server is on host, iperf -c in the guest.

>
> An skb_dump() + dump_stack() when the packet socket gets such a
> packet may point us to the root cause and fix that.

We tried dump stack, it was not informative - it was just the recvmmsg 
call stack coming from the UML until it hits the relevant recv bit in 
af_packet - it does not tell us where the packet is coming from.

Quoting from the message earlier in the thread:

[ 2334.180854] Call Trace:
[ 2334.181947]  dump_stack+0x5c/0x80
[ 2334.183021]  packet_recvmsg.cold+0x23/0x49
[ 2334.184063]  ___sys_recvmsg+0xe1/0x1f0
[ 2334.185034]  ? packet_poll+0xca/0x130
[ 2334.186014]  ? sock_poll+0x77/0xb0
[ 2334.186977]  ? ep_item_poll.isra.0+0x3f/0xb0
[ 2334.187936]  ? ep_send_events_proc+0xf1/0x240
[ 2334.188901]  ? dequeue_signal+0xdb/0x180
[ 2334.189848]  do_recvmmsg+0xc8/0x2d0
[ 2334.190728]  ? ep_poll+0x8c/0x470
[ 2334.191581]  __sys_recvmmsg+0x108/0x150
[ 2334.192441]  __x64_sys_recvmmsg+0x25/0x30
[ 2334.193346]  do_syscall_64+0x53/0x140
[ 2334.194262]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
