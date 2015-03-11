From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] virtio_rpmsg: set DRIVER_OK before using device
Date: Wed, 11 Mar 2015 14:45:07 +0200
Message-ID: <CAK=WgbYuv+7LLk0z-fM1q5zCxPTSUNW9piHcBK3mYLzR=j--HA@mail.gmail.com>
References: <1425754898-32707-1-git-send-email-mst@redhat.com>
	<20150309084101.GC22567@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150309084101.GC22567@redhat.com>
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
Cc: qemu-devel@nongnu.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 9, 2015 at 10:41 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sat, Mar 07, 2015 at 08:06:56PM +0100, Michael S. Tsirkin wrote:
>> virtio spec requires that all drivers set DRIVER_OK
>> before using devices. While rpmsg isn't yet
>> included in the virtio 1 spec, previous spec versions
>> also required this.
>>
>> virtio rpmsg violates this rule: is calls kick
>> before setting DRIVER_OK.
>>
>> The fix isn't trivial since simply calling virtio_device_ready earlier
>> would mean we might get an interrupt in parallel with adding buffers.
>>
>> Instead, split kick out to prepare+notify calls.  prepare before
>> virtio_device_ready - when we know we won't get interrupts. notify right
>> afterwards.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>
> Ohad, can you review and ack pls?

Sure,

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
