From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 1/5] virtio-gpu: add virtio_gpu_queue_ctrl_buffer_nolock
Date: Thu, 10 Sep 2015 09:39:03 +0100
Message-ID: <CACvgo53bZnLoKHu_Gh-+mBVxs0MX07LckGc-hVxCpYxXmSTwRg__31708.3475798883$1441900560$gmane$org@mail.gmail.com>
References: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
	<1441798946-26233-2-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441798946-26233-2-git-send-email-kraxel@redhat.com>
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
Cc: open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Gerd,

On 9 September 2015 at 12:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Add virtio_gpu_queue_ctrl_buffer_nolock function, which does the same as
> virtio_gpu_queue_ctrl_buffer but does not take the virtqueue lock.  The
> caller must hold the lock instead.
>
The drm subsystem tends to use *_locked and *_unlocked suffixes. With
the latter being less common.
Not a big deal but perhaps you can use one of those for virtio ?

Cheers,
Emil
