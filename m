From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] virtio-blk: make the queue depth configurable
Date: Mon, 17 Mar 2014 00:26:54 -0700
Message-ID: <1395041214.2556.17.camel__29160.748262848$1395058430$gmane$org@joe-AO722>
References: <1394818263-29947-1-git-send-email-tytso@mit.edu>
	<1394818720.3253.1.camel@joe-AO722> <20140314180258.GA29201@thunk.org>
	<87y509scl3.fsf@rustcorp.com.au> <1395032434.2556.10.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1395032434.2556.10.camel@joe-AO722>
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
Cc: fes@google.com, virtio-dev@lists.oasis-open.org, Theodore Ts'o <tytso@mit.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2014-03-16 at 22:00 -0700, Joe Perches wrote:
> On Mon, 2014-03-17 at 14:25 +1030, Rusty Russell wrote:
> 
> > Erk, our tests are insufficient.  Testbuilding an allmodconfig with this
> > now:
> 
> Good idea.
> 
> > diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> []
> > @@ -188,6 +188,9 @@ struct kparam_array
> >  	/* Default value instead of permissions? */			\
> >  	static int __param_perm_check_##name __attribute__((unused)) =	\
> >  	BUILD_BUG_ON_ZERO((perm) < 0 || (perm) > 0777 || ((perm) & 2))	\
> > +	/* User perms >= group perms >= other perms. */			\
> > +	+ BUILD_BUG_ON_ZERO(((perm) >> 6) < (((perm) >> 3) & 7))	\
> > +	+ BUILD_BUG_ON_ZERO((((perm) >> 3) & 7) < ((perm) & 7))		\
> >  	+ BUILD_BUG_ON_ZERO(sizeof(""prefix) > MAX_PARAM_PREFIX_LEN);	\
> >  	static const char __param_str_##name[] = prefix #name;		\
> >  	static struct kernel_param __moduleparam_const __param_##name	\
> 
> It might make sense to separate this octal permissions
> test into a new macro for other checks in macros like
> CLASS_ATTR, DEVICE_ATTR, SENSOR_ATTR and SENSOR_ATTR_2.
> 
> Maybe something like:
> 
> #define VERIFY_OCTAL_PERMISSIONS(perm)					\
> 	static int __param_perm_check_##name __attribute__((unused)) =	\
> 	BUILD_BUG_ON_ZERO((perm) < 0 || (perm) > 0777 || ((perm) & 2))	\
> 	/* User perms >= group perms >= other perms. */			\
> 	+ BUILD_BUG_ON_ZERO(((perm) >> 6) < (((perm) >> 3) & 7))	\
> 	+ BUILD_BUG_ON_ZERO((((perm) >> 3) & 7) < ((perm) & 7));	\

Maybe this is better:

#define VERIFY_OCTAL_PERMISSIONS(perms)					\
({									\
	if (__builtin_constant_p(perms)) {				\
		BUILD_BUG_ON((perms) < 0);				\
		BUILD_BUG_ON((perms) > 0777);				\
		/* User perms >= group perms >= other perms */		\
		BUILD_BUG_ON(((perms) >> 6) < (((perms) >> 3) & 7));	\
		BUILD_BUG_ON((((perms) >> 3) & 7) < ((perms) & 7));	\
	}								\
	;								\
})
