From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 02/13] fbdev: add remove_conflicting_pci_framebuffers()
Date: Mon, 11 Dec 2017 21:57:00 +0000
Message-ID: <20171211215700.GA4899__18064.5955064849$1513029555$gmane$org@sudip-laptop>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
	<1738dbed0239bffc886f126fd3091daa39cd14c9.1511544782.git.mirq-linux@rere.qmqm.pl>
	<20171127102758.y7c6yzyey6wfntxh@phenom.ffwll.local>
	<20171127205219.GA3537@sudip-laptop>
	<20171128102217.b7ynyqarwzkdvmdq@phenom.ffwll.local>
	<20171128113238.GA29456@kroah.com>
	<20171128123008.GA12986@sudip-tp>
	<20171129095634.ymeld4l7zaehbuvn@phenom.ffwll.local>
	<20171130234953.GA5542@sudip-laptop>
	<CACvgo52NmpWv4DdwMuu3b9fZx++Wd2zvCvtvN75LxPqmycpCtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CACvgo52NmpWv4DdwMuu3b9fZx++Wd2zvCvtvN75LxPqmycpCtQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, David Airlie <airlied@linux.ie>, Greg KH <gregkh@linuxfoundation.org>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, ML dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Emil,

On Fri, Dec 01, 2017 at 02:40:11PM +0000, Emil Velikov wrote:
> On 30 November 2017 at 23:49, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> > Hi Daniel,
> >
> > On Wed, Nov 29, 2017 at 10:56:34AM +0100, Daniel Vetter wrote:
<snip>
> > submit it to dri-devel.
> >
> A crazy idea, mostly towards Tedd and Sudip:
> 
> Start small and build gradually. An example split for separate patch series:
> 
>  - one HW, basic setup + atomic KMS
>  - add second HW
>  - more KMS features
>  - fancy memory management
>  - 2D/3D/other acceleration
> 
> The driver as seen above tries to do all of the above (almost, it's not atomic)
> at once - 40k loc.
> 
> Someone familiar with the code can quickly split it up and while doing
> so, feed it through checkpatch.

I can try but will be very tough since I have to go through the code to
get familiar with it and, as mentioned before, its not part of my dayjob,
so time will be a problem. Developing from scratch takes much more time
than fixing something.

> Current code is _very_ far from kernel coding style, plus the
> copyright blurp is very disturbing:

I will fix the coding style before my first submission to dri-devel,
which should be in January after I have setup my desktop with the
hardware for testing.

The copyright thing - I am sure Teddy can talk to his company and will
confirm that we can change it to the way kernel code is done.

--
Regards
Sudip
