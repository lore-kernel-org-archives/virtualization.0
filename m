From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio-rng: complete have_data completion in removing
	device
Date: Wed, 6 Aug 2014 13:55:29 +0530
Message-ID: <20140806082529.GC25951@grmbl.mre>
References: <1407260115-26767-1-git-send-email-akong@redhat.com>
	<20140806080541.GA3304@z.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140806080541.GA3304@z.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: kvm@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 06 Aug 2014 [16:05:41], Amos Kong wrote:
> On Wed, Aug 06, 2014 at 01:35:15AM +0800, Amos Kong wrote:
> > When we try to hot-remove a busy virtio-rng device from QEMU monitor,
> > the device can't be hot-removed. Because virtio-rng driver hangs at
> > wait_for_completion_killable().
> > 
> > This patch fixed the hang by completing have_data completion before
> > unregistering a virtio-rng device.
> 
> Hi Amit,
> 
> Before applying this patch, it's blocking insider wait_for_completion_killable()                     
> Applied this patch, wait_for_completion_killable() returns 0,
> and vi->data_avail becomes 0, then rng_get_date() will return 0.

Thanks for checking this.

> Is it expected result?

I think what will happen is vi->data_avail will be set to whatever it
was set last.  In case of a previous successful read request, the
data_avail will be set to whatever number of bytes the host gave.  On
doing a hot-unplug on the succeeding wait, the value in data_avail
will be re-used, and the hwrng core will wrongly take some bytes in
the buffer as input from the host.

So, I think we need to set vi->data_avail = 0; before calling
wait_event_completion_killable().

		Amit
