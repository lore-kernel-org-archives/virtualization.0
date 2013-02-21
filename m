From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 10/16] virtio_net: use virtqueue_add_sgs[] for command
	buffers.
Date: Thu, 21 Feb 2013 16:57:03 +1030
Message-ID: <87a9qygp1k.fsf__3068.2337157943$1361429825$gmane$org@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-11-git-send-email-rusty@rustcorp.com.au>
	<5124A157.5070800@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5124A157.5070800@cn.fujitsu.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gaowanlong@cn.fujitsu.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Wanlong Gao <gaowanlong@cn.fujitsu.com> writes:
> On 02/19/2013 03:56 PM, Rusty Russell wrote:
>> It's a bit cleaner to hand multiple sgs, rather than one big one.
>> 
>> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
...
>> +	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
>>  
>> -	ctrl.class = class;
>> -	ctrl.cmd = cmd;
>
> The class and cmd assignment of ctrl header is forgotten?
>
> Thanks,
> Wanlong Gao

Good catch, fixed.

Thanks,
Rusty.
