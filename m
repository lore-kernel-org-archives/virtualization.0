From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sat, 19 Jan 2008 14:59:49 +1100
Message-ID: <200801191459.49735.rusty__31274.3849623532$1200715346$gmane$org@rustcorp.com.au>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<47915515.1020905@gmail.com> <47915614.7080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47915614.7080608@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>, Jeff Garzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 19 January 2008 12:44:52 Tejun Heo wrote:
> Tejun Heo wrote:
> > so I think the question is "do we want to change all callbacks to
> > take native pointer type instead of void pointer?".
>
> Lemme clarity myself a bit.  I'm not saying that we should convert all
> at once or literally every callback should be converted.  What I'm
> saying is whether we're headed that way in general and converting big
> ones - timer for example - and getting the conversion agreed upon should
> be enough to set the norm.

Hi Tejun

    There are three possibilities: (1) force everyone to use void *, (2) force 
everyone to be type-correct, (3) allow both with some tricks.  Currently 
we're on (1).  For kthread, with only dozens of users, I chose (2) (very 
simple, easy to understand).  I think for widespread things like timer and 
interrupt handlers, I think (3) is the right way to go.

    I wanted to get this patch out there and see what the reaction was.  I can 
do timers next, if that's going to add fuel to the discussion.

Thanks!
Rusty.
