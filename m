From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: blk-mq crash under KVM in multiqueue block code (with virtio-blk
	and ext4)
Date: Wed, 17 Sep 2014 18:01:28 +0800
Message-ID: <CACVXFVOjoAo1d86S=7a3x27aCGVZh03HvVq4dVdRk8VQ+Ou5-w@mail.gmail.com>
References: <541178D6.6010303@de.ibm.com>
	<CACVXFVO7Oo9GeagPhejngfoeySxOP4EqWz_GN6kYv2956-Wtxg@mail.gmail.com>
	<541352ED.7030800@de.ibm.com> <54193F4F.9060508@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54193F4F.9060508@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, Virtualization List <virtualization@lists.linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 17, 2014 at 3:59 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 09/12/2014 10:09 PM, Christian Borntraeger wrote:
>> On 09/12/2014 01:54 PM, Ming Lei wrote:
>>> On Thu, Sep 11, 2014 at 6:26 PM, Christian Borntraeger
>>> <borntraeger@de.ibm.com> wrote:
>>>> Folks,
>>>>
>>>> we have seen the following bug with 3.16 as a KVM guest. It suspect the blk-mq rework that happened between 3.15 and 3.16, but it can be something completely different.
>>>>
>>>
>>> Care to share how you reproduce the issue?
>>
>> Host with 16GB RAM 32GB swap. 15 guest all with 2 GB RAM (and varying amount of CPUs). All do heavy file I/O.
>> It did not happen with 3.15/3.15 in guest/host and does happen with 3.16/3.16. So our next step is to check
>> 3.15/3.16 and 3.16/3.15 to identify if its host memory mgmt or guest block layer.
>
> The crashed happen pretty randomly, but when they happen it seems that its the same trace as below. This makes memory corruption by host vm less likely and some thing wrong in blk-mq more likely I guess
>

Maybe you can try these patches because atomic op
can be reordered on S390:

http://marc.info/?l=linux-kernel&m=141094730828533&w=2
http://marc.info/?l=linux-kernel&m=141094730828534&w=2

Thanks
-- 
Ming Lei
