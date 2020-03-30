From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 0/6] vhost: Reset batched descriptors on SET_VRING_BASE
 call
Date: Mon, 30 Mar 2020 09:34:22 +0200
Message-ID: <41dfa0e5-8013-db15-cbfe-aa4574cfb9a0@de.ibm.com>
References: <20200329113359.30960-1-eperezma@redhat.com>
 <bb95e827-f219-32fd-0046-41046eec058b@de.ibm.com>
 <CAJaqyWePfMcXhYEPxKYV22J3cYtO=DUXCj1Yf=7XH+khXHop9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJaqyWePfMcXhYEPxKYV22J3cYtO=DUXCj1Yf=7XH+khXHop9A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



On 30.03.20 09:18, Eugenio Perez Martin wrote:
> On Mon, Mar 30, 2020 at 9:14 AM Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>>
>> On 29.03.20 13:33, Eugenio Pérez wrote:
>>> Vhost did not reset properly the batched descriptors on SET_VRING_BASE event. Because of that, is possible to return an invalid descriptor to the guest.
>>
>> I guess this could explain my problems that I have seen during reset?
>>
> 
> Yes, I think so. The series has a test that should reproduce more or
> less what you are seeing. However, it would be useful to reproduce on
> your system and to know what causes qemu to send the reset :).

I do see SET_VRING_BASE in the debug output
[228101.438630] [2113] vhost:vhost_vring_ioctl:1668: VHOST_GET_VRING_BASE [vq=00000000618905fc][s.index=1][s.num=42424][vq->avail_idx=42424][vq->last_avail_idx=42424][vq->ndescs=0][vq->first_desc=0]
[228101.438631] CPU: 54 PID: 2113 Comm: qemu-system-s39 Not tainted 5.5.0+ #344
[228101.438632] Hardware name: IBM 3906 M04 704 (LPAR)
[228101.438633] Call Trace:
[228101.438634]  [<00000004fc71c132>] show_stack+0x8a/0xd0 
[228101.438636]  [<00000004fd10e72a>] dump_stack+0x8a/0xb8 
[228101.438639]  [<000003ff80377600>] vhost_vring_ioctl+0x668/0x848 [vhost] 
[228101.438640]  [<000003ff80395fd4>] vhost_net_ioctl+0x4f4/0x570 [vhost_net] 
[228101.438642]  [<00000004fc9ccdd8>] do_vfs_ioctl+0x430/0x6f8 
[228101.438643]  [<00000004fc9cd124>] ksys_ioctl+0x84/0xb0 
[228101.438645]  [<00000004fc9cd1ba>] __s390x_sys_ioctl+0x2a/0x38 
[228101.438646]  [<00000004fd12ff72>] system_call+0x2a6/0x2c8 
[228103.682732] [2122] vhost:vhost_vring_ioctl:1653: VHOST_SET_VRING_BASE [vq=000000009e1ac3e7][s.index=0][s.num=0][vq->avail_idx=27875][vq->last_avail_idx=27709][vq->ndescs=65][vq->first_desc=22]
[228103.682735] CPU: 44 PID: 2122 Comm: CPU 0/KVM Not tainted 5.5.0+ #344
[228103.682739] Hardware name: IBM 3906 M04 704 (LPAR)
[228103.682741] Call Trace:
[228103.682748]  [<00000004fc71c132>] show_stack+0x8a/0xd0 
[228103.682752]  [<00000004fd10e72a>] dump_stack+0x8a/0xb8 
[228103.682761]  [<000003ff80377422>] vhost_vring_ioctl+0x48a/0x848 [vhost] 
[228103.682764]  [<000003ff80395fd4>] vhost_net_ioctl+0x4f4/0x570 [vhost_net] 
[228103.682767]  [<00000004fc9ccdd8>] do_vfs_ioctl+0x430/0x6f8 
[228103.682769]  [<00000004fc9cd124>] ksys_ioctl+0x84/0xb0 
[228103.682771]  [<00000004fc9cd1ba>] __s390x_sys_ioctl+0x2a/0x38 
[228103.682773]  [<00000004fd12ff72>] system_call+0x2a6/0x2c8 
[228103.682794] [2122] vhost:vhost_vring_ioctl:1653: VHOST_SET_VRING_BASE [vq=00000000618905fc][s.index=1][s.num=0][vq->avail_idx=42424][vq->last_avail_idx=42424][vq->ndescs=0][vq->first_desc=0]
[228103.682795] CPU: 44 PID: 2122 Comm: CPU 0/KVM Not tainted 5.5.0+ #344
[228103.682797] Hardware name: IBM 3906 M04 704 (LPAR)
[228103.682797] Call Trace:
[228103.682799]  [<00000004fc71c132>] show_stack+0x8a/0xd0 
[228103.682801]  [<00000004fd10e72a>] dump_stack+0x8a/0xb8 
[228103.682804]  [<000003ff80377422>] vhost_vring_ioctl+0x48a/0x848 [vhost] 
[228103.682806]  [<000003ff80395fd4>] vhost_net_ioctl+0x4f4/0x570 [vhost_net] 
[228103.682808]  [<00000004fc9ccdd8>] do_vfs_ioctl+0x430/0x6f8 
[228103.682810]  [<00000004fc9cd124>] ksys_ioctl+0x84/0xb0 
[228103.682812]  [<00000004fc9cd1ba>] __s390x_sys_ioctl+0x2a/0x38 
[228103.682813]  [<00000004fd12ff72>] system_call+0x2a6/0x2c8 


Isnt that triggered by resetting the virtio devices during system reboot?
