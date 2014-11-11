From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] virtio_console: move early VQ enablement
Date: Tue, 11 Nov 2014 12:24:24 +1000
Message-ID: <CAPM=9txTy6PFW2g0C60viuWhAQ-738EGXth8OjjcZX3XaoSmbQ@mail.gmail.com>
References: <20141020133555.GA27111@redhat.com>
	<1413813529-11044-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141020140508.GA11004@redhat.com>
	<CA+5PVA7QgM9PGExjyZG-TQGYZWrWOKM+7dQGh2RWnJCfZ3aw+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CA+5PVA7QgM9PGExjyZG-TQGYZWrWOKM+7dQGh2RWnJCfZ3aw+A@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Thomas Graf <tgraf@suug.ch>
List-Id: virtualization@lists.linuxfoundation.org

On 21 October 2014 03:09, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> On Mon, Oct 20, 2014 at 10:05 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Mon, Oct 20, 2014 at 03:58:49PM +0200, Cornelia Huck wrote:
>>> Commit f5866db6 (virtio_console: enable VQs early) tried to make
>>> sure that DRIVER_OK was set when virtio_console started using its
>>> virtqueues. Doing this in add_port(), however, means that we try
>>> to set DRIVER_OK again when when a port is dynamically added after
>>> the probe function is done.
>>>
>>> Let's move virtio_device_ready() to the probe function just before
>>> trying to use the virtqueues instead. This is fine as nothing can
>>> fail inbetween.
>>>
>>> Reported-by: Thomas Graf <tgraf@suug.ch>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>>
>> Thanks!
>>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Tested-by: Michael S. Tsirkin <mst@redhat.com>
>
> This fixed my KVM guest boot issue with 3.18-rc1.  Thanks for such a quick fix.
>
> Tested-by: Josh Boyer <jwboyer@fedoraproject.org>

ping So who's merging this? Rusty?

still happens in -rc4.

Dave.
