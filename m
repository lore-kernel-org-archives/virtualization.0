From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: make the queue depth configurable
Date: Mon, 17 Mar 2014 14:25:52 +1030
Message-ID: <87y509scl3.fsf@rustcorp.com.au>
References: <1394818263-29947-1-git-send-email-tytso@mit.edu>
	<1394818720.3253.1.camel@joe-AO722>
	<20140314180258.GA29201@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140314180258.GA29201@thunk.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Theodore Ts'o <tytso@mit.edu>, Joe Perches <joe@perches.com>
Cc: fes@google.com, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Theodore Ts'o <tytso@mit.edu> writes:
> On Fri, Mar 14, 2014 at 10:38:40AM -0700, Joe Perches wrote:
>> > +static int queue_depth = 64;
>> > +module_param(queue_depth, int, 444);
>> 
>> 444?  Really Ted?
>
> Oops, *blush*.   Thanks for catching that.

Erk, our tests are insufficient.  Testbuilding an allmodconfig with this
now:

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 175f6995d1af..626b85888a6b 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -188,6 +188,9 @@ struct kparam_array
 	/* Default value instead of permissions? */			\
 	static int __param_perm_check_##name __attribute__((unused)) =	\
 	BUILD_BUG_ON_ZERO((perm) < 0 || (perm) > 0777 || ((perm) & 2))	\
+	/* User perms >= group perms >= other perms. */			\
+	+ BUILD_BUG_ON_ZERO(((perm) >> 6) < (((perm) >> 3) & 7))	\
+	+ BUILD_BUG_ON_ZERO((((perm) >> 3) & 7) < ((perm) & 7))		\
 	+ BUILD_BUG_ON_ZERO(sizeof(""prefix) > MAX_PARAM_PREFIX_LEN);	\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
