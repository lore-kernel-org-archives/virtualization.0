From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] drivers: virtio: Use PTR_RET function
Date: Mon, 25 Mar 2013 22:01:50 -0700
Message-ID: <20130325220150.af9795a7.akpm@linux-foundation.org>
References: <1364217936-6284-1-git-send-email-gheorghiuandru@gmail.com>
	<87fvzidenm.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87fvzidenm.fsf@rustcorp.com.au>
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
Cc: Alexandru Gheorghiu <gheorghiuandru@gmail.com>, virtualization@lists.linux-foundation.org, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 26 Mar 2013 13:57:09 +1030 Rusty Russell <rusty@rustcorp.com.au> wrote:

> Alexandru Gheorghiu <gheorghiuandru@gmail.com> writes:
> 
> > Used PTR_RET function instead of IS_ERR and PTR_ERR.
> > Patch found using coccinelle.
> 
> WTF is PTR_RET?  PTR_RET doesn't return anything.  Why is it called
> that?  It doesn't even make sense.
> 
> ZERO_OR_PTR_ERR() maybe.
> 
> But what problem are we solving?  Insufficient churn in the tree?  Code
> being too readable?  This isn't some hard-to-get right corner case, or a
> missed optimization.
> 
> Andrew, what am I missing here?

It seemed like a good idea at the time.  Merged it two years ago and
have since been keenly awaiting an opportunity to use it.

It seems that people _have_ been using it, but mainly netfilter people
and we know they're all crazy ;)
