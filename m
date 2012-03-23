From: Jason Wang <jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-spec: clarify ro/rw bits and updating
	rule of virtio-net status field
Date: Fri, 23 Mar 2012 10:57:24 +0800
Message-ID: <4F6BE694.1030509@redhat.com>
References: <20120320062020.12815.61342.stgit@jason-ThinkPad-T400>
	<87ty1jpm6p.fsf@rustcorp.com.au> <20120320224805.GA4997@redhat.com>
	<87ty1ializ.fsf@rustcorp.com.au> <20120321063746.GA6773@redhat.com>
	<87aa399s0x.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87aa399s0x.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/22/2012 12:30 PM, Rusty Russell wrote:
> On Wed, 21 Mar 2012 08:37:46 +0200, "Michael S. Tsirkin"<mst@redhat.com>  wrote:
>> Ah. Right, we need to trap for host to clear the bit.
>> OK, so let's make the bit RO, and add
>> VIRTIO_NET_CTRL_ANNOUNCED to acknowledge that we've
>> seen VIRTIO_NET_S_ANNOUNCE using the control VQ?
> Thanks, that's nice.  Guest should send arp packets first, then send
> VIRTIO_NET_CTRL_ANNOUNCED, and ignore the bit being set in the meantime.
>
> Thanks,
> Rusty.
Sure, I would update and re-send the spec updating patch.

Thanks
