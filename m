From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 3/6] hw_random: use reference counts on each struct
	hwrng.
Date: Mon, 20 Oct 2014 10:38:08 +1030
Message-ID: <874muza9hz.fsf@rustcorp.com.au>
References: <1411043867-21109-1-git-send-email-akong@redhat.com>
	<1411043867-21109-4-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1411043867-21109-4-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>, virtualization@lists.linux-foundation.org
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Amos Kong <akong@redhat.com> writes:
> From: Rusty Russell <rusty@rustcorp.com.au>
>
> current_rng holds one reference, and we bump it every time we want
> to do a read from it.
>
> This means we only hold the rng_mutex to grab or drop a reference,
> so accessing /sys/devices/virtual/misc/hw_random/rng_current doesn't
> block on read of /dev/hwrng.
>
> Using a kref is overkill (we're always under the rng_mutex), but
> a standard pattern.
>
> This also solves the problem that the hwrng_fillfn thread was
> accessing current_rng without a lock, which could change (eg. to NULL)
> underneath it.
>
> V2: reduce reference count in signal_pending path

OK, I changed it to do the put_rng before the check, so instead of:

> @@ -208,17 +256,19 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>  
>  		if (signal_pending(current)) {
>  			err = -ERESTARTSYS;
> +			put_rng(rng);
>  			goto out;
>  		}
> +
> +		put_rng(rng);
>  	}
>  out:
>  	return ret ? : err;
> -out_unlock:
> -	mutex_unlock(&rng_mutex);
> -	goto out;
> +
>  out_unlock_reading:
>  	mutex_unlock(&reading_mutex);
> -	goto out_unlock;
> +	put_rng(rng);
> +	goto out;
>  }

We have:


		mutex_unlock(&reading_mutex);
		put_rng(rng);

		if (need_resched())
			schedule_timeout_interruptible(1);

		if (signal_pending(current)) {
			err = -ERESTARTSYS;
			goto out;
		}
	}
out:
	return ret ? : err;

out_unlock_reading:
	mutex_unlock(&reading_mutex);
	put_rng(rng);
	goto out;
}


Cheers,
Rusty.
