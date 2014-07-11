From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH] hwrng: sysfs entry rng_seed_kernel, was: "Re: [PATCH
	v2 1/2] hwrng: fetch randomness only after device init"
Date: Fri, 11 Jul 2014 18:56:26 +0530
Message-ID: <20140711132626.GB17415@grmbl.mre>
References: <cover.1404538109.git.amit.shah@redhat.com>
	<515a12ecc5fca5452bf0bfda4d54546d8fb5829c.1404538109.git.amit.shah@redhat.com>
	<20140709115317.GM13433@titan.lakedaemon.net>
	<20140709130822.GA4553@grmbl.mre>
	<20140709131737.GO13433@titan.lakedaemon.net>
	<20140709132524.GB4667@grmbl.mre>
	<20140709160725.GP13433@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140709160725.GP13433@titan.lakedaemon.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, keescook@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) 09 Jul 2014 [12:07:25], Jason Cooper wrote:
> Amit, Kees,

(snip)

> I'm cooling to the idea of the init function for virtio-rng, and it
> might be best just to admit that there's no way to seed the entropy pool
> from the virtio-rng at probe time.  After all, once userspace is up, the
> system should take advantage of /dev/hwrng for the generation of
> long-term keys.  Either via rngd feeding /dev/random, or directly.
> 
> As for the follow-on patch you asked about, I think that's fine.  More
> entropy can't hurt.
> 
> The below patch might be worth considering so that the user of a system
> with only virtio-rng can kick the entropy pool as they see fit.  It's
> probably not too kosher as is, but if the idea is liked, I could clean
> it up and submit.
> 
> The advantage is that users don't need to have rngd installed and
> running on the system in order to jump-start the entropy pool.

... so a udev rule that looks for the new sysfs file, and asks the
kernel to do its thing?

And maybe even a patch to rngd that looks for this file and does a
similar thing?

There's also the option to use a delayed workqueue item, that will
succeed if probe has finished.  This method doesn't have userspace
dependencies.

Thanks,

		Amit
