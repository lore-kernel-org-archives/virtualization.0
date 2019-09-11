From: David Riley <davidriley@chromium.org>
Subject: Re: [PATCH v3 1/2] drm/virtio: Rewrite virtio_gpu_queue_ctrl_buffer
	using fenced version.
Date: Wed, 11 Sep 2019 10:35:15 -0700
Message-ID: <CAASgrz3rA-i3AjT3UuG7gPTHzdHppNLR3C0j23DEgqxivXtPmg@mail.gmail.com>
References: <20190829212417.257397-1-davidriley@chromium.org>
	<20190910200651.118628-1-davidriley@chromium.org>
	<20190911051240.2k2olzsc3xnqaggl@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190911051240.2k2olzsc3xnqaggl@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

They were based off of  Linus' https://github.com/torvalds/linux
master from yesterday.

I can rebase onto drm-misc-next.

On Tue, Sep 10, 2019 at 10:12 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Sep 10, 2019 at 01:06:50PM -0700, David Riley wrote:
> > Factor function in preparation to generating scatterlist prior to locking.
>
> Patches are looking good now, but they don't apply.  What tree was used
> to create them?
>
> Latest virtio-gpu driver bits are in drm-misc-next (see
> https://cgit.freedesktop.org/drm/drm-misc).
>
> cheers,
>   Gerd
