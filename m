From: Amit Shah <amit.shah@redhat.com>
Subject: Re: RFC virtio-rng: fail to read sysfs of a busy device
Date: Wed, 10 Sep 2014 11:22:12 +0530
Message-ID: <20140910055212.GB29832@grmbl.mre>
References: <20140909151844.GA17178@zen.redhat.com>
	<20140909152307.GB17178@zen.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140909152307.GB17178@zen.redhat.com>
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
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 09 Sep 2014 [23:23:07], Amos Kong wrote:
> (Resend to fix the subject)
> 
> Hi Amit, Rusty
> 
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1127062
> steps:
> - Read random data by 'dd if=/dev/hwrng of=/dev/null' in guest
> - check sysfs files in the same time, 'cat /sys/class/misc/hw_random/rng_*'
> 
> Result: cat process will get stuck, it will return if we kill dd process.

How common is it going to be to have a long-running 'dd' process on
/dev/hwrng?

Also, with the new khwrng thread, reading from /dev/hwrng isn't
required -- just use /dev/random?

(This doesn't mean we shouldn't fix the issue here...)

> We have some static variables (eg, current_rng, data_avail, etc) in hw_random/core.c,
> they are protected by rng_mutex. I try to workaround this issue by undelay(100)
> after mutex_unlock() in rng_dev_read(). This gives chance for hwrng_attr_*_show()
> to get mutex.
> 
> This patch also contains some cleanup, moving some code out of mutex
> protection.
> 
> Do you have some suggestion? Thanks.
> 
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index aa30a25..fa69020 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -194,6 +194,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>  		}
>  
>  		mutex_unlock(&rng_mutex);
> +		udelay(100);

We have a need_resched() right below.  Why doesn't that work?

>  		if (need_resched())
>  			schedule_timeout_interruptible(1);
> @@ -233,10 +234,10 @@ static ssize_t hwrng_attr_current_store(struct device *dev,
>  	int err;
>  	struct hwrng *rng;

The following hunk doesn't work:

> +	err = -ENODEV;
>  	err = mutex_lock_interruptible(&rng_mutex);

err is being set to another value in the next line!

>  	if (err)
>  		return -ERESTARTSYS;
> -	err = -ENODEV;

And all usage of err below now won't have -ENODEV but some other value.

>  	list_for_each_entry(rng, &rng_list, list) {
>  		if (strcmp(rng->name, buf) == 0) {
>  			if (rng == current_rng) {
> @@ -270,8 +271,8 @@ static ssize_t hwrng_attr_current_show(struct device *dev,
>  		return -ERESTARTSYS;
>  	if (current_rng)
>  		name = current_rng->name;
> -	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
>  	mutex_unlock(&rng_mutex);
> +	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);

This looks OK...

>  
>  	return ret;
>  }
> @@ -284,19 +285,19 @@ static ssize_t hwrng_attr_available_show(struct device *dev,
>  	ssize_t ret = 0;
>  	struct hwrng *rng;
>  
> +	buf[0] = '\0';
>  	err = mutex_lock_interruptible(&rng_mutex);
>  	if (err)
>  		return -ERESTARTSYS;
>
> -	buf[0] = '\0';
>  	list_for_each_entry(rng, &rng_list, list) {
>  		strncat(buf, rng->name, PAGE_SIZE - ret - 1);
>  		ret += strlen(rng->name);
>  		strncat(buf, " ", PAGE_SIZE - ret - 1);
>  		ret++;
>  	}
> +	mutex_unlock(&rng_mutex);
>  	strncat(buf, "\n", PAGE_SIZE - ret - 1);
>  	ret++;
> -	mutex_unlock(&rng_mutex);

But this isn't resulting in savings; the majority of the time is being
spent in the for loop, and that writes to the buffer.

BTW I don't expect strcat'ing to the buf in each of these scenarios is
a long operation, so this reworking doesn't strike to me as something
we should pursue.

		Amit
