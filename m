From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: pci: Use SIMPLE_DEV_PM_OPS macro
Date: Sun, 5 Oct 2014 18:49:00 +0300
Message-ID: <20141005154900.GA14877@redhat.com>
References: <003a01cfc8bc$bf48cd60$3dda6820$%han@samsung.com>
	<8761gxk5vt.fsf@rustcorp.com.au>
	<000d01cfd25d$0add23d0$20976b70$%han@samsung.com>
	<87oaudo62p.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87oaudo62p.fsf@rustcorp.com.au>
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
Cc: Jingoo Han <jg1.han@samsung.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 18, 2014 at 02:53:10PM +0930, Rusty Russell wrote:
> Jingoo Han <jg1.han@samsung.com> writes:
> > On Tuesday, September 09, 2014 9:14 AM, Rusty Russell wrote:
> >> Jingoo Han <jg1.han@samsung.com> writes:
> >> > Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
> >> >
> >> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> >> 
> >> This patch is obviously wrong.  It won't compile without
> >> CONFIG_PM_SLEEP.
> >
> > No, there is no compile issue.
> > When, CONFIG_PM_SLEEP=n, there is no build error.
> 
> My mistake.  Thanks, I've applied it.  It probably won't go in until the
> next merge window, however, since I'm travelling for this one.
> 
> Cheers,
> Rusty.

I have some bugfixes that are I think worth merging, so maybe
I'll do a pull request.
If so, this cleanup could go in, on top.

Rusty, what do you say?

-- 
MST
