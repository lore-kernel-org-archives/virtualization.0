From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Date: Wed, 7 Feb 2018 08:41:47 +0100
Message-ID: <1b7ff044-23c8-1bf7-004e-dd6ea1a7006e@collabora.com>
References: <20180126135803.29781-1-tomeu.vizoso@collabora.com>
	<20180126135803.29781-2-tomeu.vizoso@collabora.com>
	<20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
	<49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
	<20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
	<f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
	<20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
	<fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
	<20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
	<20180207030636-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180207030636-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Zach Reizner <zachr@google.com>, kernel@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

On 02/07/2018 02:09 AM, Michael S. Tsirkin wrote:
> On Tue, Feb 06, 2018 at 03:23:02PM +0100, Gerd Hoffmann wrote:
>>> Creation of shareable buffer by guest
>>> -------------------------------------------------
>>>
>>> 1. Client requests virtio driver to create a buffer suitable for sharing
>>> with host (DRM_VIRTGPU_RESOURCE_CREATE)
>>
>> client or guest proxy?
>>
>>> 4. QEMU maps that buffer to the guest's address space
>>> (KVM_SET_USER_MEMORY_REGION), passes the guest PFN to the virtio driver
>>
>> That part is problematic.  The host can't simply allocate something in
>> the physical address space, because most physical address space
>> management is done by the guest.  All pci bars are mapped by the guest
>> firmware for example (or by the guest OS in case of hotplug).
>>
>>> 4. QEMU pops data+buffers from the virtqueue, looks up shmem FD for each
>>> resource, sends data + FDs to the compositor with SCM_RIGHTS
> 
> If you squint hard, this sounds a bit like a use-case for vhost-user-gpu, does it not?

Can you extend on what makes you think that?

As an aside, crosvm runs the virtio-gpu device in a separate, jailed
process, among other virtual devices.

https://chromium.googlesource.com/chromiumos/platform/crosvm/

Regards,

Tomeu
