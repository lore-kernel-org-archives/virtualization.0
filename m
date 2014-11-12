From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v4 3/6] hw_random: use reference counts on each struct
	hwrng.
Date: Wed, 12 Nov 2014 14:11:23 +1030
Message-ID: <87zjbxm6fw.fsf@rustcorp.com.au>
References: <1415030186-18303-1-git-send-email-akong@redhat.com>
	<1415030186-18303-4-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1415030186-18303-4-git-send-email-akong@redhat.com>
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
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com, mb@bu3sch.de
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
> v4: decrease last reference for triggering the cleanup

This doesn't make any sense:

> +static void drop_current_rng(void)
> +{
> +	struct hwrng *rng = current_rng;
> +
> +	BUG_ON(!mutex_is_locked(&rng_mutex));
> +	if (!current_rng)
> +		return;
> +
> +	/* release current_rng reference */
> +	kref_put(&current_rng->ref, cleanup_rng);
> +	current_rng = NULL;
> +
> +	/* decrease last reference for triggering the cleanup */
> +	kref_put(&rng->ref, cleanup_rng);
> +}

Why would it drop the refcount twice?  This doesn't make sense.

Hmm, because you added kref_init, which initializes the reference count
to 1, you created this bug.

Leave out the kref_init, and let it naturally be 0 (until, and if, it
becomes current_rng).  Add a comment if you want.

Thanks,
Rusty.
