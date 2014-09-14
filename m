From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH 2/2] virtio-rng: fix stuck in catting hwrng attributes
Date: Sun, 14 Sep 2014 09:12:08 +0800
Message-ID: <20140914011208.GA1032@zen.redhat.com>
References: <1410340027-15373-1-git-send-email-akong@redhat.com>
	<1410340027-15373-3-git-send-email-akong@redhat.com>
	<8738byie04.fsf@rustcorp.com.au>
	<20140913171258.GB12276@zen.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140913171258.GB12276@zen.redhat.com>
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
Cc: amit.shah@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 14, 2014 at 01:12:58AM +0800, Amos Kong wrote:
> On Thu, Sep 11, 2014 at 09:08:03PM +0930, Rusty Russell wrote:
> > Amos Kong <akong@redhat.com> writes:
> > > When I check hwrng attributes in sysfs, cat process always gets
> > > stuck if guest has only 1 vcpu and uses a slow rng backend.
> > >
> > > Currently we check if there is any tasks waiting to be run on
> > > current cpu in rng_dev_read() by need_resched(). But need_resched()
> > > doesn't work because rng_dev_read() is executing in user context.
> > 
> > I don't understand this explanation?  I'd expect the sysfs process to be
> > woken by the mutex_unlock().
> 
> But actually sysfs process's not woken always, this is they the
> process gets stuck.

%s/they/why/

Hi Rusty,


Reference:
http://www.linuxgrill.com/anonymous/fire/netfilter/kernel-hacking-HOWTO-2.html

read() syscall of /dev/hwrng will enter into kernel, the read operation is
rng_dev_read(), it's userspace context (not interrupt context).

Userspace context doesn't allow other user contexts run on that CPU,
unless the kernel code sleeps for some reason.


In this case, the need_resched() doesn't work.

My solution is removing need_resched() and use an appropriate delay by 
schedule_timeout_interruptible(10).

Thanks, Amos
  
> > If we're really high priority (vs. the sysfs process) then I can see why
> > we'd need schedule_timeout_interruptible() instead of just schedule(),
> > and in that case, need_resched() would be false too.
> > 
> > You could argue that's intended behaviour, but I can't see how it
> > happens in the normal case anyway.
> > 
> > What am I missing?

> > Thanks,
> > Rusty.
> > 
> > > This patch removed need_resched() and increase delay to 10 jiffies,
> > > then other tasks can have chance to execute protected code.
> > > Delaying 1 jiffy also works, but 10 jiffies is safer.
> > >
> > > Signed-off-by: Amos Kong <akong@redhat.com>
> > > ---
> > >  drivers/char/hw_random/core.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> > > index c591d7e..b5d1b6f 100644
> > > --- a/drivers/char/hw_random/core.c
> > > +++ b/drivers/char/hw_random/core.c
> > > @@ -195,8 +195,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
> > >  
> > >  		mutex_unlock(&rng_mutex);
> > >  
> > > -		if (need_resched())
> > > -			schedule_timeout_interruptible(1);
> > > +		schedule_timeout_interruptible(10);
> > >  
> > >  		if (signal_pending(current)) {
> > >  			err = -ERESTARTSYS;
> > > -- 
