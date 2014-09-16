From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio-rng: fix stuck in catting hwrng attributes
Date: Wed, 17 Sep 2014 01:05:27 +0930
Message-ID: <87lhpjfuio.fsf@rustcorp.com.au>
References: <1410340027-15373-1-git-send-email-akong@redhat.com>
	<1410340027-15373-3-git-send-email-akong@redhat.com>
	<8738byie04.fsf@rustcorp.com.au>
	<20140913171258.GB12276@zen.redhat.com>
	<20140914011208.GA1032@zen.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Amos Kong <akong@redhat.com>
Cc: amit.shah@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Amos Kong <akong@redhat.com> writes:
> On Sun, Sep 14, 2014 at 01:12:58AM +0800, Amos Kong wrote:
>> On Thu, Sep 11, 2014 at 09:08:03PM +0930, Rusty Russell wrote:
>> > Amos Kong <akong@redhat.com> writes:
>> > > When I check hwrng attributes in sysfs, cat process always gets
>> > > stuck if guest has only 1 vcpu and uses a slow rng backend.
>> > >
>> > > Currently we check if there is any tasks waiting to be run on
>> > > current cpu in rng_dev_read() by need_resched(). But need_resched()
>> > > doesn't work because rng_dev_read() is executing in user context.
>> > 
>> > I don't understand this explanation?  I'd expect the sysfs process to be
>> > woken by the mutex_unlock().
>> 
>> But actually sysfs process's not woken always, this is they the
>> process gets stuck.
>
> %s/they/why/
>
> Hi Rusty,
>
>
> Reference:
> http://www.linuxgrill.com/anonymous/fire/netfilter/kernel-hacking-HOWTO-2.html

Sure, that was true when I wrote it, and is still true when preempt is
off.

> read() syscall of /dev/hwrng will enter into kernel, the read operation is
> rng_dev_read(), it's userspace context (not interrupt context).
>
> Userspace context doesn't allow other user contexts run on that CPU,
> unless the kernel code sleeps for some reason.

This is true assuming preempt is off, yes.

> In this case, the need_resched() doesn't work.

This is exactly what need_resched() is for: it should return true if
there's another process of sufficient priority waiting to be run.  It
implies that schedule() would run it.

git blame doesn't offer any enlightenment here, as to why we use
schedule_timeout_interruptible() at all.

I would expect mutex_unlock() to wake the other reader.  The code
certainly seems to, so it should now be runnable and need_resched()
should return true.

I suspect something else is happening which makes this "work".

Cheers,
Rusty.
