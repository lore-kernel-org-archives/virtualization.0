From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3 1/2] drm/virtio: Add window server support
Date: Mon, 12 Feb 2018 15:00:24 +0100
Message-ID: <eea72b9d-d180-6a57-81ce-4366dc0f2bcc__41302.7565264658$1518443956$gmane$org@collabora.com>
References: <20180126135803.29781-2-tomeu.vizoso@collabora.com>
	<20180201163623.5cs2ysykg5wgulf4@sirius.home.kraxel.org>
	<49785e0d-936a-c3b4-62dd-aafc7083a942@collabora.com>
	<20180205122017.4vb5nlpodkq2uhxa@sirius.home.kraxel.org>
	<f07a5347-13fe-76c2-f971-3f02abebd3c9@collabora.com>
	<20180205160322.sntv5uoqp5o7flnh@sirius.home.kraxel.org>
	<fd557eb7-f539-2ecf-142c-8313b9f7ddb3@collabora.com>
	<20180206142302.vdjyqmnoypydci4t@sirius.home.kraxel.org>
	<04687943-847b-25a7-42ef-a21b4c7ef0cf@collabora.com>
	<38880e66-b676-1170-c2ca-5a5603c5b521@collabora.com>
	<20180212115242.z3qv5uejbnhgvd6o@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180212115242.z3qv5uejbnhgvd6o@sirius.home.kraxel.org>
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

On 02/12/2018 12:52 PM, Gerd Hoffmann wrote:
>    Hi,
> 
>> can we reach agreement on whether vsock should be involved in this?
> 
> I think the best approach would be to have guest proxy and host proxy
> use vsock for the wayland protocol.  Use a wayland protocol extension to
> reference the buffers in stdvga / ivshmem / virtio-gpu.  Only the two
> proxies need to understand the extension, the client <=> guest proxy and
> host proxy <=> server communication would be standard wayland protocol.

Thanks for the ideas. What I haven't understood yet is how you see the 
actual passing of buffers via vsock. Are you thinking of using ancillary 
data to pass FDs, or something else?

Thanks,

Tomeu
