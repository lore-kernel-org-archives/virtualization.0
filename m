From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] virtio-blk: make the queue depth configurable
Date: Tue, 18 Mar 2014 23:50:32 -0700
Message-ID: <1395211832.8649.40.camel__17473.1937972412$1395250194$gmane$org@joe-AO722>
References: <1394818263-29947-1-git-send-email-tytso@mit.edu>
	<1394818720.3253.1.camel@joe-AO722> <20140314180258.GA29201@thunk.org>
	<87y509scl3.fsf@rustcorp.com.au> <1395032434.2556.10.camel@joe-AO722>
	<1395041214.2556.17.camel@joe-AO722> <87zjkmr8w1.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87zjkmr8w1.fsf@rustcorp.com.au>
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
Cc: fes@google.com, virtio-dev@lists.oasis-open.org, Theodore Ts'o <tytso@mit.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2014-03-19 at 17:07 +1030, Rusty Russell wrote:

> Summary of http://lkml.org/lkml/2014/3/14/363 :
> 
>   Ted: module_param(queue_depth, int, 444)
>   Joe: 0444!
>   Rusty: User perms >= group perms >= other perms?
>   Joe: CLASS_ATTR, DEVICE_ATTR, SENSOR_ATTR and SENSOR_ATTR_2?

<smile>

Adding:

Rusty: Bikeshedding
Joe: Missing ((perm) & 2) ?

[]

> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 471090093c67..945afeb3058a 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -842,4 +842,13 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
>  #endif
>  
> +/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
> +#define VERIFY_OCTAL_PERMISSIONS(perms)					\
> +	((__builtin_constant_p(perms) ?					\
> +	  BUILD_BUG_ON_ZERO((perms) < 0) +				\
> +	  BUILD_BUG_ON_ZERO((perms) > 0777) +				\
> +	  /* User perms >= group perms >= other perms */		\
> +	  BUILD_BUG_ON_ZERO(((perms) >> 6) < (((perms) >> 3) & 7)) +	\
> +	  BUILD_BUG_ON_ZERO((((perms) >> 3) & 7) < ((perms) & 7)): 0) +	\
> +	 (perms))
>  #endif
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 175f6995d1af..204a67743804 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -186,14 +186,12 @@ struct kparam_array
>     parameters. */
>  #define __module_param_call(prefix, name, ops, arg, perm, level)	\
>  	/* Default value instead of permissions? */			\
> -	static int __param_perm_check_##name __attribute__((unused)) =	\
> -	BUILD_BUG_ON_ZERO((perm) < 0 || (perm) > 0777 || ((perm) & 2))	\

Now missing test for ((perm) & 2)

Dunno if that was ever necessary.

> -	+ BUILD_BUG_ON_ZERO(sizeof(""prefix) > MAX_PARAM_PREFIX_LEN);	\
> -	static const char __param_str_##name[] = prefix #name;		\
> +	static const char __param_str_##name[] = prefix #name; \
>  	static struct kernel_param __moduleparam_const __param_##name	\
>  	__used								\
>      __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
> -	= { __param_str_##name, ops, perm, level, { arg } }
> +	= { __param_str_##name, ops, VERIFY_OCTAL_PERMISSIONS(perm),	\
> +	    level, { arg } }
