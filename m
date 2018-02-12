From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Date: Mon, 12 Feb 2018 15:42:37 +0100
Message-ID: <6cf0c06a-b884-3251-166b-6ff3dec3ebc7__27881.602155003$1518446467$gmane$org@collabora.com>
References: <49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
	<20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
	<f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
	<20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
	<fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
	<20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
	<04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
	<38880e66-b676-1170-c2ca-5a5603c5b521@collabora.com>
	<20180212115242.z3qv5uejbnhgvd6o@sirius.home.kraxel.org>
	<eea72b9d-d180-6a57-81ce-4366dc0f2bcc@collabora.com>
	<20180212142730.g2646v77qsvzd5ff@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180212142730.g2646v77qsvzd5ff@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Zach Reizner <zachr@google.com>, kernel@collabora.com
List-Id: virtualization@lists.linuxfoundation.org

On 02/12/2018 03:27 PM, Gerd Hoffmann wrote:
> On Mon, Feb 12, 2018 at 03:00:24PM +0100, Tomeu Vizoso wrote:
>> On 02/12/2018 12:52 PM, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>> can we reach agreement on whether vsock should be involved in this?
>>>
>>> I think the best approach would be to have guest proxy and host proxy
>>> use vsock for the wayland protocol.  Use a wayland protocol extension to
>>> reference the buffers in stdvga / ivshmem / virtio-gpu.  Only the two
>>> proxies need to understand the extension, the client <=> guest proxy and
>>> host proxy <=> server communication would be standard wayland protocol.
>>
>> Thanks for the ideas. What I haven't understood yet is how you see the
>> actual passing of buffers via vsock. Are you thinking of using ancillary
>> data to pass FDs, or something else?
> 
> I was more thinking about a struct containing enough info to allow the
> proxy on the host side find the buffer, something like:
> 
>     struct {
>        enum type { stdvga, virtio-cpu, ... }
>        pcislot device;
>        union {
>           int stdvga_pcibar_offset;
>           int virtio_gpu_resource_id;
>        }
>     }
> 
> So when the guest proxy gets a message with a fd referencing a buffer it
> would have to figure where the buffer is, rewrite the message into the
> struct above for the host proxy.  The host proxy would rewrite the
> message again for the server.

What I don't understand yet is how we can keep the buffer descriptions 
together with the protocol data that references them.

With SCM_RIGHTS, the FDs are placed in the ancillary data that "travels" 
together with the protocol data that references them.

With the present series, the DRM_IOCTL_VIRTGPU_WINSRV_TX ioctl struct has 
a field for the protocol data and an array of FDs.

How are you proposing to pass instances of that struct from above along 
the protocol data that refers to them?

Thanks,

Tomeu
