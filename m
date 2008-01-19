From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sat, 19 Jan 2008 13:08:28 +0900
Message-ID: <479177BC.8030200__34334.9215262153$1200715833$gmane$org@gmail.com>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<47915515.1020905@gmail.com> <47915614.7080608@gmail.com>
	<200801191459.49735.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801191459.49735.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>, Jeff Garzik <jgarzik@pobox.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

Rusty Russell wrote:
>     There are three possibilities: (1) force everyone to use void *, (2) force 
> everyone to be type-correct, (3) allow both with some tricks.  Currently 
> we're on (1).  For kthread, with only dozens of users, I chose (2) (very 
> simple, easy to understand).  I think for widespread things like timer and 
> interrupt handlers, I think (3) is the right way to go.

Yeah, during transition, we definitely want (3).

>     I wanted to get this patch out there and see what the reaction was.  I can 
> do timers next, if that's going to add fuel to the discussion.

I think you successfully got a very small sample of possible reactions.
 Jeff vetoing it (and for good reasons) and me a bit more positive but
not quite sold.  Yeah, I think we need a good flame war to determine our
heading and converting timer shouldn't take too much of your time, right?

Thanks.

-- 
tejun
