From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: BUG: 'list_empty(&vgdev->free_vbufs)' is true!
Date: Tue, 15 Nov 2016 09:55:51 +0100
Message-ID: <18ae4a55-7c36-b55c-0ce3-03aef0bab1ec__6352.46624374322$1479200188$gmane$org@suse.cz>
References: <bfe29853-694b-6cb5-02e7-6986a9927438@suse.cz>
	<20161108223153-mutt-send-email-mst@kernel.org>
	<1478678517.2078.12.camel@redhat.com>
	<f006e3a6-51d2-4092-57b6-eea7ff64f58f@suse.cz>
	<1479199588.32639.16.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1479199588.32639.16.camel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/15/2016, 09:46 AM, Gerd Hoffmann wrote:
> On Fr, 2016-11-11 at 17:28 +0100, Jiri Slaby wrote:
>> On 11/09/2016, 09:01 AM, Gerd Hoffmann wrote:
>>> On Di, 2016-11-08 at 22:37 +0200, Michael S. Tsirkin wrote:
>>>> On Mon, Nov 07, 2016 at 09:43:24AM +0100, Jiri Slaby wrote:
>>>>> Hi,
>>>>>
>>>>> I can relatively easily reproduce this bug:
>>>
>>> How?
>>
>> Run dmesg -w in the qemu window (virtio_gpu) to see a lot of output.
> 
> fbcon?  Or xorg/wayland with terminal app?

Ah, just console, so fbcon. No X server running.

thanks,
-- 
js
suse labs
