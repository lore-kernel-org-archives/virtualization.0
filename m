From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 1/2] hwrng: fetch randomness only after device init
Date: Sun, 6 Jul 2014 21:41:47 -0700
Message-ID: <CAGXu5j+j1LUv_rRpf=03nRfu=Sek5O8TUs8R066JvfbUgT9ZQQ__882.192751351063$1404708122$gmane$org@mail.gmail.com>
References: <cover.1404538109.git.amit.shah@redhat.com>
	<515a12ecc5fca5452bf0bfda4d54546d8fb5829c.1404538109.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <515a12ecc5fca5452bf0bfda4d54546d8fb5829c.1404538109.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, LKML <linux-kernel@vger.kernel.org>, "# 3.4.x" <stable@vger.kernel.org>, Virtualization List <virtualization@lists.linux-foundation.org>, Jason Cooper <jason@lakedaemon.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 4, 2014 at 10:34 PM, Amit Shah <amit.shah@redhat.com> wrote:
> Commit d9e7972619334 "hwrng: add randomness to system from rng sources"
> added a call to rng_get_data() from the hwrng_register() function.
> However, some rng devices need initialization before data can be read
> from them.
>
> This commit makes the call to rng_get_data() depend on no init fn
> pointer being registered by the device.  If an init function is
> registered, this call is made after device init.

Thanks, this seems pretty reasonable. One side-effect is that cycling
between hwrngs via sysfs (when they have init functions) will cause
them to add more entropy. I don't think this is a problem, but it is
kind of a weird side-effect.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> CC: Kees Cook <keescook@chromium.org>
> CC: Jason Cooper <jason@lakedaemon.net>
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> CC: <stable@vger.kernel.org> # For v3.15+
> Signed-off-by: Amit Shah <amit.shah@redhat.com>
> ---
>  drivers/char/hw_random/core.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 334601c..df95e2f 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -55,16 +55,37 @@ static DEFINE_MUTEX(rng_mutex);
>  static int data_avail;
>  static u8 *rng_buffer;
>
> +static inline int rng_get_data(struct hwrng *rng, u8 *buffer, size_t size,
> +                              int wait);
> +
>  static size_t rng_buffer_size(void)
>  {
>         return SMP_CACHE_BYTES < 32 ? 32 : SMP_CACHE_BYTES;
>  }
>
> +static void add_early_randomness(struct hwrng *rng)
> +{
> +       unsigned char bytes[16];
> +       int bytes_read;
> +
> +       bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
> +       if (bytes_read > 0)
> +               add_device_randomness(bytes, bytes_read);
> +}
> +
>  static inline int hwrng_init(struct hwrng *rng)
>  {
> +       int ret;
> +
>         if (!rng->init)
>                 return 0;
> -       return rng->init(rng);
> +
> +       ret =  rng->init(rng);
> +       if (ret)
> +               return ret;
> +
> +       add_early_randomness(rng);
> +       return ret;
>  }
>
>  static inline void hwrng_cleanup(struct hwrng *rng)
> @@ -304,8 +325,6 @@ int hwrng_register(struct hwrng *rng)
>  {
>         int err = -EINVAL;
>         struct hwrng *old_rng, *tmp;
> -       unsigned char bytes[16];
> -       int bytes_read;
>
>         if (rng->name == NULL ||
>             (rng->data_read == NULL && rng->read == NULL))
> @@ -347,9 +366,9 @@ int hwrng_register(struct hwrng *rng)
>         INIT_LIST_HEAD(&rng->list);
>         list_add_tail(&rng->list, &rng_list);
>
> -       bytes_read = rng_get_data(rng, bytes, sizeof(bytes), 1);
> -       if (bytes_read > 0)
> -               add_device_randomness(bytes, bytes_read);
> +       if (!rng->init)
> +               add_early_randomness(rng);
> +
>  out_unlock:
>         mutex_unlock(&rng_mutex);
>  out:
> --
> 1.9.3
>



-- 
Kees Cook
Chrome OS Security
