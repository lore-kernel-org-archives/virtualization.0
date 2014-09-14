From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH 2/2] virtio-rng: fix stuck in catting hwrng attributes
Date: Sun, 14 Sep 2014 10:25:53 +0800
Message-ID: <20140914022553.GC1032@zen.redhat.com>
References: <1410340027-15373-1-git-send-email-akong@redhat.com>
	<1410340027-15373-3-git-send-email-akong@redhat.com>
	<8738byie04.fsf@rustcorp.com.au>
	<20140913171258.GB12276@zen.redhat.com>
	<20140914011208.GA1032@zen.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140914011208.GA1032@zen.redhat.com>
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

On Sun, Sep 14, 2014 at 09:12:08AM +0800, Amos Kong wrote:

...
> > > > diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> > > > index c591d7e..b5d1b6f 100644
> > > > --- a/drivers/char/hw_random/core.c
> > > > +++ b/drivers/char/hw_random/core.c
> > > > @@ -195,8 +195,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
> > > >  
> > > >  		mutex_unlock(&rng_mutex);
> > > >  
> > > > -		if (need_resched())
> > > > -			schedule_timeout_interruptible(1);
> > > > +		schedule_timeout_interruptible(10);

Problem only occurred in non-smp guest, we can improve it to:

                        if(!is_smp())
                                schedule_timeout_interruptible(10);

is_smp() is only available for arm arch, we need a general one.

> > > >  
> > > >  		if (signal_pending(current)) {
> > > >  			err = -ERESTARTSYS;
> > > > -- 

-- 
			Amos.
